
depth = 0
ahead = 0

with open('input-1.txt') as f:
    for line in f:
        line.rstrip()
        x = line.split(' ');
        match x[0]:
            case 'forward': ahead += int(x[1])
            case 'down':    depth += int(x[1])
            case 'up':      depth -= int(x[1])

    print("depth %i ahead %i" % (depth, ahead))
    print(depth * ahead)

