
math.randomseed(os.time())

world = CellularSpace{
	xdim = 50,
	ydim = 50
}

world:createNeighborhood{
	strategy = "moore",
	self = false
}

forEachCell(world, function(cell)
	if math.random() > 0.1 then
		cell.cover = "forest"
	else
		cell.cover = "empty"
	end
end)

legend = Legend {
	grouping = "uniquevalue",
	type = "string",
	colorBar = {
		{value = "forest", color = "green"},
		{value = "burning", color = "red"},
		{value = "burned", color = "brown"},
		{value = "empty", color = "white"}
	}
}

Observer{
	subject = world,
	attributes = {"cover"},
	legends = {legend}
}

update = function(cs)
	forEachCell(cs, function(cell)
		if cell.past.cover == "forest" then
			forEachNeighbor(cell, function(cell, neighbor)
				if neighbor.past.cover == "burning" then
					cell.cover = "burning"
				end
			end)
		elseif cell.past.cover == "burning" then
			cell.cover = "burned"
		end
	end)
end

world:sample().cover = "burning"
world:notify()

t = Timer{
	Event{action = function(e)
		world:synchronize()
		update(world)
		world:notify()
	end}
}

t:execute(100)

