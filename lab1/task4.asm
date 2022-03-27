section .data
out_format:     db 'gcd(%d, %d) = %d',0Dh,0Ah,0
in_format:      db '%d %d', 0

section .bss
a:              resb 4
b:              resb 4                

section .text
                global main
                extern printf
                extern scanf
                extern exit
gcd:
                ; function calculates the greatest common divisor of the input
                ; input arguments:
                ; edi - the first number
                ; esi - the second number
                ; returns:
                ; eax - the gcd(edi, esi)
                push rdx
                push rcx
    loop:                               ; http://www.cleverstudents.ru/divisibility/nod_finding.html#Euclids_algorithm
                mov eax, edi
                xor edx, edx
                div esi                 ; edi = eax*esi + edx 
                mov edi, edx            
                push rdi                ; ===================
                push rsi                ; swap rdi and rsi
                pop rdi                 ; 
                pop rsi                 ; ===================
                test esi, esi             
                jnz loop                ; if remainder != 0 go to loop
                mov eax, edi
    return:
                pop rdx
                pop rcx
                ret
main:
                mov rbp, rsp        ; for correct debugging
                mov ebp, esp        ; for correct debugging
                sub  rsp, 8         ; align the stack to a 16B boundary before function calls
                mov rdi, in_format
                mov esi, a
                mov edx, b
                mov al, 0
                call scanf
                mov edi, [a]        ; calculate gcd     
                mov esi, [b]
                call gcd                ; gcd(a, b)
                mov rdi, out_format
                mov esi, [a]
                mov edx, [b]
                mov ecx, eax
                mov eax, 0
                call printf
                ; exit the program
                mov rdi, 0
                call exit
