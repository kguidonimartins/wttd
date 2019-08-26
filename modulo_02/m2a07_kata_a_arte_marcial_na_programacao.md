# M2A07: Kata: A arte marcial na programação - https://welcometothedjango.com.br/?post_type=aula&p=1103

Exercício do fizzbuzz: aprendendo o processo de TDD. O código será esculpido a partir das demandas criadas pelos erros do código e pelas falhas dos testes.

## Regras do jogo

- Quando o número for múltiplo de 3, fale *fizz*;
- Quando o número for múltiplo de 5, fale *buzz*;
- Quando o númeor for múltiplo de 3 e de 5, fale *fizzbuzz*;
- Para todos os outros números, fale o próprio número.

## TDD

Usando testes do início ao fim. Começando pelo problema mais simples: resultado do número 1.

```python
if __name__ == '__main__':
    assert robot(1) == '1'
```

Resultado:

```
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-1-e8a622c2b921> in <module>
      1 if __name__ == '__main__':
----> 2     assert robot(1) == '1'

NameError: name 'robot' is not defined
```

Logo de saída, o traceback informa: `NameError: name 'robot' is not defined`. Para resolver esse problema, o nome `robot` precisa ser definido.

```python
robot = None

if __name__ == '__main__':
    assert robot(1) == '1'
```

Resultado:

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-2-1f81ddb26135> in <module>
      2
      3 if __name__ == '__main__':
----> 4     assert robot(1) == '1'

TypeError: 'NoneType' object is not callable
```

O novo problema criado é: `TypeError: 'NoneType' object is not callable`. De fato, o objeto `robot` ainda não é uma função. Para resolver isso, `robot` será transformado em função apenas para que o erro do traceback não aconteça de novo.

```python
def robot():
    pass

if __name__ == '__main__':
    assert robot(1) == '1'
```

Resultado:

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-3-d4f89db81c6c> in <module>
      3
      4 if __name__ == '__main__':
----> 5     assert robot(1) == '1'

TypeError: robot() takes 0 positional arguments but 1 was given
```

O novo erro agora informa: `TypeError: robot() takes 0 positional arguments but 1 was given`. No `assert` um argumento é passado, o número 1, mas a função não apresenta esse argumento. Para resolver esse problema:

```python
def robot(pos):
    pass

if __name__ == '__main__':
    assert robot(1) == '1'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-4-998da264e440> in <module>
      3
      4 if __name__ == '__main__':
----> 5     assert robot(1) == '1'

AssertionError:
```

A nova mensagem do traceback é um pouco diferente das anteriores: `AssertionError`. Todos as mensagem anteriores informavam um erro do código. Mensagem de `AssertionError` informam falha no teste. No TDD, a prioridade é resolver o erro e, depois, a falha. Todos os erros do código foram resolvidos anteriormente. Agora, inicia-se o processo de responder às expectativas dos testes, **tentando sempre usar o menor passo, a menor modificação possível no código apenas para passar no teste**. Neste primeiro caso, a solução seria:

```python
def robot(pos):
    return '1'

if __name__ == '__main__':
    assert robot(1) == '1'
```

Sucesso! Com isso, duas decisões podem ser tomadas aqui: 1) refatorar o código; 2) escrever um novo teste (para as novas expectativas). Neste ponto, o código ainda não exige refatoração. Assim, um novo teste será criado.

```python
def robot(pos):
    return '1'

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-6-0ea45826038a> in <module>
      4 if __name__ == '__main__':
      5     assert robot(1) == '1'
----> 6     assert robot(2) == '2'

AssertionError:
```

Falha do teste: `AssertionError`. O passo mais simples para resolver essa falha é:

```python
def robot(pos):
    if pos == 2:
        return '2'
    return '1'

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
```

Sucesso, apesar da gambiarra. Mas a essência é exatamente essa. Para verificar se essa gambiarra resiste a um novo cenário, uma nova expectativa é criada. A decisão de testar o número 4 é a simplicidade. O número 3, que resultaria no *fizz*, muda a natureza do problema.

NOTE: os testes não precisam seguir uma sequência.

