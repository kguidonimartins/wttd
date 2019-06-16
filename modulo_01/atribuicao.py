# row = "Karlo", "Vix", 22.9, 43.1
table = (("Karlo", "Vix", 22.9, 43.1),
         ("Gregório", "Cariacica", 22.2, 34.7))


# def f(t):
#     nome = t[0]
#     cidade = t[1]
#     lat = t[2]
#     long = t[3]
#     print(nome, cidade, lat, long)
#
#
# def f(t):
#     nome, cidade, lat, long = t[0], t[1], t[2], t[3]
#     print(nome, cidade, lat, long)
#
#
# def f(t):
#     nome, cidade, lat, long = t
#     print(nome, cidade, lat, long)
#
#
# def f(t):
#     nome, cidade = t
#     print(nome, cidade)
#
#
# def f(t):
#     nome, cidade = t[0], t[1]
#     print(nome, cidade)
#
#
# def f(t):
#     nome, cidade = t[:2]
#     print(nome, cidade)
#
#
# def f(t):
#     nome, long = t[0], t[3]
#     print(nome, long)
#
#
# def f(t):
#     nome, long = t[0], t[-1]
#     print(nome, long)
#
#
# def f(t):
#     nome, _, _, long = t
#     print(nome, long)
#
#
# def f(t):
#     nome, _, _, long = t
#     print(nome, long, _)
#
#
# def f(t):
#     nome, *_, long = t
#     print(nome, long, _)
#
#
# def f(t):
#     nome, *meio, long = t
#     print(nome, long, meio)
#
#
# def f(t):
#     *nome, _, long = t
#     print(nome, long, _)
#
#
# def f(t):
#     *_, lat, long = t
#     print(lat, long, _)
#
#
# def f(t):
#     nome, *_ = t
#     print(nome, _)
#
#
# if __name__ == '__main__':
#     f(row)


# for row in table:
#     nome = row[0]
#     cidade = row[1]
#     lat = row[2]
#     long = row[3]
#     print(nome, cidade, lat, long)
#
#
# for row in table:
#     nome, cidade, lat, long = row
#     print(nome, cidade, lat, long)
#
#
# for nome, cidade, lat, long in table:
#     print(nome, cidade, lat, long)
#
#
# for nome, _, lat, long in table:
#     print(nome, lat, long, _)


for nome, *_ in table:
    print(nome, _)
