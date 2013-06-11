function MyLocation(locdata)
	locdata.covertype = "forest"
	locdata.deforPot = function(self)
		return 1/(self.distRoad + self.distUrban)
	end
	return locdata
end

loc = MyLocation({distRoad = 0.3, distUrban = 2})
loc = MyLocation{distRoad = 0.3, distUrban = 2}

print(loc.covertype)
print(loc:deforPot())
