# M2A01: Como não ficar para trás com seu projeto Django - https://welcometothedjango.com.br/?post_type=aula&p=907

Atualizando versão do Django do projeto. Visite https://www.djangoproject.com/, aba 'Downloads' e procure por 'Release notes'.

Acesse o diretório de trabalho e ative o 'virtual env'.

```bash
cd my_ project
source .my_project/bin/activate
```

Confira a versão do Django.

```bash
pip freeze
```

Atualize o django.

```bash
pip install --upgrade django
```

Conferir novamente a versão.

```bash
pip freeze
```

Atualize o requirements.txt na mão. Mude apenas a versão do Django. Isso porque dois módulos (gunicorn e psycopg2) foram inseridos manualmente. Adicione (`git add requirements.txt`) e commite (`git commit -m "Atualiza django para versão X"`) as mudanças ocorridas no requirements.txt.

## Checagem de mudanças ou quebras no código com a nova versão.

Informa se algo importante mudou ou se alguma função está marcado como 'deprecated' (manutenção descontinuada na próxima release)

```bash
python manage.py check
```

Rodar os testes.

```bash
python manage.py test
```

Conferir se tá tudo rodando.

```bash
python manage.py runserver
```

## Deploy

```bash
git status
```

Commite as mudanças e mande para o heroku.

```bash
git push heroku master --force
```
