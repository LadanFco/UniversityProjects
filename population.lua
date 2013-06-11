population = Cell {
	pop1 = 60,
	pop2 = 20
	}
	
Observer {
	subject = population,
	type = "chart",
	attributes = {"pop1", "pop2"}
}

t = Timer {
	Event { action = function(e)
		population.pop1 = population.pop1 + (population.pop1 * 0.5)
		population.pop2 = population.pop2 + (population.pop2 * 0.9)
		population:notify(e:getTime())
	end }
}

t:execute(7)