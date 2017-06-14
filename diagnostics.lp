
apicall_ret(T, PC) :-
    time(T),
    pcat(T, PC),
    apicall(PC, _).
    
apicall_res(T, Pos) :-
    apicall_ret(T, _),
    pos(Pos),
    regbit(T, eax, Pos).
    
#show apicall_ret/2.
#show apicall_res/2.
#show malware_sig_eicar/2.