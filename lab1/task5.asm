section .data
                file_mode: db 'rb',0
                failure_mes: db 'Failed to open file',0
                f_h: dq 0
                format: db 'in.txt = "%s"',0Dh,0Ah,0
                str: times 256 db 0
                str_end: dq str

 
section .text
                global main
                extern fopen
                extern fgetc
                extern feof
                extern fclose
                extern printf
                extern perror
                extern exit

main:
                mov rbp, rsp; for correct debugging
                
                mov rdx, [rsi]
                add rdx, 8      ; rdx = argv[1]
                
                ; open in.txt
                mov rdi, rdx
                mov rsi, file_mode
                call fopen ; FILE* f_h = fopen(file_name, file_mode)
                mov qword [f_h], rax
                test rax, rax
                jnz file_opened
                mov eax, 1
                mov rdi, failure_mes
                call perror
                jmp return
                ; read file's contents to str buffer
file_opened:
                mov rdi, [f_h]
                call fgetc ; fgetc(f_h)
                mov r9, [str_end]
                mov [r9], al
                inc r9
                mov [str_end], r9
                mov rdi, [f_h]
                call feof ; feof(f_h)
                test eax, eax
                jz file_opened
                
                mov r9, [str_end]
                dec r9
                mov byte [r9], 0
                
                ; close the file
                mov rdi, [f_h]
                call fclose ; fclose(f_h);
                
                ; output the str to the screen
                mov rdi, format
                mov rsi, str
                xor eax, eax
                call printf
                mov eax, 0
return:
                ; exit the program
                mov rdi, rax
                call exit
