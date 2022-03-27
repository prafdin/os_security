
section .data		        
var1:   db  20
var2:   dw  210
var3:   dd  2200
var4:   dq  23000
var5:   dw  230, 231, 232, 234                          ; For check byte-order
var6:   db  -20                                         ; https://math.semestr.ru/inf/inverse.php
var7:   dd  -1.5                                        ; https://math.semestr.ru/inf/ieee754.php
var8    dq  9.9

section .text		        
        global main		
main:    
        mov ebp, esp; for correct debugging
			
	