```python
def robot(pos):
    if pos == 2:
        return '2'
    return '1'

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-8-7bc45d42682f> in <module>
      7     assert robot(1) == '1'
      8     assert robot(2) == '2'
----> 9     assert robot(4) == '4'

AssertionError:
```

Falha: `AssertionError`. O passo mais simples para resolver isso é:

```python
def robot(pos):
    if pos == 4:
        return '4'
    if pos == 2:
        return '2'
    return '1'

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'
```

Sucesso, apesar da aparente gambiarra. Interessante notar que o código funciona e os testes estão garantindo isso, mas os cenários de *fizz* e *buzz* ainda não foram testados. Antes de avançar para esses cenários, o código será refatorado. O primeiro passo é reduzir o *hard code*.

```python
def robot(pos):
    if pos == 4:
        return str(pos)
    if pos == 2:
        return str(pos)
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'
```

Para simplificar ainda mais:

```python
def robot(pos):
    return str(pos)
    if pos == 4:
        return str(pos)
    if pos == 2:
        return str(pos)
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'
```

Até aqui, o que a função `robot` tem feito é: `return str(pos)`. Assim, esse trecho de código foi colocado logo após da definição da função. Quando esse trecho é executado, os outros logo abaixo dele não são. Isso acontece por causa do primeiro `return`. Essa inserção dispensa a necessidade de comentar várias linhas de código e garante que a nova proposição (a alteração do código) seja testada logo no início da função. Se a nova proposição passar no teste, isso é evidência concreta de que essa proposição funciona e de que o código está estável. A função ficará assim:

```python
def robot(pos):
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'
```

Tudo certo até. Qual é o próximo passo? O código precisa de ser refatorado? Parece que não. É necessário um novo teste? Sim. Qual seria o cenário de teste, o número 7 ou "fizz", ou "buzz", ou "fizzbuzz". O código já testa três cenários de números que não retornam a *string* "fizzbuzz" ou parte dela. De certa forma, esses cenários já estão bem cobertos. TDD não se trata de testar todas as combinações, todos os cenários possíveis. Com isso, o próximo teste tem uma nova natureza, isto é, ele testará um cenário para o "fizz" (números múltiplos de três).

```python
def robot(pos):
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-13-348f7af8724d> in <module>
      7     assert robot(4) == '4'
      8
----> 9     assert robot(3) == 'fizz'

AssertionError:
```

Falha no teste: `AssertionError`. Para resolver, sem complicações:

```python
def robot(pos):
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
```

Sucesso. O próximo teste será com o número 6. De alguma forma isso indica uma repetição...

```python
def robot(pos):
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-15-59884d19f0f4> in <module>
      7     assert robot(4) == '4'
      8
----> 9     assert robot(3) == 'fizz'
     10     assert robot(6) == 'fizz'

AssertionError:
```

Falha no teste: `AssertionError`. Para resolver:

```python
def robot(pos):
    if pos == 6:
        return 'fizz'
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
```

Sucesso. Próximo teste será com o número 9.

```python
def robot(pos):
    if pos == 6:
        return 'fizz'
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-18-666856aa71af> in <module>
     13     assert robot(3) == 'fizz'
     14     assert robot(6) == 'fizz'
---> 15     assert robot(9) == 'fizz'

AssertionError:
```

Falha no teste: `AssertionError`. Para resolver.

```python
def robot(pos):
    if pos == 9:
        return 'fizz'
    if pos == 6:
        return 'fizz'
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

Sucesso. Teste passando, código estável. Mas parece gambiarra e tem uma repetição que pode trazer problemas a medida que esse código evolui. O próximo passo agora é refatorar o código.

```python
def robot(pos):
    if pos == 9 or pos == 6:
        return 'fizz'
    # if pos == 6:
    #     return 'fizz'
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

A primeira mudança parece que está funcionando. As linhas comentadas podem ser eliminadas. A código ficará assim:

```python
def robot(pos):
    if pos == 9 or pos == 6:
        return 'fizz'
    if pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

Esse processo de refatoração agora será repetido com o número 3.

```python
def robot(pos):
    if pos == 9 or pos == 6 or pos == 3:
        return 'fizz'
    # if pos == 3:
    #     return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

