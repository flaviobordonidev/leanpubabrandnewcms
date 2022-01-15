{id: 01-base-01-new_app-04-install_postgresql}
# Cap 1.4 -- Installiamo PostgreSQL

***
Questa procedura è per ambienti di Cloud9 (istanze EC2) con sistema operativo Ubuntu
***

Il database postgreSQL non è installato di default su AWS Cloud9
Di default Rails ha attivo il database sqlite3 ma noi sin da subito nella nostra nuova applicazione useremo PostgreSQL, quindi è bene installarlo.
Usiamo PostgreSQL perché è lo stesso database che usa Heroku; e noi useremo Heroku per mettere la nostra app in produzione.


Risorse interne:

* 99-rails_references/postgresql/01-install




## Installiamo PostgreSQL

Siamo su instance EC2 con OS Ubuntu che usa "apt" come packet manager.

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo apt update
$ sudo apt install postgresql postgresql-contrib libpq-dev
-> y
```




## Impostiamo il file di configurazione di postgreSQL per collegarsi via localhost:5432

Impostiamo il collegamento di rails a postgresql con l'indirizzo "localhost" e la porta "5432"

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo vim /etc/postgresql/10/main/postgresql.conf
```

Decomentiamo le righe (da --> a)

* #listen_addresses = 'localhost' --> listen_addresses = 'localhost'
* #port = 5432                    --> port = 5432

(la seconda riga potrebbe già essere decommentata)

Per fare delle modifiche con VIM:

* muoversi con le frecce sulla tastiera. 
* premere [i] per entrare in modalità modifica. 
* premere [canc] per cancellare.
* premere [ESC] per uscire dalla modalità modifica.
* Quando si è fuori dalla modalità modifica digitare " :w " e premere [ENTER] per salvare.
* Quando si è fuori dalla modalità modifica digitare " :q " e premere [ENTER] per uscire.
* Quando si è fuori dalla modalità modifica digitare " :wq " e premere [ENTER] per salvare ed uscire.

![Fig. 01](chapters/01-base/01-new_app/04_fig01-postgresql_conf-uncomment-addresses_and_port.png)




## Aggiorniamo il file " pg_hba.conf " per l'autenticazione

Nel seguente file di configurazione impostiamo la connessione locale IPv4 sull'indirizzo di "localhost" (127.0.0.1) e l'id dell'utente registrato nel sistema operativo.

Attenzione:
Se ci logghiamo su AWS come " root " nel prompt del terminal vediamo il nome " ubuntu ": 

{caption: "terminal", format: bash, line-numbers: false}
```
ubuntu:~/environment $
```


Invece se ci logghiamo su AWS come utente IAM " user_fb " nel prompt del terminal vediamo il nome " user_fb ": 

{caption: "terminal", format: bash, line-numbers: false}
```
user_fb:~/environment $
```


Comunque in entrambi i casi l'" id " dell'utente registrato è " ubuntu " e questo lo verifichiamo con il seguente comando: 

{caption: "terminal", format: bash, line-numbers: false}
```
$ whoami


user_fb:~/environment $ whoami
ubuntu
```


Aggiorniamo quindi il file di configurazione

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo vim /etc/postgresql/10/main/pg_hba.conf
```

Troviamo la parte:

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            md5
host    replication     all             ::1/128                 md5
```

![Fig. 02](chapters/01-base/01-new_app/04_fig02-postgresql_conf-default-addresses_and_port.png)

e modifichiamo le seguenti due righe:

```
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ubuntu          127.0.0.1/0             trust
```

![Fig. 03](chapters/01-base/01-new_app/04_fig03-postgresql_conf-updated-addresses_and_port.png)





## Riavviamo il servizio postgreSQL

Start / Restart postgres server

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
```

or

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql restart
```




## Cambiamo la password per l'utente di default di postgreSQL ed aggiungiamo utente " ubuntu "

Logghiamoci su PostgreSQL come utente " postgres " che è l'utente di default, e gli cambiamo la password. Inoltre aggiungiamo l'utente " ubuntu ".

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo su - postgres
-> psql -U postgres
--> ALTER USER postgres WITH PASSWORD 'myPassword123';
--> CREATE USER "ubuntu" SUPERUSER;
--> ALTER USER "ubuntu" WITH PASSWORD 'myPassword123';
--> \q
-> exit


ec2-user:~/environment $ sudo su - postgres 
-bash-4.2$ psql -U postgres
psql (9.2.24)
Type "help" for help.

postgres=# ALTER USER postgres WITH PASSWORD 'myPassword123';
ALTER ROLE
postgres=# CREATE USER "ubuntu" SUPERUSER;
CREATE ROLE
postgres=# ALTER USER "ubuntu" WITH PASSWORD 'myPassword123';
ALTER ROLE
postgres=# \q
-bash-4.2$ exit
logout
ec2-user:~/environment $ 
```

Adesso è tutto inizializzato e pronto per lavorare su aws Cloud9.




## Future connessioni al database

Se in futuro volessimo lavorare da linea di comando direttamente sul database PostgreSQL potremmo effettuare Login con:

{caption: "terminal", format: bash, line-numbers: false}
```
$ psql postgres
```

Una volta entrati potremmo creare il nostro proprio database e lavorare sulle tabelle.

Ma per quanto riguarda il nostro tutorial abbiamo già tutto quello che ci serve per continuare.
