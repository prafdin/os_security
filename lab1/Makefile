# run: make all FILE=src.asm

OBJ_FILE="a.o"

all: $(OBJ_FILE)
	gcc -g $(OBJ_FILE) -m64 -fno-pie -no-pie

$(OBJ_FILE): $(FILE)
	nasm -f elf64 -g $(FILE) -o $(OBJ_FILE)



clean:
	rm -f *.o
