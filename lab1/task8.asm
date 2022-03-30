section .data
                format: db 'The result is: %g',0Dh,0Ah,0
                float_num: dq 3.5

section .text
                global main
                extern atoi
                extern printf
                extern exit 
                extern malloc
                extern free
                


                
                
odd_arr_sum:   
                ; a function that adds numbers from odd array indices
                ; input arguments:
                ; rdi - pointer to the array of integers (4 bytes)
                ; r10 - element_number
                ; return arguments:
                ; r11 - number of added numbers
                ; rbx- sum result
                mov r11, 0
                mov ebx, 0
                mov ecx, 2
                mov rsi, 0    ; counter
    odd_loop:  
                mov edx, 0 
                mov eax, esi
                div ecx
                test edx, edx
                jz skip_sum     
                inc r11           
                add ebx, [rdi] 
    skip_sum:
                add rdi, 4      ; move ptr to next num
                inc esi
                cmp rsi, r10 
                jnz odd_loop
                ret
                
                
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
                

main:
                mov rbp, rsp; for correct debugging
                push rdi
                mov rbp, rdi
                mov r10, rsi
                call parse_args
                ; calculate the mean of the array
                mov rdi, rbx                  ; rdi = arr_ptr
                pop rbx
                dec rbx                     
                mov r10, rbx                  ; r10 = arr_size
                call odd_arr_sum ; 
                cvtsi2sd xmm0, rbx
                cvtsi2sd xmm1, r11
                divsd xmm0, xmm1
                mov rdi, format
                mov eax, 1
                sub rsp, 8h
                call printf
                add rsp, 8h
                ; exit the program
                mov rdi, 0
                call exit

