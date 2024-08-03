[ORG 0x7c00]
bits 16

mov si, 0

call cls
jmp $

cls:
    pusha
    mov ah, 0x00
    mov al, 0x03  ; text mode 80x25 16 colors
    int 0x10
    popa

print:
    mov ah, 0x0e
    mov al, [info + si]
    int 0x10
    add si, 1
    cmp byte [info + si], 0
    jne print

prompt:
    mov ah, 0x0e
    mov al, ">"
    int 0x10
jmp $

DiskNum: db 0

info:
    db "Welcome to Ben's OS",13,10, 0

times 510-($-$$) db 0	; Pad the bootloader to 510 bytes
dw 0xAA55			   ; Boot signature at 511-512 bytes
