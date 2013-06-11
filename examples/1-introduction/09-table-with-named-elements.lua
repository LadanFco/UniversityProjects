loc = {
	cover = "forest",
	distRoad = 0.3,
	distUrban = 2
}

print(loc["cover"])
print(loc.cover)
loc.distRoad = loc.distRoad^2
loc.distTotal = loc.distRoad + loc.distUrban
print(loc.distTotal)
loc.deforestationPot = 1/loc.distTotal
print(loc.deforestationPot)

table.foreach(loc, print)