Tudo certo e funcionando. As linhas comentadas podem ser eliminadas.

```python
def robot(pos):
    if pos == 9 or pos == 6 or pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

Para eliminar ainda mais a repetição:

```python
def robot(pos):
    if pos in (9, 6, 3):
    # if pos == 9 or pos == 6 or pos == 3:
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'
```

Sucesso. O próximo passo é um novo cenário de teste. Dessa vez para o "buzz".

```python
def robot(pos):
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-25-75b3bd3456ce> in <module>
     13     assert robot(9) == 'fizz'
     14
---> 15     assert robot(5) == 'buzz'

AssertionError:
```

Falha no teste: `AssertionError`. Resolvendo:

```python
def robot(pos):
    if pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
```

Sucesso. Próximo teste será com o número 10.

```python
def robot(pos):
    if pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-28-a7d8c4d75234> in <module>
     16
     17     assert robot(5) == 'buzz'
---> 18     assert robot(10) == 'buzz'

AssertionError:
```

Falha no teste: `AssertionError`. Resolvendo:

```python
def robot(pos):
    if pos == 10:
        return 'buzz'
    if pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
```

Sucesso. Próximo teste com o número 20. O número 15 foi pulado porque ele múltiplo de 3 e de 5. Esse e outros números serão testados em outro cenário.

```python
def robot(pos):
    if pos == 10:
        return 'buzz'
    if pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-30-45eb6b46e713> in <module>
     19     assert robot(5) == 'buzz'
     20     assert robot(10) == 'buzz'
---> 21     assert robot(20) == 'buzz'

AssertionError:
```

Falha no teste: `AssertionError`. Para resolver:

```python
def robot(pos):
    if pos == 20:
        return 'buzz'
    if pos == 10:
        return 'buzz'
    if pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso. Os cenários para o "buzz" estão cobertos. Agora é hora de refatorar o código. Começando pela eliminação da repetição, com o mesmo cuidado tomado anteriormente.

```python
def robot(pos):
    if pos == 20 or pos == 10:
        return 'buzz'
    # if pos == 10:
    #     return 'buzz'
    if pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Refatoração funcionando. As linhas comentadas serão eliminadas e uma nova edição do código será feita.

```python
def robot(pos):
    if pos == 20 or pos == 10 or pos == 5:
        return 'buzz'
    # if pos == 5:
    #     return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

O mesmo processo de antes.

```python
def robot(pos):
    if pos == 20 or pos == 10 or pos == 5:
        return 'buzz'
    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso. Continuando com a refatoração. A repetição do `or` será eliminada. Em seu lugar, entrará a condicional com os elementos dentro da tupla.

```python
def robot(pos):
    if pos in (20, 10, 5):
        return 'buzz'

    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso novamente. Agora refatoração levará em conta a multiplicidade dos números. Isso pode ser feito usando a função de módulo. Por exemplo, se a divisão de qualquer número por 3 tem resto igual a zero, isso indica que o número testado é múltiplo de 3. Isso tornará a função `robot` mais geral, podendo ser usada para outros números. Exemplo abaixo.

```python
# divisão com resto
4 / 3
# res: 1.3333333333333333

# divisão com resto truncado para inteiro
int(4 / 3)
# res: 1

# multiplicação do resto truncado pelo número que se deseja encontrar
# a multiplicidade
int(4 / 3) * 3
# res: 3

# para testar se um número x é múltiplo de 3, deve-se dividir x por 3,
# multiplicar a parte inteira do resto da divisão por 3 e substrair esse
# resultado de x. se o resultado for igual a zero, x é múltiplo de 3.
4 - int(4 / 3) * 3
# res: 1

# testando o número 5
5 - int(5 / 3) * 3
# res: 2

# testando o número 6
6 - int(6 / 3) * 3
# res: 0

# generalizando:
num = 5; num - int(num / 3) * 3 == 0
# res: False

# testando para o número 6
num = 6; num - int(num / 3) * 3 == 0
# res: True
```

Essa generalização acima será incorporada à função `robot`. Isso vai permitir que essa função possa ser usada/testada com outros números.

