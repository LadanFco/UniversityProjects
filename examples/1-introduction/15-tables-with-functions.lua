loc = {
	cover = "forest", 
	distRoad = 0.3, 
	distUrban = 2,
	deforestPot = function(myloc)
		return 1/(myloc.distRoad + myloc.distUrban)
	end
}

print(loc.deforestPot(loc))
print(loc:deforestPot())
