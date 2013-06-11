a = 6; b = 5

if a < 0 then
	print("a < 0")
end

if a < b then print("a < b") else print("a >= b") end

if a < b then 
	print("a < b")
elseif a < b + 5 then
	print("b <= a < b+5")
else
	print("a > b+5")
end
