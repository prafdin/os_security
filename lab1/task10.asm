section .data
                
                src_file: dq 0
                src_file_mode: db 'r', 0
                src_handler: dq 0
                dst_file: dq 0
                dst_file_mode: db 'w', 0
                dst_format: db '%s',0
                dst_handler: dq 0                
                key: dq 0
                
                fail_msg: db 'Failed to open txt file',0
                src_contnet: times 256 db 0
                src_end: dq src_contnet
                
                key_buff: times 256 db 0
                buff_end: dq key_buff
                
                out_buf: times 256 db 0
                
                src_size: dq 0
                key_size: dq 0

section .text
                global main
                extern fopen
                extern atoi
                extern printf
                extern exit 
                extern malloc
                extern free
                extern perror
                extern fgetc
                extern feof
                extern fclose
                extern strlen
                extern memcpy
                extern fprintf
                extern fwrite

encrypt:

                mov rdi,[key]
                call strlen
                mov [key_size], rax
                
                mov r13, [key_size]
                mov r14, [src_size]
    multi_feed:             
                cmp r14, r13
                jle single_feed ; if r14 <= r13
                
                
                mov rdi, [buff_end]
                mov rsi, [key]
                mov rdx, r13
                call memcpy
                
                mov r9, [buff_end]
                add r9, r13
                mov [buff_end], r9
                
                sub r14, r13
                jmp multi_feed
                
    single_feed:                
                cmp r14, 0
                jz key_buf_filled       
                
                mov r15, 0         
    single_loop:
                mov r13, [key]
                mov r9, [r13+r15]
                mov r10, [buff_end]
                mov [r10], r9b
                inc r10
                mov [buff_end], r10
                inc r15
                cmp r15, r14
                jne single_loop
    key_buf_filled:        
    
                mov r14, 0
                
    multi_encrypt:
                mov r15, [src_size]
                mov rax, 0
                mov eax, 16
                mul r14d
                cmp rax, r15
                jg encrypt_ret
                
                mov rax, 0
                mov al, 2
                mul r14b
                mov r15b, 8
                mul r15b  ; rax = 8*(r14*2)
                
                mov r9, src_contnet
                add r9, rax
                mov RDX, [r9]
                movq XMM0, RDX
                
                
                add rax, 8                
                mov r9, src_contnet
                add r9, rax
                mov RDX, [r9]
                movq XMM1, RDX
                movlhps XMM0,XMM1
                                
                mov rax, 0
                mov al, 2
                mul r14b
                mov r15b, 8
                mul r15b  ; rax = 8*(r14*2)
                    
                mov r9, key_buff
                add r9, rax
                mov RDX, [r9]            
                movq XMM2, RDX
                
                add rax, 8
                mov r9, key_buff
                add r9, rax
                MOV RDX, [r9]
                movq XMM3, RDX
                movlhps XMM2,XMM3
                
                xorpd xmm0, xmm2

                mov rax, 0
                mov eax, 16
                mul r14w
                mov rsi, out_buf
                add rsi, rax
                movdqu [rsi], xmm0
                
                inc r14
                jmp multi_encrypt
 encrypt_ret:                                           
                ret


main:
                
                add rsi, 8
                mov rdx, [rsi]
                mov qword [src_file], rdx
                
                add rsi, 8
                mov rdx, [rsi]
                mov qword [dst_file], rdx
                
                add rsi, 8
                mov rdx, [rsi]
                mov qword [key], rdx
                
                mov r15,0                                       ; use below

                mov rbp, rsp; for correct debugging
                ; open txt file
                mov rdi, [src_file]
                mov rsi, src_file_mode
                call fopen 
                mov qword [src_handler], rax
                jnz file_opened_r
                mov eax, 1
                mov rdi, fail_msg
                call perror
                jmp return
               
    file_opened_r:
                inc r15                                        ; use here
                mov rdi, [src_handler]
                call fgetc
                mov r9, [src_end]
                mov [r9], al
                inc r9
                mov [src_end], r9
                mov rdi, [src_handler]
                call feof
                test eax, eax,
                jz file_opened_r
                mov r9, [src_end]
                dec r9
                mov byte [r9], 0
                
                dec r15
                mov [src_size], r15
                
                ; close the file
                mov rdi, [src_handler]
                call fclose
               
                mov rdi, src_contnet
                call encrypt
                mov rdi, [dst_file]
                mov rsi, dst_file_mode
                call fopen 
                mov qword [dst_handler], rax
                jnz file_opened_w
                mov eax, 1
                mov rdi, fail_msg
                call perror
                jmp return
    file_opened_w:
                mov rdi, out_buf
                mov rsi, [src_size]
                mov rdx, 1
                mov rcx, [dst_handler]
                call fwrite
               
return: 
                mov rdi, rax
                call exit