```python
def robot(pos):
    if pos in (20, 10, 5):
        return 'buzz'

    if pos - int(pos / 3) * 3 == 0:
        return 'fizz'

    if pos in (9, 6, 3):
        return 'fizz'
    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso. O trecho de código da condicional testando elementos dentro da tupla pode ser eliminado.

```python
def robot(pos):
    if pos in (20, 10, 5):
        return 'buzz'

    if pos - int(pos / 3) * 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

A mesma lógica será aplicada ao número 5.

```python
def robot(pos):
    if pos - int(pos / 5) * 5 == 0:
        return 'buzz'

    if pos in (20, 10, 5):
        return 'buzz'

    if pos - int(pos / 3) * 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso. A condicional com a tupla pode ser eliminada.

```python
def robot(pos):
    if pos - int(pos / 5) * 5 == 0:
        return 'buzz'

    if pos - int(pos / 3) * 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Essa solução pode ficar mais enxuta se a opção de divisão com resto truncado, implementada no python 3, for utilizada. Exemplo abaixo.

```python
# em vez de:
int(4 / 3)
# res: 1

# pode-se usar:
4 // 3
# res: 1
```

Aplicando isso à função `robot`. Eu mantive os parênteses por conta da precedência das operações.

```python
def robot(pos):
    if pos - (pos // 5) * 5 == 0:
        return 'buzz'

    if pos - (pos // 3) * 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Para simplificar ainda mais. Pode-se o operador de módulo. Exemplo abaixo.

```python
# em vez de:
num = 3; num - (num // 3) * 3 == 0
# res: True

# usa-se:
3 % 3
# res: 0

# ou
num = 3; num % 3 == 0
# res: True
```

Novamente, aplicando isso à função `robot`.

```python
def robot(pos):
    if pos % 5 == 0:
        return 'buzz'

    # if pos - (pos // 5) * 5 == 0:
    #     return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    # if pos - (pos // 3) * 3 == 0:
    #     return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso. As linhas comentadas serão eliminadas.

```python
def robot(pos):
    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'
```

Sucesso. Código refatorado. Agora, a solução para a *string* 'fizzbuzz' será implementada.

```python
def robot(pos):
    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-35-16ec4d451478> in <module>
     21     assert robot(20) == 'buzz'
     22
---> 23     assert robot(15) == 'fizzbuzz'

AssertionError:
```

Falha: `AssertionError`. Resolvendo da forma mais simples possível.

```python
def robot(pos):
    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    if pos == 15:
        return 'fizzbuzz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-37-8042593e2e39> in <module>
     24     assert robot(20) == 'buzz'
     25
---> 26     assert robot(15) == 'fizzbuzz'

AssertionError:
```

Falha: `AssertionError`. Cabe notar aqui que o número 15 é múltiplo de 5. Logo, a condicional que testa o número 15 diretamente não é executada, pois a primeira condicional que testa se o número 15 é múltiplo de 5 é testada primeiro. Para resolver isso e evitar o `AssertionError` basta transferir o trecho que testa o número 15 para a posição logo após a definição da função `robot`. Assim:

```python
def robot(pos):
    if pos == 15:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
```

Sucesso. Apesar da gambiarra. Isso resolve o problema da falha do teste (o que era desejado), mas não resolve o problema em si. Um novo teste será implementado e esse problema será resolvido posteriormente.

```python
def robot(pos):
    if pos == 15:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-39-1e97fb5559a5> in <module>
     25
     26     assert robot(15) == 'fizzbuzz'
---> 27     assert robot(30) == 'fizzbuzz'

AssertionError:
```

Falha: `AssertionError`. Para resolver:

```python
def robot(pos):
    if pos == 30:
        return 'fizzbuzz'

    if pos == 15:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
```

Sucesso. Mais um teste:

```python
def robot(pos):
    if pos == 30:
        return 'fizzbuzz'

    if pos == 15:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-42-4b248676b5a3> in <module>
     14     assert robot(15) == 'fizzbuzz'
     15     assert robot(30) == 'fizzbuzz'
---> 16     assert robot(45) == 'fizzbuzz'

AssertionError:
```

Falha: `AssertionError`. Para resolver:

```python
def robot(pos):
    if pos == 45:
        return 'fizzbuzz'

    if pos == 30:
        return 'fizzbuzz'

    if pos == 15:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Com três para a nova proposição, está na hora de refatorar o código. Passo a passo, usando os mesmos princípios das proposições anteriores.

```python
def robot(pos):
    if pos == 45 or pos == 30:
        return 'fizzbuzz'

    # if pos == 30:
    #     return 'fizzbuzz'

    if pos == 15:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. As linhas comentadas serão eliminadas e a condicional do número 15 será incorporada ao trecho recém-editado.

```python
def robot(pos):
    if pos == 45 or pos == 30 or pos == 15:
        return 'fizzbuzz'

    # if pos == 15:
    #     return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Refatorando usando o `in`.

```python
def robot(pos):
    if pos in (45, 30, 15):
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Para melhorar, o mesmo processo com o `%` será usado.

```python
def robot(pos):
    if pos % 3 == 0 and pos % 5 == 0:
        return 'fizzbuzz'

    if pos % 5 == 0:
        return 'buzz'

    if pos % 3 == 0:
        return 'fizz'

    return str(pos)

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Os pontos de `return` podem ser reduzidos para tornar o código ainda mais polido.

```python
def robot(pos):
    say =  str(pos)

    if pos % 3 == 0 and pos % 5 == 0:
        say = 'fizzbuzz'

    if pos % 5 == 0:
        say = 'buzz'

    if pos % 3 == 0:
        say = 'fizz'

    return say

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-10-4b248676b5a3> in <module>
     12     assert robot(20) == 'buzz'
     13
---> 14     assert robot(15) == 'fizzbuzz'
     15     assert robot(30) == 'fizzbuzz'
     16     assert robot(45) == 'fizzbuzz'

AssertionError:
```

Falha: `AssertionError`. A mensagem aponta que o problema está no número 15. Isso acontece porque os `if`s estão independentes uns dos outros e a variável `say` é atualizada dentro de todos eles. A solução á amarrar os `if`s usando `elif`.

```python
def robot(pos):
    say =  str(pos)

    if pos % 3 == 0 and pos % 5 == 0:
        say = 'fizzbuzz'
    elif pos % 5 == 0:
        say = 'buzz'
    elif pos % 3 == 0:
        say = 'fizz'

    return say

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. A ideia agora é deixar o código mais expressivo usando funções auxiliares.

```python
def multiple_of_3(num):
    return num % 3 == 0


def multiple_of_5(num):
    return num % 5 == 0


def robot(pos):
    say =  str(pos)

    if multiple_of_3(pos) and multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Para deixar as funções ainda mais expressivas.

```python
def multiple_of(base, num):
    return num % base == 0


def multiple_of_3(num):
    return multiple_of(3, num)


def multiple_of_5(num):
    return multiple_of(5, num)


def robot(pos):
    say =  str(pos)

    if multiple_of_3(pos) and multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. A função `multiple_of` pode ser usada com `lambda`. Isso diminui o número de linhas.

```python
multiple_of = lambda base, num: num % base == 0


def multiple_of_3(num):
    return multiple_of(3, num)


def multiple_of_5(num):
    return multiple_of(5, num)


def robot(pos):
    say =  str(pos)

    if multiple_of_3(pos) and multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Agora o refatoração contará com ajuda da biblioteca `functools` para diminuir ainda mais o número de linhas. Especificamente, será usada a função `partial`.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_3 = partial(multiple_of, 3)
multiple_of_5 = partial(multiple_of, 5)


def robot(pos):
    say =  str(pos)

    if multiple_of_3(pos) and multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say

if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert robot(3) == 'fizz'
    assert robot(6) == 'fizz'
    assert robot(9) == 'fizz'

    assert robot(5) == 'buzz'
    assert robot(10) == 'buzz'
    assert robot(20) == 'buzz'

    assert robot(15) == 'fizzbuzz'
    assert robot(30) == 'fizzbuzz'
    assert robot(45) == 'fizzbuzz'
```

Sucesso. Função finalizada. Falta agora utilizá-la.

```python
from modulo_02.fizzbuzz import robot

robot(353765)
robot(42)
robot(1)
robot(11)
robot(99)
robot(13)
```
