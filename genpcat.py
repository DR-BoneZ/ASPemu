
def genpcat(bits, maxpc):
    with open('pcat' + str(bits) + '.lp', 'w') as f:
        f.write('toolong(T, Reg) :-\n')
        f.write('    time(T),\n')
        f.write('    register(Reg),\n')
        f.write('    regbit(T, Reg, Pos),\n')
        f.write('    pos(Pos),\n')
        f.write('    Pos >= ' + str(maxpc.bit_length()) + '.\n\n')
        for i in range(0, maxpc + 1):
            f.write('pcat(T, ' + str(i) + ') :-\n')
            f.write('    time(T),\n')
            f.write('    pc(PC),\n')
            for j in range(0, maxpc.bit_length()):
                f.write('    ' + ('' if i&(1<<j) else 'not ') + 'regbit(T, eip, ' + str(j) + '),\n')
            f.write('    not toolong(T, eip).\n')