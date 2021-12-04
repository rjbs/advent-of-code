count = 0
sums  = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

with open('input.txt') as f:
    for line in f:
        count += 1
        line = line.rstrip()
        bits = map(int, list(line))
        for i, v in enumerate(bits):
            sums[i] += int(v)

common = [ 1 if float(i) / count > 0.5 else 0 for i in sums ]

gamma   = int(''.join(map(str, common)), 2)
epsilon = int(''.join(map(str, [ 0 if i == 1 else 1 for i in common ])), 2)

print(gamma * epsilon)
