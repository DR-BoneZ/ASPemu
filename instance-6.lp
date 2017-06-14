
#const maxtime = 20.
#const maxpc = 10.

apicall(1, get_something).
mov(2, eax, ebx).
apicall(3, get_something).
add(4, eax, ebx, eax).
cmp_imm(5, eax, 0).
cmp_imm(5, eax, 2).
cmp_imm(5, eax, 4).
cmp_imm(5, eax, 7).
cmp_imm(5, eax, 12).
cmp_imm(5, eax, 16).
cmp_imm(5, eax, 17).
cmp_imm(5, eax, 23).
jl_abs(6, 0).
jl_abs(6, 1).
jl_abs(6, 3).
cmp_imm(8, ebx, 3).
cmp_imm(8, ebx, 7).
jge_abs(9, 0).
jge_abs(9, 1).
jge_abs(9, 3).
eicar(10).
end(maxpc).