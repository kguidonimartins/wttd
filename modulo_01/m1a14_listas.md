# M1A14: Listas - https://welcometothedjango.com.br/?post_type=aula&p=924

Listas

```python
["a", "b", "c"]

l = ["a", "b", "c"]

type(l)

l.append("d")

l

l.sort(reverse=True)

l

l.sort()

l

print(l.append("f"))

l

["a", 1, 3.14, 10j, len, [1, 2, 3]]

l[0]

l[-1]

m = l

l, m

id(l), id(m)

m.append("g")

l, m
```

Copiando listas

```python
def f(x):
    x.append(42)
    return x

f(l), l

def g(x):
    x = x.copy()
    x.append(51)
    return x

g(l), l

l1 = [1, 2, 3]

l2 = l1

l3 = l1[:]

l4 = l1.copy()

id(l1), id(l2), id(l3), id(l4)
```

Preste atenção nisso aqui!

```python
m = [1, 2, 3, [4, 5, 6]]

m

n = m[-1]

n

n.append(7)

n

id(m), id(n)
```
