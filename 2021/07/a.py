import sys
file = sys.argv[1]

with open(file) as f:
    line = f.readline().rstrip()
    crab = list(map(int,line.split(",")))

best_i = None
best_t = None

for target in range(len(crab)):
    total = sum(map(lambda c: abs(target - c), crab))

    if best_i is None or (best_t is not None and best_t > total):
        best_i = target
        best_t = total

print(f"best index is {best_i} for total {best_t}")
