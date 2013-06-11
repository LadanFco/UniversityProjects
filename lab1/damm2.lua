-- The author of this code is Nadal Francisco Garcia
-- All rights reserved


city = Cell {
	population = 100000,
	year = 1950,
	energy_increase = 1.05,
	consum_per_person = 10
}

damm = Cell {
	max_cap = 5000000000,
	current_water_status = 5000000000,
	water_per_kWh = 80,
	year_increase = 3500000000,
	}
	
Observer {
	subject = damm,
	type = "chart",
	attributes = {"current_water_status"}
}
	
damm:notify(1950)

t = Timer {
	Event { time = 1950, action = function(e)
		damm.current_water_status = damm.current_water_status - (city.population * city.consum_per_person * damm.water_per_kWh)
		damm.current_water_status = damm.current_water_status + damm.year_increase
		
		if damm.current_water_status > damm.max_cap then
	    	damm.current_water_status = damm.max_cap
	    end
	    if damm.current_water_status < 0 then
	    	damm.current_water_status = 0
	    end
		
		city.year = city.year + 1
		city.consum_per_person = city.consum_per_person * city.energy_increase
		damm:notify(e:getTime())
	end }
}

t:execute(2060)