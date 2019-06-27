# M1A24: Supere o medo da Web - https://welcometothedjango.com.br/?post_type=aula&p=934

O que é *url*? Onde ele está? Como chegar lá? Como falo? Como represento? É feito de que?

## DNS

Domain Name Service: responde para o navegador quem é a *url*. O DNS é um gerenciador de domínios espalhados pelo mundo que conecta o nome contido na *url* ao IP da própria *url*.

## TCP

Garante a entrega do pacote requisitado ao cliente (navegador) ao servidor.

## HTTP Request

```bash
curl -iv http://welcometothedjango.com.br/
```

A requisição do comando acima é dada por:

```
GET / HTTP/1.1
User-Agent: curl/7.19.7 (universal-apple) libcurl/7.19.7
Host: welcometothedjango.com.br
Accept: */*
```

## HTTP Response

```bash
curl -i http://welcometothedjango.com.br/
```
