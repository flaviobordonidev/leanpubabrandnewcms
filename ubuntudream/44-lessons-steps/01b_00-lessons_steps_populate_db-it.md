# <a name="top"></a> Cap 33.2 - Lessons and Steps populate db

Popoliamo le tabelle `lessons` e `steps` direttamente su PostgreSql tramite comandi SQL.
Questo ci è utile nel caso in cui non abbiamo accesso al terminale. (Ad esempio nelle web app gratuite di render.com non abbiamo accesso al terminale.)



## Risorse interne

- []()
- [vedi anche "base_line/02-new_app/02_00-pg_app_databases"]()
- [vedi anche "ubuntudream/33-users_seeds/02_00-users_populate_db-it"]()



## Risorse esterne

- []()


## Connettiamoci al databas PostgreSQL remoto di produzione

Su *render.com* andiamo nel database di produzione `ubuntudream_production` e copiamoci il codice su `Connect -> External Connection -> PSQL Command`

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/03_fig01-render_postgres_external_connection.png)

Usiamo quel codice sul nostro terminale.
Esempio:

```bash
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
```



## Verifichiamo i dati nella tabella `lessons`

Una volta collegati al database possiamo usare i comandi SQL di postgresql.

```sql
> \d users
> SELECT * FROM lessons;
```

> per uscire dalle schermate premere il tasto "q"



## Aggiungiamo una lezione (lesson) da postgreSQL

Aggiungiamo una lezione usando la CLI (Command Line Interface) di postgreSQL, in altre parole il "terminale" di postgreSQL (questo è diverso dal terminale id rails e a questo abbiamo accesso da render.com anche nel database gratuito).

Aggiungiamo un record al nostro database remoto (production) su render.com.

nome colonna          | location      | valore
|:--                  |:--            |:--
id                    | table         | 1
description           | table         | 'Quadro della casa del primo presidente degli USA'
description_rtf       | Mobility+ActionText | 'Quadro della casa del primo presidente degli USA'
duration              | table         | 90
name                  | Mobility      | 'View of mount Vermon'
picture_author_name   | table         | 'Joachim Ferdinand Richardt'
picture_author_image  | ActiveStorage | file.png
picture_image         | ActiveStorage | file.jpg
picture_museum_name   | table         | 'Chicago museum'
created_at            | table         | '2023-01-01 23:30:30.257872'
updated_at            | table         | '2023-01-01 23:30:30.257872'


```sql
INSERT INTO lessons (id, description, description_rtf, duration, name, picture_author_name, picture_museum_name, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$EYO', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
```

> `name` non posso metterlo nella tabella lessons perché usa Mobility e quindi va nella rispettiva tabella Mobility insieme all'id di lessons. (nel nostro caso id = 1)

Mobility usa le seguenti 2 tabelle:
- mobility_string_translations
- mobility_text_translations

ed il `name` lo abbiamo definito nel Model come `type: :string` quindi va sulla tabella `mobility_string_translations`.

Vediamo tutte le tabelle sul database ed i dati di quella che ci interessa.

```sql
$ psql postgres
> \c ubuntudream_development
> \d
> SELECT * FROM mobility_string_translations;
```

Esempio:

