




## Impostiamo il file di configurazione di postgreSQL per collegarsi via localhost:5432

Impostiamo il collegamento di rails a postgresql con l'indirizzo **localhost** e la porta **5432**.

> apriamo il file `postgresql.conf` nella directory `/etc/postgresql/<<version>>/main/`

```bash
$ sudo vim /etc/postgresql/16/main/postgresql.conf
```

> ATTENZIONE alla parte centrale del percorso che cambia a seconda della versione di postgresql che abbiamo installato. Nel nostro caso è la versione 16 ed il percorso ha `.../16/...`.

Per fare delle modifiche con VIM:

- muoversi con le frecce sulla tastiera. 
- premere [i] per entrare in modalità modifica. 
- premere [canc] per cancellare.
- premere [ESC] per uscire dalla modalità modifica.
- Quando si è fuori dalla modalità modifica digitare " :w " e premere [ENTER] per salvare.
- Quando si è fuori dalla modalità modifica digitare " :q " e premere [ENTER] per uscire.
- Quando si è fuori dalla modalità modifica digitare " :wq " e premere [ENTER] per salvare ed uscire.


*** Codice 01 - /etc/postgresql/16/main/postgresql.conf - linea: 54 ***

```shell
#------------------------------------------------------------------------------
# CONNECTIONS AND AUTHENTICATION
#------------------------------------------------------------------------------

# - Connection Settings -

#listen_addresses = 'localhost'		# what IP address(es) to listen on;
					# comma-separated list of addresses;
					# defaults to 'localhost'; use '*' for all
					# (change requires restart)
port = 5432				# (change requires restart)
```

Assicuriamoci che `listen_addresses = 'localhost'` e `port = 5432` siano decommentate.

*** Codice 02 - /etc/postgresql/16/main/postgresql.conf - linea: 60 ***

```shell
listen_addresses = 'localhost'		# what IP address(es) to listen on;
					# comma-separated list of addresses;
					# defaults to 'localhost'; use '*' for all
					# (change requires restart)
port = 5432				# (change requires restart)
```




## Aggiorniamo il file *pg_hba.conf* per l'autenticazione

Nel seguente file di configurazione impostiamo la connessione locale IPv4 sull'indirizzo di *localhost* (127.0.0.1) e l'id dell'utente registrato nel sistema operativo.

Per verificarlo usiamo il comando ***whoami***. 

```bash
$ whoami
```

Esempio:

```bash
ubuntu@ubuntufla:~$ whoami
ubuntu
ubuntu@ubuntufla:~$ 
```

> Attenzione: <br/>
> L'id utente **non è necessariamente** quello che vediamo nel prompt dei comandi. <br/>
> Nel nostro caso è lo stesso ma non è sempre così.

Aggiorniamo quindi il file di configurazione

```bash
$ sudo vim /etc/postgresql/16/main/pg_hba.conf
```

Troviamo la parte:

```bash
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

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/05_fig02-postgresql_conf-default-addresses_and_port.png)

e modifichiamo le seguenti due righe:

```bash
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ubuntu          127.0.0.1/0             trust
```

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/05_fig03-postgresql_conf-updated-addresses_and_port.png)



## Riavviamo il servizio postgreSQL

Facciamo partire/ripartire il server postgres

```bash
$ sudo service postgresql start
```

or

```bash
$ sudo service postgresql restart
```



## Agiorniamo gli utenti di postgreSQL
Cambiamo la password per l'utente di default di postgreSQL ed aggiungiamo l'utente *ubuntu*.

- Logghiamoci su PostgreSQL come utente **postgres** che è l'utente di default, e gli cambiamo la password. 
- Inoltre aggiungiamo l'utente **ubuntu**.

```bash
$ sudo su - postgres
-> psql -U postgres
--> ALTER USER postgres WITH PASSWORD 'myPassword123';
--> CREATE USER "ubuntu" SUPERUSER;
--> ALTER USER "ubuntu" WITH PASSWORD 'myPassword456';
--> \q
-> exit
```

Esempio:

```bash
ubuntu@ubuntufla:~$ sudo su - postgres
postgres@ubuntufla:~$ psql -U postgres
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1))
Type "help" for help.

postgres=# ALTER USER postgres WITH PASSWORD 'myPassword123';
ALTER ROLE
postgres=# CREATE USER "ubuntu" SUPERUSER;
CREATE ROLE
postgres=# ALTER USER "ubuntu" WITH PASSWORD 'myPassword456';
ALTER ROLE
postgres=# \q
postgres@ubuntufla:~$ exit
logout
ubuntu@ubuntufla:~$ 
```

Adesso è tutto inizializzato e pronto per lavorare.



## Future connessioni al database

Se in futuro volessimo lavorare da linea di comando direttamente sul database PostgreSQL potremmo effettuare Login con:

```bash
$ psql postgres
```

Una volta entrati potremmo creare il nostro proprio database e lavorare sulle tabelle.

Ma per quanto riguarda il nostro tutorial abbiamo già tutto quello che ci serve per continuare.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/04_00-install_rails.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/06_00-new_app.md)
