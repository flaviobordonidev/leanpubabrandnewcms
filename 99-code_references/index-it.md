# <a name="top"></a> Indice

Se invece di avere dei raggruppamenti fosse un elenco enorme in ordine alfabetico?
Per qualche cosa funziona ma per altre no, perché dei raggruppamenti su alcune cose aiutano.
Ad esempio per le migration è bene che stiano dentro il model?

---

Dentro Generic c'è un solo livello di cartelle. è un elenco di cartelle ma dentro ognuna di queste ci sono solo files e non altre cartelle annidate.

Dentro Controllers ci sono solo files

Dentro models c'è un solo livello di cartelle.

Dentro views c'è un solo livello di cartelle.

Dentro config c'è un solo livello di cartelle. (in realtà ce n'è una sola)

> Quindi mi sembra abbastanza ovvio che possiamo rivedere questo raggruppamento in favore di un unico lungo elenco di cartelle ad un solo livello (dentro ogni cartella sono permessi solo files. l'eccezione è una cartella OLD)


## Toglierei anche i numeri a questo primo elenco lasciandoli in ordine alfabetico.

sarà importante capire come nominare la cartella. Esempio:

- Creazione nuovo utente
- Utente - Creazione nuovo (va tolto dalle notes and Best Practice)


---

- 0-Generic
  - 000-notes-and-best_practice
  - 001-gems
  - 002-rails-console_commands
  - 003-ruby_data_types and i18n
  - 004-ruby_methods
  - 005-postgresql
  - 006-sqlite_to_pg
  - 007-yarn
  - 008-debug
  - 009-tests-user_stories
  - 010-performances
  - 011-ftp
  - 012-csv
  - 013-schedule
  - 014-ubuntu
  - 015-aws_cloud9
  - 016-git_github
  - 017-Heroku
  - 018-autoresponder-email_marketing
  - 019-Facebook-plugins
  - 020-google_maps
  - 021-Leanpub markua
  - 201-authentication_authorization_roles
  - 556-start_page
- 01-controllers
- 03-models
- 04-views
- 05-config
- 06-from-elis6