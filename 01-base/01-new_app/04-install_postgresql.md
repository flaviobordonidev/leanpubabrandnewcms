# <a name="01-01-04"></a> Cap 1.4 -- Installiamo PostgreSQL

> Questa procedura è per ambienti di Cloud9 (istanze EC2) con sistema operativo **Ubuntu**

Il database postgreSQL non è installato di default su AWS Cloud9.

Di default Rails ha attivo il database sqlite3 ma noi sin da subito nella nostra nuova applicazione useremo PostgreSQL, quindi è bene installarlo.

Usiamo PostgreSQL perché è lo stesso database che usa Heroku; e noi useremo Heroku per mettere la nostra app in produzione.




## Risorse interne:

* 99-rails_references/postgresql/01-install




## Verifichiamo che postgreSQL non è installato

Comando per avviare postgres server

```bash
$ sudo service postgresql start
```

Risultato su finestra terminal:

```bash
user_fb:~/environment $ sudo service postgresql start
Failed to start postgresql.service: Unit postgresql.service not found.
user_fb:~/environment $ 
```




## Installiamo PostgreSQL

Siamo su instance EC2 con OS Ubuntu che usa "apt" come packet manager.

```bash
$ sudo apt update
$ sudo apt install postgresql postgresql-contrib libpq-dev
-> y
```

Esecuzione su terminal

