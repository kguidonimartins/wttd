# M1A15: Tuplas - https://welcometothedjango.com.br/?post_type=aula&p=925

Ajuda

```python
help(tuple)
```

Declarando tuplas: objeto imutáveis com apenas dois métodos (.count e .index)

```python
t = ("a", "b", "c")

t + ("d", "e")

tuple("karlo")

tuple([1, 2, 3])

("a", 1, 3.14, (2j, len), [1, 2, 3])

t[0]

t[1:]
```

Tuplas não são copiáveis

```python
u = t[:]

id(t), id(u)

v = t.copy()
```

Quem constrói a tupla é a vírgula e não o parênteses

```python
"a", "b", "c"
```

Os parênteses servem para informar a precedêcnia das operações

```python
"e", "f" + t # erro
("e", "f") + t
```

Criando tuplas de outras formas

```python
"a"
type("a")

# a vírgula é importante
"a",
type(("a", ))

# tupla vazia
tuple()
# ou
()
```
