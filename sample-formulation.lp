
#const intlen = 32.

register(eax;ebx;ecx;edx;esi;edi;edp;esp;eip).
flag(n;z;p).
pos(0..intlen-1).
bit(0;1).
imm8(-128..127).
time(T) :- T = 0..maxtime.
regbit(0, Reg, Pos, 0) :- register(Reg), pos(Pos).
flg(0, Flag, 0) :- flag(Flag).
    
:- regbit(T, Reg, Pos, B1), regbit(T, Reg, Pos, B2), B1 > B2, register(Reg), pos(Pos), bit(B1), bit(B2), time(T).
:- flg(T, Flag, B1), flg(T, Flag, B2), B1 > B2, flag(Flag), bit(B1), bit(B2), time(T).
    
cmp(PC) :- cmp_imm(PC, Reg, Val), register(Reg), imm8(Val).
%cmp(PC) :- cmp_reg(PC, Reg1, Reg2), register(Reg1), register(Reg2).
    
flg(T, Flag, Val) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    flg(T-1, Flag, Val),
    not cmp(PC).

flg(T, n, 0) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    cmp_imm(PC, Reg, Val),
    register(Reg),
    imm8(Val),
    regval(T, Reg, RVal),
    RVal >= Val.
    
flg(T, n, 1) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    cmp_imm(PC, Reg, Val),
    register(Reg),
    imm8(Val),
    regval(T, Reg, RVal),
    RVal < Val.
    
flg(T, z, 0) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    cmp_imm(PC, Reg, Val),
    register(Reg),
    imm8(Val),
    regval(T, Reg, RVal),
    RVal != Val.
    
flg(T, z, 1) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    cmp_imm(PC, Reg, Val),
    register(Reg),
    imm8(Val),
    regval(T, Reg, RVal),
    RVal = Val.
    
flg(T, p, 0) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    cmp_imm(PC, Reg, Val),
    register(Reg),
    imm8(Val),
    regval(T, Reg, RVal),
    RVal <= Val.
    
flg(T, p, 1) :-
    time(T),
    flag(Flag),
    regval(T, eip, PC),
    cmp_imm(PC, Reg, Val),
    register(Reg),
    imm8(Val),
    regval(T, Reg, RVal),
    RVal > Val.

regbit(T, Reg, Pos, Val) :-
    time(T),
    register(Reg),
    pos(Pos),
    Reg != eip,
    regval(T, eip, PC),
    regbit(T-1, Reg, Pos, Val),
    Reg != eax,
    not end(PC).
    
regbit(T, eax, Pos, Val) :-
    time(T),
    pos(Pos),
    regval(T, eip, PC),
    regbit(T-1, eax, Pos, Val),
    not apicall(PC, _).
    
regval(T, eip, PC) :-
    time(T),
    regval(T-1, eip, PC-1),
    %not jmp(PC, _),
    %not je(PC, _),
    not jne(PC-1, _),
    %not jg(PC, _),
    %not jge(PC, _),
    %not jl(PC, _),
    %not jle(PC, _),
    not end(PC-1).
    
regbit(T, eip, Pos, B) :-
    time(T),
    pos(Pos),
    jne(PC2, PC),
    regval(T-1, eip, PC2),
    PC / (2 ** Pos) & 1 = B,
    flg(T-1, z, 0).
    
regbit(T, eip, Pos, B) :-
    time(T),
    pos(Pos),
    jne(PC-1, _),
    regval(T-1, eip, PC-1),
    PC / (2 ** Pos) & 1 = B,
    flg(T-1, z, 1).

apicall_res(T, Pos, 0) :-
    Pos > 8,
    time(T),
    pos(Pos),
    regval(T, eip, PC),
    apicall(PC, get_something).
1 { apicall_res(T, Pos, B):bit(B) } 1 :-
    Pos <= 8,
    time(T),
    pos(Pos),
    regval(T, eip, PC),
    apicall(PC, get_something).
    
regbit(T, eax, Pos, B) :-
    time(T),
    pos(Pos),
    apicall_res(T, Pos, B),
    regval(T, eip, PC),
    apicall(PC, _).
    
malware_sig_eicar(T) :-
    time(T),
    regval(T, eip, PC),
    eicar(PC).
    
malware_sig :- malware_sig_eicar(T), time(T).
    
%:- not malware_sig.
    
%#show malware_sig_eicar/1.
%#show apicall_res/3.
#show regval/3.
#show apicall_res/3.
