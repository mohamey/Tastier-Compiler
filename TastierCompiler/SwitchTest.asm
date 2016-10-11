.names 1
.proc Main
Main: Enter 12
Const 10
Const 7
Const 14
Sto 0 8
Const 0
StoG 14
Const 7
Load 0 8
Dup
Const 10
Equ
FJmp L$0
Const 2
Const 100
Sto 0 3
Const 1
StoG 14
Jmp L$1
L$0: Nop
Dup
Const 11
Equ
FJmp L$1
Const 2
Const 200
Sto 0 3
Const 1
StoG 14
Jmp L$2
L$1: Nop
Dup
Const 12
Equ
FJmp L$2
Const 2
Const 300
Sto 0 3
Const 1
StoG 14
Jmp L$3
L$2: Nop
Dup
Const 13
Equ
FJmp L$3
Const 2
Const 400
Sto 0 3
Const 1
StoG 14
Jmp L$4
L$3: Nop
Dup
Const 140
Equ
FJmp L$4
Const 2
Const 500
Sto 0 3
Const 1
StoG 14
Jmp L$5
L$4: Nop
Dup
Const 15
Equ
FJmp L$5
Const 2
Const 600
Sto 0 3
Const 1
StoG 14
Jmp L$6
L$5: Nop
Const 0
LoadG 14
Equ
FJmp L$6
Const 2
Const 1000
Sto 0 3
L$6: Nop
Const 2
Load 0 3
Write
Leave
Ret