```bash
user_fb:~/environment $ sudo apt update
Hit:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic InRelease
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
Get:4 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]                         
Hit:5 https://download.docker.com/linux/ubuntu bionic InRelease                                                 
Fetched 252 kB in 1s (502 kB/s)                                                                                 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
8 packages can be upgraded. Run 'apt list --upgradable' to see them.

user_fb:~/environment $ sudo apt install postgresql postgresql-contrib libpq-dev
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libpq5 libsensors4 postgresql-10 postgresql-client-10 postgresql-client-common postgresql-common sysstat
Suggested packages:
  postgresql-doc-10 lm-sensors postgresql-doc locales-all libjson-perl isag
The following NEW packages will be installed:
  libpq-dev libpq5 libsensors4 postgresql postgresql-10 postgresql-client-10 postgresql-client-common postgresql-common postgresql-contrib sysstat
0 upgraded, 10 newly installed, 0 to remove and 8 not upgraded.
Need to get 5563 kB of archives.
After this operation, 22.1 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 libpq5 amd64 10.19-0ubuntu0.18.04.1 [108 kB]
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 libpq-dev amd64 10.19-0ubuntu0.18.04.1 [219 kB]
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic/main amd64 libsensors4 amd64 1:3.4.0-4 [28.8 kB]
Get:4 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 postgresql-client-common all 190ubuntu0.1 [29.6 kB]
Get:5 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 postgresql-client-10 amd64 10.19-0ubuntu0.18.04.1 [942 kB]
Get:6 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 postgresql-common all 190ubuntu0.1 [157 kB]
Get:7 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 postgresql-10 amd64 10.19-0ubuntu0.18.04.1 [3772 kB]
Get:8 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 postgresql all 10+190ubuntu0.1 [5884 B]
Get:9 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 postgresql-contrib all 10+190ubuntu0.1 [5896 B]
Get:10 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 sysstat amd64 11.6.1-1ubuntu0.1 [295 kB]
Fetched 5563 kB in 0s (33.6 MB/s)
Preconfiguring packages ...
Selecting previously unselected package libpq5:amd64.
(Reading database ... 104693 files and directories currently installed.)
Preparing to unpack .../0-libpq5_10.19-0ubuntu0.18.04.1_amd64.deb ...
Unpacking libpq5:amd64 (10.19-0ubuntu0.18.04.1) ...
Selecting previously unselected package libpq-dev.
Preparing to unpack .../1-libpq-dev_10.19-0ubuntu0.18.04.1_amd64.deb ...
Unpacking libpq-dev (10.19-0ubuntu0.18.04.1) ...
Selecting previously unselected package libsensors4:amd64.
Preparing to unpack .../2-libsensors4_1%3a3.4.0-4_amd64.deb ...
Unpacking libsensors4:amd64 (1:3.4.0-4) ...
Selecting previously unselected package postgresql-client-common.
Preparing to unpack .../3-postgresql-client-common_190ubuntu0.1_all.deb ...
Unpacking postgresql-client-common (190ubuntu0.1) ...
Selecting previously unselected package postgresql-client-10.
Preparing to unpack .../4-postgresql-client-10_10.19-0ubuntu0.18.04.1_amd64.deb ...
Unpacking postgresql-client-10 (10.19-0ubuntu0.18.04.1) ...
Selecting previously unselected package postgresql-common.
Preparing to unpack .../5-postgresql-common_190ubuntu0.1_all.deb ...
Adding 'diversion of /usr/bin/pg_config to /usr/bin/pg_config.libpq-dev by postgresql-common'
Unpacking postgresql-common (190ubuntu0.1) ...
Selecting previously unselected package postgresql-10.
Preparing to unpack .../6-postgresql-10_10.19-0ubuntu0.18.04.1_amd64.deb ...
Unpacking postgresql-10 (10.19-0ubuntu0.18.04.1) ...
Selecting previously unselected package postgresql.
Preparing to unpack .../7-postgresql_10+190ubuntu0.1_all.deb ...
Unpacking postgresql (10+190ubuntu0.1) ...
Selecting previously unselected package postgresql-contrib.
Preparing to unpack .../8-postgresql-contrib_10+190ubuntu0.1_all.deb ...
Unpacking postgresql-contrib (10+190ubuntu0.1) ...
Selecting previously unselected package sysstat.
Preparing to unpack .../9-sysstat_11.6.1-1ubuntu0.1_amd64.deb ...
Unpacking sysstat (11.6.1-1ubuntu0.1) ...
Setting up libpq5:amd64 (10.19-0ubuntu0.18.04.1) ...
Setting up postgresql-client-common (190ubuntu0.1) ...
Setting up postgresql-common (190ubuntu0.1) ...
Adding user postgres to group ssl-cert

Creating config file /etc/postgresql-common/createcluster.conf with new version
Building PostgreSQL dictionaries from installed myspell/hunspell packages...
Removing obsolete dictionary files:
Created symlink /etc/systemd/system/multi-user.target.wants/postgresql.service → /lib/systemd/system/postgresql.service.
Setting up libsensors4:amd64 (1:3.4.0-4) ...
Setting up postgresql-client-10 (10.19-0ubuntu0.18.04.1) ...
update-alternatives: using /usr/share/postgresql/10/man/man1/psql.1.gz to provide /usr/share/man/man1/psql.1.gz (psql.1.gz) in auto mode
Setting up libpq-dev (10.19-0ubuntu0.18.04.1) ...
Setting up sysstat (11.6.1-1ubuntu0.1) ...

Creating config file /etc/default/sysstat with new version
update-alternatives: using /usr/bin/sar.sysstat to provide /usr/bin/sar (sar) in auto mode
Created symlink /etc/systemd/system/multi-user.target.wants/sysstat.service → /lib/systemd/system/sysstat.service.
Setting up postgresql-10 (10.19-0ubuntu0.18.04.1) ...
Creating new PostgreSQL cluster 10/main ...
/usr/lib/postgresql/10/bin/initdb -D /var/lib/postgresql/10/main --auth-local peer --auth-host md5
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "C.UTF-8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/10/main ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default timezone ... Etc/UTC
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

Success. You can now start the database server using:

    /usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main -l logfile start

Ver Cluster Port Status Owner    Data directory              Log file
10  main    5432 down   postgres /var/lib/postgresql/10/main /var/log/postgresql/postgresql-10-main.log
update-alternatives: using /usr/share/postgresql/10/man/man1/postmaster.1.gz to provide /usr/share/man/man1/postmaster.1.gz (postmaster.1.gz) in auto mode
Setting up postgresql (10+190ubuntu0.1) ...
Setting up postgresql-contrib (10+190ubuntu0.1) ...
Processing triggers for systemd (237-3ubuntu10.52) ...
Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
Processing triggers for ureadahead (0.100.0-21) ...
Processing triggers for libc-bin (2.27-3ubuntu1.4) ...
user_fb:~/environment $ 
```



## Impostiamo il file di configurazione di postgreSQL per collegarsi via localhost:5432

Impostiamo il collegamento di rails a postgresql con l'indirizzo **localhost** e la porta **5432**

```bash
$ sudo vim /etc/postgresql/10/main/postgresql.conf
```

