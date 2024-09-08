	[org 0x7c00]
	%include "kernelpoint.asm"
	call "kernelpoint.asm"

	TIMES 510 - ($ - $$) db 0
	DW 0xAA55

