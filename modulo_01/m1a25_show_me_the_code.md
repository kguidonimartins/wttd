# M1A25: Show me the code - https://welcometothedjango.com.br/?post_type=aula&p=935

Django mão na massa.

Criação do projeto.

```bash
mkdir my_project
cd my_project
```

Criação  do `pyenv` para isolar as dependências do projeto. O diretório do `pyenv` será oculto.

```bash
python -m venv .my_project
```

Ativação do ambiente isolado.

```bash
source .my_project/bin/activate
```

Verificação da ativação. A ativação deve indicar o caminho do python que está sendo utilizado no projeto.

```bash
which python
```

Instalando o Django.

```bash
pip install --upgrade pip
pip install django
```

Inicialização do projeto.

```bash
django-admin startproject eventex .
```

Inspecionando o eventex (pacote python)

```bash
tree
# .
# ├── eventex
# │   ├── __init__.py  # indica que o eventex é um pacote python
# │   ├── settings.py  # submódulo
# │   ├── urls.py      # submódulo
# │   └── wsgi.py      # submódulo
# └── manage.py
```

Comando disponíveis:

```bash
manage
```

Criando alias para manage.py (faça isso, para o seu bem)

```bash
cd eventex
pwd
echo $VIRTUAL_ENV
alias manage='python $VIRTUAL_ENV/../manage.py'
echo $VIRTUAL_ENV
manage
```

Inicializando servidor:

```bash
manage runserver
```

Criação da primeira django app

```bash
manage startapp core
```

Retorno ao diretório e visualização da estrutura.

```bash
cd ..
pwd
tree
# Isso está dentro de my_project/
# my_project/
# ├── db.sqlite3
# ├── eventex
# │   ├── __init__.py
# │   ├── __pycache__
# │   │   ├── __init__.cpython-37.pyc
# │   │   ├── settings.cpython-37.pyc
# │   │   ├── urls.cpython-37.pyc
# │   │   └── wsgi.cpython-37.pyc
# │   ├── core
# │   │   ├── __init__.py
# │   │   ├── admin.py
# │   │   ├── apps.py
# │   │   ├── migrations
# │   │   │   └── __init__.py
# │   │   ├── models.py
# │   │   ├── tests.py
# │   │   └── views.py
# │   ├── settings.py
# │   ├── urls.py
# │   └── wsgi.py
# └── manage.py
```

ATENÇÃO À HIERARQUIA NECESSÁRIA PARA TUDO FUNCIONAR!

A partir daqui, os outro comandos são executados no pycharm. Para a instalação do pycharm, consulte o arquivo: `others/00_instalacao-pycharm-ubuntu-1604.md`
