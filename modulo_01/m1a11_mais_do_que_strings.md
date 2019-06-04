# M1A11: Mais do que Strings - https://welcometothedjango.com.br/?post_type=aula&p=921

```python
nome = 'karlo'
type(nome)
str(1)
str(1.2)
'karlo'.encode()
'gregório'.encode()
'²³£¢¬§/?€®ŧ←↓→øþ´ªæßðđŋħ̉̉ĸł~ºº«»©“”nµ─·°°'.encode()
```

Para `dir(nome)` ver os métodos disponíveis para o objeto `nome`:

```python
dir(nome)
```

Strings em python são imutáveis. Assim qualquer operação que modifique uma string, um caracter que seja, gerará um novo objeto.

```python
nome.upper()
nome.capitalize()
'karlo guidoni martins'.title()
nome = 'karlo guidoni martins'
nome.replace('a', 'AAA')
nome.split()
nome.split('a')
'karlo' + ' ' + 'martins'
' '.join(['karlo', 'martins'])
'\n'.join(['karlo', 'martins'])
print('\n'.join(['karlo', 'martins']))
len(nome)
```
