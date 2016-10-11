# Tastier Compiler
This is a working implementation of a compiler for the language Coco written in C# for the Compiler and haskell for the machine. Built on top of a minimal compiler, I added the following features:
* Multi-dimensional Arrays
* For Loops
* Switch Statements
* Runtime Array Bounds Checking
* Variable Printing

## Usage
To build the compiler, `cd` into the compiler directory and run `make`. Next `cd` into the Machines directory and run `cabal install`.

The Attributed Translation Grammar can be found in `src/grammar/Tastier.ATG`, in the Compiler Directory.

To compile and run a program, for example `Test.TAS`,  on a unix based machine run the following from the TastierCompiler Directory:
```
mono bin/tcc.exe test/Programs/Test.TAS test.asm
tasm test.asm test.bc
tvm test.bc test/Inputs/test.IN
```
