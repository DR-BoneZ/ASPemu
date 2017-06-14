
#const maxtime = 16.
#const maxpc = 8.

apicall(1, get_something).
cmp_imm(2, eax, 0).
jl_abs(3, 0).
jl_abs(3, 2).
eicar(4).
apicall(5, get_something).
cmp_imm(6, eax, 3).
cmp_imm(6, eax, 7).
jge_abs(7, 0).
jge_abs(7, 1).
end(maxpc).