# M1A07: O Interpretador Python

Para conferir a versão python do sistema:

```bash
python -V
```

Para passar um programa simples para o python:

```bash
python -c "print(40 + 2)"
```

Passando usando o stderr

```bash
echo "print(40 + 2)" | python -
```

Testando um programa:

```bash
echo 'print("Python é", 40 + 2)' > meuprograma.py
```

Passando o programa para o interpretador:

```bash
python meuprograma.py
``` 

Rodando o programa e abrindo o python no modo interativo:

```bash
python -i  meuprograma.py
``` 
 
Para instalar o ipython:

```shell
pip install ipython[notebook]
```

Para testar:

```shell
ipython
```

iPython com extensão notebook:

```shell
ipython notebook
```
