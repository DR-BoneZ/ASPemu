
pcat(T, PC) :-
    regval(T, eip, PC).

regval(T, Reg, Val) :-
    time(T),
    register(Reg),
    regbit(T, Reg, 0, B0),
    regbit(T, Reg, 1, B1),
    regbit(T, Reg, 2, B2),
    regbit(T, Reg, 3, B3),
    regbit(T, Reg, 4, B4),
    regbit(T, Reg, 5, B5),
    regbit(T, Reg, 6, B6),
    regbit(T, Reg, 7, B7),
    Val = (B7 * (2 ** 7)) +
          (B6 * (2 ** 6)) +
          (B5 * (2 ** 5)) +
          (B4 * (2 ** 4)) +
          (B3 * (2 ** 3)) +
          (B2 * (2 ** 2)) +
          (B1 * (2 ** 1)) + B0.
