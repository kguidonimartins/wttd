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