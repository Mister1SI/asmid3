nasm main.asm -felf64 -o  main.o
ld main.o -o main
rm main.o
./main
