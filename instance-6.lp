
#const maxtime = 6.
#const maxpc = 5.

apicall(1, get_something).
cmp_imm(2, eax, 0).
jge_abs(3, 0).
jge_abs(3, 2).
eicar(4).
end(maxpc).