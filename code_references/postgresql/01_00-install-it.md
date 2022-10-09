# Installiamo PostgreSQL

Risorse interne:

* 01-base/01-new_app/04-install_postgresql
* 01-base/01-new_app/04b-install_postgresql_on_ec2_amazon


Risorse web:

* [How to Install PostgreSQL on Ubuntu 18.04](https://linuxize.com/post/how-to-install-postgresql-on-ubuntu-18-04/)
* [How To Install and Use PostgreSQL on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04)




## Installiamo PostgreSQL su piattaforma Ubuntu

```bash
$ sudo apt update
$ sudo apt install postgresql postgresql-contrib libpq-dev
-> y
```

oppure

```bash
$ sudo su - 
> apt update
> apt install postgresql postgresql-contrib libpq-dev
-> y
> exit
```


oppure ?!?

```bash
$ sudo su - 
> sudo apt update
> sudo apt install postgresql postgresql-contrib libpq-dev
-> y
> exit
```
