--
-- Enviornmental Modelling
-- Exercise 2 - 1
--
-- Author: Nadal Francisco Garcia
-- All rights reserved

-- model constants
world = Cell {
	planetSurface = 1000,
	whiteAlbedo = 0.75,
	blackAlbedo = 0.25,
	groundAlbedo = 0.5,
	decay = 0.3,
	luminosity = 1,
}

-- Cell with the temperatures of both plants and the world's average
temp = Cell {
	avgTemp = 22.5,
	whiteTemp = 11,
	blackTemp = 11
}

-- Cell with the are of the flowers and the bare ground
area = Cell {
	blackArea = 270,
	whiteArea = 400,
	groundArea = 330
}

-- Function that calculates the growth rate of a plant given its local temperature
function growth(temperature)
	if temperature < 5 then
		return 0
	elseif temperature < 22.5 then
		return 0.0571 * temperature - 0.2857
	elseif temperature < 40 then
		return -0.0571 * temperature + 2.284
	else
		return 0
	end
end

-- Function that calculates the average temperature given the absorbed luminosity
function avgTemp(absorbedLuminosity)
	return 200 * absorbedLuminosity - 80
end

-- Observer of the temperature
o1 = Observer{
	subject = temp,
	type = "chart",
	attributes = {"whiteTemp", "blackTemp", "avgTemp"},
	title = "Daisy World - Temperature",
	xLabel = "Year",
	yLabel = "Temperature",
	curveLabels = {"White Daisy", "Black Daisy", "Average Temperature"}
}

-- Observer of the daisies and the bare ground areas
o2 = Observer{
	subject = area,
	type = "chart",
	attributes = {"whiteArea", "blackArea", "groundArea"},
	title = "Daisy World - Surface",
	xLabel = "Year",
	yLabel = "Area",
	curveLabels = {"White Daisy", "Black Daisy", "Bare Ground"}
}

t = Timer{
	Event{time = 2000, action = function(e)
		
		-- First I calculate the planet abledo
		planetAlbedoPercentage = world.whiteAlbedo * area.whiteArea + world.blackAlbedo * area.blackArea + world.groundAlbedo * area.groundArea
		world.planetAlbedo = planetAlbedoPercentage / 1000
		
		-- Here I calculate the amount of luminosity absorbed by the planet
		absorbedLumPercentage = 1 - world.planetAlbedo
		absorbedLum = world.luminosity * absorbedLumPercentage
		
		print("absorbedLum: "..absorbedLum)
		
		-- Here the temperature is calculated using the avgTemp() function
 		temp.avgTemp = avgTemp(absorbedLum)
		temp.whiteTemp = temp.avgTemp - 20 * (world.whiteAlbedo - world.planetAlbedo)
		temp.blackTemp = temp.avgTemp + 20 * (world.planetAlbedo - world.blackAlbedo)
		
		-- We need the planet's ground area percentage to calculate the growth rates
		groundAreaPercentage = area.groundArea / world.planetSurface
		
		whiteGrowthRate = growth(temp.whiteTemp) * groundAreaPercentage - world.decay
		blackGrowthRate = growth(temp.blackTemp) * groundAreaPercentage - world.decay
		
		-- With the growth rates here is calculated the area of both flowers
		area.whiteArea = area.whiteArea + area.whiteArea * whiteGrowthRate
		area.blackArea = area.blackArea + area.blackArea * blackGrowthRate

		daisiesArea = area.whiteArea + area.blackArea
		area.groundArea = world.planetSurface - area.whiteArea - area.blackArea
		
		print("time: "..e:getTime())
		print("whiteTemp: "..temp.whiteTemp)
		print("blackTemp: "..temp.blackTemp)
		print("avgTemp: "..temp.avgTemp)
		
		print("whiteArea: "..area.whiteArea)
		print("blackArea: "..area.blackArea)
		print("groundArea: "..area.groundArea)
		
		-- After a year has passed, we update the observers
		temp:notify(e:getTime())
		area:notify(e:getTime())
		
	end}
}

-- In just ten years we know how this model will evolve
t:execute(2010)


