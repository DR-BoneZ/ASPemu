
regbit(T, Reg, Pos, B) :-
    time(T),
    register(Reg),
    pos(Pos),
    regval(T, Reg, Val),
    Val / (2 ** Pos) & 1 = B.

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
    regbit(T, Reg, 16, B16),
    regbit(T, Reg, 17, B17),
    regbit(T, Reg, 18, B18),
    regbit(T, Reg, 19, B19),
    regbit(T, Reg, 20, B20),
    regbit(T, Reg, 21, B21),
    regbit(T, Reg, 22, B22),
    regbit(T, Reg, 23, B23),
    regbit(T, Reg, 24, B24),
    regbit(T, Reg, 25, B25),
    regbit(T, Reg, 26, B26),
    regbit(T, Reg, 27, B27),
    regbit(T, Reg, 28, B28),
    regbit(T, Reg, 29, B29),
    regbit(T, Reg, 30, B30),
    regbit(T, Reg, 31, B31),
    Val = (B31 * (2 ** 31)) +
          (B30 * (2 ** 30)) +
          (B29 * (2 ** 29)) +
          (B28 * (2 ** 28)) +
          (B27 * (2 ** 27)) +
          (B26 * (2 ** 26)) +
          (B25 * (2 ** 25)) +
          (B24 * (2 ** 24)) +
          (B23 * (2 ** 23)) +
          (B22 * (2 ** 22)) +
          (B21 * (2 ** 21)) +
          (B20 * (2 ** 20)) +
          (B19 * (2 ** 19)) +
          (B18 * (2 ** 18)) +
          (B17 * (2 ** 17)) +
          (B16 * (2 ** 16)) +
          (B15 * (2 ** 15)) +
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