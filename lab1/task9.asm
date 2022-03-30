section .data
                
                print_format: db '%d ',0
                arr_ptr: dq 0
                arr_size: dd 3

section .text
                global main
                extern atoi
                extern printf
                extern exit 
                extern malloc
                extern free

                
                
parse_args:     
                ; function that parse args with array of numbers. 
                ; input arguments:
                ; rbp - count numbers on array
                ; r10 - ptr to array of pointers to strings
                ; return arguments:
                ; rbx - pointer to the array of integers (4 bytes)
                sub rsp, 8
                push r10
                
                dec rbp        ; ======
                mov eax, ebp     ; 
                mov ebx, 4       ; eax = count_numbers * sizeof(int)
                mul ebx          ; ======
                
                mov rdi, 0
                mov edi, eax
                call malloc
                mov rbx, rax     ; rbx = malloc(...)
                
                mov r12, rbx      
    parse_loop: 
                pop r10
                add r10, 8         ;   first elem - prog name                   
                mov rdi, [r10]

                push r10
                call atoi
                mov [r12], rax
                add r12, 4
                dec rbp
                test rbp, rbp
                jnz parse_loop
                pop r10
                
                add rsp, 8
                ret
               
swap:           
                ; input params:
                ; rdi - pointer to arr with integers (4 byte)
                ; r10 - first index
                ; r12 - second index
                ; FUNC BROKE ebx, eax register
                
                mov ebx, 0 ; first buffer
                mov eax, 0 ; second buffer
                mov ebx, [rdi+r10*4]
                mov eax, [rdi+r12*4]
                mov [rdi+r10*4], eax
                mov [rdi+r12*4], ebx
                ret
                 

print_array:
                ; input params:
                ; r14 - pointer to arr with integers (4 byte)
                ; r15 - array size
                mov rbx, 0
                sub rsp, 8       
    print_loop:
                mov rsi, [r14+rbx*4]
                mov rdi, print_format    
                xor rax, rax 
                call printf 
                inc rbx
                cmp rbx, r15
                jnz print_loop
                add rsp, 8
                ret
                
insert_sort:   
                ; input params:
                ; rdi - ptr to arr
                ; rsi - array size        
                
                mov r10, 0     ; external counter
                mov r11, 0
                
    external:
                mov r12, r10    ; index of max elem
                mov eax, [rdi+r10*4] ; current number
                mov r11, r10         ; nested counter
                test r11, r11
                jz force ; if current number is first number of array
      nested:
                dec r11
                mov ebx, [rdi+r11*4]
                cmp ebx, eax   ; if ebx < eax
                jle not_great
                mov eax, ebx
                mov r12, r11
      not_great:       
            
                test r11, r11              
                jnz nested
                
                call swap
                
                cmp r12, r10
                je force
                mov r10, r12
                jmp external
                
      force: 
                
                inc r10                                        
                cmp r10, rsi
                jnz external
                ret
                



main:
  
                
                mov rbp, rsp; for correct debugging
                mov rax, rdi
                dec rax
                mov [arr_size], rax
                mov rbp, rdi
                mov r10, rsi
                call parse_args ; ret rbx - ptr to arr
                push rbx 
                
                mov rdi, rbx
                mov rsi, [arr_size]
                call insert_sort
                
                pop rbx
                mov r14, rbx
                mov r15, [arr_size]
                call print_array
                
                
                call exit

