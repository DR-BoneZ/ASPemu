toolong(T, Reg) :-
    time(T),
    register(Reg),
    regbit(T, Reg, Pos),
    pos(Pos),
    Pos >= 4.

pcat(T, 0) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 1) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 2) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 3) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 4) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 5) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 6) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 7) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 8) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 9) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 10) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not toolong(T, eip).
pcat(T, 11) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not toolong(T, eip).
