# <a name="top"></a> Cap postgresql.4 - Vediamo le tabelle del database

Siamo collegati ad un database adesso vediamo le sue tabelle.


## Risorse esterne

- [psql-commands](https://www.postgresqltutorial.com/postgresql-administration/psql-commands/)



## List available tables

To list all tables in the current database, you use \dt command:

```sql
\dt
```

Note that this command shows the only table in the currently connected database.

## Describe a table

To describe a table such as a column, type, modifiers of columns, etc., you use the following command:

```sql
\d table_name
```

## List available schema

To list all schemas of the currently connected database, you use the \dn command.

```sql
\dn
```

## List available functions

To list available functions in the current database, you use the \df command.

```sql
\df
```

## List available views

To list available views in the current database, you use the \dv command.

```sql
\dv
```

## List users and their roles

To list all users and their assign roles, you use \du command:

```sql
\du
```


## Aggiorna un a RECORD

```sql
\d users
SELECT * FROM users;
```

Premiamo il tasto `q` per uscire.

```sql
UPDATE users
SET role = 1 
WHERE id = 1;
```

```sql
UPDATE courses
SET published_date = '2020-08-01' 
WHERE course_id = 3;
```


```sql
UPDATE users
SET encrypted_password = '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO' 
WHERE id = 1;
```

> Ha funzionato ^_^


INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');

INSERT INTO users (id, username, email, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');

