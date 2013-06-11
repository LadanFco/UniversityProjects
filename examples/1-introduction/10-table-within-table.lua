loc = {
	cover = "forest", 
    dist = {road = 0.3, urban = 2} 

} 

print(loc.dist.road)
loc.dist.total = loc.dist.road + loc.dist.urban
print(loc.dist.total) 
