
section .data
arr:        dd  2, 4, 8, 16, 32
size_arr:   equ 5
operand:    db 2

section .text
        global main
main:
            mov ebp, esp                ; for correct debugging
            mov cx, size_arr            ; i = 5
            mov ebx, arr                ; ptr on current number of array
loop:       
            mov al, [ebx]               ; mov al, *arr
            mul byte [operand]          ; 
            mov [ebx], ax               ; *arr = al * operand
            add ebx, 4                  ; arr + 4 
            dec cx                      ; --i
            jnz loop                    ; if i - 1 != 0 go to loop label        
