# <a name="top"></a> Cap 14 - Prima nuova app rails

Installiamo includendo da subito il database postgreSQL perché è quello che abbiamo in produzione su Render.
Se nella VM è la prima volta che creiamo una applicazione rails che usa il database postgresql.


## Creiamo una nuova applicazione Rails con database postgreSQL per la prima volta

Per creare una nuova applicazione rails che usa il database postgreSQL dobbiamo usare il comando: `$ rails new nome-app --database=postgresql`
Ma la prima volta che creiamo una applicazione con l'opzione `--database=postgresql` dobbiamo prima installare `sudo apt install libpq-dev`.

```shell
$ cd ~
$ rails --version
# installiamo la libreria postgreSQL di sviluppo
$ sudo apt install libpq-dev
```

> Attenzione!
> Affinché funzioni l'opzione `--database=postgresql` deve essere installata la libreria libpq-dev: `sudo apt install libpq-dev`.

Il comando per la nuova applicazione lo daremo nel prossimo capitolo.


Esempio:

```shell
ubuntu@ub22fla:~ $cd ~
ubuntu@ub22fla:~ $pwd
/home/ubuntu
ubuntu@ub22fla:~ $rails --version
Rails 7.1.3

ubuntu@ub22fla:~$ sudo apt install libpq-dev
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Suggested packages:
  postgresql-doc-16
The following NEW packages will be installed:
  libpq-dev
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 138 kB of archives.
After this operation, 592 kB of additional disk space will be used.
Get:1 https://apt.postgresql.org/pub/repos/apt jammy-pgdg/main arm64 libpq-dev arm64 16.1-1.pgdg22.04+1 [138 kB]
Fetched 138 kB in 2s (65.9 kB/s)     
Selecting previously unselected package libpq-dev.
(Reading database ... 80334 files and directories currently installed.)
Preparing to unpack .../libpq-dev_16.1-1.pgdg22.04+1_arm64.deb ...
Unpacking libpq-dev (16.1-1.pgdg22.04+1) ...
Setting up libpq-dev (16.1-1.pgdg22.04+1) ...
Processing triggers for man-db (2.10.2-1) ...
Scanning processes...                                
Scanning linux images...                                              
Running kernel seems to be up-to-date.
No services need to be restarted.
No containers need to be restarted.
No user sessions are running outdated binaries.
No VM guests are running outdated hypervisor (qemu) binaries on this host.
```
