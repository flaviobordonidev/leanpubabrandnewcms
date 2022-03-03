# <a name="top"></a> Cap 1.5 - Installiamo PostgreSQL

Di default Rails ha attivo il database sqlite3 ma noi sin da subito nella nostra nuova applicazione useremo PostgreSQL, quindi è bene installarlo.

> Usiamo PostgreSQL perché è lo stesso database che usa Heroku; e noi useremo Heroku per mettere la nostra app in produzione.



## Risorse interne:

- [99-rails_references/postgresql/01-install]



## Risorse esterne

- - [Heroku - getting-started-with-rails7](https://devcenter.heroku.com/articles/getting-started-with-rails7)



## Verifichiamo che postgreSQL non è installato

Proviamo ad avviare postgres server da terminale.

```bash
$ sudo service postgresql start
```

Esempio:

```bash
ubuntu@ubuntufla:~$ sudo service postgresql start
Failed to start postgresql.service: Unit postgresql.service not found.
ubuntu@ubuntufla:~$ 
```



## Installiamo PostgreSQL

Poiché la nostra VM ha *OS Ubuntu* usiamo il suo packet manager *apt* per installare PostgreSQL.

```bash
$ sudo apt update
$ sudo apt install postgresql postgresql-contrib libpq-dev
-> y
```

Esempio:

```bash
ubuntu@ubuntufla:~$ sudo apt update
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Get:2 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]  
Get:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Hit:5 https://deb.nodesource.com/node_16.x focal InRelease               
Get:6 http://security.ubuntu.com/ubuntu focal-security/main Translation-en [224 kB]
Get:7 http://security.ubuntu.com/ubuntu focal-security/main amd64 c-n-f Metadata [9740 B]
Get:8 http://security.ubuntu.com/ubuntu focal-security/universe amd64 c-n-f Metadata [13.2 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1608 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 c-n-f Metadata [14.8 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [905 kB]
Fetched 3111 kB in 2s (1540 kB/s)                        
Reading package lists... Done
Building dependency tree       
Reading state information... Done
All packages are up to date.
ubuntu@ubuntufla:~$ sudo apt install postgresql postgresql-contrib libpq-dev
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libllvm10 libpq5 libsensors-config libsensors5 postgresql-12 postgresql-client-12 postgresql-client-common postgresql-common ssl-cert
  sysstat
Suggested packages:
  postgresql-doc-12 lm-sensors postgresql-doc libjson-perl openssl-blacklist isag
The following NEW packages will be installed:
  libllvm10 libpq-dev libpq5 libsensors-config libsensors5 postgresql postgresql-12 postgresql-client-12 postgresql-client-common
  postgresql-common postgresql-contrib ssl-cert sysstat
0 upgraded, 13 newly installed, 0 to remove and 0 not upgraded.
Need to get 30.8 MB of archives.
After this operation, 122 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libllvm10 amd64 1:10.0.0-4ubuntu1 [15.3 MB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpq5 amd64 12.9-0ubuntu0.20.04.1 [117 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libpq-dev amd64 12.9-0ubuntu0.20.04.1 [136 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 libsensors-config all 1:3.6.0-2ubuntu1 [6092 B]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libsensors5 amd64 1:3.6.0-2ubuntu1 [27.4 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 postgresql-client-common all 214ubuntu0.1 [28.2 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 postgresql-client-12 amd64 12.9-0ubuntu0.20.04.1 [1047 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal/main amd64 ssl-cert all 1.0.39 [17.0 kB]
Get:9 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 postgresql-common all 214ubuntu0.1 [169 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 postgresql-12 amd64 12.9-0ubuntu0.20.04.1 [13.5 MB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 postgresql all 12+214ubuntu0.1 [3924 B]
Get:12 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 postgresql-contrib all 12+214ubuntu0.1 [3932 B]
Get:13 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 sysstat amd64 12.2.0-2ubuntu0.1 [448 kB]
Fetched 30.8 MB in 2s (13.6 MB/s)
Preconfiguring packages ...
Selecting previously unselected package libllvm10:amd64.
(Reading database ... 103883 files and directories currently installed.)
Preparing to unpack .../00-libllvm10_1%3a10.0.0-4ubuntu1_amd64.deb ...
Unpacking libllvm10:amd64 (1:10.0.0-4ubuntu1) ...
Selecting previously unselected package libpq5:amd64.
Preparing to unpack .../01-libpq5_12.9-0ubuntu0.20.04.1_amd64.deb ...
Unpacking libpq5:amd64 (12.9-0ubuntu0.20.04.1) ...
Selecting previously unselected package libpq-dev.
Preparing to unpack .../02-libpq-dev_12.9-0ubuntu0.20.04.1_amd64.deb ...
Unpacking libpq-dev (12.9-0ubuntu0.20.04.1) ...
Selecting previously unselected package libsensors-config.
Preparing to unpack .../03-libsensors-config_1%3a3.6.0-2ubuntu1_all.deb ...
Unpacking libsensors-config (1:3.6.0-2ubuntu1) ...
Selecting previously unselected package libsensors5:amd64.
Preparing to unpack .../04-libsensors5_1%3a3.6.0-2ubuntu1_amd64.deb ...
Unpacking libsensors5:amd64 (1:3.6.0-2ubuntu1) ...
Selecting previously unselected package postgresql-client-common.
Preparing to unpack .../05-postgresql-client-common_214ubuntu0.1_all.deb ...
Unpacking postgresql-client-common (214ubuntu0.1) ...
Selecting previously unselected package postgresql-client-12.
Preparing to unpack .../06-postgresql-client-12_12.9-0ubuntu0.20.04.1_amd64.deb ...
Unpacking postgresql-client-12 (12.9-0ubuntu0.20.04.1) ...
Selecting previously unselected package ssl-cert.
Preparing to unpack .../07-ssl-cert_1.0.39_all.deb ...
Unpacking ssl-cert (1.0.39) ...
Selecting previously unselected package postgresql-common.
Preparing to unpack .../08-postgresql-common_214ubuntu0.1_all.deb ...
Adding 'diversion of /usr/bin/pg_config to /usr/bin/pg_config.libpq-dev by postgresql-common'
Unpacking postgresql-common (214ubuntu0.1) ...
Selecting previously unselected package postgresql-12.
Preparing to unpack .../09-postgresql-12_12.9-0ubuntu0.20.04.1_amd64.deb ...
Unpacking postgresql-12 (12.9-0ubuntu0.20.04.1) ...
Selecting previously unselected package postgresql.
Preparing to unpack .../10-postgresql_12+214ubuntu0.1_all.deb ...
Unpacking postgresql (12+214ubuntu0.1) ...
Selecting previously unselected package postgresql-contrib.
Preparing to unpack .../11-postgresql-contrib_12+214ubuntu0.1_all.deb ...
Unpacking postgresql-contrib (12+214ubuntu0.1) ...
Selecting previously unselected package sysstat.
Preparing to unpack .../12-sysstat_12.2.0-2ubuntu0.1_amd64.deb ...
Unpacking sysstat (12.2.0-2ubuntu0.1) ...
Setting up postgresql-client-common (214ubuntu0.1) ...
Setting up libsensors-config (1:3.6.0-2ubuntu1) ...
Setting up libpq5:amd64 (12.9-0ubuntu0.20.04.1) ...
Setting up libpq-dev (12.9-0ubuntu0.20.04.1) ...
Setting up libllvm10:amd64 (1:10.0.0-4ubuntu1) ...
Setting up postgresql-client-12 (12.9-0ubuntu0.20.04.1) ...
update-alternatives: using /usr/share/postgresql/12/man/man1/psql.1.gz to provide /usr/share/man/man1/psql.1.gz (psql.1.gz) in auto mode
Setting up ssl-cert (1.0.39) ...
Setting up postgresql-common (214ubuntu0.1) ...
Adding user postgres to group ssl-cert

Creating config file /etc/postgresql-common/createcluster.conf with new version
Building PostgreSQL dictionaries from installed myspell/hunspell packages...
Removing obsolete dictionary files:
Created symlink /etc/systemd/system/multi-user.target.wants/postgresql.service → /lib/systemd/system/postgresql.service.
Setting up libsensors5:amd64 (1:3.6.0-2ubuntu1) ...
Setting up postgresql-12 (12.9-0ubuntu0.20.04.1) ...
Creating new PostgreSQL cluster 12/main ...
/usr/lib/postgresql/12/bin/initdb -D /var/lib/postgresql/12/main --auth-local peer --auth-host md5
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "C.UTF-8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/12/main ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... Europe/Rome
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

Success. You can now start the database server using:

    pg_ctlcluster 12 main start

Ver Cluster Port Status Owner    Data directory              Log file
12  main    5432 down   postgres /var/lib/postgresql/12/main /var/log/postgresql/postgresql-12-main.log
update-alternatives: using /usr/share/postgresql/12/man/man1/postmaster.1.gz to provide /usr/share/man/man1/postmaster.1.gz (postmaster.1.gz) in auto mode
Setting up sysstat (12.2.0-2ubuntu0.1) ...

Creating config file /etc/default/sysstat with new version
update-alternatives: using /usr/bin/sar.sysstat to provide /usr/bin/sar (sar) in auto mode
Created symlink /etc/systemd/system/multi-user.target.wants/sysstat.service → /lib/systemd/system/sysstat.service.
Setting up postgresql-contrib (12+214ubuntu0.1) ...
Setting up postgresql (12+214ubuntu0.1) ...
Processing triggers for systemd (245.4-4ubuntu3.15) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.7) ...
ubuntu@ubuntufla:~$ 
```



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT /dev/vda1
```

Esempio:

```bash
ubuntu@ubuntufla:~$ df -hT
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  2.0G     0  2.0G   0% /dev
tmpfs          tmpfs     394M  880K  393M   1% /run
/dev/vda1      ext4       20G  3.5G   16G  18% /
tmpfs          tmpfs     2.0G   16K  2.0G   1% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     2.0G     0  2.0G   0% /sys/fs/cgroup
/dev/loop0     squashfs   62M   62M     0 100% /snap/core20/1328
/dev/loop1     squashfs   44M   44M     0 100% /snap/snapd/14978
/dev/loop2     squashfs   62M   62M     0 100% /snap/core20/1361
/dev/vda15     vfat      105M  5.2M  100M   5% /boot/efi
/dev/loop3     squashfs   68M   68M     0 100% /snap/lxd/21835
/dev/loop4     squashfs   68M   68M     0 100% /snap/lxd/22526
tmpfs          tmpfs     394M     0  394M   0% /run/user/1000
ubuntu@ubuntufla:~$ df -hT /dev/vda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/vda1      ext4   20G  3.5G   16G  18% /
ubuntu@ubuntufla:~$ 
```

Abbiamo ancora **16GB** disponibili.



## Impostiamo il file di configurazione di postgreSQL per collegarsi via localhost:5432

Impostiamo il collegamento di rails a postgresql con l'indirizzo **localhost** e la porta **5432**.

```bash
$ sudo vim /etc/postgresql/12/main/postgresql.conf
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

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/05_fig01-postgresql_conf-uncomment-addresses_and_port.png)




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

Ma in **entrambi** i casi l'*id* dell'utente registrato è ***ubuntu*** e questo lo verifichiamo il comando ***whoami***. 

```bash
$ whoami
```

Esempio:

```bash
user_fb:~/environment $ whoami
ubuntu
user_fb:~/environment $ 
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

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/05_fig02-postgresql_conf-default-addresses_and_port.png)

e modifichiamo le seguenti due righe:

```bash
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ubuntu          127.0.0.1/0             trust
```

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/05_fig03-postgresql_conf-updated-addresses_and_port.png)




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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/04-aws_c9_more_disk_space.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/06-install_postgresql_on_ec2_amazon.md)
