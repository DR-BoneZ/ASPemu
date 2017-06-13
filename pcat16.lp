toolong(T) :-
    time(T),
    regbit(T, eip, Pos),
    pos(Pos),
    Pos >= 2.

pcat(T, 0) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not toolong(T).
pcat(T, 1) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not toolong(T).
pcat(T, 2) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not toolong(T).
