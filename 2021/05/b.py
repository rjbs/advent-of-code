import sys
grid = dict()
hits = 0

fn   = sys.argv[1]
part = sys.argv[2]

with open(fn) as f:
  for line in f:
    [ start, finish ] = line.rstrip().split(' -> ')
    [ x1, y1 ] = map(int, start.split(','))
    [ x2, y2 ] = map(int, finish.split(','))

    dx = 0 if x1 == x2 else 1 if x2 > x1 else -1
    dy = 0 if y1 == y2 else 1 if y2 > y1 else -1

    if part == "1" and dx != 0 and dy != 0 : continue

    x = x1
    y = y1

    while True:
      key = f"{x},{y}"
      grid[key] = grid.get(key, 0) + 1
      if grid[key] == 2: hits += 1
      if x == x2 and y == y2: break
      x += dx
      y += dy

print(hits)

