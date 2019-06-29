# M2A06: A essência de um teste - https://welcometothedjango.com.br/?post_type=aula&p=1102

```python
def calc(a, b):
    return a + b


calc(1, 2)
```

Expressão do teste:

> Eu espero 3 quando executar `calc(1, 2)`

Quando é verdadeiro:

```python
assert 3 == calc(1, 2)
```

Quando é falso:

```python
assert 3 == calc(1, 2)
assert []
assert ''
```

Voltando ao `calc`

```python
assert 0 == calc(1, 2)
```
