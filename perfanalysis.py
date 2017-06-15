
for i in range(4):
    with ('perftest.ins', 'w') as f:
        PC = 1
        for j in range(1<<i):
            f.write("0x{:02X} APICALL GetSomething\n".format(PC))
            f.write("0x{:02X} CMP EAX 0xDEADBEEF\n".format(PC+1))
            f.write("0x{:02X} JNZ 0x{:X}".format(PC+2, (3 * (1<<i)) + 3))
            PC = PC + 3
        f.write("0x{:02X} EICAR".format(PC))
        f.write("0x{:02X} APICALL Exit".format((3 * (1<<i)) + 3))
    print(str(i) + ": ", end='')
    exec("bash aspemu perftest.ins | grep Total")