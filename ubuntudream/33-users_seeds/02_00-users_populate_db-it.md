# <a name="top"></a> Cap 33.2 - Users populate db

Popoliamo la tabella `users` direttamente su PostgreSql tramite comandi SQL.
Questo ci è utile nel caso in cui non abbiamo accesso al terminale. (Ad esempio nelle web app gratuite di render.com non abbiamo accesso al terminale.)



## Risorse interne

- []()
- [vedi anche "base_line/02-new_app/02_00-pg_app_databases"]()



## Risorse esterne

- []()




## Popoliamo da terminale il database su render.com

Se abbiamo una versione a pagamento abbiamo disponibile la console remota tramite SSL e quindi possiamo ridare semplicemente gli stessi comandi.

Se invece siamo sulla versione gratuita dobbiamo collegarci direttamente al database PostgreSQL di render.com ed inserire i dati lì.

La difficoltà è l'inserimento della password perché dobbiamo mettere quella già criptata. Quindi ci colleghiamo prima al PostgreSQL locale e ce la copiamo e poi la usiamo nel database remoto di postgresql.

```sql
$ psql postgres
> \c ubuntudream_development
> SELECT * FROM users;
```

Ci copiamo i dati (ad esempio):

- id                 : 1
- username           : 'Ann'
- email              : 'ann@test.abc'
- encrypted_password : '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO'
- created_at         : '2022-10-08 23:30:28.257872'
- updated_at         : '2022-10-08 23:30:28.257872'

Usciamo con `\q` oppure su un nuovo terminale:

```sql
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
> INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

> Per approfondimenti vedi: [code_reference/postgresql]() 


> Un'altra possibilità per ovviare al fatto che sulla versione gratuita non c'è il collegamento SSL e quindi no possiamo creare l'utente da terminale, è quello di inserirlo direttamente tramite web gui.
La web gui la creiamo nei prossimi capitoli.



## Connettiamoci al databas PostgreSQL locale di sviluppo

> Lo abbiamo già fatto ma in questo capitolo facciamo altri "passaggi didattici".

Su *multipass* andiamo nella cartella della nostra applicazione ed eseguiamo:

```bash
$ psql -h localhost -U ubuntu ubuntudream_development
```

> diamo la password che abbiamo assegnato e siamo dentro.

Per verificare le tabelle:

```SQL
$ psql postgres
-> \d
-> \q
```

Esempio:

```SQL
ubuntu@ubuntufla:~/bl7_0$ psql -h localhost -U ubuntu ubuntudream_development
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1))
Type "help" for help.

ubuntudream_development=# \d
 public | action_text_rich_texts                | table    | ubuntu
 public | action_text_rich_texts_id_seq         | sequence | ubuntu
 public | active_storage_attachments            | table    | ubuntu
 public | active_storage_attachments_id_seq     | sequence | ubuntu
 public | active_storage_blobs                  | table    | ubuntu
 public | active_storage_blobs_id_seq           | sequence | ubuntu
 public | active_storage_variant_records        | table    | ubuntu
 public | active_storage_variant_records_id_seq | sequence | ubuntu
 public | answers                               | table    | ubuntu
 public | answers_id_seq                        | sequence | ubuntu
 public | ar_internal_metadata                  | table    | ubuntu
 public | lessons                               | table    | ubuntu
 public | lessons_id_seq                        | sequence | ubuntu
 public | mobility_string_translations          | table    | ubuntu
 public | mobility_string_translations_id_seq   | sequence | ubuntu
 public | mobility_text_translations            | table    | ubuntu
 public | mobility_text_translations_id_seq     | sequence | ubuntu
 public | preparatories                         | table    | ubuntu
 public | preparatories_id_seq                  | sequence | ubuntu
 public | schema_migrations                     | table    | ubuntu
 public | steps                                 | table    | ubuntu
 public | steps_id_seq                          | sequence | ubuntu
 public | users                                 | table    | ubuntu
 public | users_id_seq                          | sequence | ubuntu

ubuntudream_development=# \q
ubuntu@ubuntufla:~/bl7_0$
```


Potevamo anche collegarci direttamente al server posrgreSql e vedere tutti i database.
Ma poi avremmo comunque dovuto connetterci al database che ci interessava (ubuntudream_development)

```bash
$ psql postgres
```

Esempio

```bash
ubuntu@ubuntufla:~/ubuntudream (lng)$psql postgres
psql (12.14 (Ubuntu 12.14-0ubuntu0.20.04.1))
Type "help" for help.

postgres=# \d
Did not find any relations.
postgres=# \list
                                       List of databases
            Name             |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-----------------------------+----------+----------+---------+---------+-----------------------
 bl7_0_development           | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 bl7_0_test                  | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 eduport_esbuild_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 eduport_esbuild_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres                    | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0                   | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                             |          |          |         |         | postgres=CTc/postgres
 template1                   | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                             |          |          |         |         | postgres=CTc/postgres
 ubuntudream_development     | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 ubuntudream_test            | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
(9 rows)

