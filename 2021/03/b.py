lines = []

with open('input.txt') as f:
    for line in f:
        bits = map(int, list(line.rstrip()))
        lines += [ list(bits) ]

def filterydoo (current, test):
    for i in range(len(current[0])):
        avg = sum([ line[i] for line in current ]) / float(len(current))
        keep = 1 if test(avg) else 0
        current = list( filter(lambda b: b[i] == keep, current) )
        if len(current) == 1: return current[0]
    raise("Filtering failed.")

def b2s (bit_list): return int(''.join(map(str, bit_list)), 2)

o_lines = filterydoo(lines, lambda avg: avg >= 0.5)
c_lines = filterydoo(lines, lambda avg: avg <  0.5)
support = b2s(o_lines) * b2s(c_lines)
print(support)
