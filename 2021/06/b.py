import sys
file = sys.argv[1]
days = int(sys.argv[2])

print(file)

fish = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

with open(file) as f:
    line = f.readline().rstrip()
    for value in map(int,line.split(",")):
        fish[value] += 1
        print(value)

print(f"day 0: {fish}")

for day in range(1, days+1):
    zeroes, *rest = fish
    fish = rest + [ zeroes ]
    fish[6] += zeroes

    print(f"day {day}: {fish} ({sum(fish)})")
