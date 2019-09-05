# M2A08: Por dentro do framework de testes - https://welcometothedjango.com.br/?post_type=aula&p=1104

O objetivo aqui é explorar o framework de testes. Isso será feito usando a função `robot` criada em `modulo_02/m2a07_kata_a_arte_marcial_na_programacao.md`. Para começar, a função `robot` será trazida para cá.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

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

A exploração inicial é a do `assert`. Para isso, um *bug* será inserido no código da função, trocando o `and` por `or`.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
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

Resultado:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-12-4b248676b5a3> in <module>
      4     assert robot(4) == '4'
      5
----> 6     assert robot(3) == 'fizz'
      7     assert robot(6) == 'fizz'
      8     assert robot(9) == 'fizz'

AssertionError:
```

A falha informa que a função, que deveria retornar 'fizz', está retornando outra *string* ('fizzbuzz', nesse caso). O código é finalizado assim que a falha acontece e os outros testes não são executados. Seria interessante ter acesso ao resultado dos outros testes independente das falhas que ocorrem. Isso pode ser importante em programas nos quais uma função depende da outra. Para que todos os testes rodem independente das exceções que ocorreram, serão inseridos `try` e `except AssertionError` ao longo do código.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
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

    try:
        assert robot(3) == 'fizz'
    except AssertionError:
        print('Falha no assert robot(3)')

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
Falha no assert robot(3)
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-18-367a15f475dc> in <module>
      9         print('Falha no assert robot(3)')
     10
---> 11     assert robot(6) == 'fizz'
     12     assert robot(9) == 'fizz'
     13

AssertionError:
```

O print que foi inserido funcionou, indicando que o `try` cumpriu seu papel. No entanto, o próxima linha levantou uma nova exceção. Ela também precisará (e todas as outras linhas de teste) de um `try`. Para aplicar as exceções a todos os testes, uma função auxiliar será criada.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_true(expr):
    try:
        assert expr
    except AssertionError:
        print(expr)


if __name__ == '__main__':
    assert robot(1) == '1'
    assert robot(2) == '2'
    assert robot(4) == '4'

    assert_true(robot(3) == 'fizz')
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
False
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-32-b18a4ec01ba7> in <module>
      5
      6     assert_true(robot(3) == 'fizz')
----> 7     assert robot(6) == 'fizz'
      8     assert robot(9) == 'fizz'
      9

AssertionError:
```

A função auxiliar cumpriu seu papel: retornou um `False`. A ideia agora é involver todas as linhas de teste com a função auxiliar.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_true(expr):
    try:
        assert expr
    except AssertionError:
        print(expr)


if __name__ == '__main__':
    assert_true(robot(1) == '1')
    assert_true(robot(2) == '2')
    assert_true(robot(4) == '4')

    assert_true(robot(3) == 'fizz')
    assert_true(robot(6) == 'fizz')
    assert_true(robot(9) == 'fizz')

    assert_true(robot(5) == 'buzz')
    assert_true(robot(10) == 'buzz')
    assert_true(robot(20) == 'buzz')

    assert_true(robot(15) == 'fizzbuzz')
    assert_true(robot(30) == 'fizzbuzz')
    assert_true(robot(45) == 'fizzbuzz')
```

Feito. Os testes estão passando e as exceções também, retornando `False`. Mas a função não diz quais são os testes que estão falhando. Para resolver, a função auxiliar receberá o argumento `line` que informará a linha na qual está o teste que falhou.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_true(expr, line):
    try:
        assert expr
    except AssertionError:
        print('Line', line, expr)


if __name__ == '__main__':
    assert_true(robot(1) == '1', '37')
    assert_true(robot(2) == '2', '38')
    assert_true(robot(4) == '4', '39')

    assert_true(robot(3) == 'fizz', '41')
    assert_true(robot(6) == 'fizz', '42')
    assert_true(robot(9) == 'fizz', '43')

    assert_true(robot(5) == 'buzz', '45')
    assert_true(robot(10) == 'buzz', '46')
    assert_true(robot(20) == 'buzz', '47')

    assert_true(robot(15) == 'fizzbuzz', '49')
    assert_true(robot(30) == 'fizzbuzz', '50')
    assert_true(robot(45) == 'fizzbuzz', '51')
