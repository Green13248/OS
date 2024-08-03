# OS

This is an OS developed by me

Maybe someday it will do these things:
  Run in 32 bit mode
  Run in 64 bit mode
  Have some form of window manager/windowing system (Might be x11 or other)
  Have some form of language compiler (C, C++, Perl)
  Run some form of web/internet browser
  Be able to open things like bitmaps and png or jpegs
  Be not all asm


important for building:

nasm -f bin "C:\User\Desktop\Operating\nameSource.txt" -o "C:\User\Desktop\nameCompiled.ISO" to build into an ISO

gcc -c File.c -o File.o to make a c into object

g++ -cpp File.cpp -o File.o to make a cpp into an object

gcc File1.o File2.o -o File3 to link your object files

nasm "C:\Users\Desktop\Source.asm" -f elf -o "C:\Users\Desktop\Source.o" to make asm into an object file

"C:\Program Files\qemu\qemu-system-x86_64.exe" "C:\User\Desktop\nameCompiled.ISO" to run on Qemu

