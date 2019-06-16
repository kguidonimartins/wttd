# M1A18: Loops radicais - https://welcometothedjango.com.br/?post_type=aula&p=928

Loops

```python
nome = 'Karlo'
print(nome, len(nome))

i = 0

while i < len(nome):
    print(nome[i])
    i += 1

for i in range(len(nome)):
    print(nome[i])
```

Entendendo o `range`

```python
range(8)
r = range(8)
r
r[0]
r[-1]
list(r)
```

O `range` constrói a lista quando for necessário; isso evita ocupar espaço na memória, por exemplo, usando uma lista de 1 milhão de números.

```python
help(range)
list(range(1, 20, 3))

for i in range(8):
    print(i)

for c in nome:
    print(c)

for c in enumerate(nome):
    print(c)

for i, c in enumerate(nome):
    print(i, c)

enumerate('Karlo')

e = enumerate('Karlo')

e

next(e)

next(e)

next(e)

next(e)

next(e)

for i, c in enumerate(nome):
    if c == 'r':
        continue
    print(i, c)


for i, c in enumerate(nome):
    if i == 3:
        continue
    print(i, c)

for i, c in enumerate(nome):
    if c == 'r':
        break
    print(i, c)


for i, c in enumerate(nome):
    if i == 3:
        break
    print(i, c)
```
