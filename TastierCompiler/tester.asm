.names 3
.proc Main
.var 1 x
.var 1 i
Main: Enter 0
Const 0
StoG 3
L$0: Nop
LoadG 3
Const 1
Add
StoG 3
LoadG 3
Const 10
Lsse
FJmp L$2
LoadG 3
Const 5
Lsse
FJmp L$3
LoadG 3
Jmp L$4
L$3: Nop
LoadG 3
Const 5
Sub
L$4: Nop
StoG 4
LoadG 4
Write
Jmp L$0
L$2: Nop
Leave
Ret
