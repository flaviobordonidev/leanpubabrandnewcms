# <a name="top"></a> Cap postgresql.3 - Colleghiamoci al database remoto

Ci colleghiamo al database di sviluppo in locale che stiamo ospitando su `multipass`.



## Risorse esterne

- [psql-commands](https://www.postgresqltutorial.com/postgresql-administration/psql-commands/)



## Colleghiamoci a PostgreSQL locale

Colleghiamoci al PostgreSQL della nostra macchina virtuale `ubuntu multipass` ed elenchiamo tutti i databases.

```bash
$ psql -U user -W
```

> Premendo *Enter* PostgreSQL will ask for the password of the user.

Per vedere l'elenco dei databases usiamo il comando `\list` oppure `\l`.

Esempio:

```bash
$ psql postgres
> \list


ubuntu:~/environment/s5cmsbeginning (master) $ psql postgres
psql (10.10 (Ubuntu 10.10-0ubuntu0.18.04.1))
Type "help" for help.

postgres=# \list
                                     List of databases
          Name           |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-------------------------+----------+----------+---------+---------+-----------------------
 postgres                | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 s5beginning_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 s5beginning_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0               | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                         |          |          |         |         | postgres=CTc/postgres
 template1               | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                         |          |          |         |         | postgres=CTc/postgres
(5 rows)

postgres=# 
```



## Verifica di connessioni attive

Verifichiamo se ci sono delle connessioni attive sui databases "s5beginning_development" e "s5beginning_test"

```sql
> SELECT
>     *
> FROM
>     pg_stat_activity
> WHERE
>     datname = 's5beginning_development';


postgres=# SELECT
postgres-# *
postgres-# FROM
postgres-# pg_stat_activity
postgres-# WHERE
postgres-# datname = 's5beginning_development';
 datid | datname | pid | usesysid | usename | application_name | client_addr | client_hostname | client_port | backend_start | xact_start | query_start | state_change | wait_event_type | wait_event | state | backend_xid | backend_xmin | query | backend_type 
-------+---------+-----+----------+---------+------------------+-------------+-----------------+-------------+---------------+------------+-------------+--------------+-----------------+------------+-------+-------------+--------------+-------+--------------
(0 rows)

postgres=# 
```



## Colleghiamoci ad un database

Sia per collegarci ad un primo database, sia per cambiare connessione ad un nuovo database possiamo usare il comando:

```
\c dbname username
```

> The previous connection will be closed. <br/>
> If you omit the username parameter, the current user is assumed.


Per Esempio The following command connects to dvdrental database under postgres user:

```
postgres=# \c dvdrental
You are now connected to database "dvdrental" as user "postgres".
dvdrental=#
Code language: PHP (php)
```



## Colleghiamoci direttamente ad un database

Invece di aprire prima PostgreSQL e poi di collegarsi ad un database; se ci volessimo collegare direttamente ad un database specifico potremmo indicarlo con l'opzione `-d database`.

```bash
$ psql -d database -U user -W
```

Se ad esempio ci volessimo collegare al database *dvdrental* come utente *user* il comando sarebbe il seguente:

```bash
C:\Program Files\PostgreSQL\9.5\bin>psql -d dvdrental -U user postgres -W
Password for user postgres:
dvdrental=#
Code language: SQL (Structured Query Language) (sql)
```
