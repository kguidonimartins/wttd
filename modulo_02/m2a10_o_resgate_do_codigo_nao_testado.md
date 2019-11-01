# M2A10: O resgate do código não testado - https://welcometothedjango.com.br/?post_type=aula&p=1106

Testando nosso projeto. O django já oferece testes via manage.py. O teste é feito com:

```python
manage test
```

Edição do arquivo `eventex/core/tests.py` para incluir o primeiro teste. Interessante notar que a docstring do teste pode ser usada como informação adicional quando o teste falha. Além disso, é importante separar um método de `assert` por teste para evitar dor de cabeça e deixar o teste o mais explícito possível.

A repetição de `response = self.client.get('/')` nos dois testes foi corrigida criando um novo método `setUp` para a classe `HomeTest`. Os métodos (os testes) dessa classe são executados independentemente e o método `setUp` precisa ter uma variável de instância. Por conta disso, `self` foi adicionado a `response = self.client.get('/')` e todas as suas ocorrências ao longo do código foram comentadas com `#` (essas linhas serão mantidas para fins didáticos).

Commit do teste.
