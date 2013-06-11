x = {7, 3, 2, 6, 4, 3, 9}

print(x[1])
x[1] = x[2] + x[3]
print(x[1])
print(#x)

for i = 1, #x do
	print(i.." "..x[i])
end
