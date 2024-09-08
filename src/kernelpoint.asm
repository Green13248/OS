cls:	
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	jmp Loop
Loop:	
	mov ah, 0x0e
	mov al, 10
	int 0x10
	mov al, 13
	int 0x10
	mov al, ">"
	int 0x10
	mov ah, 0
	int 0x16
	cmp al, "C"
	je cls
	jmp Loop