```sql
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

ubuntudream_development=# SELECT * FROM mobility_string_translations;

id | locale |   key    |                                                              value                                                               | translatable_type | translatable_id |         created_at         |         updated_at         
----+--------+----------+----------------------------------------------------------------------------------------------------------------------------------+-------------------+-----------------+----------------------------+----------------------------
  1 | en     | cheneso  | this is a don't say                                                                                                              | Step              |               1 | 2022-12-26 23:18:48.938254 | 2022-12-26 23:18:48.938254
  2 | it     | cheneso  | Caramba                                                                                                                          | Step              |               1 | 2022-12-27 00:19:20.269705 | 2022-12-27 00:20:54.988281
  3 | it     | question | Quante persone ci sono?                                                                                                          | Step              |               1 | 2022-12-27 08:53:55.034708 | 2022-12-27 08:53:55.034708
  4 | en     | question | How many people there are?                                                                                                       | Step              |               1 | 2022-12-27 08:54:32.381891 | 2022-12-27 08:54:32.381891
  5 | en     | question | One of the 10 columns in front of the house with yellow brick is quite different. Which one?                                     | Step              |               2 | 2022-12-27 08:57:07.64603  | 2022-12-27 08:58:55.345247
  7 | pt     | question | Uma das 10 colunas da varanda da casa de tijolos amarelos é bem diferente das demais. Qual?                                      | Step              |               2 | 2023-01-10 13:11:18.468099 | 2023-01-10 13:11:18.468099
  9 | en     | name     | View of mount Vernon                                                                                                             | Lesson            |               1 | 2023-01-10 13:28:51.68805  | 2023-01-10 13:28:51.68805
 10 | pt     | name     | Vista do Monte Vernon                                                                                                            | Lesson            |               1 | 2023-01-10 13:30:00.102017 | 2023-01-10 13:30:00.102017
  8 | it     | name     | Veduta di Mount Vernon                                                                                                           | Lesson            |               1 | 2023-01-10 13:28:13.841161 | 2023-01-10 13:33:40.438983
```

Vediamo che le colonne che ci servono sono 4:
- translatable_type --> il nome del Model con il campo da tradurre (nel nostro caso è 'Lesson')
- translatable_id --> l'id del record della tabella con il campo da tradurre
- key --> il nome del campo con il valore da tradurre (nel nostro caso è 'name')
- locale --> l'abbreviazione i18n della lingua che usiamo (nel nostro caso è 'en' o 'it' o 'pt')
- value --> il valore che vogliamo inserire scritto nella lingua selezionata in locale

Ad esempio per mettere in inglese, italiano e portoghese il nome del primo quadro abbiamo l'inserimento di 3 records sulla tabella `mobility_string_translations`:

- translatable_type = 'Lesson'
- translatable_id = 1
- key = 'name'
- locale = 'en'
- value = 'View of mount Vernon'

- translatable_type = 'Lesson'
- translatable_id = 1
- key = 'name'
- locale = 'it'
- value = 'Veduta del monte Vernon'

- translatable_type = 'Lesson'
- translatable_id = 1
- key = 'name'
- locale = 'pt'
- value = 'Vista do monte Vernon'



```sql
INSERT INTO mobility_string_translations (id, locale, key, value, translatable_type, translatable_id, created_at, updated_at) 
VALUES 
  (1, 'en', 'name', 'View of mount Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872'),
  (2, 'it', 'name', 'Veduta del monte Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
  (3, 'pt', 'name', 'Vista do monte Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
```

> Immagino di partire con la tabella vuota quindi parto da id = 1





## Aggiungiamo tre passaggi (steps) da postgreSQL

Aggiungiamo due passaggi alla lezione inserita sopra.

nome colonna          | location      | valore
|:--                  |:--            |:--
id                    | table         | 1
question              | table         | 'Quante persone ci sono?'
answer                | table         | 'Ci sono sei persone.'
name                  | Mobility      | 'View of mount Vermon'
lesson_id             | table         | 1
youtube_video_id      | table         | 'bJJpGBBlsy4'
created_at            | table         | '2023-01-01 23:30:30.257872'
updated_at            | table         | '2023-01-01 23:30:30.257872'

> la colonna `lesson_id` è la chiave esterna usata dall'associazione molti-a-uno per legarsi al record della tabella `lessons`.


```sql
INSERT INTO steps (id, question, answer, lesson_id, youtube_video_id, created_at, updated_at) 
VALUES 
  (1, 'Quante persone ci sono?', 'Ci sono sei persone.', 1, 'bJJpGBBlsy4', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872'),
  (2, 'Che colore è il cane?', 'Nero.', 1, 'eg_6CxTEiL8', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
```

> Immagino di partire con la tabella vuota quindi parto da id = 1



## Commenti

Questo approccio funziona ma è lungo e forse si fa prima a riempire i campi manualmente...
A meno di non creare un grosso file con tutti i comandi SQL e fare copia/incolla di tutti i comandi dentro la CLI di postgresql.
[da-verificare-se-funziona]
[vedi:99-restart_db/02_00-populate_db_empty-it]
