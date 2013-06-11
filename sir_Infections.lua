city = Cell {
	susceptible = 9998,
	infected = 2,
	recovered = 0
}

o = Observer {
	subject = city,
	attributes = {"susceptible", "infected", "recovered"},
	type = "chart",
	curveLabels = {"susceptible", "infected", "recovered"}
}

city:notify(0)

t = Timer {
	Event {action = function(e)
		city.recovered = city.recovered + city.infected / 2
		
		new_infected = city.infected * 6 / 4 - city.infected / 2
		
		if city.infected > city.susceptible then
			new_infected = city.susceptible
		end
		
		city.infected = new_infected + city.infected / 2
		
		city.susceptible = 10000 - city.recovered - city.infected
		
		city:notify(e:getTime())
	end}
}

t:execute(30)