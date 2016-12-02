#10kssembly
10kssembly is a POC and benchmark program that experiements with a number of NASM system calls for dealing
with multiple TCP connections. 10kssembly is meant to demonstrate the 10k problem using multi-processing,
select and epoll system calls. The client then benchmarks these systems for their performance. All components
are coded in Linux NASM x64 Assembly, giving a performance boost in these different systems


#Prerequisites
NASM Assembler must be installed on your system. It can be done with
```
sudo dnf install nasm

sudo apt-get install nasm
```

#Setup
##Installation
Each component must be individualy compiled. `cd` into the /src/{component} folder of your choice
and open the source code file main.asm in that folder. Instructions at the top will specify how
to compile the project. For most cases the compilation procedure is as follows

From within the directory of the component you wish to compile
```
nams -f elf64 -d ELF_TYPE -i .././ main.asm
gcc main.o -o main.out
```
You can then execute the main.out program to run it
