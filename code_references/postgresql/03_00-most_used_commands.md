# <a name="top"></a> Cap postgresql.3 - I comandi più usati

Comandi più usati


## Risorse esterne

- [17 Practical psql Commands You Don’t Want to Miss](https://www.postgresqltutorial.com/postgresql-administration/psql-commands/)



## Connect to PostgreSQL database

Da postgresql 16 le connessioni che mi hanno funzionato sono quelle in cui il comando deve essere dato dall'utente che è attualmente loggato nel sistema operativo (ubuntu server).

Se voglio loggarmi come utente `sammy` devo impostarlo sia come utente del sistema operativo sia come utente/role di postgresql.

Esempio:

```shell
$ sudo -u postgres createuser --interactive
-> Enter name of role to add: sammy
-> Shall the new role be a superuser? (y/n) y
$ sudo -u postgres createdb sammy
$ sudo adduser sammy
$ sudo -u sammy psql
```

- creo l'utente/role `sammy` in postgresql. Per crearlo lancio il comando `createuser` come utente `postgres`. La prima perte del comando `sudo -u postgres` fa eseguire il comando successivo cambiando l'utente del sistema operativo.
- creo il database `sammy` perché postgresql permette ad utenti/role diversi da `postgres` di loggarsi solo se hanno un db col loro nome.
- creo l'utente `sammy` nel sistema operativo.
- eseguo il comando `psql` come utente del sistema operativo `sammy`



### Di seguito i comandi che si usavano prima

The following command connects to a database under a specific user. 

```shell
psql -d database -U user
```

Se vogliamo forzare la richiesta della password dell'utente aggiungiamo l'opzione `-W`.

For example, to connect to dvdrental database under postgres user, you use the following command:

```shell
psql -d dvdrental -U postgres -W
Password for user postgres:
dvdrental=#
```

If you want to connect to a database that resides on another host, you add the `-h` option as follows:

```shell
psql -h host -d database -U user -W
```

In case you want to use SSL mode for the connection, just specify it as shown in the following command:

```shell
psql -U user -h host "dbname=db sslmode=require"
```



## Switch connection to a new database

Once you are connected to a database, you can switch the connection to a new database under a user-specified by user. The previous connection will be closed. If you omit the user parameter, the current user is assumed.

```shell
\c dbname username
```

The following command connects to sammy database under `postgres` user:

```shell
$ sudo -u postgres psql
postgres=# \c sammy
You are now connected to database "sammy" as user "postgres".
sammy=#
```



## List available databases

To list all databases in the current PostgreSQL database server, you use `\l` command.

```shell
\l
```



## List available tables
To list all tables in the current database, you use the `\dt` command.

```shell
\dt
```

> Note that this command shows the only table in the currently connected database.



## Describe a table
To describe a table such as a column, type, or modifiers of columns, you use the following command:

```shell
\d table_name
```


## List available schema

To list all schemas of the currently connected database, you use the `\dn` command.

```shell
\dn
```



## List available functions

To list available functions in the current database, you use the `\df` command.

```shell
\df
```



##  List available views
To list available views in the current database, you use the `\dv` command.

```shell
\dv
```



## List users and their roles

To list all users and their assigned roles, you use `\du` command:

```shell
\du
```


## PostgreSQL version

To retrieve the current version of PostgreSQL server, you use the version() function as follows:

```shell
SELECT version();
```



## Execute the previous command

If you want to save time typing the previous command again, you can use `\g` command to execute the previous command:

```shell
\g
```



## Command history

To display command history, you use the `\s` command.

```shell
\s
```

If you want to save the command history to a file, you need to specify the file name followed the `\s` command as follows:

```shell
\s filename
```



## Execute psql commands from a file

In case you want to execute psql commands from a file, you use `\i` command as follows:

```shell
\i filename
```



## Get help on psql commands

To know all available psql commands, you use the `\?` command.

```shell
\?
```

To get help on specific PostgreSQL statement, you use the `\h` command.

For example, if you want to know detailed information on the ALTER TABLE statement, you use the following command:

```shell
\h ALTER TABLE
```



## Turn on query execution time

To turn on query execution time, you use the `\timing` command.

```shell
sammy=# \timing
Timing is on.
sammy=# select count(*) from film;
 count
-------
  1000
(1 row)

Time: 1.495 ms
sammy=#
```

You use the same command `\timing` to turn it off.

```shell
sammy=# \timing
Timing is off.
sammy=#
```



## Switch output options

psql supports some types of output format and allows you to customize how the output is formatted on the fly.

```shell
 \a command switches from aligned to non-aligned column output.
 \H command formats the output to HTML format.
```



## Quit psql

To quit psql, you use `\q` command and press Enter to exit psql.

```shell
\q
```



## Edit command in your editor

It is very handy if you can type the command in your favorite editor. To do this in psql, you `\e` command. After issuing the command, psql will open the text editor defined by your EDITOR environment variable and place the most recent command that you entered in psql into the editor.

![fig.01](psql commands)

After you type the command in the editor, save it, and close the editor, psql will execute the command and return the result.

![fig.02](psql command example)

It is more useful when you edit a function in the editor.

```shell
\ef [function name]
```

![fig.03](psql commadn ef edit function)

