# M1A10: Por dentro do import - https://welcometothedjango.com.br/?post_type=aula&p=920

O python executa completamente o módulo `proga` quando o importamos dentro do `progb`

```python
import progb
```

Ele acaba executando todos os "print" de `proga`, quando na verdade queríamos apenas executar a função `fA()` de `proga`. Como resolver isso?

Devemos incluir uma condição no `proga`:

```python
if __name__ == '__main__':
    print('Chama fA')
    fA()
```

<!-- TODO: responda o que é entry point -->
Isso indicará se módulo importado é um *entry point* ou uma biblioteca!

Testando a importação do módulo `progb`:

```python
import progb
```

https://stackoverflow.com/questions/419163/what-does-if-name-main-do
