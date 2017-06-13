
#const intlen = 32.

register(eax;ebx;ecx;edx;esi;edi;edp;esp;eip;imm;cmp).
flag(n;z;p).
pos(0..intlen-1).
time(0..maxtime).
flg(0, z).
    
:- flg(T, F1), flg(T, F2), F1 != F2, flag(F1), flag(F2), time(T).

%% Registers maintain value unless acted upon
regbit(T, Reg, Pos) :-
    time(T),
    register(Reg),
    pos(Pos),
    bit(B),
    regbit(T-1, Reg, Pos),
    pcat(T, PC),
    not end(PC),
    not sub(PC, _, _, Reg),
    Reg != eip,
    %Reg != eax,
    Reg != imm.
regbit(T, imm, Pos) :-
    time(T),
    pos(Pos),
    bit(B),
    regbit(T-1, imm, Pos),
    pcat(T, PC),
    not end(PC),
    not cmp_imm(PC, _, _, _).
    
%% PC advances each time step
regbit(T+1, eip, 0) :-
    time(T),
    bit(B),
    not regbit(T, eip, 0).
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    Pos > 0,
    regbit(T, eip, Pos),
    regbit(T+1, eip, Pos-1).
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    Pos > 0,
    regbit(T, eip, Pos),
    not regbit(T, eip, Pos-1).
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    Pos > 0,
    bit(B),
    not regbit(T, eip, Pos),
    not regbit(T+1, eip, Pos-1),
    regbit(T, eip, Pos-1).
    

% Comparisons    
cmp(T) :- time(T), pcat(T, PC), cmp_imm(PC, _, _, _).
    
%% Store value from cmp_imm in imm
regbit(T, imm, Pos) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    cmp_imm(PC, _, Pos).

%% Reg - imm -> cmp
sub(PC, Reg, imm, cmp) :- cmp_imm(PC, Reg, _, _).

%% Subtraction
regbit(T, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    not carry(T, Pos).
regbit(T, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    not carry(T, Pos).
regbit(T, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    carry(T, Pos).
regbit(T, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    carry(T, Pos).
    
%% Flags
flg(T, n) :- 
    cmp(T),
    carry(T, intlen).
flg(T, z) :-
    cmp(T),
    not regbit(T, cmp, _),
    not carry(T, intlen).
flg(T, p) :-
    cmp(T),
    regbit(T, cmp, _),
    not carry(T, intlen).