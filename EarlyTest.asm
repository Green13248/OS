global start
section .text
[ORG 0x7c00]
bits 16

start:
    mov ah, 0x00
    mov al, 0x03  ; text mode 80x25 16 colors
    int 0x10

mov bx, info
mov si, promptinfo

print:
    mov ah, 0x0e
    mov al, [bx]
    cmp al, 0
    je printprompt
    int 0x10
    inc bx
    jmp print

jmp $

printprompt:
    mov ah, 0x0e
    mov al, [si]
    cmp al, 0
    je prompt
    int 0x10
    inc si
    jmp printprompt

prompt:
	mov ax,0x00             ; get keyboard input
	int 0x16    	        ; hold for input
    jmp saveinput
.past:

	cmp ah,0x1C             ; compare input is enter(1C) or not
	je .exitinput           ; if enter then jump to exitinput

	mov ah,0x0e             ;display input char
    cmp al, "s"
    je save
	int 0x10

	inc cx                  ; increase counter
	cmp cx,5
    mov si, promptinfo   ; yes jump to _getUsernameinput
	jmp .inputdone          ; else jump to inputdone

.inputdone:
	mov cx,0
    jmp prompt

.exitinput:
    pop ax
    mov si, promptinfo
    cmp al, "h"
    je save
    jmp printprompt

jmp $

saveprompt:
    mov ah, 0x0e
    mov al, [si]
    cmp al, 0
    je save.donedanger
    int 0x10
    inc si
    jmp saveprompt

save:
    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [disknum]
    mov ax, 0
    mov es, ax
    mov bx, 0x7e00
    int 0x13
    mov si, saveprompttext
    jmp saveprompt
.donedanger:
    hlt

info:
    db "*** Welcome to CSOS ***", 10, 13, 0

promptinfo:
    db 10, 13, "U:>", 0

saveprompttext:
    db 10, 13, "loading...", 0

saveinput:
    push ax
    jmp prompt.past

disknum: db 0

TIMES 510 - ($ - $$) db "A"

TIMES 510 - ($ - $$) db 0
DW 0xAA55
