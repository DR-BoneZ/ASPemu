
#const intlen = 32.

register(eax;ebx;ecx;edx;esi;edi;edp;esp;eip).
pos(0..intlen-1).
bit(0;1).
time(T) :- T = 0..maxtime.
regbit(0, Reg, Pos, 0) :- register(Reg), pos(Pos).
    
:- regbit(T, Reg, Pos, B1), regbit(T, Reg, Pos, B2), B1 != B2, register(Reg), pos(Pos), bit(B1), bit(B2), time(T).
    
regbit(T, Reg, Pos, Val) :-
    time(T),
    register(Reg),
    pos(Pos),
    Reg != eip,
    regval(T, eip, PC),
    regbit(T-1, Reg, Pos, Val),
    not end(PC).
    
regval(T, eip, PC) :-
    time(T),
    regval(T-1, eip, PC-1),
    not end(PC-1).
    
%#show malware_sig_eicar/1.
%#show apicall_res/3.
#show regbit/4.