
import re

def convert_case(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def geninstance(filename, timesteps):
    with open(filename) as f:
        with open("instance.lp", 'w') as g:
            section = "none"
            maxpc = 0
            maxtime = timesteps
            for line in f:
                line = line.strip()
                if line == ".code":
                    section = "code"
                    continue
                elif line == ".data":
                    section = "data"
                    continue
                elif section == "code":
                    ins = line.split(" ")
                    if ins[1] == "APICALL":
                        if ins[2].lower() == "exit":
                            g.write("end({:d}).\n".format(int(ins[0], 0)))
                        else:
                            g.write("apicall({:d}, {:s}).\n".format(int(ins[0], 0), convert_case(ins[2])))
                    elif ins[1] == "MOV":
                        try:
                            imm = int(ins[2], 0)
                            if imm == 0:
                                g.write("mov_imm({:d}, {:s}, zero).\n".format(int(ins[0], 0), ins[3].lower()))
                            else:
                                for i in range(0, imm.bit_length()):
                                    if imm & (1<<i) != 0:
                                        g.write("mov_imm({:d}, {:s}, {:d}).\n".format(int(ins[0], 0), ins[3].lower(), i))
                        except ValueError:
                            g.write("mov({:d}, {:s}, {:s}).\n".format(int(ins[0], 0), ins[2].lower(), ins[3].lower()))
                    elif ins[1] == "CMP":
                        try:
                            imm = int(ins[3], 0)
                            if imm == 0:
                                g.write("cmp_imm({:d}, {:s}, zero).\n".format(int(ins[0], 0), ins[2].lower()))
                            else:
                                for i in range(0, imm.bit_length()):
                                    if imm & (1<<i) != 0:
                                        g.write("cmp_imm({:d}, {:s}, {:d}).\n".format(int(ins[0], 0), ins[2].lower(), i))
                        except ValueError:
                            g.write("cmp({:d}, {:s}, {:s}, cmp).\n".format(int(ins[0], 0), ins[2].lower(), ins[3].lower()))
                    elif ins[1] == "ADD" or ins[1] == "SUB":
                        try:
                            imm = int(ins[3], 0)
                            if imm == 0:
                                g.write("{:s}_imm({:d}, {:s}, zero, {:s}).\n".format(ins[1].lower(), int(ins[0], 0), ins[2].lower(), ins[4].lower()))
                            else:
                                for i in range(0, imm.bit_length()):
                                    if imm & (1<<i) != 0:
                                        g.write("{:s}_imm({:d}, {:s}, {:d}, {:s}).\n".format(ins[1].lower(), int(ins[0], 0), ins[2].lower(), i, ins[4].lower()))
                        except ValueError:
                            g.write("{:s}({:d}, {:s}, {:s}, {:s}).\n".format(ins[1].lower(), int(ins[0], 0), ins[2].lower(), ins[3].lower(), ins[4].lower()))
                    elif ins[1][0] == 'J':
                        try:
                            imm = int(ins[2], 0)
                            if imm == 0:
                                g.write("{:s}_abs({:d}, zero).\n".format(ins[1].lower(), int(ins[0], 0)))
                            else:
                                for i in range(0, imm.bit_length()):
                                    if imm & (1<<i) != 0:
                                        g.write("{:s}_abs({:d}, {:d}).\n".format(ins[1].lower(), int(ins[0], 0), i))
                        except ValueError:
                            g.write("{:s}_reg({:d}, {:s}).\n".format(ins[1].lower(), int(ins[0], 0), ins[2].lower()))
                    elif ins[1] == 'STO':
                        try:
                            imm = int(ins[3], 0)
                            if imm == 0:
                                g.write("sto_imm({:d}, {:s}, zero).\n".format(int(ins[0], 0), ins[2].lower()))
                            else:
                                for i in range(0, imm.bit_length()):
                                    if imm & (1<<i) != 0:
                                        g.write("sto_imm({:d}, {:s}, {:d}).\n".format(int(ins[0], 0), ins[2].lower(), i))
                        except ValueError:
                            g.write("sto({:d}, {:s}, {:s}).\n".format(int(ins[0], 0), ins[2].lower(), ins[3].lower()))
                    elif ins[1] == 'EICAR':
                        g.write("{:s}({:d}).\n".format(ins[1].lower(), int(ins[0], 0)))
                    maxpc = max(maxpc, int(ins[0], 0))
            if timesteps == 0:
                maxtime = 2*maxpc
            g.write("\n#const maxpc = {:d}.\n#const maxtime = {:d}.\n".format(maxpc, maxtime))
            return maxpc