# <a name="top"></a> Cap 99.2 - Popoliamo da db vuoto

Mettiamo tutti i comandi SQL in un unico file e facciamo copia/incolla di tutto per ripopolare la nostra applicazione.

> Per dettagli sul codice che SQL che usiamo fare riferimento ai relativi capitoli "xxx_populate_db" che riportiamo anche nei "Riferimenti interni"


## Riferimenti interni

- []()


## Popoliamo users

***Codice: 01 - populate_db.sql - linea:01***

```sql
INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (2, 'Bob', 'bob@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (3, 'Carl', 'carl@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (4, 'David', 'david@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (5, 'Elvis', 'elvis@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (6, 'Fla', 'fla@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

> nota: l'estenzione ".sql" l'ho messa solo per vedere il testo formattato, tanto facciamo copia/incolla del testo quindi l'estenzione non ci interessa.



## Popoliamo Lessons

***Codice: 01 - ...continua - linea:07***

```sql
INSERT INTO lessons (id, description, description_rtf, duration, name, picture_author_name, picture_museum_name, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$EYO', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
INSERT INTO mobility_string_translations (id, locale, key, value, translatable_type, translatable_id, created_at, updated_at) 
VALUES 
  (1, 'en', 'name', 'View of mount Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872'),
  (2, 'it', 'name', 'Veduta del monte Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
  (3, 'pt', 'name', 'Vista do monte Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
```



## Popoliamo Steps

***Codice: 01 - ...continua - linea:13***

```sql
INSERT INTO steps (id, question, answer, lesson_id, youtube_video_id, created_at, updated_at) 
VALUES 
  (1, 'Quante persone ci sono?', 'Ci sono sei persone.', 1, 'bJJpGBBlsy4', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872'),
  (2, 'Che colore è il cane?', 'Nero.', 1, 'eg_6CxTEiL8', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
```

> ATTENZIONE!
> ci sono i seguenti errori:
> 'answer' non ci serve visto che c'è l'apposita tabella.
> il campo 'question' va su Mobility perché deve essere tradottto in più lingue.
> il campo 'youtube_video_id' va su Mobility perché indirizzo su video con lingue diverse.



## Popoliamo Answers

[TODO]
