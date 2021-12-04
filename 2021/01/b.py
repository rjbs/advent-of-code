with open("puzzle.txt") as f:
    arr = [
       int(f.readline().rstrip()),
       int(f.readline().rstrip()),
       int(f.readline().rstrip()),
    ]

    j = 0
    for line in f:
        old = sum(arr)
        arr = arr[1:3] + [ int(line) ]
        new = sum(arr)

        if new > old: j += 1

    print(j)