```

Resultado:

```
Line 41 False
Line 42 False
Line 43 False
Line 45 False
Line 46 False
Line 47 False
```

Funcionou. Agora a função informa as linhas que de teste que falharam. Seria ainda mais interessante se ela retornasse quais os valores dos testes que falharam. Para isso, a função `assert_true` precisa ser refatorada para receber diretamente os valores dos testes que são passados, em vez de uma única expressão. Para que a função tenha ainda mais significado, seu nome passará de `assert_true` para `assert_equal`.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_equal(first, second, line):
    try:
        assert first == second
    except AssertionError:
        print('Line', line, first, second)


if __name__ == '__main__':
    assert_equal(robot(1), '1', '37')
    assert_equal(robot(2), '2', '38')
    assert_equal(robot(4), '4', '39')

    assert_equal(robot(3), 'fizz', '41')
    assert_equal(robot(6), 'fizz', '42')
    assert_equal(robot(9), 'fizz', '43')

    assert_equal(robot(5), 'buzz', '45')
    assert_equal(robot(10), 'buzz', '46')
    assert_equal(robot(20), 'buzz', '47')

    assert_equal(robot(15), 'fizzbuzz', '49')
    assert_equal(robot(30), 'fizzbuzz', '50')
    assert_equal(robot(45), 'fizzbuzz', '51')
```

Resultado:

```
Line 41 fizzbuzz fizz
Line 42 fizzbuzz fizz
Line 43 fizzbuzz fizz
Line 45 fizzbuzz buzz
Line 46 fizzbuzz buzz
Line 47 fizzbuzz buzz
```

Funcionou. Agora a função de teste informa os valores que estão divergindo. A mensagem de falha pode ficar melhor, assim:

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_equal(first, second, line):
    msg = 'Fail: Line {} got {} expecting {}'
    try:
        assert first == second
    except AssertionError:
        print(msg.format(line, first, second))


if __name__ == '__main__':
    assert_equal(robot(1), '1', '37')
    assert_equal(robot(2), '2', '38')
    assert_equal(robot(4), '4', '39')

    assert_equal(robot(3), 'fizz', '41')
    assert_equal(robot(6), 'fizz', '42')
    assert_equal(robot(9), 'fizz', '43')

    assert_equal(robot(5), 'buzz', '45')
    assert_equal(robot(10), 'buzz', '46')
    assert_equal(robot(20), 'buzz', '47')

    assert_equal(robot(15), 'fizzbuzz', '49')
    assert_equal(robot(30), 'fizzbuzz', '50')
    assert_equal(robot(45), 'fizzbuzz', '51')
```

Resultado:

```
Fail: Line 41 got fizzbuzz expecting fizz
Fail: Line 42 got fizzbuzz expecting fizz
Fail: Line 43 got fizzbuzz expecting fizz
Fail: Line 45 got fizzbuzz expecting buzz
Fail: Line 46 got fizzbuzz expecting buzz
Fail: Line 47 got fizzbuzz expecting buzz
```

Perfeito. A função pode ser ainda mais simples e mais específica. Primeiro, o `assert` não é mais necessário. Segundo, os nomes dos argumentos utilizados são muitos genéricos.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_equal(result, expected, line):
    msg = 'Fail: Line {} got {} expecting {}'
    if not result == expected:
        print(msg.format(line, result, expected))


if __name__ == '__main__':
    assert_equal(robot(1), '1', '37')
    assert_equal(robot(2), '2', '38')
    assert_equal(robot(4), '4', '39')

    assert_equal(robot(3), 'fizz', '41')
    assert_equal(robot(6), 'fizz', '42')
    assert_equal(robot(9), 'fizz', '43')

    assert_equal(robot(5), 'buzz', '45')
    assert_equal(robot(10), 'buzz', '46')
    assert_equal(robot(20), 'buzz', '47')

    assert_equal(robot(15), 'fizzbuzz', '49')
    assert_equal(robot(30), 'fizzbuzz', '50')
    assert_equal(robot(45), 'fizzbuzz', '51')
```

Resultado:

