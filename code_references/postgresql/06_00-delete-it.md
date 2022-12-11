# <a name="top"></a> Cap postgresql.6 - Cancellare records dalla tabella

Siamo collegati ad un database cancelliamo dei records da una tabella.


## Risorse esterne

- [PostgreSQL DELETE](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-delete/)
- [PostgreSQL TRUNCATE](https://www.tutorialspoint.com/postgresql/postgresql_truncate_table)



## Cancelliamo dei records da una tabella

> I records sono anche chiamati "righe" ("rows") di una tabella.
The PostgreSQL DELETE statement allows you to delete one or more rows from a table.

The following shows basic syntax of the DELETE statement:


## DELETE: The syntax

```sql
DELETE FROM table_name
WHERE condition;
```

> To return the deleted row(s) to the client, you use the RETURNING clause as follows:

```sql
DELETE FROM table_name
WHERE condition
RETURNING (select_list | *)
```

> The asterisk (*) allows you to return all columns of the deleted row from the table_name.<br/>
> To return specific columns, you specify them after the RETURNING keyword.

> Note that the DELETE statement only removes data from a table. It doesn’t modify the structure of the table. If you want to change the structure of a table such as removing a column, you should use the ALTER TABLE statement.



## Esempio 1) Using PostgreSQL DELETE to delete one row from the table

Questo esempio presuppone la presenza della tabella `links`

The following statement uses the DELETE statement to delete one row with the id 8 from the links table:

```sql
DELETE FROM links
WHERE id = 8;
```

The statement returns 1 indicated that one row has been deleted:

```bash
DELETE 1
```

The following statement uses the DELETE statement to delete the row with id 10:

```sql
DELETE FROM links
WHERE id = 10;
```

Since the row with id 10 does not exist, the statement returns 0:

```bash
DELETE 0
```



## 2) Using PostgreSQL DELETE to delete a row and return the deleted row

The following statement deletes the row with id 7 and returns the deleted row to the client:

```sql
DELETE FROM links
WHERE id = 7
RETURNING *;
```



## 3) Using PostgreSQL DELETE to delete multiple rows from the table

The following statement deletes two rows from the links table and return the values in the id column of deleted rows:

```sql
DELETE FROM links
WHERE id IN (6,5)
RETURNING *;
```



## 4) Using PostgreSQL DELETE to delete all rows from the table

The following statement uses the DELETE statement without a WHERE clause to delete all rows from the links table:

```sql
DELETE FROM links;
```

The links table now is empty.



## Cancelliamo TUTTI i records di una tabella in modo più efficente

The PostgreSQL TRUNCATE TABLE command is used to delete complete data from an existing table. You can also use DROP TABLE command to delete complete table but it would remove complete table structure from the database and you would need to re-create this table once again if you wish to store some data.

> It has the same effect as DELETE on each table, but since it does not actually scan the tables, it is faster. Furthermore, it reclaims disk space immediately, rather than requiring a subsequent VACUUM operation. This is most useful on large tables.


## TRUNCATE: The syntax

The basic syntax of TRUNCATE TABLE is as follows −

```sql
TRUNCATE TABLE table_name;
```

