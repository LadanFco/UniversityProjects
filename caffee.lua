room = Cell {
	coffee1 = 80,
	coffee2 = 20,
	coffee3 = 5,
	temperature = 20
	}
	
Observer {
	subject = room,
	type = "chart",
	attributes = {"coffee1", "coffee2", "coffee3"}
}
	
t = Timer {
	Event { action = function(e)
		room.coffee1 = room.coffee1 - (room.coffee1 - room.temperature) * 0.1
		room.coffee2 = room.coffee2 - (room.coffee2 - room.temperature) * 0.1
		room.coffee3 = room.coffee3 - (room.coffee3 - room.temperature) * 0.1
		room:notify(e:getTime())
	end }
}

t:execute(20)