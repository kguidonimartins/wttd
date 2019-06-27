# M1A20: Faça mágica com atribuições inteligentes - https://welcometothedjango.com.br/?post_type=aula&p=930

Uma aula sobre o sinal de igual em python =P

O exemplo abaixo retornará erro porque não existe a definição dos nomes usados na tupla `row`.

```python
row = "Karlo", "Vix", 22.9, 43.1


def f(t):
    print(nome, cidade, lat, long)


f(row)
```

Para evitar o erro, define-se nomes, um por um, a partir das posições da tupla.

```python
def f(t):
    nome = t[0]
    cidade = t[1]
    lat = t[2]
    long = t[3]
    print(nome, cidade, lat, long)


f(row)
```

O mesmo pode ser feito usando apenas uma linha, já que o python aceita esse tipo de atribuição 'experta'. Os nomes são definidos separando-os por vírgula e atribuídos a um elemento identificado pela posição na tupla.

```python
def f(t):
    nome, cidade, lat, long = t[0], t[1], t[2], t[3]
    print(nome, cidade, lat, long)


f(row)
```

A solução abaixo é similar a anterior. É uma atribuição direta, sem a necessidade de informar a posição dos elementos na tupla. A tupla contém quatro e apenas quatro nomes foram definidos.

```python
def f(t):
    nome, cidade, lat, long = t
    print(nome, cidade, lat, long)


f(row)
```

Se apenas dois nomes fossem definidos, o traceback informaria: `ValueError: too many values to unpack (expected 2)`. Confira abaixo.

```python
def f(t):
    nome, cidade = t
    print(nome, cidade)


f(row)
```

Para que este tipo de operação seja viável, é necessário informar a posição desejada.

```python
def f(t):
    nome, cidade = t[0], t[1]
    print(nome, cidade)


f(row)
```

Usando o slice também funciona.

```python
def f(t):
    nome, cidade = t[:2]
    print(nome, cidade)


f(row)
```

Escolhendo outras variáveis para serem retornadas (sempre informando a posição desejada).

```python
def f(t):
    nome, long = t[0], t[3]
    print(nome, long)


f(row)
```

Com outras palavras.

```python
def f(t):
    nome, long = t[0], t[-1]
    print(nome, long)


f(row)
```

Apesar de funcionar, essa solução é um tanto quanto [*hard-coded*](https://en.wikipedia.org/wiki/Hard_coding). Para evitar isso, o `_` (*underscore*, *underline*, subtraço) pode ser utilizado. A operação abaixo é similar a anterior, mas sem *hard-code*.

```python
def f(t):
    nome, _, _, long = t
    print(nome, long)


f(row)
```

No caso abaixo, a atribuição é feita sobreescrevendo o `_` usando o último elemento a ele atribuído. Neste caso, o próximo elemento após `cidade` seria `lat`. Portanto, a função retornará os nomes diretamente informados mais o elemento atribuído ao `_`.

```python
def f(t):
    nome, _, _, long = t
    print(nome, long, _)


f(row)
```

Esse comportamento, quando não desejado, pode ser modificado usando uma combinação do `_` com o `*`. O retorno da função será uma lista com os elementos que foram atribuídos ao conjunto `*_`. Isso lembra o regex ou wildcard usados em algumas linguagens. Por exemplo, no terminal Linux: `ls *.csv`.

```python
def f(t):
    nome, *_, long = t
    print(nome, long, _)


f(row)
```

No entanto, essa operação não é restrita ao uso do `_`. Qualquer outro nome de variável pode ser utilizado.

```python
def f(t):
    nome, *meio, long = t
    print(nome, long, meio)


f(row)
```

Esse ficou confuso. O primeiro elemento (`*nome`) pega o resto, o `_` pega o `lat`.

```python
def f(t):
    *nome, _, long = t
    print(nome, long, _)


f(row)
```

Assim fica melhor. O resto atribuído ao `_` e o print retorna o que de fato foi passado mais o resto em forma de lista por último.

```python
def f(t):
    *_, lat, long = t
    print(lat, long, _)


f(row)
```

E se só o nome fosse desejado.

```python
def f(t):
    nome, *_ = t
    print(nome, _)


f(row)
```

Os exemplos a seguir exploram laços `for` e seu desempacotamento usando exemplos de extração dos elementos pela posição e usando o `_`.


Extraindo os elementos pela posição.

```python
table = (("Karlo", "Vix", 22.9, 43.1),
         ("Gregório", "Cariacica", 22.2, 34.7))

for row in table:
    nome = row[0]
    cidade = row[1]
    lat = row[2]
    long = row[3]
    print(nome, cidade, lat, long)
```

O mesmo da operação anterior, mas usando atribuições de uma linha. Lembrando que isso é permitido uma vez que existem quatro elementos em cada linha da tabela (que é uma tupla). Atenção ao resultado de `table[0]` e `table[0][0]`.

```python
for row in table:
    nome, cidade, lat, long = row
    print(nome, cidade, lat, long)
```

No do laço `for` a tupla é lida por posição. A tupla `table` tem comprimento = 2 (`len(table)`). Mas cada item tem quatro elementos. Isso facilita a extração dentro do laço `for`, eliminando a necessidade de um indexador. O indexador `row` da operação anterior foi omitido.

```python
for nome, cidade, lat, long in table:
    print(nome, cidade, lat, long)
```

Usando o `_` para desempacotar o resto da tupla.

```python
for nome, _, lat, long in table:
    print(nome, lat, long, _)
```

De uma forma mais elegante:

```python
for nome, *_ in table:
    print(nome, _)
```
