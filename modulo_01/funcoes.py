def f():
    return 42


def f():
    pass


# print(f())


def f(a, b, c):
    print(a, b, c)


f('A', 'B', 'C')


f(a='A', b='B', c='C')


f(b='B', c='C', a='A')


def f(a, b, c='dC'):
    print(a, b, c)

f(b='B', a='A')
