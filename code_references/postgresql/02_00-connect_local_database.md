# <a name="top"></a> Cap postgresql.3 - Colleghiamoci al database locale

Ci colleghiamo al database di sviluppo in locale che stiamo ospitando su `multipass`.



## Risorse esterne

- [psql-commands](https://www.postgresqltutorial.com/postgresql-administration/psql-commands/)
- [digitalocean: postgresql ubuntu 22](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart)



## Colleghiamoci a PostgreSQL locale

Colleghiamoci al PostgreSQL della nostra macchina virtuale `ubuntu multipass` ed elenchiamo tutti i databases.

By default, Postgres uses a concept called **roles** to handle authentication and authorization. These are, in some ways, similar to regular Unix-style users and groups.

Upon installation, Postgres is set up to use ident authentication, meaning that it associates Postgres roles with a matching Unix/Linux system account. If a role exists within Postgres, a Unix/Linux username with the same name is able to sign in as that role.

The installation procedure created a user account called `postgres` that is associated with the **default Postgres role**. There are a few ways to utilize this account to access Postgres. One way is to switch over to the `postgres` account on your server and run the commands.


```shell
# cambio utente da ubuntu a postgres
$ sudo -i -u postgres
-> $ psql
--> =# \q
-> $ exit
```

Esempio:

```shell
ubuntu@ub22fla:~$ sudo -i -u postgres
postgres@ub22fla:~$ psql
psql (16.1 (Ubuntu 16.1-1.pgdg22.04+1))
Type "help" for help.

postgres=# \q
postgres@ub22fla:~$ exit
logout
ubuntu@ub22fla:~$ 
```

Another way to connect to the Postgres prompt is to run the psql command as the postgres account directly with sudo.
This will log you directly into Postgres without the intermediary bash shell in between.

```shell
# eseguo psql come utente postgres
$ sudo -u postgres psql
```



## Vediamo l'elenco dei databases

Per vedere l'elenco dei databases usiamo il comando `\list` oppure `\l`.


```shell
$ sudo -u postgres psql
-> \list
```

Esempio:

```shell
ubuntu@ub22fla:~$ sudo -u postgres psql
psql (16.1 (Ubuntu 16.1-1.pgdg22.04+1))
Type "help" for help.

postgres=# \list
                                                   List of databases
   Name    |  Owner   | Encoding | Locale Provider | Collate |  Ctype  | ICU Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+---------+---------+------------+-----------+-----------------------
 postgres  | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | 
 template0 | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |         |         |            |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |         |         |            |           | postgres=CTc/postgres
(3 rows)

postgres=# \q
```



## Creiamo un nuovo utente di postgresql (**role**)

If you are logged in as the `postgres` account, you can create a new **role** with the command `createuser --interactive`.

```shell
$ sudo -u postgres createuser --interactive
```

Esempio:

```shell
ubuntu@ub22fla:~$ sudo -u postgres createuser --interactive
Enter name of role to add: ubuntu
Shall the new role be a superuser? (y/n) y
ubuntu@ub22fla:~$ 
```



## Creiamo un nuovo database

Another assumption that the Postgres authentication system makes by default is that for any role used to log in, that role will have a database with the same name which it can access.

This means that if the user you created in the last section is called **ubuntu**, that role will attempt to connect to a database which is also called “ubuntu” by default. You can create the appropriate database with the `createdb` command.

If must be the `postgres` account to create the database.

```shell
$ sudo -u postgres createdb ubuntu
```


In alternativa da dentro psql si poteva creare il database con un comando SQL.

```shell
# eseguo psql come utente postgres
$ sudo -u postgres psql
-> =# CREATE DATABASE ubuntu;
```


## Colleghiamoci al nuovo database 

To log in with ident based authentication, you’ll need a Linux user with the same name as your Postgres role and database.

```shell
$ psql
```

> Siccome siamo loggati su multipass come utente ubuntu possiamo collegarci al database ubuntu appena creato.
> una volta entrati possiamo visualizzare anche gli altri databases.

Esempio:

```shell
ubuntu@ub22fla:~$ whoami
ubuntu
ubuntu@ub22fla:~$ psql
psql (16.1 (Ubuntu 16.1-1.pgdg22.04+1))
Type "help" for help.

ubuntu=# \conninfo
You are connected to database "ubuntu" as user "ubuntu" via socket in "/var/run/postgresql" at port "5432".
ubuntu=# \list
                                                   List of databases
   Name    |  Owner   | Encoding | Locale Provider | Collate |  Ctype  | ICU Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+---------+---------+------------+-----------+-----------------------
 postgres  | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | 
 template0 | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |         |         |            |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |         |         |            |           | postgres=CTc/postgres
 ubuntu    | postgres | UTF8     | libc            | C.UTF-8 | C.UTF-8 |            |           | 
(4 rows)

ubuntu=# \c postgres
You are now connected to database "postgres" as user "ubuntu".
postgres=# \conninfo
You are connected to database "postgres" as user "ubuntu" via socket in "/var/run/postgresql" at port "5432".
postgres=# \q
ubuntu@ub22fla:~$ 
```

Legenda:

- `=# \conninfo` --> Per visualizzare a che database siamo connessi
- `=# \c dbname username` --> Per connettersi al database
    > The previous connection will be closed. <br/>
    > If you omit the username parameter, the current user is assumed.
- `=# \q` --> Per uscire da psql


Invece di aprire prima `psql` che si collega al database dell'utente, nel nostro caso `ubuntu`, e poi collegarci ad un database...
Ci possiamo collegare direttamente ad un database specifico usando l'opzione `-d database`.

```shell
$ psql -d database
```

Esempio:

```shell
ubuntu@ub22fla:~$ psql -d postgres
psql (16.1 (Ubuntu 16.1-1.pgdg22.04+1))
Type "help" for help.

postgres=# \conninfo
You are connected to database "postgres" as user "ubuntu" via socket in "/var/run/postgresql" at port "5432".
postgres=# 
```
