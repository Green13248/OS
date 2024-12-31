cls:	
	mov ah, 0x00
	mov al, 0x03
	int 0x10
    mov si, Info
    jmp printf
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
	cmp byte [di], "d"
	je directory
    cmp byte [di], "r"
	je readdisk
	cmp byte [di], "c"
	je cls
	jmp Loop

printf: ;put anything into si you want to print
    mov ah, 0x0e
    mov al, [si]
    cmp al, "%"
    je Loop
    int 0x10
    inc si
    jmp printf

directory:
    mov si, TABLE
    jmp printf

readdisk:
    mov ah, 0x0e
    mov al, "$"
    int 0x10 ;print $
    mov ah, 0x00
    int 0x16 ;User input
    mov ah, 0x0e
	int 0x10 ;print users entered char to screen
	cmp al, 0xD ;check if we hit enter
	je .done ;if so go to .done to be cmp
	mov [di], al ;save our char to char
.done:
    cmp byte [di], "1"
    je readfunc1
    cmp byte [di], "2"
    je readfunc2
    cmp byte [di], "3"
    je readfunc3
    cmp byte [di], "4"
    je readfunc4
    cmp byte [di], "5"
    je readfunc5
    jmp ErrorFindFile
readfunc1:
    mov si, 0x8400
    mov di, 0 ;inc counter
    jmp loopfunc
readfunc2:
    mov si, 0x8600
    mov di, 0 ;inc counter
    jmp loopfunc
readfunc3:
    mov si, 0x8800
    mov di, 0 ;inc counter
    jmp loopfunc
readfunc4:
    mov si, 0x8A00
    mov di, 0 ;inc counter
    jmp loopfunc
readfunc5:
    mov si, 0x8C00
    mov di, 0 ;inc counter
    jmp loopfunc

loopfunc:
    mov ah, 0x0e
    mov al, [si]
    cmp di, 512
    je Loop
    int 0x10
    inc si
    inc di
    jmp loopfunc

ErrorFindFile:
    mov si, Filenotfound
    jmp printf


Filenotfound: db "That file does not exist", "%"
Badcommand: db "Your command was bad"
Info: db "***Green OS v0.0.2***%"
TABLE: db "Hello.txt", "Paint.run", "Text.txt", "Work.txt", "Okay.txt", "%"
Hellotxt: db "Hello.txt", 0
Paintrun: db "Paint.run", 0
Texttxt: db "Text.txt", 0
Worktxt: db "Work.txt", 0
Okaytxt: db "Okay.txt", 0
buffer: db 0
TIMES 2048 - ($ - $$) db "R"

db "Hello   txt"
TIMES 501 db "0"
db "Paint   run"
TIMES 501 db "0"
db "Text    txt"
TIMES 501 db "0"
db "Work    txt"
TIMES 501 db "0"
db "Okay    txt"
TIMES 501 db "0"
