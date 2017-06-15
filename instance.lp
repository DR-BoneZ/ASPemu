apicall(1, get_something).
mov(2, eax, ebx).
apicall(3, get_something).
add(4, eax, ebx, eax).
cmp_imm(5, eax, 0).
cmp_imm(5, eax, 2).
cmp_imm(5, eax, 4).
cmp_imm(5, eax, 7).
cmp_imm(5, eax, 12).
cmp_imm(5, eax, 15).
cmp_imm(5, eax, 16).
cmp_imm(5, eax, 22).
jl_abs(6, 0).
jl_abs(6, 1).
jl_abs(6, 3).
mov(7, eip, eax).
cmp_imm(8, ebx, 3).
cmp_imm(8, ebx, 7).
jge_abs(9, 0).
jge_abs(9, 1).
jge_abs(9, 3).
sto(10, ebx, eax).
end(11).

#const maxpc = 11.
#const maxtime = 22.
