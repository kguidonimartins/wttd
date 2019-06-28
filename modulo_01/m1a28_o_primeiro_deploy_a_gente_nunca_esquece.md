# M1A28: O primeiro deploy a gente nunca esquece - https://welcometothedjango.com.br/?post_type=aula&p=938

Necessidade de separar o que é do projeto e o que é da instância. Quem facilita essa separação é o `python-decouple`. Com o `virtual-env` ativo, instale:

```bash
pip install python-decouple
pip install dj-database-url
pip install dj-static
```

Pegue as alterações com o commit desse arquivo.

Nota¹: a SECRET_KEY dentro do arquivo `.env` não pode conter espaço nem aspas.

Nota²: sqlite3 para desenvolvimento e postgresql para produção

Nota³: entrada do 'gunicorn==19.8.1' e  do 'psycopg2==2.7.4' no requirements.txt sem o uso do `pip`. Essas bibliotecas serão utilizadas somente em produção. Além disso, elas podem exigir outras dependências não prontamente disponíveis pelo sistema operacional.
