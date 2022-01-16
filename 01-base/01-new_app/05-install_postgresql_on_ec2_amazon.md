# <a name="01-01-04"></a> Cap 1.5 -- Installiamo PostgreSQL su Amazon Linux

> Possiamo **saltare** questo capitolo.
> Questa procedura è per ambienti di Cloud9 (istanze EC2) con sistema operativo **Amazon Linux**


# Installiamo PostgreSQL

Se avessimo utilizzato l'istanza con **OS Amazon Linux** avremmo dovuto installare PostgreSQL come descritto in questo capitolo.
Questa parte non fa parte della nostra applicazione e quindi la saltiamo.




## Risorse web:

- [Setting up Postgres on Cloud9 IDE](https://medium.com/@floodfx/setting-up-postgres-on-cloud9-ide-720e5b879154)




## Installiamo PostgreSQL

siamo su EC2 instance con OS Amazon Linux che usa "Yum" come packet manager.

Setting up Postgres on Cloud9 IDE
Install Postgres via Yum

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
--> y
~~~~~~~~




## Run postgres service init

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql initdb

Initializing database:                                     [  OK  ]
~~~~~~~~




## Edit postgres conf to connect via localhost:5432

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
sudo vim /var/lib/pgsql9/data/postgresql.conf
~~~~~~~~

Decomentiamo le 2 righe (da --> a)

* #listen_addresses = 'localhost' --> listen_addresses = 'localhost'
* #port = 5432                    --> port = 5432

I comandi VIM da usare sono:

* muoversi con le frecce. 
* [i] per entrare in modalità modifica. 
* [canc] per cancellare.
* [ESC] per uscire dalla modifica.
* [:w] per salvare
* [:q] per uscire

![Fig. 01](images/01-beginning/01-new_app/03_01-postgresql_conf-uncomment-addresses_and_port.PNG)




## Update pg_hba.conf file for ec2-user auth:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
sudo vim /var/lib/pgsql9/data/pg_hba.conf
~~~~~~~~

Trovare la parte che è

~~~~~~~~
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
# IPv6 local connections:
host    all             all             ::1/128                 ident
~~~~~~~~

E modificare in

~~~~~~~~
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ec2-user        127.0.0.1/0             trust
# IPv6 local connections:
host    all             all             ::1/128                 md5
~~~~~~~~




## Start / Restart postgres server

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
~~~~~~~~

or

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql restart
~~~~~~~~




## Login as Postgres User and Change Password / Add ec2-user

* login as postgres user
* login to postgres db as postgres user
* cambia la password




{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo su - postgres 
-> psql -U postgres
--> ALTER USER postgres WITH PASSWORD 'myPassword123';
--> CREATE USER "ec2-user" SUPERUSER;
--> ALTER USER "ec2-user" WITH PASSWORD 'myPassword123';
--> \q
-> exit


ec2-user:~/environment $ sudo su - postgres 
-bash-4.2$ psql -U postgres
psql (9.2.24)
Type "help" for help.

postgres=# ALTER USER postgres WITH PASSWORD 'myPassword123';
ALTER ROLE
postgres=# CREATE USER "ec2-user" SUPERUSER;
CREATE ROLE
postgres=# ALTER USER "ec2-user" WITH PASSWORD 'myPassword123';
ALTER ROLE
postgres=# \q
-bash-4.2$ exit
logout
ec2-user:~/environment $ 
~~~~~~~~

![Fig. 02](images/01-beginning/01-new_app/03_02-pg_change_password_and_create_user.PNG)

Adesso è tutto inizializzato e pronto per lavorare su aws Cloud9.




## Future connessioni al database

Se in futuro volessimo lavorare da linea di comando direttamente sul database PostgreSQL possiamo effettuare Login come utente "ec2-user" con il seguente codice:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ psql postgres
~~~~~~~~

Una volta entrati possiamo creare il nostro proprio database e lavorare sulle tabelle.

Ma per quanto riguarda il nostro tutorial abbiamo già tutto quello che ci serve per continuare.
