	[org 0x7c00]
	[bits 16]
	xor ax, ax                          
	mov es, ax
	mov ds, ax
	mov bp, 0x8000
	mov sp, bp
	mov ah, 0x0e
	mov al, "1"
	int 0x10
	mov ah, 0x02                    ; load second stage to memory
	mov al, 50                       ; numbers of sectors to read into memory
	mov dl, 0x80                    ; sector read from fixed/usb disk
	mov ch, 0                       ; cylinder number
	mov dh, 0                       ; head number
	mov cl, 2                       ; sector number
	mov bx, Load             ; load into es:bx segment :offset of buffer
	int 0x13                        ; disk I/O interrupt
	TIMES 510 - ($ - $$) db 0
	DW 0xAA55
Load:
	mov ah, 0x00
	mov al, 0x0E
	int 0x10
	%include "kernelpoint.asm"
	call "kernelpoint.asm"
