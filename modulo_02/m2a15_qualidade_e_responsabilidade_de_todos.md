# M2A15: Qualidade é responsabilidade de todos - https://welcometothedjango.com.br/?post_type=aula&p=1111

## Refatoração dos códigos de testes (arrumando a casa)

Primeiro é preciso restruturar o projeto, que deve sair dessa estrutura:

```
.
├── Procfile
├── README.md
├── db.sqlite3
├── eventex/
│   ├── __init__.py
│   ├── core/
│   │   ├── __init__.py
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── migrations/
│   │   ├── models.py
│   │   ├── static/
│   │   ├── templates/
│   │   ├── tests.py
│   │   └── views.py
│   ├── settings.py
│   ├── subscriptions/
│   │   ├── __init__.py
│   │   ├── forms.py
│   │   ├── templates/
│   │   ├── tests.py
│   │   └── views.py
│   ├── urls.py
│   └── wsgi.py
├── landingpage.zip
├── manage.py
├── requirements.txt
└── staticfiles/
```

Para essa:

```
.
├── Procfile
├── README.md
├── db.sqlite3
├── eventex/
│   ├── __init__.py
│   ├── core/
│   │   ├── __init__.py
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── migrations/
│   │   │   ├── __init__.py
│   │   ├── models.py
│   │   ├── static/
│   │   ├── templates/
│   │   ├── tests/
│   │   │   ├── __init__.py
│   │   │   └── test_view_home.py # renomeado de `core/tests.py`
│   │   └── views.py
│   ├── settings.py
│   ├── subscriptions/
│   │   ├── __init__.py
│   │   ├── forms.py
│   │   ├── templates/
│   │   │   └── subscriptions/
│   │   ├── tests/
│   │   │   ├── __init__.py
│   │   │   └── test_view_subscribe.py # renomeado de `subscriptions/tests.py`
│   │   └── views.py
│   ├── urls.py
│   └── wsgi.py
├── landingpage.zip
├── manage.py
├── requirements.txt
└── staticfiles
```

Basicamente, os arquivos `core/tests.py` e `subscriptions/tests.py` foram renomeados e para `core/tests/test_view_home.py` e `subscriptions/tests/test_view_subscribe.py`, respectivamente. Essas pastas de teste foram transformadas em pacotes python com a adição do arquivo `__init__.py` em cada uma delas.

Rodando os testes:

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....................
----------------------------------------------------------------------
Ran 20 tests in 0.177s

OK
Destroying test database for alias 'default'...
```

Apesar da mudança na estrutura, os testes ainda são executados sem erros. O python procura módulo que começam com a palavra teste e os executa independentemente da pasta que eles estão.

## Refatoração do teste em `subscriptions`

O primeiro passo é reduzir redundâncias. Primeiro trecho que será reduzido é o método `test_html` da class `SubscribeTest`. Ele vai sair disso:

```python
def test_html(self):
    """HTML must contain input tags"""
    self.assertContains(self.resp, '<form')
    self.assertContains(self.resp, '<input', 6)
    self.assertContains(self.resp, 'type="text"', 3)
    self.assertContains(self.resp, 'type="email"')
    self.assertContains(self.resp, 'type="submit"')
```

Para isso:

```python
def test_html(self):
    """HTML must contain input tags"""
    tags = (
        ('<form', 1),
        ('<input', 6),
        ('type="text"', 3),
        ('type="email"', 1),
        ('type="submit"', 1)
    )

    for text, count in tags:
        with self.subTest():
            self.assertContains(self.resp, text, count)
```

Testando:

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....................
----------------------------------------------------------------------
Ran 20 tests in 0.162s

OK
Destroying test database for alias 'default'...
```

Teste ok. Agora, dois erros serão inseridos para que seja possível entender como o `subTest` funciona. Os erros serão símbolos de `!` nas `tags`, assim:

```python
def test_html(self):
    """HTML must contain input tags"""
    tags = (
        ('<form', 1),
        ('<input!', 6),
        ('type="text"!', 3),
        ('type="email"', 1),
        ('type="submit"', 1)
    )

    for text, count in tags:
        with self.subTest():
            self.assertContains(self.resp, text, count)
```

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...................
======================================================================
FAIL: test_html (eventex.subscriptions.tests.test_view_subscribe.SubscribeTest) (<subtest>)
HTML must contain input tags
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/karlo/google-drive/kguidonimartins/git-repos/wttd/my_project/eventex/subscriptions/tests/test_view_subscribe.py", line 30, in test_html
    self.assertContains(self.resp, text, count)
  File "/home/karlo/.pyenv/versions/3.7.4/lib/python3.7/site-packages/django/test/testcases.py", line 451, in assertContains
    msg_prefix + "Found %d instances of %s in response (expected %d)" % (real_count, text_repr, count)
