section .data
                format: db 'The result is: %f',0Dh,0Ah,0
                array: dd 10, 42, 573, 84, 5775, 26, 47
                array_len: equ 7
                float_zero: dd 0.0
                array_pointer: dq 0
                int_size: dd 4

section .text
                global main
                extern atoi
                extern printf
                extern exit 
                extern malloc
                extern free
                

mean_func:
                ; function calculates the mean of the input array
                ; input arguments:
                ; rdi - pointer to the array of integers (4 bytes)
                ; esi - element_number
                ; return arguments:
                ; eax - 0 on success, 1 on input data error
                ; xmm0 - the mean value of the input array
                push rcx
                test rdi, rdi
                jnz valid_array_ptr
                mov eax, 1
                movss xmm0, [float_zero]
                jmp return
                
    valid_array_ptr:
                movss xmm0, [float_zero]
                test esi, esi
                mov eax, 1
                jz return
                mov ecx, esi

    array_loop:
                mov eax, [rdi]
                cvtsi2ss xmm1, eax
                addss xmm0, xmm1
                add rdi, 4
                dec ecx
                test ecx, ecx
                jnz array_loop
                cvtsi2ss xmm1, esi
                divss xmm0, xmm1
                mov eax, 0
    return:
                pop rcx
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
                mov rdi, rbx
                pop rbx
                dec rbx
                mov esi, ebx
                call mean_func ; mean_func(array, array_len)
                sub rsp, 8h
                mov rdi, format
                mov eax, 1
                cvtps2pd xmm0, xmm0
                call printf
                add rsp, 8h
                ; exit the program
                mov rdi, 0
                call exit

