
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
    regbit(T, Reg, 8, B8),
    regbit(T, Reg, 9, B9),
    regbit(T, Reg, 10, B10),
    regbit(T, Reg, 11, B11),
    regbit(T, Reg, 12, B12),
    regbit(T, Reg, 13, B13),
    regbit(T, Reg, 14, B14),
    regbit(T, Reg, 15, B15),
    Val = (B15 * (2 ** 15)) +
          (B14 * (2 ** 14)) +
          (B13 * (2 ** 13)) +
          (B12 * (2 ** 12)) +
          (B11 * (2 ** 11)) +
          (B10 * (2 ** 10)) +
          (B9 * (2 ** 9)) +
          (B8 * (2 ** 8)) +
          (B7 * (2 ** 7)) +
          (B6 * (2 ** 6)) +
          (B5 * (2 ** 5)) +
          (B4 * (2 ** 4)) +
          (B3 * (2 ** 3)) +
          (B2 * (2 ** 2)) +
          (B1 * (2 ** 1)) + B0.