```
Fail: Line 41 got fizzbuzz expecting fizz
Fail: Line 42 got fizzbuzz expecting fizz
Fail: Line 43 got fizzbuzz expecting fizz
Fail: Line 45 got fizzbuzz expecting buzz
Fail: Line 46 got fizzbuzz expecting buzz
Fail: Line 47 got fizzbuzz expecting buzz
```

A função continua funcionando após a refatoração. O ideal seria não ter que passar as linhas que estão falhando (as quais já não são as mesmas desde que a refatoração começou). Para resolver esse problema, isto é, saber quais são as linhas que estão retornando a falha do teste automaticamente, será utilizada uma função interna do python: `sys._getframe`. É essa função que o `Traceback` usa para retornar a linha e a expressão que deu erro ou falhou, no caso dos testes. Por exemplo:

```python
def linhas():
    print('linha 2')
    print('linha 3')
    print('linha 4')
    print(a)

linhas()
```

Resultado:

```
linha 2
linha 3
linha 4
---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-72-444b9bb9eeaa> in <module>
----> 1 linhas()

<ipython-input-71-252bd088c04d> in linhas()
      3     print('linha 3')
      4     print('linha 4')
----> 5     print(a)

NameError: name 'a' is not defined
```

O erro aconteceu na linha 5 dentro da função `linhas`. Essas informações serão usadas na função `assert_equal`.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_equal(result, expected, line):
    from sys import _getframe

    msg = 'Fail: Line {} got {} expecting {}'

    if not result == expected:
        current = _getframe()
        caller = current.f_back
        line_no = caller.f_lineno
        print(msg.format(line_no, result, expected))


if __name__ == '__main__':
    assert_equal(robot(1), '1', '37')
    assert_equal(robot(2), '2', '38')
    assert_equal(robot(4), '4', '39')

    assert_equal(robot(3), 'fizz', '41')
    assert_equal(robot(6), 'fizz', '42')
    assert_equal(robot(9), 'fizz', '43')

    assert_equal(robot(5), 'buzz', '45')
    assert_equal(robot(10), 'buzz', '46')
    assert_equal(robot(20), 'buzz', '47')

    assert_equal(robot(15), 'fizzbuzz', '49')
    assert_equal(robot(30), 'fizzbuzz', '50')
    assert_equal(robot(45), 'fizzbuzz', '51')
```

Resultado:

```
Fail: Line 6 got fizzbuzz expecting fizz
Fail: Line 7 got fizzbuzz expecting fizz
Fail: Line 8 got fizzbuzz expecting fizz
Fail: Line 10 got fizzbuzz expecting buzz
Fail: Line 11 got fizzbuzz expecting buzz
Fail: Line 12 got fizzbuzz expecting buzz
```

Sucesso. A `_getframe` consegue identificar as linhas. Com isso, o argumento `line` da função não está sendo mais utilizado. Isso precisa sair.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


def assert_equal(result, expected):
    from sys import _getframe

    msg = 'Fail: Line {} got {} expecting {}'

    if not result == expected:
        current = _getframe()
        caller = current.f_back
        line_no = caller.f_lineno
        print(msg.format(line_no, result, expected))


if __name__ == '__main__':
    assert_equal(robot(1), '1')
    assert_equal(robot(2), '2')
    assert_equal(robot(4), '4')

    assert_equal(robot(3), 'fizz')
    assert_equal(robot(6), 'fizz')
    assert_equal(robot(9), 'fizz')

    assert_equal(robot(5), 'buzz')
    assert_equal(robot(10), 'buzz')
    assert_equal(robot(20), 'buzz')

    assert_equal(robot(15), 'fizzbuzz')
    assert_equal(robot(30), 'fizzbuzz')
    assert_equal(robot(45), 'fizzbuzz')
```

Resultado:

```
Fail: Line 6 got fizzbuzz expecting fizz
Fail: Line 7 got fizzbuzz expecting fizz
Fail: Line 8 got fizzbuzz expecting fizz
Fail: Line 10 got fizzbuzz expecting buzz
Fail: Line 11 got fizzbuzz expecting buzz
Fail: Line 12 got fizzbuzz expecting buzz
```

