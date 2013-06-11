myprint = print
print = nil
myprint(2)
print = myprint
