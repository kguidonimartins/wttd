# M1A16: Dicionários - https://welcometothedjango.com.br/?post_type=aula&p=926

Declarando dicionários

```python
dicionario = {'nome': 'Karlo', 'cidade': 'Vix', 'lat': 22.9, 'long': 43.1}

dicionario

dicionario['nome']

dicionario['nome'] = 'Karlo Guidoni Martins'

dicionario
```

Verificando a existência da chave no dicionário

```python
'asd' in dicionario
dicionario.get('asd')
print(dicionario.get('asd'))
dicionario.get('asd', 'valor padrão')
```

Verificando a existência de valores no dicionário

```python
'Vix' in dicionario.values()
```

Quantas chaves existem?

```python
len(dicionario)
```

Quais são as chaves e os valores? (somente para o python 3)

```python
dicionario.keys()
dicionario.values()
# visualização pareada de chaves e valores
dicionario.items()
```

Testes de referência

```python
chaves = dicionario.keys()

valores = dicionario.values()

itemz = dicionario.items()

dicionario['Olá'] = "Mundo!"

dicionario

chaves

valores

itemz
```

Os elementos do dicionário podem ser copiado para listas ou tuplas

```python
k = tuple(dicionario.keys())

k

v = list(dicionario.values())

v
```

Deletando chaves

```python
del dicionario['Olá']

dicionario
```

Atualização o dicionário

```python
dicionario.update(interesses=['Data Science', 'Programming'])

dicionario

dicionario['interesses']

dicionario['interesses'].append('Time Management')

dicionario

dicionario

dicionario.pop('interesses')
```

Outros métodos para construir dicionários

```python
# a partir de tuplas
d_ex = tuple(dicionario.items())

dict(d_ex)

# criando diretamente
dict(nome="Karlo", cidade="Vix")
```
