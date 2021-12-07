import sys
file = sys.argv[1]
days = int(sys.argv[2])

print(file)

with open(file) as f:
    line = f.readline().rstrip()
    fish = list(map(int,line.split(",")))

print(fish)

for day in range(days):
    spawn = []
    for i in range(len(fish)):
        fish[i] -= 1
        if fish[i] == -1:
            fish[i] = 6
            spawn += [ 8 ]

    fish += spawn

    print(f"day {day}, {len(fish)} fish")

print(len(fish))
