# M1A12: Simplifique tudo com Sequências - https://welcometothedjango.com.br/?post_type=aula&p=922

Strings são sequências.

```python
nome = 'karlo'
len(nome)
nome[0]
nome[1]
nome[2]
nome[3]
nome[4]
```

```python
nome[len(nome)-1]
nome[-1]
import modulo_01.magic_indexes
%indexes $nome
```


Slices


```python
nome[0:5]
nome[1:-1]
nome[0:len(nome)]
nome[:]
nome[0:]
nome[:5]
nome[:len(nome)]
```

```python
nome = 'karlo guidoni martins'
%indexes $nome
nome[1:7:2]
nome[1:-1:2]
nome[::2]
nome[::-1]
nome[-2:]
nome[0:2]
nome[1:]
```

```python
nome.__len__()
pi = 3.14
pi.__len__()
len(pi)
nome[0]
nome.__getitem__(0)
idx = slice(1, -1, 2)
type(idx)
nome[idx]
dir(idx)
idx.indices?
# Docstring:
# S.indices(len) -> (start, stop, stride)
#
# Assuming a sequence of length len, calculate the start and stop
# indices, and the stride length of the extended slice described by
# S. Out of bounds indices are clipped in a manner consistent with the
# handling of normal slices.
# Type:      builtin_function_or_method
idx.indices(len(nome))
nome.__getitem__(slice(1, -1, 2))
```
