pcat(T, 0) :- pc(PC), time(T),
    not toolong(T),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1).

pcat(T, 1) :- pc(PC), time(T),
    not toolong(T),
    not regbit

toolong(T) :-
    time(T),
    regbit(T, eip, Pos),
    pos(Pos),
    Pos > 1.