Per fare delle modifiche con VIM:

- muoversi con le frecce sulla tastiera. 
- premere [i] per entrare in modalità modifica. 
- premere [canc] per cancellare.
- premere [ESC] per uscire dalla modalità modifica.
- Quando si è fuori dalla modalità modifica digitare " :w " e premere [ENTER] per salvare.
- Quando si è fuori dalla modalità modifica digitare " :q " e premere [ENTER] per uscire.
- Quando si è fuori dalla modalità modifica digitare " :wq " e premere [ENTER] per salvare ed uscire.


Troviamo le due righe:

```bash
#listen_addresses = 'localhost'

#port = 5432
```

e, se sono commentate, le decommentiamo:

```bash
listen_addresses = 'localhost'

port = 5432
```

(la seconda riga potrebbe già essere decommentata)

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig01-postgresql_conf-uncomment-addresses_and_port.png)




## Aggiorniamo il file *pg_hba.conf* per l'autenticazione

Nel seguente file di configurazione impostiamo la connessione locale IPv4 sull'indirizzo di "localhost" (127.0.0.1) e l'id dell'utente registrato nel sistema operativo.

Attenzione:
L'id utente **non è necessariamente** quello che vediamo nel prompt dei comandi.

Se ci logghiamo su AWS come *root* nel prompt del terminal vediamo il nome *ubuntu*: 

```bash
ubuntu:~/environment $
```

Invece se ci logghiamo su AWS come utente IAM *user_fb* nel prompt del terminal vediamo il nome *user_fb*: 

```bash
user_fb:~/environment $
```

Ma in **entrambi** i casi l'*id* dell'utente registrato è ***ubuntu*** e questo lo verifichiamo con il seguente comando: 

{caption: "terminal", format: bash, line-numbers: false}
```bash
$ whoami

user_fb:~/environment $ whoami
ubuntu
```


Aggiorniamo quindi il file di configurazione

```bash
$ sudo vim /etc/postgresql/10/main/pg_hba.conf
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

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig02-postgresql_conf-default-addresses_and_port.png)

e modifichiamo le seguenti due righe:

```bash
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ubuntu          127.0.0.1/0             trust
```

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04_fig03-postgresql_conf-updated-addresses_and_port.png)




## Riavviamo il servizio postgreSQL

Start / Restart postgres server

```bash
$ sudo service postgresql start
```

or

```bash
$ sudo service postgresql restart
```




## Agiorniamo gli utenti di postgreSQL
Cambiamo la password per l'utente di default di postgreSQL ed aggiungiamo l'utente *ubuntu*
Logghiamoci su PostgreSQL come utente **postgres** che è l'utente di default, e gli cambiamo la password. Inoltre aggiungiamo l'utente **ubuntu**.

```bash
$ sudo su - postgres
-> psql -U postgres
--> ALTER USER postgres WITH PASSWORD 'myPassword123';
--> CREATE USER "ubuntu" SUPERUSER;
--> ALTER USER "ubuntu" WITH PASSWORD 'myPassword456';
--> \q
-> exit


user_fb:~/environment $ sudo su - postgres
postgres@ip-172-31-24-105:~$ psql -U postgres
psql (10.19 (Ubuntu 10.19-0ubuntu0.18.04.1))
Type "help" for help.

postgres=# ALTER USER postgres WITH PASSWORD 'myPassword123';
ALTER ROLE
postgres=# CREATE USER "ubuntu" SUPERUSER;
CREATE ROLE
postgres=# ALTER USER "ubuntu" WITH PASSWORD 'myPassword456';
ALTER ROLE
postgres=# \q
postgres@ip-172-31-24-105:~$ exit
logout
user_fb:~/environment $ 
```

Adesso è tutto inizializzato e pronto per lavorare su aws Cloud9.




## Future connessioni al database

Se in futuro volessimo lavorare da linea di comando direttamente sul database PostgreSQL potremmo effettuare Login con:

```bash
$ psql postgres
```

Una volta entrati potremmo creare il nostro proprio database e lavorare sulle tabelle.

Ma per quanto riguarda il nostro tutorial abbiamo già tutto quello che ci serve per continuare.

---

[<- back  ](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/03-aws_cloud9_new_environment.md)
[  next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/05-install_postgresql_on_ec2_amazon.md)
