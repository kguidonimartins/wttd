# M1A19: Decisões e expressões lógicas - https://welcometothedjango.com.br/?post_type=aula&p=929

Controle condicional

```python
nome = 'Karlo'


for c in nome:
    print(c)


for c in nome:
    if c == 'a' or c == 'r' or c == 'l':
        print(c.upper())
    print(c)


for c in nome:
    if c == 'a' or c == 'r' or c == 'l':
        print(c.upper())
    else:
        print(c)


for c in nome:
    if c in ('a', 'r', 'l'):
        print(c.upper())
    else:
        print(c)


for c in nome:
    if c in ('aeiou'):
        print(c.upper())
    else:
        print(c)
    if c == 'o':
        print('@')


for c in nome:
    if c in ('aeiou'):
        print(c.upper())
    elif c == 'l':
        print('@')
    else:
        print(c)
```

Expressões lógicas

```python
True and True
True and False
True or True
True or False
False or False
bool(None)
bool(False)
bool(False)
bool(str())
bool('')
bool(())
bool({})
bool(1)
bool(['abc'])
True and 'abc' # retorna o último elemento avaliado
True and []
'abc' and True
[]  and True # and exige que os dois sejam verdadeiros, então retorna a lista
1 or [] # não testa o segundo elemento
1 or indefinido
1 and indefinido
```