AssertionError: 0 != 6 : Found 0 instances of '<input!' in response (expected 6)

======================================================================
FAIL: test_html (eventex.subscriptions.tests.test_view_subscribe.SubscribeTest) (<subtest>)
HTML must contain input tags
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/karlo/google-drive/kguidonimartins/git-repos/wttd/my_project/eventex/subscriptions/tests/test_view_subscribe.py", line 30, in test_html
    self.assertContains(self.resp, text, count)
  File "/home/karlo/.pyenv/versions/3.7.4/lib/python3.7/site-packages/django/test/testcases.py", line 451, in assertContains
    msg_prefix + "Found %d instances of %s in response (expected %d)" % (real_count, text_repr, count)
AssertionError: 0 != 3 : Found 0 instances of 'type="text"!' in response (expected 3)

----------------------------------------------------------------------
Ran 20 tests in 0.147s

FAILED (failures=2)
Destroying test database for alias 'default'...
```

Ainda são 20 testes, mas o `subTest` reporta os dois `AssertionError`. Os erros foram corrigidos.

O objetivo agora é normalizar os nomes das classes em `subscriptions/tests/test_view_subscribe.py`. Elas devem sair de:

```python
class SubscribeTest(TestCase):
class SubscribePostTest(TestCase):
class SubscribeInvalidPost(TestCase):
class SubscribeSuccessMessage(TestCase):
```

Para:

```python
class SubscribeGet(TestCase):
class SubscribePostValid(TestCase):
class SubscribePostInvalid(TestCase):
class SubscribeSuccessMessage(TestCase):
```

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....................
----------------------------------------------------------------------
Ran 20 tests in 0.182s

OK
Destroying test database for alias 'default'...
```

Teste ok.

Ao examinar a classe `SubscribePostValid`, percebe-se que os métodos estão acumulando muita responsabilidade, testando tanto o envio do email (que deve ser de responsabilidade somente da view) quanto o seu conteúdo. O ideal é transferir parte de suas responsabilidades para um arquivo a parte. O arquivo `subscriptions/tests/test_mail_subscribe.py` será criado e receberá parte do conteúdo (responsável pelo conteúdo do email) da classe `SubscribePostValid`.

Os arquivos ficarão assim:

- `subscriptions/tests/test_view_subscribe.py`:

```python
from django.core import mail
from django.test import TestCase
from eventex.subscriptions.forms import SubscriptionForm


class SubscribeGet(TestCase):
    def setUp(self):
        self.resp = self.client.get('/inscricao/')

    def test_get(self):
        """Get /inscricao/ must return status code 200"""
        self.assertEqual(200, self.resp.status_code)

    def test_template(self):
        """Must use subscriptions/subscription_form.html"""
        self.assertTemplateUsed(self.resp, 'subscriptions/subscription_form.html')

    def test_html(self):
        """HTML must contain input tags"""
        tags = (
            ('<form', 1),
            ('<input', 6),
            ('type="text"', 3),
            ('type="email"', 1),
            ('type="submit"', 1)
        )

        for text, count in tags:
            with self.subTest():
                self.assertContains(self.resp, text, count)

    def test_csrf(self):
        """HTML must contain csrf"""
        self.assertContains(self.resp, 'csrfmiddlewaretoken')

    def test_has_form(self):
        """Context must have subscription form"""
        form = self.resp.context['form']
        self.assertIsInstance(form, SubscriptionForm)

    def test_form_has_fields(self):
        """Form must have 4 fields"""
        form = self.resp.context['form']
        self.assertSequenceEqual(['name', 'cpf', 'email', 'phone'], list(form.fields))


class SubscribePostValid(TestCase):
    def setUp(self):
        data = dict(
            name = 'Karlo Guidoni Martins',
            cpf = '12345678901',
            email = 'kguidonimartins@gmail.com',
            phone = '28-9-9992-2969'
        )
        self.resp = self.client.post('/inscricao/', data)

    def test_post(self):
        """Valid POST shoud redirect to /inscricao/"""
        self.assertEqual(302, self.resp.status_code)

    def test_send_subscribe_email(self):
        self.assertEqual(1, len(mail.outbox))


class SubscribePostInvalid(TestCase):
    def setUp(self):
        self.resp = self.client.post('/inscricao/', {})

    def test_post(self):
        """Invalid POST should not redirect"""
        self.assertEqual(200, self.resp.status_code)

    def test_template(self):
        self.assertTemplateUsed(self.resp, 'subscriptions/subscription_form.html')

    def test_has_form(self):
        form = self.resp.context['form']
        self.assertIsInstance(form, SubscriptionForm)

    def test_form_has_errors(self):
        form = self.resp.context['form']
        self.assertTrue(form.errors)


class SubscribeSuccessMessage(TestCase):
    def test_message(self):
        data = dict(
            name='Karlo Guidoni Martins',
            cpf='12345678901',
            email='kguidonimartins@gmail.com',
            phone='28999922969'
        )
        response = self.client.post('/inscricao/', data, follow=True)
        self.assertContains(response, 'Inscrição realizada com sucesso!')
```