Sucesso. Função de teste pronta. As falhas dos testes (que são o resultado de um *bug* inserido lá no início) agora estão detalhadas, facilitando a manutenção do código. Com isso em mente, a ideia agora é usar o framework próprio de testes em python: `unittest`. Para isso, todo o código da função `assert_equal` será comentado e daqui pra frente ele não aparecerá nos blocos de código.

```python
from functools import partial

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say

"""
def assert_equal(result, expected):
    from sys import _getframe

    msg = 'Fail: Line {} got {} expecting {}'

    if not result == expected:
        current = _getframe()
        caller = current.f_back
        line_no = caller.f_lineno
        print(msg.format(line_no, result, expected))


if __name__ == '__main__':
    assert_equal(robot(1), '1')
    assert_equal(robot(2), '2')
    assert_equal(robot(4), '4')

    assert_equal(robot(3), 'fizz')
    assert_equal(robot(6), 'fizz')
    assert_equal(robot(9), 'fizz')

    assert_equal(robot(5), 'buzz')
    assert_equal(robot(10), 'buzz')
    assert_equal(robot(20), 'buzz')

    assert_equal(robot(15), 'fizzbuzz')
    assert_equal(robot(30), 'fizzbuzz')
    assert_equal(robot(45), 'fizzbuzz')
"""
```

A etapa a seguir inclui o `unittest`. Uma nova classe, `FizzbuzzTest`, será inserida. Esta classe herda `TestCase` do `unittest`. Cada teste será definido um novo método. Os métodos dessa classe precisam ter `test_` no início do nome.

```python
from functools import partial
import unittest

multiple_of = lambda base, num: num % base == 0
multiple_of_5 = partial(multiple_of, 5)
multiple_of_3 = partial(multiple_of, 3)


def robot(pos):
    say = str(pos)

    if multiple_of_3(pos) or multiple_of_5(pos):
        say = 'fizzbuzz'
    elif multiple_of_5(pos):
        say = 'buzz'
    elif multiple_of_3(pos):
        say = 'fizz'

    return say


class FizzbuzzTest(unittest.TestCase):
    def test_say_1_when_1(self):
        self.assertEqual(robot(1), '1')

    def test_say_2_when_2(self):
        self.assertEqual(robot(2), '2')

    def test_say_4_when_4(self):
        self.assertEqual(robot(4), '4')

    def test_say_fizz_when_3(self):
        self.assertEqual(robot(3), 'fizz')

    def test_say_fizz_when_6(self):
        self.assertEqual(robot(6), 'fizz')

    def test_say_fizz_when_9(self):
        self.assertEqual(robot(9), 'fizz')

    def test_say_buzz_when_5(self):
        self.assertEqual(robot(5), 'buzz')

    def test_say_buzz_when_10(self):
        self.assertEqual(robot(10), 'buzz')

    def test_say_buzz_when_20(self):
        self.assertEqual(robot(20), 'buzz')

    def test_say_fizzbuzz_when_15(self):
        self.assertEqual(robot(15), 'fizzbuzz')

    def test_say_fizzbuzz_when_30(self):
        self.assertEqual(robot(30), 'fizzbuzz')

    def test_say_fizzbuzz_when_45(self):
        self.assertEqual(robot(45), 'fizzbuzz')

if __name__ == '__main__':
    unittest.main()
```

Classe de testes pronta. Logo após a classe, foi inserido um `if __name__ == '__main__':; unittest.main()`. Isso chama a função do `unittest` capaz de rodar os testes. A versão do código anterior será transferida para o arquivo `fizzbuzz_unittest.py` para que seja possível visualizar os *output* via terminal. Para chamar o arquivo pelo terminal:

```bash
python modulo_02/fizzbuzz_unittest.py
```

Resultado:

