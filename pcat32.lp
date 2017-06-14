toolong(T) :-
    time(T),
    regbit(T, eip, Pos),
    pos(Pos),
    Pos >= 5.

pcat(T, 0) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 1) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 2) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 3) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 4) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 5) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 6) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 7) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 8) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 9) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 10) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 11) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 12) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 13) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 14) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 15) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    regbit(T, eip, 2),
    regbit(T, eip, 3),
    not regbit(T, eip, 4),
    not toolong(T).
pcat(T, 16) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    regbit(T, eip, 4),
    not toolong(T).
pcat(T, 17) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    not regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    regbit(T, eip, 4),
    not toolong(T).
pcat(T, 18) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    regbit(T, eip, 4),
    not toolong(T).
pcat(T, 19) :-
    time(T),
    pc(PC),
    regbit(T, eip, 0),
    regbit(T, eip, 1),
    not regbit(T, eip, 2),
    not regbit(T, eip, 3),
    regbit(T, eip, 4),
    not toolong(T).
pcat(T, 20) :-
    time(T),
    pc(PC),
    not regbit(T, eip, 0),
    not regbit(T, eip, 1),
    regbit(T, eip, 2),
    not regbit(T, eip, 3),
    regbit(T, eip, 4),
    not toolong(T).
