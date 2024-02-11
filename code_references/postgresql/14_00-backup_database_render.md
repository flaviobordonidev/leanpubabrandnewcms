# <a name="top"></a> Cap postgresql.4 - Facciamo backup e restore del database remoto

Facciamo un backup del database di produzione `ubuntudream_production` che stiamo ospitando su *render.com*.

> `ubuntudream_production` è un nome di database scelto per fare gli esempi. Può essere qualsiasi nome, anche se per convenzione Rails tende ad essere `nomeapp_production`.

> Automatic and manual backups are unavailable for databases on the Free Tier. You can upgrade to a Starter Plan to enable automatic backups.


## Risorse interne

- [code_references/multipass_ubuntu/03_00-mount_a_directory-it.md]()



## Risorse Esterne

- [Render: PostgreSQL](https://render.com/docs/databases)
- [Render: PostgreSQL Backup]()https://render.com/docs/databases#backups
- [Render: PostgreSQL on Render](https://docs.render.com/databases#backups)
- [postgresql.org: 26.1. SQL Dump](https://www.postgresql.org/docs/current/backup-dump.html)
- [How to share data between host and VM with Multipass](https://www.youtube.com/watch?v=vrLcER1V2Co)



## Standard Backup del databas PostgreSQL di produzione

Da interfaccia web è possibile solo con la versione a pagamento!
A full backup of your database that you can download.

> Automatic and manual backups are unavailable for databases on the Free Tier!

[implementeremo questi passaggi solo dopo essere passati al database a pagamento!]


## Il dump del database

Leggendo nella documentazione (https://render.com/docs/databases#backups)
Su Database Versions & Upgrades c'è il comando "database_dump"

At a high level, here are the steps to migrate your database to a newer version:

1. Create a new database with the desired version.
2. Disable or suspend any applications that write to your existing database. This prevents drift between the data in your database and that in your backup.
3. Take a backup of your existing database.
4. Restore that backup to your new database.
5. Point your applications at the new database and re-enable them.

Depending on how your applications are set up, this operation may require some downtime.



## Prima di fare il dump

Per evitare che gli utenti continuino ad inserire dati nel database conviene mettere in manutenzione il sito e stoppare il database di produzione.

Ma lo riattiviamo appena prima di fare il damp.
**Per poter accedere e fare il dump lo dobbiamo togliere dal Suspend.**

Quindi sbrighiamoci a fare il dump altrimenti gli utenti ricominceranno a collegarsi.

Da render.com --> Dashboard --> <<nome_databse>> --> Suspend Database

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/04_fig01-render_postgres_suspend_1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/04_fig02-render_postgres_suspend_2.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/04_fig03-render_postgres_suspend_3.png)

### Verifichiamo versioni di postgresgl

Inoltre guardiamo la versione di postgresql usata su render.
Nel nostro caso PostgreSQL Version 15

E la versione di PostgreSQL sulla VM multipass.

```bash
$ psql -V
$ psql --version
```

> Attenzione!
> Affinché il dump abbia successo:
> Versione Postgresql su VM multipass ≥ Versione Postgresql su render.com



## Fare il dump

Puoi eseguire un backup dello schema del tuo database e dei dati nelle tue tabelle utilizzando `pg_dump`. Questo comando può essere utilizzato per eseguire il dump del database in un file.

```bash
$ PGPASSWORD={PASSWORD} pg_dump -h {FINGERPRINT}.{STATE}-postgres.render.com -U {DATABASE_USER} {DATABASE_NAME} -n public --no-owner > database_dump.sql
```

> Assicuriamoci di scambiare le variabili del database appropriate, nonché il nome host per i database della regione (nel nostro caso è Francoforte)

Vedi esempi nei prossimi paragrafi.



## Ripristinare il dump

Possiamo quindi ripristinare in un nuovo database i dati che abbiamo messo nel file di *dump*.

```bash
$ PGPASSWORD={PASSWORD} psql -h {FINGERPRINT}.{STATE}-postgres.render.com -U {DATABASE_USER} {DATABASE_NAME} < database_dump.sql
```

Vedi esempi nei prossimi paragrafi.

> If you have multiple databases in your PostgreSQL instance, repeat the steps above for each database you wish to backup and restore. Alternatively, you can use pg_dumpall to automatically backup all databases in your instance.</br>
> Refer to [Backups](https://render.com/docs/databases#backups) for more details regarding backup and restore.</br>
> If certain statements fail to execute due to a version incompatibility, you may need to manually modify your database dump to resolve these issues.



## Esempio di dump del database su `ubuntudream_production`

Prendiamo la stringa usata per collegarsi al database remoto (quello di produzione su render.com) e la adattiamo a quella per fare il dump del database.

render.com -> ubuntudream_production -> Connect -> External Connection -> PSQL Command

> Non dobbiamo collegarci al database. Dobbiamo solo prendere la stringa.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/04_fig04-render_command_for_external_connection.png)

```shell
$ PGPASSWORD=x...0 psql -h d...a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production_arvy
```

Adattiamo la stringa. Al posto di `psql` mettiamo `pg_dump` ed aggiungiamo la stringa `-n public --no-owner > database_dump.sql` per eseguire il comando di dump.

```shell
$ PGPASSWORD=x...0 pg_dump -h d...a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production_arvy -n public --no-owner > database_dump.sql
```

> Questo comando va eseguito nella VM (virtual machine) di multipass che abbia installata la stessa versione, o una maggiore, della versione Postgres che è installata su render.com.</br>
> *Versione Postgresql su VM multipass ≥ Versione Postgresql su render.com*

Ci scaricherà il file `database_dump.sql` sulla nostra VM.



## Esempio con errore

Versione Postgresql su VM multipass < Versione Postgresql su render.com

In questo primo esempio siamo su una VM multipass che ha Postgres 12 (quello che si installa dalla repository di default di Ubuntu 20.04) Invece su render.com è installata l'ultima versione ossia Postgres 15. Quindi abbiamo un errore.

```bash
ubuntu@ubuntufla:~/ubuntudream (lng)$PGPASSWORD=x...0 pg_dump -h d...a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production_arvy -n public --no-owner > database_dump.sql
pg_dump: error: server version: 15.2; pg_dump version: 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)
pg_dump: error: aborting because of server version mismatch
ubuntu@ubuntufla:~ $psql --version
psql (PostgreSQL) 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)
ubuntu@ubuntufla:~ $
```

> Prende errore perché il mio ubuntu 20.04 su multipass ha installato postgreesql versione 12.14
> invece su render.com c'è la versione 15.2



## Esempio senza errore

Versione Postgresql su VM multipass = Versione Postgresql su render.com

In questo esempio siamo su una VM multipass che ha Postgres 15 (installato cambiando il repository di default di Ubuntu 20.04 con quello di https://www.postgresql.org/download/linux/ubuntu/)
Questo è allineato con render.com, quindi **non** abbiamo errori.

```bash
ubuntu@primary:~$ ls
Home  snap
ubuntu@primary:~$ PGPASSWORD=x...0 pg_dump -h d...a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production_arvy -n public --no-owner > database_dump.sql
ubuntu@primary:~$ ls
Home  database_dump.sql  snap
ubuntu@primary:~$ 
```



## Altro esempio senza errore

Versione Postgresql su VM multipass > Versione Postgresql su render.com

Ho rifatto il dump avendo sulla VM di multipass un postgresql con versione più alta e non mi ha dato nessun errore.

- Il mio ubuntu 20.04 su multipass ha installato postgreesql versione 16.0
- Su render.com c'è la versione 15.2

```bash
ubuntu@primary:~$ psql -V
psql (PostgreSQL) 16.0 (Ubuntu 16.0-1.pgdg22.04+1)
ubuntu@primary:~$ 
```



## Spostiamo il file dalla VM multipass al PC fisico

Per creare un collegamento tra la VM di multipass ed il nostro pc fisico dobbiamo fare un `mount`.

> Se da multipass creiamo la vm di default `primary` potremmo treovarne uno impostato di default la cartella Home con un mount già importato.
> Nella cartella `~/Home` della VM è montata la cartella user del pc fisico `<<root>>/Users/<<username>>`. 
> Nel mio caso è su: `FlaMac/Users/FB`. (I files che sul mac troviamo con "finder" su /Users/FB)

Possiamo vedere i "mounts" con il comando:

```shell
$ multipass info vm_name
```

Esempio:

```shell
❯ multipass info ub22fla
Name:           ub22fla
State:          Running
IPv4:           192.168.64.4
Release:        Ubuntu 22.04.3 LTS
Image hash:     dddfb1741f16 (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     4.0GiB out of 19.2GiB
Memory usage:   195.2MiB out of 3.8GiB
Mounts:         --
```

Se non è montata la possiamo montare con il seguente comando `multipass mount` da fare dal terminale di mac. (non da dentro l'istanza multipass).

```shell
❯ multipass list
❯ multipass mount ~ vm_name
❯ multipass info vm_name
❯ multipass shell vm_name
$ cd /Users/FB/
$ cp ~/database_dump.sql .
$ exit
❯ multipass unmount vm_name
```

Esempio:

```shell
❯ multipass mount ~ ub22fla
❯ multipass info ub22fla
Name:           ub22fla
State:          Running
IPv4:           192.168.64.4
Release:        Ubuntu 22.04.3 LTS
Image hash:     dddfb1741f16 (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.11 0.03 0.01
Disk usage:     4.0GiB out of 19.2GiB
Memory usage:   198.8MiB out of 3.8GiB
Mounts:         /Users/fb => /Users/fb
                    UID map: 501:default
                    GID map: 20:default

❯ multipass shell ub22fla
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-92-generic aarch64)
...
ubuntu@ub22fla:~ $ls
database_dump.sql  snap  ubuntudream
ubuntu@ub22fla:~ $ls /
Users  bin  boot  dev  etc  home  lib  lost+found  media  mnt  opt  proc  root  run  sbin  snap  srv  sys  tmp  usr  var
ubuntu@ub22fla:~ $ls /Users/
fb
ubuntu@ub22fla:~ $ls /Users/fb/
 Applications   Desktop   Documents   Downloads   Dropbox  'Google Drive'   Library   Movies   Music   Pictures   Public
ubuntu@ub22fla:~ $cd /Users/fb/
ubuntu@ub22fla:/Users/fb $cp ~/database_dump.sql .
ubuntu@ub22fla:/Users/fb $
ubuntu@ub22fla:/Users/fb $exit
logout

❯ multipass unmount ub22fla
❯ multipass info ub22fla
Name:           ub22fla
State:          Running
IPv4:           192.168.64.4
Release:        Ubuntu 22.04.3 LTS
Image hash:     dddfb1741f16 (Ubuntu 22.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     4.0GiB out of 19.2GiB
Memory usage:   185.9MiB out of 3.8GiB
Mounts:         --
```

Il file ce lo ritroviamo sul mac con "finder" su /Users/FB.



## Altro metodo per spostare il file

- [`multipass transfer` command](https://multipass.run/docs/transfer-command)
- [How to share data with an instance](https://multipass.run/docs/share-data-with-an-instance)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_00-install_i18n_globalize-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/25-nested_forms_with_stimulus/01_00-stimulus-mockup-it.md)
