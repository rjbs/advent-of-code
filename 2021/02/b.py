
aim   = 0
depth = 0
ahead = 0

with open('input-1.txt') as f:
    for line in f:
        line.rstrip()
        x = line.split(' ');
        match x[0]:
            case 'down':    aim   += int(x[1])
            case 'up':      aim   -= int(x[1])
            case 'forward':
                ahead += int(x[1])
                depth += aim * int(x[1])

    print("depth %i ahead %i" % (depth, ahead))
    print(depth * ahead)