postgres=# 
postgres=# \c ubuntudream_development 
You are now connected to database "ubuntudream_development" as user "ubuntu".
ubuntudream_development=# \d
                         List of relations
 Schema |                 Name                  |   Type   | Owner  
--------+---------------------------------------+----------+--------
 public | action_text_rich_texts                | table    | ubuntu
 public | action_text_rich_texts_id_seq         | sequence | ubuntu
 public | active_storage_attachments            | table    | ubuntu
 public | active_storage_attachments_id_seq     | sequence | ubuntu
 public | active_storage_blobs                  | table    | ubuntu
 public | active_storage_blobs_id_seq           | sequence | ubuntu
 public | active_storage_variant_records        | table    | ubuntu
 public | active_storage_variant_records_id_seq | sequence | ubuntu
 public | answers                               | table    | ubuntu
 public | answers_id_seq                        | sequence | ubuntu
 public | ar_internal_metadata                  | table    | ubuntu
 public | lessons                               | table    | ubuntu
 public | lessons_id_seq                        | sequence | ubuntu
 public | mobility_string_translations          | table    | ubuntu
 public | mobility_string_translations_id_seq   | sequence | ubuntu
 public | mobility_text_translations            | table    | ubuntu
 public | mobility_text_translations_id_seq     | sequence | ubuntu
 public | preparatories                         | table    | ubuntu
 public | preparatories_id_seq                  | sequence | ubuntu
 public | schema_migrations                     | table    | ubuntu
 public | steps                                 | table    | ubuntu
 public | steps_id_seq                          | sequence | ubuntu
 public | users                                 | table    | ubuntu
 public | users_id_seq                          | sequence | ubuntu
(24 rows)

ubuntudream_development=# \q
ubuntu@ubuntufla:~/ubuntudream (lng)$
```

> ATTENZIONE!
> Poiché non abbiamo indicato una password per collegarci come "superuser" al servizio "postgreSQL" abbiamo potuto connetterci al database senza indicare nè utente nè password.



## Connettiamoci al databas PostgreSQL remoto di produzione

Su *render.com* andiamo nel database di produzione `ubuntudream_production` e copiamoci il codice su `Connect -> External Connection -> PSQL Command`

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/03_fig01-render_postgres_external_connection.png)

Usiamo quel codice sul nostro terminale.
Esempio:

```bash
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
```



## Verifichiamo i dati nella tabella `users`

Una volta collegati al database possiamo usare i comandi SQL di postgresql.

```sql
\d users
SELECT * FROM users;
```

> per uscire dalle schermate premere il tasto "q"



## Aggiungiamo un utente da postgreSQL

Aggiungiamo un utente usando la CLI (Command Line Interface) di postgreSQL, in altre parole il "terminale" di postgreSQL (questo è diverso dal terminale id rails e a questo abbiamo accesso da render.com anche nel database gratuito).

Aggiungiamo un record al nostro database remoto (production) su render.com.

```sql
INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

>l'encrypted_password l'abbiamo copiata dal postgresql db locale (development), in cui abbiamo già inserito l'utente Ann usando la password in chiaro e rails l'ha archiviata criptata nel database. Aggiungendola criptata possiamo fare il login in remoto con la stessa password in chiaro usata in locale. 


Verifichiamo che l'utente è stato inserito correttamente.

```sql
SELECT * FROM users;
```

Adesso se riandiamo sulla nostra app in produzione (il web service *ubuntudream*)...

- https://ubuntudream.onrender.com/

...Possiamo fare login.





## Verifichiamo produzione

Verifichiamo la nostra applicazione in produzione.
Andiamo all'URL:

- https://ubuntudream.onrender.com//users/sign_in

Usiamo le credenziali di login create su development e ricopiate nel database di produzione.

```
email     : ann@test.abc
password  : passworda
```

> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati se proviamo di nuovo veniamo riportati sulla pagina di *root* con l'avviso: "You are already signed in."

> Se non abbiamo fatto il copia/incolla della password tra i due database PostgreSQL di sviluppo e di produzione, possiamo aspettare i prossimi capitoli in cui la inseriremo tramite web gui.



## Inseriamo gli altri utenti

Inseriamo altri sei utenti ma a questi non assegniamo la password da CLI per evitare di doverle andare a prendere nel database di sviluppo. Le password le assegneremo direttamente dalla GUI.

```sql
SELECT * FROM users WHERE ID = 1;

SELECT * FROM users WHERE ID = 2;
```

```sql
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (2, 'Bob', 'bob@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

> Non mi da errore per la mancanza della password.

Mettiamo gli altri utenti.

```sql
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (3, 'Carl', 'carl@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (4, 'David', 'david@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (5, 'Elvis', 'elvis@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (6, 'Fla', 'fla@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

```sql
SELECT * FROM users WHERE ID = 3;
SELECT * FROM users WHERE ID = 4;
SELECT * FROM users WHERE ID = 5;
SELECT * FROM users WHERE ID = 6;
\q
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_00-authentication-devise_install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_00-users_table-it.md)
