
apicall(1, get_clipboard_data).
add_imm(2, eax, eax, 4). %Let's say there is some useful value at offset 4 of the clipboard object
mov_dir(3, edx, eax).
cmp(4, edx, 0).
jne(5, 7).
eicar(6).
end(7).