# Installiamo PostgreSQL

Risorse interne:

* 01-base/01-new_app/04-install_postgresql
* 01-base/01-new_app/04b-install_postgresql_on_ec2_amazon


Risorse web:

* [How to Install PostgreSQL on Ubuntu 18.04](https://linuxize.com/post/how-to-install-postgresql-on-ubuntu-18-04/)
* [How To Install and Use PostgreSQL on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04)



## Installiamo il Postgres di default su piattaforma Ubuntu

Questa è una versione testata ma più **vecchia**.
Nelle versioni di Ubuntu (20.4 e 22.4) la versione di Postgres rilasciata è la `12` invece l'ultima versione disponibile oggi 20-04-2023 è la `15`.


> ATTENZIONE! </br>
> SALTA AL PROSSIMO PARAGRAFO PER INSTALLARE L'ULTIMA VERSIONE!


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



## Installiamo l'ultima versione di Postgres

Se vogliamo passare all'ultima versione di Postgres, che ad oggi 20-04-2023 è la versione 15, dobbiamo spostare il repository di apt dal default di ubuntu a quello di postgres.

- vedi [Postgresql: Upgrade on ubuntu](https://www.postgresql.org/download/linux/ubuntu/)

In pratica dobbiamo eseguire questi passaggi.

```bash
$ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get -y install postgresql
```


Poi uscire e riavviare la macchina.

> prima di dare `shell` assicurarsi che la macchina sia "running" con `list`

```bash
$ exit
$ multipass stop ub22fla
$ multipass start ub22fla
$ multipass list
$ multipass shell ub22fla
```

Esempio:

```bash
ubuntu@primary:~$ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
ubuntu@primary:~$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
OK
ubuntu@primary:~$ sudo apt-get update
Hit:1 http://archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://apt.postgresql.org/pub/repos/apt jammy-pgdg InRelease [116 kB]                      
Hit:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease                                   
Hit:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease               
Hit:5 http://security.ubuntu.com/ubuntu jammy-security InRelease               
Get:6 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 Packages [258 kB]
Fetched 374 kB in 1s (288 kB/s)   
Reading package lists... Done
W: http://apt.postgresql.org/pub/repos/apt/dists/jammy-pgdg/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
ubuntu@primary:~$ sudo apt-get -y install postgresql
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libcommon-sense-perl libjson-perl libjson-xs-perl libllvm14 libpq5 libsensors-config libsensors5 libtypes-serialiser-perl postgresql-15 postgresql-client-15
  postgresql-client-common postgresql-common ssl-cert sysstat
Suggested packages:
  lm-sensors postgresql-doc postgresql-doc-15 isag
The following NEW packages will be installed:
  libcommon-sense-perl libjson-perl libjson-xs-perl libllvm14 libpq5 libsensors-config libsensors5 libtypes-serialiser-perl postgresql postgresql-15
  postgresql-client-15 postgresql-client-common postgresql-common ssl-cert sysstat
0 upgraded, 15 newly installed, 0 to remove and 3 not upgraded.
Need to get 43.9 MB of archives.
After this operation, 175 MB of additional disk space will be used.
Get:1 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 postgresql-client-common all 248.pgdg22.04+1 [92.7 kB]
Get:2 http://archive.ubuntu.com/ubuntu jammy/main amd64 libjson-perl all 4.04000-1 [81.8 kB]    
Get:3 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 postgresql-common all 248.pgdg22.04+1 [237 kB]
Get:4 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 libpq5 amd64 15.2-1.pgdg22.04+1 [183 kB]
Get:5 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 postgresql-client-15 amd64 15.2-1.pgdg22.04+1 [1680 kB]
Get:6 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 postgresql-15 amd64 15.2-1.pgdg22.04+1 [16.9 MB]
Get:7 http://archive.ubuntu.com/ubuntu jammy/main amd64 ssl-cert all 1.1.2 [17.4 kB]
Get:8 http://archive.ubuntu.com/ubuntu jammy/main amd64 libcommon-sense-perl amd64 3.75-2build1 [21.1 kB]
Get:9 http://archive.ubuntu.com/ubuntu jammy/main amd64 libtypes-serialiser-perl all 1.01-1 [11.6 kB]
Get:10 http://archive.ubuntu.com/ubuntu jammy/main amd64 libjson-xs-perl amd64 4.030-1build3 [87.2 kB]
Get:11 http://archive.ubuntu.com/ubuntu jammy/main amd64 libllvm14 amd64 1:14.0.0-1ubuntu1 [24.0 MB]
Get:12 http://apt.postgresql.org/pub/repos/apt jammy-pgdg/main amd64 postgresql all 15+248.pgdg22.04+1 [67.7 kB]
Get:13 http://archive.ubuntu.com/ubuntu jammy/main amd64 libsensors-config all 1:3.6.0-7ubuntu1 [5274 B]
Get:14 http://archive.ubuntu.com/ubuntu jammy/main amd64 libsensors5 amd64 1:3.6.0-7ubuntu1 [26.3 kB]
Get:15 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 sysstat amd64 12.5.2-2ubuntu0.1 [487 kB]
Fetched 43.9 MB in 3s (17.5 MB/s)
Preconfiguring packages ...
Selecting previously unselected package libjson-perl.
(Reading database ... 93790 files and directories currently installed.)
Preparing to unpack .../00-libjson-perl_4.04000-1_all.deb ...
Unpacking libjson-perl (4.04000-1) ...
Selecting previously unselected package postgresql-client-common.
Preparing to unpack .../01-postgresql-client-common_248.pgdg22.04+1_all.deb ...
Unpacking postgresql-client-common (248.pgdg22.04+1) ...
Selecting previously unselected package ssl-cert.
Preparing to unpack .../02-ssl-cert_1.1.2_all.deb ...
Unpacking ssl-cert (1.1.2) ...
Selecting previously unselected package postgresql-common.
Preparing to unpack .../03-postgresql-common_248.pgdg22.04+1_all.deb ...
Adding 'diversion of /usr/bin/pg_config to /usr/bin/pg_config.libpq-dev by postgresql-common'
Unpacking postgresql-common (248.pgdg22.04+1) ...
Selecting previously unselected package libcommon-sense-perl:amd64.
Preparing to unpack .../04-libcommon-sense-perl_3.75-2build1_amd64.deb ...
Unpacking libcommon-sense-perl:amd64 (3.75-2build1) ...
Selecting previously unselected package libtypes-serialiser-perl.
Preparing to unpack .../05-libtypes-serialiser-perl_1.01-1_all.deb ...
Unpacking libtypes-serialiser-perl (1.01-1) ...
Selecting previously unselected package libjson-xs-perl.
Preparing to unpack .../06-libjson-xs-perl_4.030-1build3_amd64.deb ...
Unpacking libjson-xs-perl (4.030-1build3) ...
Selecting previously unselected package libllvm14:amd64.
Preparing to unpack .../07-libllvm14_1%3a14.0.0-1ubuntu1_amd64.deb ...
Unpacking libllvm14:amd64 (1:14.0.0-1ubuntu1) ...
Selecting previously unselected package libpq5:amd64.
Preparing to unpack .../08-libpq5_15.2-1.pgdg22.04+1_amd64.deb ...
Unpacking libpq5:amd64 (15.2-1.pgdg22.04+1) ...
Selecting previously unselected package libsensors-config.
Preparing to unpack .../09-libsensors-config_1%3a3.6.0-7ubuntu1_all.deb ...
Unpacking libsensors-config (1:3.6.0-7ubuntu1) ...
Selecting previously unselected package libsensors5:amd64.
Preparing to unpack .../10-libsensors5_1%3a3.6.0-7ubuntu1_amd64.deb ...
Unpacking libsensors5:amd64 (1:3.6.0-7ubuntu1) ...
Selecting previously unselected package postgresql-client-15.
Preparing to unpack .../11-postgresql-client-15_15.2-1.pgdg22.04+1_amd64.deb ...
Unpacking postgresql-client-15 (15.2-1.pgdg22.04+1) ...
Selecting previously unselected package postgresql-15.
Preparing to unpack .../12-postgresql-15_15.2-1.pgdg22.04+1_amd64.deb ...
Unpacking postgresql-15 (15.2-1.pgdg22.04+1) ...
Selecting previously unselected package postgresql.
Preparing to unpack .../13-postgresql_15+248.pgdg22.04+1_all.deb ...
Unpacking postgresql (15+248.pgdg22.04+1) ...
Selecting previously unselected package sysstat.
Preparing to unpack .../14-sysstat_12.5.2-2ubuntu0.1_amd64.deb ...
Unpacking sysstat (12.5.2-2ubuntu0.1) ...
Setting up postgresql-client-common (248.pgdg22.04+1) ...
Setting up libsensors-config (1:3.6.0-7ubuntu1) ...
Setting up libpq5:amd64 (15.2-1.pgdg22.04+1) ...
Setting up libcommon-sense-perl:amd64 (3.75-2build1) ...
Setting up postgresql-client-15 (15.2-1.pgdg22.04+1) ...
update-alternatives: using /usr/share/postgresql/15/man/man1/psql.1.gz to provide /usr/share/man/man1/psql.1.gz (psql.1.gz) in auto mode
Setting up ssl-cert (1.1.2) ...
Setting up libsensors5:amd64 (1:3.6.0-7ubuntu1) ...
Setting up libllvm14:amd64 (1:14.0.0-1ubuntu1) ...
Setting up libtypes-serialiser-perl (1.01-1) ...
Setting up libjson-perl (4.04000-1) ...
Setting up sysstat (12.5.2-2ubuntu0.1) ...

Creating config file /etc/default/sysstat with new version
update-alternatives: using /usr/bin/sar.sysstat to provide /usr/bin/sar (sar) in auto mode
Created symlink /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer → /lib/systemd/system/sysstat-collect.timer.
Created symlink /etc/systemd/system/sysstat.service.wants/sysstat-summary.timer → /lib/systemd/system/sysstat-summary.timer.
Created symlink /etc/systemd/system/multi-user.target.wants/sysstat.service → /lib/systemd/system/sysstat.service.
Setting up libjson-xs-perl (4.030-1build3) ...
Setting up postgresql-common (248.pgdg22.04+1) ...
Adding user postgres to group ssl-cert

Creating config file /etc/postgresql-common/createcluster.conf with new version
Building PostgreSQL dictionaries from installed myspell/hunspell packages...
Removing obsolete dictionary files:
'/etc/apt/trusted.gpg.d/apt.postgresql.org.gpg' -> '/usr/share/postgresql-common/pgdg/apt.postgresql.org.gpg'
Created symlink /etc/systemd/system/multi-user.target.wants/postgresql.service → /lib/systemd/system/postgresql.service.
Setting up postgresql-15 (15.2-1.pgdg22.04+1) ...
Creating new PostgreSQL cluster 15/main ...
/usr/lib/postgresql/15/bin/initdb -D /var/lib/postgresql/15/main --auth-local peer --auth-host scram-sha-256 --no-instructions
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "C.UTF-8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/15/main ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... Europe/Rome
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok
update-alternatives: using /usr/share/postgresql/15/man/man1/postmaster.1.gz to provide /usr/share/man/man1/postmaster.1.gz (postmaster.1.gz) in auto mode
Setting up postgresql (15+248.pgdg22.04+1) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.1) ...
Scanning processes...                                                                                                                                                   
Scanning linux images...                                                                                                                                                

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
ubuntu@primary:~$ 
```



## Vediamo la versione


```bash
$ psql -V
$ psql --version
```

Esempio:


```bash
ubuntu@primary:~$ psql -V
psql (PostgreSQL) 15.2 (Ubuntu 15.2-1.pgdg22.04+1)
ubuntu@primary:~$ 
```



[vedi anche 05_00-upgrade_postgresql-it.md]

