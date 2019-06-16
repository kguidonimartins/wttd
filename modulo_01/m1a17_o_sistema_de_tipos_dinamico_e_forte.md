# M1A17: O Sistema de Tipos: Dinâmico e Forte - https://welcometothedjango.com.br/?post_type=aula&p=927

Tipagem dinâmica

```python
letras = 'abc'
letras.upper()
letras.upper
```

Tipagem forte

```python
1 + '1'
1 + int('1')
str(1) + '1'
```

Sobrecarga de operadores

```python
# açúcar sintático
'1' + str(1)
int('1') + 1
# de
'1'.__add__(str(1))
int('1').__add__(1)

3 * 42
'#' * 42
'#'.__mul__(42)
```

```python
3 % 2
int(3).__mod__(2)
'Olá, %s!' % 'Karlo'
'Olá, %s! %s' % ('Karlo', 'Bom dia!')
```

https://docs.python.org/3/reference/datamodel.html#emulating-numeric-types