```
...FFFFFF...
======================================================================
FAIL: test_say_buzz_when_10 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "modulo_02/fizzbuzz_unittest.py", line 45, in test_say_buzz_when_10
    self.assertEqual(robot(10), 'buzz')
AssertionError: 'fizzbuzz' != 'buzz'
- fizzbuzz
+ buzz


======================================================================
FAIL: test_say_buzz_when_20 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "modulo_02/fizzbuzz_unittest.py", line 48, in test_say_buzz_when_20
    self.assertEqual(robot(20), 'buzz')
AssertionError: 'fizzbuzz' != 'buzz'
- fizzbuzz
+ buzz


======================================================================
FAIL: test_say_buzz_when_5 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "modulo_02/fizzbuzz_unittest.py", line 42, in test_say_buzz_when_5
    self.assertEqual(robot(5), 'buzz')
AssertionError: 'fizzbuzz' != 'buzz'
- fizzbuzz
+ buzz


======================================================================
FAIL: test_say_fizz_when_3 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "modulo_02/fizzbuzz_unittest.py", line 33, in test_say_fizz_when_3
    self.assertEqual(robot(3), 'fizz')
AssertionError: 'fizzbuzz' != 'fizz'
- fizzbuzz
+ fizz


======================================================================
FAIL: test_say_fizz_when_6 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "modulo_02/fizzbuzz_unittest.py", line 36, in test_say_fizz_when_6
    self.assertEqual(robot(6), 'fizz')
AssertionError: 'fizzbuzz' != 'fizz'
- fizzbuzz
+ fizz


======================================================================
FAIL: test_say_fizz_when_9 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "modulo_02/fizzbuzz_unittest.py", line 39, in test_say_fizz_when_9
    self.assertEqual(robot(9), 'fizz')
AssertionError: 'fizzbuzz' != 'fizz'
- fizzbuzz
+ fizz


----------------------------------------------------------------------
Ran 12 tests in 0.002s

FAILED (failures=6)
```

O *output* indica que 12 testes forma realizados e que 6 falharam. Lembrando que um *bug* foi inserido no início da função `robot`. Esse *bug* será corrigido e os testes serão realizados novamente.

```bash
python modulo_02/fizzbuzz_unittest.py
```

Resultado

```
............
----------------------------------------------------------------------
Ran 12 tests in 0.001s

OK
```

Todos os testes passaram. Outra forma de chamar os testes seria:

```bash
cd modulo_02
python -m unittest
```

Resultado:

```
............
----------------------------------------------------------------------
Ran 12 tests in 0.001s

OK
```

Os resultados ficariam mais interessantes se fosse utilizado o argumento `-v`, assim:

```bash
python -m unittest -v
```

Resultado:

```
test_say_1_when_1 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_2_when_2 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_4_when_4 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_buzz_when_10 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_buzz_when_15 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_buzz_when_20 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_buzz_when_30 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_buzz_when_45 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_buzz_when_5 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_fizz_when_3 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_fizz_when_6 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok
test_say_fizz_when_9 (test_fizzbuzz_update_assert.Fizzbuzz) ... ok

----------------------------------------------------------------------
Ran 12 tests in 0.001s

OK
```

Quando usado dessa forma, o comando `-m unittest` é capaz de varrer todo o código buscando por testes. Para testar isso, um novo *bug* será injetado no código.

```bash
python fizzbuzz_unittest.py
```

Resultado:

```
EEEEEEEEEEEE
======================================================================
ERROR: test_say_1_when_1 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 24, in test_say_1_when_1
    self.assertEqual(robot(1), '1')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_2_when_2 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 27, in test_say_2_when_2
    self.assertEqual(robot(2), '2')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_4_when_4 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 30, in test_say_4_when_4
    self.assertEqual(robot(4), '4')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_buzz_when_10 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 45, in test_say_buzz_when_10
    self.assertEqual(robot(10), 'buzz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_buzz_when_20 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 48, in test_say_buzz_when_20
    self.assertEqual(robot(20), 'buzz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_buzz_when_5 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 42, in test_say_buzz_when_5
    self.assertEqual(robot(5), 'buzz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_fizz_when_3 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 33, in test_say_fizz_when_3
    self.assertEqual(robot(3), 'fizz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_fizz_when_6 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 36, in test_say_fizz_when_6
    self.assertEqual(robot(6), 'fizz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_fizz_when_9 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 39, in test_say_fizz_when_9
    self.assertEqual(robot(9), 'fizz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_fizzbuzz_when_15 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 51, in test_say_fizzbuzz_when_15
    self.assertEqual(robot(15), 'fizzbuzz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_fizzbuzz_when_30 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 54, in test_say_fizzbuzz_when_30
    self.assertEqual(robot(30), 'fizzbuzz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

======================================================================
ERROR: test_say_fizzbuzz_when_45 (__main__.FizzbuzzTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "fizzbuzz_unittest.py", line 57, in test_say_fizzbuzz_when_45
    self.assertEqual(robot(45), 'fizzbuzz')
  File "fizzbuzz_unittest.py", line 11, in robot
    nova_variavel
NameError: name 'nova_variavel' is not defined

----------------------------------------------------------------------
Ran 12 tests in 0.003s

FAILED (errors=12)
```

