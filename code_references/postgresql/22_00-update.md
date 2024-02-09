# <a name="top"></a> Cap postgresql.4 - Vediamo le tabelle del database

Siamo collegati ad un database adesso vediamo le sue tabelle.


## Risorse esterne

- [PostgreSQL UPDATE](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-update/)



## The syntax

The PostgreSQL UPDATE statement allows you to modify data in a table. 
The following illustrates the syntax of the UPDATE statement:

```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

> The WHERE clause is optional. If you omit the WHERE clause, the UPDATE statement will update all rows in the table.

When the UPDATE statement is executed successfully, it returns the following command tag:

```
UPDATE count
```

The count is the number of rows updated including rows whose values did not change.



## Aggiorniamo il campo `role` di un RECORD della tabella `users`

Rendiamo amministratore il primo utente.

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



## Aggiorniamo il campo `password` di un RECORD della tabella `users`

Prendo il valore crittato dalla tabella development dal database di sviluppo (development) e lo inserisco direttamente nel database di produzione (deployment) su render.com. 

```sql
UPDATE users
SET encrypted_password = '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO' 
WHERE id = 1;
```

> Ha funzionato ^_^ <br/>
> Posso entrare con la password non crittata dalla view di login.
> Password che conosco perché l'ho creata io nel database di sviluppo.


```
INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');

INSERT INTO users (id, username, email, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```


## Setting up a sample table

The following statements create a table called courses and insert some data into it:

```sql
DROP TABLE IF EXISTS courses;

CREATE TABLE courses(
	course_id serial primary key,
	course_name VARCHAR(255) NOT NULL,
	description VARCHAR(500),
	published_date date
);

INSERT INTO 
	courses(course_name, description, published_date)
VALUES
	('PostgreSQL for Developers','A complete PostgreSQL for Developers','2020-07-13'),
	('PostgreSQL Admininstration','A PostgreSQL Guide for DBA',NULL),
	('PostgreSQL High Performance',NULL,NULL),
	('PostgreSQL Bootcamp','Learn PostgreSQL via Bootcamp','2013-07-11'),
	('Mastering PostgreSQL','Mastering PostgreSQL in 21 Days','2012-06-30');
```

The following statement returns the data from the `courses` table:

```sql
SELECT * FROM courses;
```

### 1) PostgreSQL UPDATE – updating one row

The following statement uses the `UPDATE` statement to update the course with id 3. It changes the `published_date` from `NULL` to `'2020-08-01'`.

```sql
UPDATE courses
SET published_date = '2020-08-01' 
WHERE course_id = 3;
```

The statement returns the following message indicating that one row has been updated:

```bash
UPDATE 1
```

The following statement selects the course with id 3 to verify the update:

```sql
SELECT * 
FROM courses
WHERE course_id = 3;
```


## 2) PostgreSQL UPDATE – updating a row and returning the updated row

The following statement updates course id 2. It modifies `published_date` of the course to `'2020-07-01'` and returns the updated course.

```sql
UPDATE courses
SET published_date = '2020-07-01'
WHERE course_id = 2
RETURNING *;
```
