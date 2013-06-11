function foreach(tab, func)
	for position, value in pairs(tab) do
		func(value, position)
	end
end

x = {7, 3, 2, 6, 4}

foreach(x, function(element)
	print(element)
end)

foreach(x, function(value, position)
	print(position, value)
end)