Diferentemente dos testes anteriores, os quais informavam as falhas, os resultados acima informam erros.

## Isolando os testes em um novo arquivo

NOTE: por uma questão didática, os códigos que foram transferidos de um arquivo para outro serão apenas comentados.

Uma boa prática é transferir os testes para um arquivo a parte. Esse arquivo, recebe o nome da função a ser testada precedido por `test_`. Aqui, esse arquivo vai se chamar `test_fizzbuzz_unittest.py`. Assim, todo o trecho de código relativo aos testes será passado para esse novo arquivo. É importante lembrar de importar a função `robot` no cabeçalho do arquivo de testes.

```python
from fizzbuzz_unittest import robot
import unittest

class FizzbuzzTest(unittest.TestCase):
    def test_say_1_when_1(self):
        self.assertEqual(robot(1), '1')

    def test_say_2_when_2(self):
        self.assertEqual(robot(2), '2')

    def test_say_4_when_4(self):
        self.assertEqual(robot(4), '4')

    def test_say_fizz_when_3(self):
        self.assertEqual(robot(3), 'fizz')

    def test_say_fizz_when_6(self):
        self.assertEqual(robot(6), 'fizz')

    def test_say_fizz_when_9(self):
        self.assertEqual(robot(9), 'fizz')

    def test_say_buzz_when_5(self):
        self.assertEqual(robot(5), 'buzz')

    def test_say_buzz_when_10(self):
        self.assertEqual(robot(10), 'buzz')

    def test_say_buzz_when_20(self):
        self.assertEqual(robot(20), 'buzz')

    def test_say_fizzbuzz_when_15(self):
        self.assertEqual(robot(15), 'fizzbuzz')

    def test_say_fizzbuzz_when_30(self):
        self.assertEqual(robot(30), 'fizzbuzz')

    def test_say_fizzbuzz_when_45(self):
        self.assertEqual(robot(45), 'fizzbuzz')
```

Os arquivos `fizzbuzz_unittest.py` e `test_fizzbuzz_unittest.py` não informam qualquer *output* quando são chamados diretamente no terminal. Eles são apenas bibliotecas.

```bash
pwd
# cd modulo_02
python fizzbuzz_unittest.py
python test_fizzbuzz_unittest.py
```

Assim, para que os testes funcionem, é necessário rodar:

```bash
python -m unittest -v
```

Resultado:

```
test_say_1_when_1 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_2_when_2 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_4_when_4 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_buzz_when_10 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_buzz_when_20 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_buzz_when_5 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_fizz_when_3 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_fizz_when_6 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_fizz_when_9 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_fizzbuzz_when_15 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_fizzbuzz_when_30 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok
test_say_fizzbuzz_when_45 (test_fizzbuzz_unittest.FizzbuzzTest) ... ok

----------------------------------------------------------------------
Ran 12 tests in 0.002s

OK
```

## O que o `unittest` faz?

- Invoca o `TestRunner` a partir do diretório atual;
- Procura e carrega o módulo test_\*.py; <-- *Suite de testes*
- Identifica cada **cenário de teste** (as classes) ; <-- *TestCase*
- Identifica os **testes** (os métodos das classes) dentro de cada **cenário**; <-- *TestMethod*
- Executa **setUp** (estruturação do ambiente para os testes), **Teste** e **tearDown** (limpeza do ambiente de teste) para cada teste.

## Como o Django executa os testes?

Para executar todos os testes:

```bash
manage test
```

Ou especificar um diretório:

```bash
manage test eventex.core
```

Ou especificar apenas um cenário:

```bash
manage test eventex.core.tests.HomeTest
```

Ou especificar apenas um método:

```bash
manage test eventex.core.tests.HomeTest.test_get
```
