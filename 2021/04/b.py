seq   = []

with open('input.txt') as f:
    seq = list(map(int,f.readline().rstrip().split(",")))

    f.readline() # line separating cards from sequence

    def card_line(smap):
        return [ dict(hit=False, value=i) for i in map(int, smap) ]

    cards = [
        list(map(card_line, map(str.split, hunk.split("\n"))))
        for hunk in f.read().rstrip().split("\n\n")
    ]

def card_won(card):
    for row in card:
        if all(map(lambda c: c['hit'], row)): return f"row {row}"

    for i in range(5):
        if all(map(lambda r: r[i]['hit'], list(card))): return f"col {i}"

    # if all(map(lambda i: card[i][i]['hit'], list(range(5)))): return "d1"
    # if all(map(lambda i: card[i][4-i]['hit'], list(range(5)))): return "d2"

    return None

def print_card(card):
    for row in card:
        print(" ".join(
            [ f"{c['value']:2}x" if c['hit'] else f"{c['value']:2} " for c in row ]
        ))

def card_value(card):
    value = 0
    for row in card:
        print(f"{row}")
        for cell in filter(lambda c: not c['hit'], row):
            print(f"* {cell['value']}")
            value += cell['value']

    return value

last = None

for n in seq:
    print(f"next: {n}")
    for card in cards:
        for row in card:
            for cell in row:
                if cell['value'] == n: cell['hit'] = True

        how = card_won(card)
        if (how): last = card

    print(len(cards))
    cards = list(filter(lambda card: not card_won(card), cards))

    if len(cards) == 0:
        print_card(last)
        print(f"{n} * {card_value(last)} = {n * card_value(last)}")
        break
