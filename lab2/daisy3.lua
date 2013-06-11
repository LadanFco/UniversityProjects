--
-- Enviornmental Modelling
-- Exercise 2 - 3
--
-- Author: Nadal Francisco Garcia
-- All rights reserved

world = Cell {
	planetSurface = 1000,
	whiteAlbedo = 0.75,
	blackAlbedo = 0.25,
	groundAlbedo = 0.5,
	decay = 0.3,
	luminosity = 1,
}

temp = Cell {
	avgTemp = 22.5,
	whiteTemp = 11,
	blackTemp = 11
}

area = Cell {
	blackArea = 270,
	whiteArea = 400,
	groundArea = 330
}

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

function avgTemp(absorbedLuminosity)
	return 200 * absorbedLuminosity - 80
end

o1 = Observer{
	subject = temp,
	type = "chart",
	attributes = {"whiteTemp", "blackTemp", "avgTemp"},
	title = "Daisy World - Temperature",
	xLabel = "Year",
	yLabel = "Temperature",
	curveLabels = {"White Daisy", "Black Daisy", "Average Temperature"}
}

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
				
		planetAlbedoPercentage = world.whiteAlbedo * area.whiteArea + world.blackAlbedo * area.blackArea + world.groundAlbedo * area.groundArea
		world.planetAlbedo = planetAlbedoPercentage / 1000
		
		--------------------------------------------------
		-- The only modification of the code is here
		-- The luminosity is decreased to 0.95 in 2010
		if (e:getTime() == 2010) then
			world.luminosity = 0.95
		end
		-- end of modifications
		--------------------------------------------------

		absorbedLumPercentage = 1 - world.planetAlbedo
		absorbedLum = world.luminosity * absorbedLumPercentage
		
		print("absorbedLum: "..absorbedLum)
		
 		temp.avgTemp = avgTemp(absorbedLum)
		
		temp.whiteTemp = temp.avgTemp - 20 * (world.whiteAlbedo - world.planetAlbedo)
		temp.blackTemp = temp.avgTemp + 20 * (world.planetAlbedo - world.blackAlbedo)
		
		groundAreaPercentage = area.groundArea / world.planetSurface
		
		whiteGrowthRate = growth(temp.whiteTemp) * groundAreaPercentage - world.decay
		blackGrowthRate = growth(temp.blackTemp) * groundAreaPercentage - world.decay
		
		area.whiteArea = area.whiteArea + area.whiteArea * whiteGrowthRate
		area.blackArea = area.blackArea + area.blackArea * blackGrowthRate

		daisiesArea = area.whiteArea + area.blackArea
		area.groundArea = world.planetSurface - area.whiteArea - area.blackArea
		
		print("time: "..e:getTime())
		print("whiteGrowthRate: "..whiteGrowthRate)
		print("blackGrowthRate: "..blackGrowthRate)
		
		print("whiteArea: "..area.whiteArea)
		print("blackArea: "..area.blackArea)
		print("groundArea: "..area.groundArea)
		
		temp:notify(e:getTime())
		area:notify(e:getTime())
		
	end}
}

t:execute(2020)


