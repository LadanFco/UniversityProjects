
world = CellularSpace{
	xdim = 50,
	ydim = 50
}

world:createNeighborhood{
	strategy = "vonneumann",
	self = false
}

forEachCell(world, function(cell)
	cell.cover = "forest"
end)

legend = Legend {
	grouping = "uniquevalue",
	type = "string",
	colorBar = {
		{value = "forest", color = "green"},
		{value = "burning", color = "red"},
		{value = "burned", color = "brown"},
	}
}

Observer{
	subject = world,
	attributes = {"cover"},
	legends = {legend}
}

update = function(cs)
	forEachCell(cs, function(cell)
		if cell.cover == "forest" then
			forEachNeighbor(cell, function(cell, neighbor)
				if neighbor.cover == "burning" then
					cell.cover = "burning"
				end
			end)
		elseif cell.cover == "burning" then
			cell.cover = "burned"
		end
	end)
end

world:sample().cover = "burning"
world:notify()

t = Timer{
	Event{action = function()
		update(world)
		world:notify()
	end}
}

t:execute(90)

