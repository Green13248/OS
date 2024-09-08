bootloader.bin:bootloader.asm kernelpoint.asm
	nasm -f bin bootloader.asm -o bootloader.bin
clean:
	remove bootloader.bin

run:
	qemu-system-x86_64 bootloader.bin

