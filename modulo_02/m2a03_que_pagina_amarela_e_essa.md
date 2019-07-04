# M2A03: Que página amarela é essa? - https://welcometothedjango.com.br/?post_type=aula&p=1099

Problema detectado pelo cliente: 'Page not found (404)'. Isso ocorreu porque a aplicação está em produção com `DEBUG=True`. Para resolver:

```bash
pwd
cd my_project
source .my_project/bin/activate
heroku open
```

A landingpage está funcionando.

![](img/app-ok.png)

No entanto, ao acessar uma *url* inexistente (e.g. https://eventex-kguidonimartins.herokuapp.com/nao-existe/)...

![](img/app-not-found-debug-true.png)

Listando as variáveis de ambiente.

```bash
heroku confing
```

Conferindo as opções do `heroku config`.

```bash
heroku config --help
```

É exibido:

```
display the config vars for an app

USAGE
  $ heroku config

OPTIONS
  -a, --app=app        (required) app to run command against
  -j, --json           output config vars in json format
  -r, --remote=remote  git remote of app to use
  -s, --shell          output config vars in shell format

COMMANDS
  config:edit   interactively edit config vars
  config:get    display a single config value for an app
  config:set    set one or more config vars
  config:unset  unset one or more config vars
```

Para reconfigurar o `DEBUG=True`, usa-se:

```bash
heroku config:set DEBUG=False
```

Conferir no navagador como a [*url*](https://eventex-kguidonimartins.herokuapp.com/nao-existe/) inexistente é apresentada.

![](img/app-not-found-debug-false.png)

Alteração do `my_project/eventex/settings.py` trocando `ALLOWED_HOSTS = ['*']` para `ALLOWED_HOSTS = []`. E voltando para o modo de debug em produção.

```bash
heroku config:set DEBUG=True
```

A página retorna ao erro inicial!

![](img/app-not-found-debug-true.png)

Rodando a aplicação localmente.

```bash
manage runserver
```

Reproduzindo o erro de [*url*](http://127.0.0.1:8000/nao-existe/), porém localmente.

![](img/app-not-found-debug-true-running-locally.png)

Informações do terminal.

```bash
June 29, 2019 - 14:22:54
Django version 2.2.2, using settings 'eventex.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
[29/Jun/2019 14:22:59] "GET / HTTP/1.1" 200 6186
Not Found: /nao-existe/
[29/Jun/2019 14:24:06] "GET /nao-existe/ HTTP/1.1" 404 2073
Not Found: /favicon.ico
[29/Jun/2019 14:24:07] "GET /favicon.ico HTTP/1.1" 404 2073
```

Desabilitando o `DEBUG`.

```bash
DEBUG=False manage runserver
```

Informações do terminal.

```
CommandError: You must set settings.ALLOWED_HOSTS if DEBUG is False.
```

Visitar documentação: https://docs.djangoproject.com/en/2.2/ref/settings/#allowed-hosts

Mudanças no `ALLOWED_HOSTS = []` do `my_project/eventex/settings.py` para `ALLOWED_HOSTS = ['127.0.0.1']`

Desabilitando o `DEBUG` novamente.

```bash
DEBUG=False manage runserver
```

Era esperado que a home da langindpage fosse exibida sem o estilo

![](../modulo_01/img/eventex-cru.png)

Mas não aconteceu aqui. Para estes casos, é necessário rodar o comando para coletar os arquivos estáticos.

```bash
manage collectstatic
```

E, novamente:

```bash
DEBUG=False manage runserver
```

Agora [*url*](http://127.0.0.1:8000/nao-existe/) inexistente deve ser exibida as informações do DEBUG.

![](img/app-not-found-debug-false-running-locally.png)

Permitindo HOST no ambiente de desenvvolvimento. Para isso, altera-se o `ALLOWED_HOSTS` do `my_project/eventex/settings.py` para `ALLOWED_HOSTS = ['127.0.0.1', '.localhost']`. E para produção, inclue-se o '.herokuapp.com'.

Além disso, ajusta-se o `.env`, uma vez que essa cofigurações são da instância e não do projeto. Assim, `ALLOWED_HOSTS = ['127.0.0.1', '.localhost', '.herokuapp.com']` é incluído no `.env` dessa forma: `ALLOWED_HOSTS=127.0.0.1, .localhost, .herokuapp.com`

Confira modificações no `ALLOWED_HOSTS` do `my_project/eventex/settings.py`. O `Csv` agora será importado do decouple e o `ALLOWED_HOSTS` ficará assim: `ALLOWED_HOSTS = config('ALLOWED_HOSTS', default=[], cast=Csv())`.

Cancele o processo no terminal e reinicie novamente.

```bash
DEBUG=False manage runserver
```

Conferir a [*url*](http://127.0.0.1:8000/nao-existe/) inexistente.

Configurando as novas informações no heroku.

```bash
heroku config:set ALLOWED_HOSTS=.herokuapp.com
```

Informações do terminal:

```
Setting ALLOWED_HOSTS and restarting ⬢ eventex-kguidonimartins... done, v10
ALLOWED_HOSTS: .herokuapp.com
```

Checando:

```bash
heroku config
```

Informações do terminal:

```
=== eventex-kguidonimartins Config Vars
ALLOWED_HOSTS: .herokuapp.com
DATABASE_URL:  postgres://nevbxmhsjkfqxc:3ae855586a29b982844f8525cbce6d793f3123c466ea55a3870c44498c1cafd4@ec2-174-129-227-128.compute-1.amazonaws.com:5432/ddqprqtcjmfska
DEBUG:         True
SECRET_KEY:    f1zhoutybyd@2)g3df^d3tne3+k5*7y2tb&&p4svp$l3c_4f^n
```

## Enviando as informações para a produção.

Checando e adicionado as modificações.

```bash
git status
git add eventex/settings.py
git status
git commit -m "Configura ALLOWED_HOSTS"
git push heroku master --force
```

Informações do terminal:

```
Counting objects: 7, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 1.01 KiB | 0 bytes/s, done.
Total 7 (delta 3), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Python app detected
remote: -----> Installing requirements with pip
remote:
remote: -----> $ python manage.py collectstatic --noinput
remote:        /app/.heroku/python/lib/python3.6/site-packages/psycopg2/__init__.py:144: UserWarning: The psycopg2 wheel package will be renamed from release 2.8; in order to keep installing from binary please use "pip install psycopg2-binary" instead. For details see: <http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.
remote:          """)
remote:        182 static files copied to '/tmp/build_3d8bec605da7ea6e4cd8410f27e70c0a/staticfiles'.
remote:
remote: -----> Discovering process types
remote:        Procfile declares types -> web
remote:
remote: -----> Compressing...
remote:        Done: 56.9M
remote: -----> Launching...
remote:        Released v11
remote:        https://eventex-kguidonimartins.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy... done.
To https://git.heroku.com/eventex-kguidonimartins.git
   d89f274..ad15c4c  master -> master
```

Conferindo o site.

```bash
heroku open
```

O código foi atualizado, mas o modo de debug na produção continua `DEBUG=True`

Mudando:

```bash
heroku config:set DEBUG=False
```
