# M1A21: Não subestime as funções - https://welcometothedjango.com.br/?post_type=aula&p=931

Ver script `funcoes.py`

Se você não explicitar o que a função retorna, ela sempre vai retornar 'None'.

Uso de parâmetro *default* nas funções

```python
def f(a, b, c='dC'):
    print(a, b, c)

f(b='B', a='A')
```
