
#const intlen = 32.

register(eax;ebx;ecx;edx;esi;edi;edp;esp;eip;imm;cmp).
flag(n;z;p).
pos(0..intlen-1).
bit(0;1).
time(0..maxtime).
regbit(0, Reg, Pos, 0) :- register(Reg), pos(Pos).
flg(0, z).
    
:- regbit(T, Reg, Pos, B1), regbit(T, Reg, Pos, B2), B1 > B2, register(Reg), pos(Pos), bit(B1), bit(B2), time(T).
:- flg(T, F1), flg(T, F2), F1 != F2, flag(F1), flag(F2), time(T).

%% Registers maintain value unless acted upon
regbit(T, Reg, Pos, B) :-
    time(T),
    register(Reg),
    pos(Pos),
    bit(B),
    regbit(T-1, Reg, Pos, B),
    pcat(T, PC),
    not end(PC),
    not sub(PC, _, _, Reg),
    Reg != eip,
    %Reg != eax,
    Reg != imm.
regbit(T, imm, Pos, B) :-
    time(T),
    pos(Pos),
    bit(B),
    regbit(T-1, imm, Pos, B),
    pcat(T, PC),
    not end(PC),
    not cmp_imm(PC, _, _, _).
    
%% PC advances each time step
regbit(T+1, eip, 0, B) :-
    time(T),
    bit(B),
    regbit(T, eip, 0, B^1).
regbit(T+1, eip, Pos, B) :-
    time(T),
    pos(Pos),
    Pos > 0,
    bit(B),
    regbit(T, eip, Pos, B),
    regbit(T+1, eip, Pos-1, 1).
regbit(T+1, eip, Pos, B) :-
    time(T),
    pos(Pos),
    Pos > 0,
    bit(B),
    regbit(T, eip, Pos, B),
    regbit(T, eip, Pos-1, 0).
regbit(T+1, eip, Pos, B) :-
    time(T),
    pos(Pos),
    Pos > 0,
    bit(B),
    regbit(T, eip, Pos, B^1),
    regbit(T+1, eip, Pos-1, 0),
    regbit(T, eip, Pos-1, 1).
    

% Comparisons    
cmp(T) :- time(T), pcat(T, PC), cmp_imm(PC, _, _, _).
    
%% Store value from cmp_imm in imm
regbit(T, imm, Pos, B) :-
    time(T),
    pos(Pos),
    bit(B),
    pcat(T, PC),
    cmp_imm(PC, _, Pos, B).

%% Reg - imm -> cmp
sub(PC, Reg, imm, cmp) :- cmp_imm(PC, Reg, _, _).

%% Subtraction
regbit(T, Res, Pos, B) :-
    time(T),
    register(Res),
    pos(Pos),
    bit(B),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos, B1),
    regbit(T, Reg2, Pos, B2),
    B = B1 ^ B2,
    not carry(T, Pos).
regbit(T, Res, Pos, B) :-
    time(T),
    register(Res),
    pos(Pos),
    bit(B),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos, B1),
    regbit(T, Reg2, Pos, B2),
    B = B1 ^ B2 ^ 1,
    carry(T, Pos).
carry(T, Pos-1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos, 0),
    regbit(T, Reg2, Pos, 1).
carry(T, Pos-1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos, B),
    regbit(T, Reg2, Pos, B),
    bit(B),
    carry(T, Pos).
    
%% Flags
flg(T, n) :- 
    cmp(T),
    carry(T, 0).
flg(T, z) :-
    cmp(T),
    not regbit(T, cmp, _, 1),
    not carry(T, 0).
flg(T, p) :-
    cmp(T),
    regbit(T, cmp, _, 1),
    not carry(T, 0).