
register(eax;ebx;ecx;edx;esi;edi;edp;esp;eip).
apicall_alloc(0, 0, 200)

:- reg(T, Reg, Val1), reg(T, Reg, Val2), Val1 < Val2, register(Reg).
    
reg(T, eip, PC) :-
    reg(T-1, eip, PC-1),
    not jmp(PC-1, _),
    not je(PC-1, _),
    not jne(PC-1, _),
    not jg(PC-1, _),
    not jge(PC-1, _),
    not jl(PC-1, _),
    not jle(PC-1, _).
    
apicall_res(T, Addr) :-
    reg(T, eip, PC),
    apicall(PC, get_clipboad_data),
    apicall_alloc(T2, Base, Size),
    T2 < T,
    Addr = Base + Size,
    not apicall_alloc(T3, Addr),
    T3 < T.
    
apicall_alloc(T, Base, 40) :-
    apicall_res(T, Base),
    reg(T, eip, PC),
    apicall(PC, get_clipboad_data).
    
reg(T, eax, Val) :-
    apicall_res(T, Val),
    reg(T, eip, PC),
    apicall(PC, _).
    
mov_dir_res(T, Reg, Addr, Val) :-
    reg(T, eip, PC),
    mov_dir(PC, Reg, AddrReg),
    reg(T, AddrReg, Addr),
    apicall_alloc(T2, Base, Size),
    T2 < T,
    Addr = Base..Base+Size-1,
    Val =  −2147483648..2147483647.
    
reg(T, Reg, Val) :-
    mov_dir_res(T, Reg, _, Val).
    
malware_sig_eicar(T) :-
    reg(T, eip, PC),
    eicar(PC).
    
malware_sig :- malware_sig_eicar(_).
    
:- not malware_sig