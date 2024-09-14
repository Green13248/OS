cls:	
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	mov ah, 0x0B
	mov bh, 0x00
	mov bl, 0x01
	int 0x10
	mov ah, 0x0e
	mov al, 10
	int 0x10
	mov al, 13
	int 0x10
	mov al, ">"
	int 0x10
Loop:
	mov ah, 0x00
	int 0x16
	mov ah, 0x0e
	int 0x10
	cmp al, 0xD
	je Done
	mov [di], al
	jmp Loop
Done:
	mov ah, 0x0e
	mov al, 10
	int 0x10
	mov al, 13
	int 0x10
	mov al, ">"
	int 0x10
	cmp byte [di], "F"
	je Good
	cmp byte [di], "c"
	je cls
	jmp Loop

printstring:
	mov ah, 0x0e
	mov al, [bx]
	cmp al, 0
	je done
	int 0x10
	inc bx
	jmp printstring
done:
	jmp Gdone

Good:
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	mov ah, 0x0B
	mov bh, 0x00
	mov bl, 0x01
	int 0x10
	mov bx, Filebrowser
	mov si, 0
	mov di, 0
	jmp printstring
Gdone:	
	mov ah, 0x0e
	mov al, [0x8400 + si]
	cmp si, 512
	je dilogic
	inc si
	cmp al, "&"
	je dilogic
	cmp di, "1"
	je printname
	jmp Gdone

printname:	
	int 0x10
	jmp Gdone
dilogic:
	cmp di, 1
	je .minloop
	mov di, 1
	jmp Gdone
	.minloop:
	mov di, 0
	jmp Gdone

Success:	db 10, 13, "The program has run successfully :)", 0
Error:	db 10, 13,  "There was an error :(", 0
Filebrowser:	db "Name            Type            Sector            /", 0

	TIMES 2048 - ($ - $$) db "R"
	db "&"
	TIMES 510 db "A"
	db "&"
	TIMES 512 db "B"
	TIMES 512 db "C"
	TIMES 512 db "D"
	TIMES 512 db "E"
	TIMES 512 db "F"
	TIMES 512 db "G"
	TIMES 512 db "H"
	TIMES 512 db "I"
	TIMES 512 db "J"