- `subscriptions/tests/test_mail_subscribe.py`:

```python
from django.core import mail
from django.test import TestCase

class SubscribePostValid(TestCase):
    def setUp(self):
        data = dict(
            name = 'Karlo Guidoni Martins',
            cpf = '12345678901',
            email = 'kguidonimartins@gmail.com',
            phone = '28-9-9992-2969'
        )
        self.resp = self.client.post('/inscricao/', data)

    def test_subscription_email_subject(self):
        email = mail.outbox[0]
        expect = 'Confirmação de inscrição'

        self.assertEqual(expect, email.subject)

    def test_subscription_email_from(self):
        email = mail.outbox[0]
        expect = 'contato@eventex.com.br'

        self.assertEqual(expect, email.from_email)

    def test_subscription_email_to(self):
        email = mail.outbox[0]
        expect = ['contato@eventex.com.br', 'kguidonimartins@gmail.com']

        self.assertEqual(expect, email.to)

    def test_subscription_email_body(self):
        email = mail.outbox[0]

        self.assertIn('Karlo Guidoni Martins', email.body)
        self.assertIn('12345678901', email.body)
        self.assertIn('kguidonimartins@gmail.com', email.body)
        self.assertIn('28-9-9992-2969', email.body)
```

O teste aqui é necessário para garantir que 20 testes serão executados.

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....................
----------------------------------------------------------------------
Ran 20 tests in 0.160s

OK
Destroying test database for alias 'default'...
```

Teste ok. O objetivo agora é refatorar o `subscriptions/tests/test_mail_subscribe.py`. Que deve ficar assim:

```python
from django.core import mail
from django.test import TestCase

class SubscribePostValid(TestCase):
    def setUp(self):
        data = dict(
            name = 'Karlo Guidoni Martins',
            cpf = '12345678901',
            email = 'kguidonimartins@gmail.com',
            phone = '28-9-9992-2969'
        )
        self.resp = self.client.post('/inscricao/', data)
        self.email = mail.outbox[0]

    def test_subscription_email_subject(self):
        expect = 'Confirmação de inscrição'

        self.assertEqual(expect, self.email.subject)

    def test_subscription_email_from(self):
        expect = 'contato@eventex.com.br'

        self.assertEqual(expect, self.email.from_email)

    def test_subscription_email_to(self):
        expect = ['contato@eventex.com.br', 'kguidonimartins@gmail.com']

        self.assertEqual(expect, self.email.to)

    def test_subscription_email_body(self):
        contents = [
            'Karlo Guidoni Martins',
            '12345678901',
            'kguidonimartins@gmail.com',
            '28-9-9992-2969'
        ]

        for content in contents:
            with self.subTest():
                self.assertIn(content, self.email.body)
```

Testando:

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....................
----------------------------------------------------------------------
Ran 20 tests in 0.188s

OK
Destroying test database for alias 'default'...
```

O mesmo contexto de acúmulo de responsabilidades acontece dentro da class `SubscribeGet` em `subscriptions/tests/test_view_subscribe.py`. O método `test_form_has_fields` está dentro do contexto errado. O ideal é ter um teste unitário somente para os campos do formulário. O objetivo é extraí-lo para um novo módulo: `subscriptions/tests/test_form_subscription.py` que deve ficar assim:

```python
from django.test import TestCase
from eventex.subscriptions.forms import SubscriptionForm

class SubscriptionFormTest(TestCase):
    def setUp(self):
        self.form = SubscriptionForm()

    def test_form_has_fields(self):
        """Form must have 4 fields"""
        expected = ['name', 'cpf', 'email', 'phone']
        self.assertSequenceEqual(expected, list(self.form.fields))
```

Testando para garantir os 20 testes (garantir que tudo foi extraído e transferido sem a criação de testes adicionais):

```bash
manage test
```

Resultado:

```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....................
----------------------------------------------------------------------
Ran 20 tests in 0.204s

OK
Destroying test database for alias 'default'...
```

Parei no 15:00
