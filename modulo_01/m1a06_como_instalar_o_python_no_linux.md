# M1A06: Como instalar o Python no Linux

A sugestão do Henrique é usar o `pyenv`. ~~Eu não sei até que ponto isso pode estragar as instalações do python na minha máquina, uma vez que estou usando o anaconda~~

O `pyenv` depende de algumas bibliotecas, que podem ser encontradas aqui: https://github.com/pyenv/pyenv/wiki/Common-build-problems

O comando abaixo foi extraído do link anterior:

```bash
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

A instalação do `pyenv` é feita por um script baixado do próprio [repositório oficial](https://github.com/pyenv/pyenv-installer) do `pyenv` no github. Use:

```bash
curl https://pyenv.run | bash
```

Após a instalação, aparecerá a seguinte mensagem:

```
WARNING: seems you still have not added 'pyenv' to the load path.

# Load pyenv automatically by adding
# the following to ~/.bashrc:

export PATH="/home/karlo/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

Vamos seguir o que foi recomendado e incluir essas três linhas no arquivo ~/.bashrc:

```bash
echo '
export PATH="/home/karlo/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
' > ~/.bashrc 
```

Para que tudo funcione, é necessário recarregar o arquivo .bashrc com:

```bash
source ~/.bashrc
```

Para testar se o `pyenv` foi instalado com sucesso, executamos:

```bash
pyenv
```

Para verificar as versões disponíveis do python, usamos:

```bash
pyenv install -l
```

Para instalar a última versão do python, usamos:

```bash
pyenv install 3.7.3
```

Após a instalação, verificamos as versões python disponíveis:

```bash
pyenv versions
```

Precisamos agora informar para o sistema operacional que queremos que a versão recém instalada seja a versão python global.

```bash
pyenv global 3.7.3
```

Confira:

```bash
pyenv versions
```

Abra um novo terminal e teste:

```bash
python -V
```

E, depois:

```bash
python
```
