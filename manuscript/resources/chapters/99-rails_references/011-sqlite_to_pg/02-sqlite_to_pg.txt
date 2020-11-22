# PostgreSQL

Attiviamo il server Postgre SQL sulla workspace di Cloud9

Creiamo il branch "pg"

{title="terminale", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b pg
~~~~~~~~




## Environment

Abbiamo installato rails 5 con i settaggi di default e questo mi imposta come database sqlite3. 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails _5.0.0.1_ new donamat
~~~~~~~~

Ma in produzione Heroku utilizza postgreSQL quindi lo installiamo anche localmente.
Possiamo gestire postgreSQL localmente nell'ambiente di sviluppo e test perché su cloud9 è già preinstallato postgreSQL e dobbiamo solo farlo partire. Un'alternativa era quella di caricare la gemma "pg" solo per l'ambiente di produzione. Ma se possibile è preferibile usare nell'ambiente di sviluppo le stesse risorse usate in produzione.
Sarebbe stato meglio usare quindi

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails new my_app_name --database=postgresql
~~~~~~~~

Possiamo comunque passare rapidamente alla configurazione per lavorare con postgreSQL. Basta sovrascreivere la gemma "sqlite" e sovrascrivere il file database.yml




## Da sqlite a postgresql

Convertiamo l'applicazione partendo dal Gemfile su Cloud9

[codice c9_postgresql: application 03](#code-c9_postgresql-application-03)

{title="DEFAULT CLOUD9 - Gemfile", lang=ruby, line-numbers=on, starting-line-number=6}
~~~~~~~~
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
~~~~~~~~

Sostituiamo le righe in alto con

[codice c9_postgresql: application 04](#code-c9_postgresql-application-04)

{title="Gemfile", lang=ruby, line-numbers=on, starting-line-number=6}
~~~~~~~~
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
~~~~~~~~

eseguiamo bundle install per installare la gemma postgres.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ bundle install
~~~~~~~~



Adesso convertiamo il file database.yml su Cloud9

[codice c9_postgresql: application config 03](#code-c9_postgresql-application-config-03)

{title="DEFAULT CLOUD9 - config/database.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
# SQLite version 3.x
...
~~~~~~~~

sostituendolo con


[codice c9_postgresql: application config 04](#code-c9_postgresql-application-config-04)

{title="config/database.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
# PostgreSQL. Versions 9.3 and up are supported.

default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see rails configuration guide
  # http://guides.rubyonrails.org/configuring.html#database-pooling
  pool: 5

development:
  <<: *default
  database: donamat_development

  # To create additional roles in postgres see `$ createuser --help`.
  # When left blank, postgres will use the default role. This is
  # the same name as the operating system user that initialized the database.
  #username: my_app_name

  # The password associated with the postgres role (username).
  #password:

test:
  <<: *default
  database: donamat_test
~~~~~~~~


Come si vede sul database.yml di postgresql diamo il nome dei database con la convenzione "nome-applicazione + _development (o _test)" 
Non creiamo il database di produzione (_production) perché la produzione la teniamo su heroku.

Adesso non ci resta che creare il database sul postgreSQL del workspace di cloud9




## PostgreSQL

PostgreSQL è preinstallato su ogni workspace di Cloud9, basta attivarlo.

I> Il "sudo sudo" su alcuni comandi non è un errore di digitazione ma è necessario su Cloud9 per evitare che il prompt ti richieda una password per l'utente ubuntu interrompendo il comando perché non viene fornita una password per l'utente ubuntu.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
~~~~~~~~


Connettiamoci al servizio postgresql e creiamo i databases

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ psql
postgres=# CREATE DATABASE "my_app_name_development";
postgres=# CREATE DATABASE "my_app_name_test";
postgres=# \list
postgres=# \q
~~~~~~~~


oppure li creiamo attraverso il comando postgreSQL "createdb"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ createdb my_app_name_development
$ createdb my_app_name_test
$ psql
postgres=# \list
postgres=# \q
~~~~~~~~

I> ATTENZIONE
I>
I> il database ha encoding: SQL_ASCII quindi non supporta caratteri accentato come invece fa UTF8
I>
I> Probabilmente è bene cambiare encoding...

verifichiamo che c'è comunicazione eseguendo


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~

Va a buon fine quindi non è necessario impostare un utente ed una password per il database. Quelle impostate in automatico di default vanno bene.


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "switch from sqlite3 to postgreSQL"
~~~~~~~~




## chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge pg
$ git branch -d pg
~~~~~~~~