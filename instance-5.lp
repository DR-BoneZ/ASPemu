
#const maxtime = 18.

apicall(1, get_something).
cmp_imm(2, eax, 0).
jne(3, 5).
eicar(4).
apicall(5, get_something).
cmp_imm(6, eax, 12).
jne(7, 9).
eicar(8).
apicall(9, get_something).
cmp_imm(10, eax, 24).
jne(11, 13).
eicar(12).
end(13).