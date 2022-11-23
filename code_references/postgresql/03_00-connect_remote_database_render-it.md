# <a name="top"></a> Cap postgresql.3 - Colleghiamoci al database remoto

Ci colleghiamo al database di produzione `ubuntudream_production` che stiamo ospitando su *render.com*.

> `ubuntudream_production` è un nome di database scelto per fare gli esempi. Può essere qualsiasi nome, anche se per convenzione Rails tende ad essere `nomeapp_production`.



## Risorse Esterne

- [17 Practical psql Commands That You Don’t Want To Miss](https://www.postgresqltutorial.com/postgresql-administration/psql-commands/)
-[Documentation → PostgreSQL 14](https://www.postgresql.org/docs/current/app-psql.html)



## Connettiamoci al databas PostgreSQL di produzione

Su *render.com* andiamo nel database di produzione `ubuntudream_production` e copiamoci il codice su `Connect -> External Connection -> PSQL Command`

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/03_fig01-render_postgres_external_connection.png)

Usiamo quel codice sul nostro terminale

```bash
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
```

Esempio 

```bash
ubuntu@ubuntufla:~/ubuntudream (main)$PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
psql (12.12 (Ubuntu 12.12-0ubuntu0.20.04.1), server 14.5)
WARNING: psql major version 12, server major version 14.
         Some psql features might not work.
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_128_GCM_SHA256, bits: 128, compression: off)
Type "help" for help.       
                            
ubuntudream_production=> help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit
ubuntudream_production=>
```



## Navighiamo nel PostgreSql Database

```sql
ubuntudream_production=> help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit       
ubuntudream_production=> \list
                                       List of databases
          Name          |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
------------------------+----------+----------+------------+------------+-----------------------
 postgres               | postgres | UTF8     | en_US.UTF8 | en_US.UTF8 | 
 template0              | postgres | UTF8     | en_US.UTF8 | en_US.UTF8 | =c/postgres          +
                        |          |          |            |            | postgres=CTc/postgres
 template1              | postgres | UTF8     | en_US.UTF8 | en_US.UTF8 | =c/postgres          +
                        |          |          |            |            | postgres=CTc/postgres
 ubuntudream_production | ubuntu   | UTF8     | en_US.UTF8 | en_US.UTF8 | 
(4 rows)

ubuntudream_production-> \l
                                       List of databases
          Name          |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
------------------------+----------+----------+------------+------------+-----------------------
 postgres               | postgres | UTF8     | en_US.UTF8 | en_US.UTF8 | 
 template0              | postgres | UTF8     | en_US.UTF8 | en_US.UTF8 | =c/postgres          +
                        |          |          |            |            | postgres=CTc/postgres
 template1              | postgres | UTF8     | en_US.UTF8 | en_US.UTF8 | =c/postgres          +
                        |          |          |            |            | postgres=CTc/postgres
 ubuntudream_production | ubuntu   | UTF8     | en_US.UTF8 | en_US.UTF8 | 
(4 rows)

ubuntudream_production-> \dt
               List of relations
 Schema |         Name         | Type  | Owner  
--------+----------------------+-------+--------
 public | ar_internal_metadata | table | ubuntu
 public | schema_migrations    | table | ubuntu
 public | users                | table | ubuntu
(3 rows)

ubuntudream_production-> \d users
                                                Table "public.users"
         Column         |              Type              | Collation | Nullable |              Default              
------------------------+--------------------------------+-----------+----------+-----------------------------------
 id                     | bigint                         |           | not null | nextval('users_id_seq'::regclass)
 username               | character varying              |           | not null | ''::character varying
 first_name             | character varying              |           |          | 
 last_name              | character varying              |           |          | 
 location               | character varying              |           |          | 
 bio                    | character varying              |           |          | 
 phone_number           | character varying              |           |          | 
 email                  | character varying              |           | not null | ''::character varying
 encrypted_password     | character varying              |           | not null | ''::character varying
 reset_password_token   | character varying              |           |          | 
 reset_password_sent_at | timestamp(6) without time zone |           |          | 
 remember_created_at    | timestamp(6) without time zone |           |          | 
 created_at             | timestamp(6) without time zone |           | not null | 
 updated_at             | timestamp(6) without time zone |           | not null | 
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)
    "index_users_on_email" UNIQUE, btree (email)
    "index_users_on_reset_password_token" UNIQUE, btree (reset_password_token)

ubuntudream_production-> 
```


INSERT INTO users (username, email, password, password_confirmation) VALUES ('Ann', 'ann@test.abc', 'passworda', 'passworda');


User.create(username: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')



## Impostiamo il ruolo di amministratore al primo user

vediamo i nomi delle colonne della tabella ed i dati di tutti gli utenti.

```sql
\d users
SELECT * FROM users;
```

Premiamo il tasto `q` per uscire.

Impostiamo il `role = 1`, che è quello di `administrator` all'utente con `id = 1`, che di solito è il primo utente.

```sql
UPDATE users
SET role = 1 
WHERE id = 1;
```





## Colleghiamoci al database locale

psql -d database -U user -W



 id | username | first_name | last_name | location | bio | phone_number |    email     |                      encrypted_password                      | reset_password_token | reset_password_sent_at | remember_created_at |         created_at         |         updated_at         
----+----------+------------+-----------+----------+-----+--------------+--------------+--------------------------------------------------------------+----------------------+------------------------+---------------------+----------------------------+----------------------------
  1 | Ann      |            |           |          |     |              | ann@test.abc | $2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO |                      |                        |                     | 2022-10-08 23:30:28.257872 | 2022-10-08 23:30:28.257872
(1 row)

(END)



INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');

INSERT INTO users (id, username, email, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');

$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO