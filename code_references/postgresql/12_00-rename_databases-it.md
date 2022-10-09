# <a name="top"></a> Cap postgresql.3 - Rinominiamo i databases

Rinominiamo i databases su PostgreSQL



## Risorse interne

- [01-beginning/01-new_app/06-pg_app_databases]()



## Cambiamo i nomi dei databases su postgreSQL

Rinominiamo i due database di "S5beginning" direttamente su postgreSQL.

Colleghiamoci a postgreSQL ed elenchiamo tutti i databases.

```bash
$ psql postgres
-> \list


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


{caption: "terminal", format: bash, line-numbers: false}
```
-> SELECT
->     *
-> FROM
->     pg_stat_activity
-> WHERE
->     datname = 's5beginning_test';


postgres=# SELECT
*
FROM
pg_stat_activity
WHERE
datname = 's5beginning_test';
 datid | datname | pid | usesysid | usename | application_name | client_addr | client_hostname | client_port | backend_start | xact_start | query_start | state_change | wait_event_type | wait_event | state | backend_xid | backend_xmin | query | backend_type 
-------+---------+-----+----------+---------+------------------+-------------+-----------------+-------------+---------------+------------+-------------+--------------+-----------------+------------+-------+-------------+--------------+-------+--------------
(0 rows)

postgres=# 
```

Il database non ha nessuna connessione attiva, altrimenti era meglio informare gli utenti connessi di scollegarsi prima di rinominare.
Rinominiamo i due database (da -> a):

* s5beginning_development   -> s5cmsbeginning_development
* s5beginning_test          -> s5cmsbeginning_test

{caption: "terminal", format: bash, line-numbers: false}
```
-> ALTER DATABASE "s5beginning_development" RENAME TO "s5cmsbeginning_development";
-> ALTER DATABASE "s5beginning_test" RENAME TO "s5cmsbeginning_test";


postgres=# ALTER DATABASE "s5beginning_development" RENAME TO "s5cmsbeginning_development";
ALTER DATABASE
postgres=# ALTER DATABASE "s5beginning_test" RENAME TO "s5cmsbeginning_test";
ALTER DATABASE
postgres=# 
```


Verifichiamo il cambio di nome ed usciamo da postgreSQL

```sql
-> \list
-> \q

postgres=# \list
                                      List of databases
            Name            |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
----------------------------+----------+----------+---------+---------+-----------------------
 postgres                   | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 s5cmsbeginning_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 s5cmsbeginning_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0                  | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                            |          |          |         |         | postgres=CTc/postgres
 template1                  | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                            |          |          |         |         | postgres=CTc/postgres
(5 rows)

postgres=# \q
ubuntu:~/environment/s5cmsbeginning (master) $ 
```


