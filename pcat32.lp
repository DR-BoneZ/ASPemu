toolong(T) :-
    time(T),
    regbit(T, eip, Pos),
    pos(Pos),
    Pos >= 3.

pcat(T, 0) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not toolong(T).
pcat(T, 1) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not toolong(T).
pcat(T, 2) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not toolong(T).
pcat(T, 3) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not toolong(T).
pcat(T, 4) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not toolong(T).
pcat(T, 5) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not toolong(T).
