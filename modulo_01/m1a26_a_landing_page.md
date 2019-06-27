# M1A26: A landing page - https://welcometothedjango.com.br/?post_type=aula&p=936

Baixando o pacote zip que nosso amigo design preparou.

```bash
pwd
cd my_project
pwd
wget https://welcometothedjango.com.br/wp-content/uploads/2015/12/landingpage.zip
unzip landingpage.zip
```

Importando template para o projeto.

```bash
pwd
mkdir -p eventex/core/static
mv -t eventex/core/static landingpage/css landingpage/fonts/ landingpage/img landingpage/js
mv -t eventex/core/templates landingpage/index.html
```
