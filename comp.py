raw = "ax = 5\nbx = 6\ncx = ax * bx\n"

tokens = []
token = ""

x = 0

while x != len(raw):
    if raw[x] != " " and raw[x] != "\n":
        token += raw[x]
    else:
        tokens.append(token)
        token = ""
    x += 1

print(tokens)
print(x)