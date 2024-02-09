# <a name="top"></a> Cap postgresql.1 - Installiamo PostgreSQL

Installiamo PostgreSQL
Di default Rails ha attivo il database sqlite3 ma noi sin da subito nella nostra nuova applicazione useremo PostgreSQL, quindi è bene installarlo.

> Usiamo PostgreSQL perché è lo stesso database che usa Render ( e Heroku).
> La piattaforma che usiamo per mettere in produzione le nostre app fatte in Ruby on Rails.



## Risorse interne

- 01-base/01-new_app/04-install_postgresql
- 01-base/01-new_app/04b-install_postgresql_on_ec2_amazon
- [99-rails_references/postgresql/01-install]()



## Risorse esterne

- [Heroku - getting-started-with-rails7](https://devcenter.heroku.com/articles/getting-started-with-rails7)
- [How to Install PostgreSQL on Ubuntu 18.04](https://linuxize.com/post/how-to-install-postgresql-on-ubuntu-18-04/)
- [How To Install and Use PostgreSQL on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04)



## Verifichiamo che postgreSQL non è installato

Proviamo ad avviare postgres server da terminale.

```shell
$ sudo service postgresql start
```

Esempio:

```shell
ubuntu@ub22fla:~$ sudo service postgresql start
Failed to start postgresql.service: Unit postgresql.service not found.
```



## Installiamo l'ultima versione di Postgres

Usando il repository di default di ubuntu andremo ad installare una versione più vecchia di postgresql.

> Nelle versioni di Ubuntu (20.4 e 22.4) la versione di Postgres rilasciata è la `12` invece l'ultima versione disponibile oggi 02-02-2024 è la `16`.

Se vogliamo passare all'ultima versione di Postgres, che ad oggi 20-04-2023 è la versione 15, dobbiamo spostare il repository di apt dal default di ubuntu a quello di postgres.

- vedi [Postgresql: Upgrade on ubuntu](https://www.postgresql.org/download/linux/ubuntu/)

In pratica dobbiamo eseguire questi passaggi.

```shell
$ sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get -y install postgresql
```

Poi uscire e riavviare la macchina.

> prima di dare `shell` assicurarsi che la macchina sia "running" con `list`

```shell
$ exit
❯ multipass stop ub22fla
❯ multipass start ub22fla
❯ multipass list
❯ multipass shell ub22fla
```



## Vediamo la versione

```bash
$ psql -V
$ psql --version
```

Esempio:

```bash
ubuntu@ub22fla:~$ psql --version
psql (PostgreSQL) 16.1 (Ubuntu 16.1-1.pgdg22.04+1)
```



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT
$ df -hT /dev/sda1
```

Esempio:

```shell
ubuntu@ub22fla:~$ df -hT
Filesystem     Type   Size  Used Avail Use% Mounted on
tmpfs          tmpfs  392M  1.1M  391M   1% /run
/dev/sda1      ext4    20G  3.3G   16G  17% /
tmpfs          tmpfs  2.0G  1.1M  2.0G   1% /dev/shm
tmpfs          tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/sda15     vfat    98M  6.3M   92M   7% /boot/efi
tmpfs          tmpfs  392M  4.0K  392M   1% /run/user/1000
ubuntu@ub22fla:~$ df -hT /dev/sda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/sda1      ext4   20G  3.3G   16G  17% /
```

> Abbiamo ancora **16GB** disponibili.



## Verifichiamo se è attivo

The PostgreSQL service is controlled by the Systemctl utility. The following commands are executed with sudo privileges.

```shell
$ sudo systemctl status postgresql
```

Esempio:

```shell
ubuntu@ub22fla:~$ systemctl status postgresql
● postgresql.service - PostgreSQL RDBMS
     Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled)
     Active: active (exited) since Thu 2024-02-01 17:17:13 CET; 14min ago
    Process: 786 ExecStart=/bin/true (code=exited, status=0/SUCCESS)
   Main PID: 786 (code=exited, status=0/SUCCESS)
        CPU: 1ms

Feb 01 17:17:13 ub22fla systemd[1]: Starting PostgreSQL RDBMS...
Feb 01 17:17:13 ub22fla systemd[1]: Finished PostgreSQL RDBMS.
```


Altri comandi per gestire il servizio postgresql

```shell
$ sudo systemctl enable postgresql
$ sudo systemctl start postgresql
$ sudo systemctl reload postgresql
$ sudo systemctl stop postgresql
```
