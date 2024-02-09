# <a name="top"></a> Cap postgresql.5 - Upgrade Postgres

Facciamo un upgrade di postgresql sulla nostra versione ubuntu multipass.

I passi che seguiremo sono:
- installiamo una nuova versione di posgres in parallelo all'esistente
- spostiamo la gestione dei database dal *cluster* attuale al *cluster* della nuova versione
- eliminiamo il vecchio *cluster* e la vecchia versione di postgres



## Risorse Esterne

- [Postgresql: Upgrade on ubuntu](https://www.postgresql.org/download/linux/ubuntu/)
- [Upgrading PostgreSQL Version on Ubuntu Server](https://gorails.com/guides/upgrading-postgresql-version-on-ubuntu-server)
- [Upgrade PostgreSQL Version without uninstall Existing PostgreSQL in Ubuntu](https://medium.com/yavar/upgrade-postgresql-version-in-ubuntu-20-04-dfdce9193bc)
- [Upgrade PostgreSQL from 13 to 14 on Ubuntu 22.04](https://www.paulox.net/2022/04/28/upgrading-postgresql-from-version-13-to-14-on-ubuntu-22-04-jammy-jellyfish/)



## Entriamo nella macchina virtuale ubuntu multipass

Entriamo nella nostra macchina virtuale multipass che abbiamo chiamato "ubuntufla".

```bash
$ multipass list
$ multipass start ubuntufla
$ multipass shell ubuntufla
```

> Postgresql lavora per tutta la macchina quindi non serve entrare nella sotto directory del progetto rails.



## Cambiamo repository per installare ultima versione

Se non è già stato fatto in fase di installazione dobbiamo cambiare il repository dei pacchetti `apt` da quella di default di ubuntu a quella di postgresql altrimenti non avremo l'ultima versione.

Nelle versioni di Ubuntu (20.4 e 22.4) la versione di Postgres rilasciata è la 12.
Facendo `sudo apt-get upgrade` aggiorniamo le minor release che risolvono i bugs.

Se vogliamo passare all'ultima versione di Postgres, che ad oggi 20-04-2023 è la versione 15, dobbiamo spostare il repository su quello di postgres.

- vedi [Postgresql: Upgrade on ubuntu](https://www.postgresql.org/download/linux/ubuntu/)

In pratica dobbiamo eseguire questi passaggi.

```bash
$ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get -y install postgresql
```



## Aggiorniamo la libreria del gestore dei pacchetti `apt-get`

Aggiorniamo la libreria apt-get

```bash
$ sudo apt-get upgrade
```

> Io per aggiornare il sistema operativo aggiorno prima la libreria `apt` che è una libreria più nuova con meno sotto opzioni ma con più controlli nella fase di installazione pacchetti.
> in pratica eseguo il comando `$ sudo apt upgrade` ma nei tutorial su internet preferiscono `apt-get`.



## Verifichiamo la versione attuale di Postgres e del *cluster* usato

Vediamo la versione di Posgres.

```bash
$ dpkg -l | grep 
$ dpkg --get-selections | grep postgres
```

Esempio:

```bash
ubuntu@ubuntufla:~ $dpkg -l | grep postgresql
ii  postgresql                        12+214ubuntu0.1                   all          object-relational SQL database (supported version)
ii  postgresql-12                     12.14-0ubuntu0.20.04.1            amd64        object-relational SQL database, version 12 server
ii  postgresql-client-12              12.14-0ubuntu0.20.04.1            amd64        front-end programs for PostgreSQL 12
ii  postgresql-client-common          214ubuntu0.1                      all          manager for multiple PostgreSQL client versions
ii  postgresql-common                 214ubuntu0.1                      all          PostgreSQL database-cluster manager
ii  postgresql-contrib                12+214ubuntu0.1                   all          additional facilities for PostgreSQL (supported version)
ubuntu@ubuntufla:~ $
ubuntu@ubuntufla:~ $dpkg --get-selections | grep postgres
postgresql					install
postgresql-12					install
postgresql-client-12				install
postgresql-client-common			install
postgresql-common				install
postgresql-contrib				install
ubuntu@ubuntufla:~ $
```

Ed anche la versione del *cluster* attivo.

```bash
$ pg_lsclusters
```

Esempio:

```bash
ubuntu@ubuntufla:~ $pg_lsclusters
Ver Cluster Port Status Owner    Data directory              Log file
12  main    5432 online postgres /var/lib/postgresql/12/main /var/log/postgresql/postgresql-12-main.log
ubuntu@ubuntufla:~ $
```



## Installiamo nuova versione di Postgres

Fermiamo Postgres prima di fare dei cambi

```bash
$ sudo service postgresql stop
```




> "pristine" vuol dire "incontaminato" e si riferisce al fatto che è veramente nuovo; che ancora non è stato neanche toccato.






At a high level, here are the steps to migrate your database to a newer version:

```ruby
PGPASSWORD={PASSWORD} pg_dump -h oregon-postgres.render.com -U {DATABASE_USER} {DATABASE_NAME} \
   -n public --no-owner > database_dump.sql
```

You can then restore this data to your new database:

```ruby
PGPASSWORD={PASSWORD} psql -h oregon-postgres.render.com -U {DATABASE_USER} {DATABASE_NAME} < database_dump.sql
```

If you have multiple databases in your PostgreSQL instance, repeat the steps above for each database you wish to backup and restore. Alternatively, you can use pg_dumpall to automatically backup all databases in your instance.

Refer to [Backups](https://render.com/docs/databases#backups) for more details regarding backup and restore.

If certain statements fail to execute due to a version incompatibility, you may need to manually modify your database dump to resolve these issues.

