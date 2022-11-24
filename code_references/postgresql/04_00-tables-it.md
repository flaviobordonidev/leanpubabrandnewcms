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
