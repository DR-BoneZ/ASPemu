
import json

maxtime = 16
maxpc = 8
maxtimelen = str(int(maxtime.bit_length()/4)+1)
maxpclen = str(int(maxpc.bit_length()/4)+1)

calls = {}
sigs = []
cpu = 0
grounding = 0
solving = 0

with open('trace.json') as f:
    data = json.loads(f.read())
    if "Witnesses" in data["Call"][0]:
        for fact in data["Call"][0]["Witnesses"][-1]["Value"]:
            ent = fact.split('(')
            ent[1] = ent[1][:-1].split(',')
            if ent[0] == "apicall_ret":
                if not int(ent[1][0]) in calls:
                    calls[int(ent[1][0])] = {'PC' : int(ent[1][1]), 'value': 0}
                else:
                    calls[int(ent[1][0])]['PC'] = int(ent[1][1])
            if ent[0] == "apicall_res":
                if not int(ent[1][0]) in calls:
                    calls[int(ent[1][0])] = {'PC' : 0, 'value': 1<<int(ent[1][1])}
                else:
                    calls[int(ent[1][0])]['value'] += 1<<int(ent[1][1])
            if ent[0][:12] == "malware_sig_":
                sigs.append({'type':ent[0][12:], 'time': int(ent[1][0]), 'PC': int(ent[1][1])})
    else:
        print("No malware signatures could be reached.")
    cpu = data["Time"]["CPU"]
    solving = data["Time"]["Solve"]
    grounding = cpu - solving
            
for sig in sigs:
    print(("Signature {:s} encountered at time 0x{:0" + maxtimelen + "X} at PC 0x{:0" + maxpclen + "X}\n")\
          .format(sig['type'].upper(), sig['time'], sig['PC']))
    print(("{:" + str(int(maxtimelen)+2) + "s}\t{:" + str(int(maxpclen)+2) + "s}\t{:10s}").format("Time", "PC", "Value"))
    for call in sorted(calls.items()):
        print(("0x{:0" + maxtimelen + "X}\t0x{:0" + maxpclen + "X}\t0x{:08X}")\
             .format(call[0], call[1]['PC'], call[1]['value']))    
        
print('\nTotal Time: {:1.03f}s\tGrounding: {:1.03f}s\tSolving: {:1.03f}s'.format(cpu, grounding, solving))