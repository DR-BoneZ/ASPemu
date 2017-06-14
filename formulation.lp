
#const intlen = 32.

register(eax;ebx;ecx;edx;esi;edi;edp;esp;eip;imm;cmp).
flag(c;z;s;o).
apitype_value(get_something).
apitype_alloc(alloc_something).
pos(0..intlen-1).
time(0..maxtime).
pc(0..maxpc).

%% Generalizations
mathop(T, cmp) :- time(T), pcat(T, PC), cmp_imm(PC, _, _).
mathop(T, Reg) :- time(T), pcat(T, PC), add(PC, _, _, Reg).
mathop(T, Reg) :- time(T), pcat(T, PC), sub(PC, _, _, Reg).
imm(T) :- time(T), pcat(T, PC), cmp_imm(PC, _, _).
    
%% Jump detection
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jmp_abs(PC, Pos).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jo_abs(PC, Pos), flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jno_abs(PC, Pos), not flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), js_abs(PC, Pos), flg(T, s).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jns_abs(PC, Pos), not flg(T, s).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jz_abs(PC, Pos), flg(T, z).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jnz_abs(PC, Pos), not flg(T, z).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jc_abs(PC, Pos), flg(T, c).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jnc_abs(PC, Pos), not flg(T, c).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jl_abs(PC, Pos), flg(T, s), not flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jl_abs(PC, Pos), not flg(T, s), flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jge_abs(PC, Pos), flg(T, s), flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jge_abs(PC, Pos), not flg(T, s), not flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jle_abs(PC, Pos), flg(T, s), not flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jle_abs(PC, Pos), not flg(T, s), flg(T, o).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jle_abs(PC, Pos), flg(T, z).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jle_abs(PC, Pos), not flg(T, s), not flg(T, o), not flg(T, z).
jump_abs(T, Pos) :- time(T), pos(Pos), pcat(T, PC), jle_abs(PC, Pos), flg(T, s), flg(T, o), not flg(T, z).
%jump(T) :- time(T), pcat(T, PC), jmp_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jo_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jno_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), js_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jns_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jz_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jnz_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jc_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jnc_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jl_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jle_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jg_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jge_rel(PC, _).
%jump(T) :- time(T), pcat(T, PC), jmp_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jo_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jno_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), js_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jns_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jz_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jnz_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jc_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jnc_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jl_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jle_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jg_reg(PC, _).
%jump(T) :- time(T), pcat(T, PC), jge_reg(PC, _).
    
%% Registers maintain value unless acted upon
regbit(T, Reg, Pos) :-
    time(T),
    register(Reg),
    pos(Pos),
    regbit(T-1, Reg, Pos),
    pcat(T, PC),
    not end(PC),
    not sub(PC, _, _, Reg),
    Reg != eip,
    Reg != eax,
    Reg != imm,
    Reg != cmp.
regbit(T, eax, Pos) :-
    time(T),
    pos(Pos),
    regbit(T-1, eax, Pos),
    pcat(T, PC),
    not end(PC),
    not apicall(PC, _).
    
%% PC advances each time step
regbit(T+1, eip, 0) :-
    time(T),
    not regbit(T, eip, 0),
    not jump_abs(T, _).
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    Pos > 0,
    regbit(T, eip, Pos),
    regbit(T+1, eip, Pos-1),
    not jump_abs(T, _).
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    Pos > 0,
    regbit(T, eip, Pos),
    not regbit(T, eip, Pos-1),
    not jump_abs(T, _).
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    Pos > 0,
    not regbit(T, eip, Pos),
    not regbit(T+1, eip, Pos-1),
    regbit(T, eip, Pos-1),
    not jump_abs(T, _).

% Set PC on Jump
regbit(T+1, eip, Pos) :-
    time(T),
    pos(Pos),
    jump_abs(T, Pos).
    
% Comparisons    

%% Store value from cmp_imm in imm
regbit(T, imm, Pos) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    cmp_imm(PC, _, Pos).

%% Reg - imm -> cmp
cmp(PC, Reg, imm, cmp) :- cmp_imm(PC, Reg, _).
    
%% MOV
regbit(T+1, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    mov(PC, Reg, Res),
    register(Reg),
    regbit(T, Reg, Pos).

%% Subtraction
regbit(T, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    cmp(PC, Reg1, Reg2, Res),
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
    cmp(PC, Reg1, Reg2, Res),
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
    cmp(PC, Reg1, Reg2, Res),
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
    cmp(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    cmp(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    cmp(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    cmp(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    carry(T, Pos).
regbit(T+1, Res, Pos) :-
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
regbit(T+1, Res, Pos) :-
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
regbit(T+1, Res, Pos) :-
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
regbit(T+1, Res, Pos) :-
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
    sub(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    carry(T, Pos).
    
%% Addition
regbit(T+1, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    not carry(T, Pos).
regbit(T+1, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    not carry(T, Pos).
regbit(T+1, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos),
    carry(T, Pos).
regbit(T+1, Res, Pos) :-
    time(T),
    register(Res),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    not regbit(T, Reg1, Pos),
    not regbit(T, Reg2, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    regbit(T, Reg2, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg1, Pos),
    carry(T, Pos).
carry(T, Pos+1) :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    add(PC, Reg1, Reg2, _),
    register(Reg1),
    register(Reg2),
    regbit(T, Reg2, Pos),
    carry(T, Pos).
    
%% API Calls: single value
0 { regbit(T, eax, Pos) } 1 :-
    time(T),
    pos(Pos),
    pcat(T, PC),
    apicall(PC, Call),
    apitype_value(Call).
    
%% Flags
flg(T, c) :- 
    time(T),
    mathop(T, _),
    carry(T, intlen).
flg(T, c) :- 
    time(T),
    not mathop(T, _),
    flg(T-1, c).
flg(T, z) :-
    time(T),
    mathop(T, Reg),
    not regbit(T, Reg, _).
flg(T, z) :-
    time(T),
    not mathop(T, _),
    flg(T-1, z).
flg(T, s) :-
    time(T),
    mathop(T, Reg),
    regbit(T, Reg, intlen-1).
flg(T, s) :-
    time(T),
    not mathop(T, _),
    flg(T-1, s).
flg(T, o) :-
    time(T),
    pcat(T, PC),
    add(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    register(Res),
    regbit(T-1, Reg1, intlen-1),
    regbit(T-1, Reg2, intlen-1),
    not regbit(T, Res, intlen-1).
flg(T, o) :-
    time(T),
    pcat(T, PC),
    add(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    register(Res),
    not regbit(T-1, Reg1, intlen-1),
    not regbit(T-1, Reg2, intlen-1),
    regbit(T, Res, intlen-1).
flg(T, o) :-
    time(T),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    register(Res),
    regbit(T-1, Reg1, intlen-1),
    not regbit(T-1, Reg2, intlen-1),
    not regbit(T, Res, intlen-1).
flg(T, o) :-
    time(T),
    pcat(T, PC),
    sub(PC, Reg1, Reg2, Res),
    register(Reg1),
    register(Reg2),
    register(Res),
    not regbit(T-1, Reg1, intlen-1),
    regbit(T-1, Reg2, intlen-1),
    regbit(T, Res, intlen-1).
flg(T, o) :-
    time(T),
    not mathop(T, _),
    flg(T-1, o).