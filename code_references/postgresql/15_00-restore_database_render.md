# <a name="top"></a> Cap postgresql.4 - Facciamo il restore del database remoto

Ripristiniamo il backup del database di produzione `ubuntudream_production` che abbiamo fatto nel capitolo precedente. Lo spostiamo dal nostro archivio di backup ad un nuovo database ospitato su *render.com*.


## Risorse interne

- [code_references/multipass_ubuntu/03_00-mount_a_directory-it.md]()



## Risorse Esterne

- [Render: PostgreSQL](https://render.com/docs/databases)
- [Render: PostgreSQL Backup]()https://render.com/docs/databases#backups
- [postgresql.org: 26.1. SQL Dump](https://www.postgresql.org/docs/current/backup-dump.html)
- [How to share data between host and VM with Multipass](https://www.youtube.com/watch?v=vrLcER1V2Co)



## I passi

Leggendo nella documentazione (https://render.com/docs/databases#backups)
Su Database Versions & Upgrades c'è il comando "database_dump"

At a high level, here are the steps to migrate your database to a newer version:

1. Create a new database with the desired version.
2. Disable or suspend any applications that write to your existing database. This prevents drift between the data in your database and that in your backup.
3. Take a backup of your existing database.
(i passi da 1 a 3 li abbiamo fatti nel capitolo precedente)

4. Restore that backup to your new database.
5. Point your applications at the new database and re-enable them.

Depending on how your applications are set up, this operation may require some downtime.



## RESTORE

Ripristiniamo un dump.


### Spostiamo il file dal PC fisico alla VM multipass 

Per creare un collegamento tra la VM di multipass ed il nostro pc fisico dobbiamo fare un "mount".
Di solito multipass ne ha già uno di default:
- nella cartella `~/Home` della VM è montata la cartella user del pc fisico "<<root>>/Users/<<username>>". Nel mio caso è su: `FlaMac/Users/FB`.
(I files che sul mac troviamo con "finder" su /Users/FB)

Possiamo vedere se i "mounts" con il comando:
```bash
$ multipass info primary
```

Se non è montata la possiamo montare con il seguente comando `multipass mount` da fare dal terminale di mac. (non da dentro l'istanza multipass):

```bash
MacBook-Pro-di-Flavio:~ FB$ multipass list
MacBook-Pro-di-Flavio:~ FB$ multipass mount ~ primary
MacBook-Pro-di-Flavio:~ FB$ multipass info primary
MacBook-Pro-di-Flavio:~ FB$ multipass shell primary
ubuntu@primary:~$ cd ~
ubuntu@primary:~$ cp /Users/FB/database_dump.sql .
ubuntu@primary:~$ exit
MacBook-Pro-di-Flavio:~ FB$ multipass unmount primary
```



### Stoppiamo il database attuale

Se siamo sulla versione gratuita di render.com non possiamo avere due database attivi allo stesso tempo quindi stoppiamo il ns database attivo prima di crearne uno nuovo.

https://dashboard.render.com/ --> Dashboard --> <<nome_databse>> --> Suspend Database

> Nel nostro caso <<nome_database>> è "ubuntudream_production".



## Creiamo un nuovo database su render.com

**NON** dobbiamo ripristinare il dump su un database esistente ma dobbiamo creare un nuovo database.
Il ripristino va fatto su un database **NUOVO APPENA CREATO** senza nessuna tabella o dato dentro.


https://dashboard.render.com/ --> Dashboard --> New + --> PostgreSQL


![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/05_fig01-render_new_postgres.png)

Non possiamo dare lo stesso "Nome" di uno già dato, ma questo nome è solo per render.com. Il nome del database è quello nel campo "Database" e qui possiamo, e dobbiamo, usare lo stesso nome.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/05_fig02-render_new_postgres_name.png)

Aggiungiamo un numero progressivo alla fine del "Nome" così abbiamo una traccia di quanti ripristini da dump abbiamo fatto. Quindi, nel nostro caso, avremo:

New PostgreSQL

- `Name`: ubuntudream_production2
- `Database`: ubuntudream_production
- `user`: ubuntudream
- `Region`: Frankfurt (EU Central)
- `PostgreSQL Version`: 15

Creiamo il database.







## Ripristiniamo il dump

You can then restore this data to your new database:

```bash
PGPASSWORD={PASSWORD} psql -h oregon-postgres.render.com -U {DATABASE_USER} {DATABASE_NAME} < database_dump.sql
```

> In pratica è la stringa che prendiamo per connetterci al database a cui aggiungiamo `< database_dump.sql` per passargli il dump del database.

Esempio:

```bash
PGPASSWORD=x...0 psql -h d...a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production_arvy < database_dump.sql
```



## Esempio di ripristino riuscito su NUOVO DB

Abbiamo appena creato un nuovo db e facciamo il rirpristino del dump.

```bash
ubuntu@primary:~$ ls
Home  database_dump.sql  snap
ubuntu@primary:~$ PGPASSWORD=rDSJZNjKSjXQ3ytdV8KwIwM63p524pRq psql -h dpg-ch1839bh4hstbhi9vdrg-a.frankfurt-postgres.render.com -U ubuntudream ubuntudream_production_pdgr < database_dump.sql
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
ERROR:  schema "public" already exists
COMMENT
SET
SET
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
CREATE TABLE
CREATE SEQUENCE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
COPY 0
COPY 0
COPY 0
COPY 0
COPY 0
COPY 1
COPY 0
COPY 0
COPY 11
COPY 0
COPY 1
 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ubuntu@primary:~$ 
```

Il ripristion è riuscito!

> C'è l'errore `ERROR:  schema "public" already exists` ma non è influente.



## Esempio di ripristino errato su DB esistente

Proviamo ad eseguirla sul database a cui abbiamo aggiunto una lezione e modificato il profilo utente di "ann" per vedere cosa succede. 

```bash
ubuntu@primary:~$ ls
Home  database_dump.sql  snap
ubuntu@primary:~$ PGPASSWORD=x...0 psql -h d...a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production_arvy < database_dump.sql
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
ERROR:  schema "public" already exists
COMMENT
SET
SET
ERROR:  relation "action_text_rich_texts" already exists
ERROR:  relation "action_text_rich_texts_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "active_storage_attachments" already exists
ERROR:  relation "active_storage_attachments_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "active_storage_blobs" already exists
ERROR:  relation "active_storage_blobs_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "active_storage_variant_records" already exists
ERROR:  relation "active_storage_variant_records_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "answers" already exists
ERROR:  relation "answers_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "ar_internal_metadata" already exists
ERROR:  relation "lessons" already exists
ERROR:  relation "lessons_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "preparatories" already exists
ERROR:  relation "preparatories_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "schema_migrations" already exists
ERROR:  relation "steps" already exists
ERROR:  relation "steps_id_seq" already exists
ALTER SEQUENCE
ERROR:  relation "users" already exists
ERROR:  relation "users_id_seq" already exists
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
COPY 0
COPY 0
COPY 0
COPY 0
COPY 0
ERROR:  duplicate key value violates unique constraint "ar_internal_metadata_pkey"
DETAIL:  Key (key)=(environment) already exists.
CONTEXT:  COPY ar_internal_metadata, line 1
COPY 0
COPY 0
ERROR:  duplicate key value violates unique constraint "schema_migrations_pkey"
DETAIL:  Key (version)=(20221008202526) already exists.
CONTEXT:  COPY schema_migrations, line 1
COPY 0
ERROR:  duplicate key value violates unique constraint "users_pkey"
DETAIL:  Key (id)=(1) already exists.
CONTEXT:  COPY users, line 1
 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

 setval 
--------
      1
(1 row)

ERROR:  multiple primary keys for table "action_text_rich_texts" are not allowed
ERROR:  multiple primary keys for table "active_storage_attachments" are not allowed
ERROR:  multiple primary keys for table "active_storage_blobs" are not allowed
ERROR:  multiple primary keys for table "active_storage_variant_records" are not allowed
ERROR:  multiple primary keys for table "answers" are not allowed
ERROR:  multiple primary keys for table "ar_internal_metadata" are not allowed
ERROR:  multiple primary keys for table "lessons" are not allowed
ERROR:  multiple primary keys for table "preparatories" are not allowed
ERROR:  multiple primary keys for table "schema_migrations" are not allowed
ERROR:  multiple primary keys for table "steps" are not allowed
ERROR:  multiple primary keys for table "users" are not allowed
ERROR:  relation "index_action_text_rich_texts_uniqueness" already exists
ERROR:  relation "index_active_storage_attachments_on_blob_id" already exists
ERROR:  relation "index_active_storage_attachments_uniqueness" already exists
ERROR:  relation "index_active_storage_blobs_on_key" already exists
ERROR:  relation "index_active_storage_variant_records_uniqueness" already exists
ERROR:  relation "index_answers_on_step_id" already exists
ERROR:  relation "index_answers_on_user_id" already exists
ERROR:  relation "index_steps_on_lesson_id" already exists
ERROR:  relation "index_users_on_email" already exists
ERROR:  relation "index_users_on_reset_password_token" already exists
ERROR:  relation "index_users_on_role" already exists
ERROR:  constraint "fk_rails_2c4859e022" for relation "answers" already exists
ERROR:  constraint "fk_rails_584be190c2" for relation "answers" already exists
ERROR:  constraint "fk_rails_86d3260272" for relation "steps" already exists
ERROR:  constraint "fk_rails_993965df05" for relation "active_storage_variant_records" already exists
ERROR:  constraint "fk_rails_c3b3935057" for relation "active_storage_attachments" already exists
ubuntu@primary:~$ 
```

> Questo ci dimostra che è bene fare il restore su un database **NUOVO APPENA CREATO**!</br>
> **NON** si deve usare un database esistente con tabelle e dati dentro.



## Colleghiamo nuovo db ad app esistente

Rientriamo sul nostro "ubuntudream_production2"

https://dashboard.render.com/ --> Dashboard --> ubuntudream_production2

Prendiamo l'`Internal Database URL`: `postgres://ubuntu:06...f-k/ubuntudream_production_pdgr`



### Colleghiamo il Web Service *ubuntudream*

Su render.com -> Dashboard -> web service "ubuntudream" (i web service hanno l'icona del mondo).
Andiamo su "Environment" e modifichiamo l'`Environment Variable` DATABASE_URL.

KEY	VALUE of `Environment Variables`
- DATABASE_URL      :	the internal database URL for the database you created above
- RAILS_MASTER_KEY  :	lasciamo il valore che c'è (the content of the config/master.key file)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/05_fig03-render-ubuntudream-environment-database_url.png)

That’s it! You can now finalize your service deployment. It will be live on your .onrender.com URL as soon as the build finishes.

- https://ubuntudream.onrender.com/



## Verifichiamo

Torniamo sulla dashboard e vediamo che lo STATUS è in "Deploy in progress".

> Aspettiamo che termini. Ci possono volere alcuni minuti.
> Se non dovesse funzionare possiamo rilanciare un `Manual Deploy -> Deploy latest commit`

Quando lo STATUS diventa "Deploy succeeded" possiamo verificare.

nell'url: https://ubuntudream.onrender.com/
Ci appare il login.
E possiamo anche effettuarlo con "ann" perché il database è stato ripristinato dal "dump".

> A volte ci può volere qualche minuto prima che le modifiche siano visibili.<br>
> Ma spesso quando ho "Deploy succeeded" le modifiche sono subito visibili sul sito.





---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_00-install_i18n_globalize-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/25-nested_forms_with_stimulus/01_00-stimulus-mockup-it.md)
