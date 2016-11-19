
all: 
	gcc ./src/main.o ./src/constants.o -o 10kssembly

buildmain: ./src/main.asm
	nasm -f elf64 ./src/main.asm

buildconstants: ./src/contants.inc
	nasm -f elf64 ./src/constants.inc