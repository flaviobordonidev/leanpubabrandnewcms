# <a name="top"></a> Cap 9.1 - Permettiamo all'utente di scegliere un cartoon-avatar

Creiamo una cartella `cartoon_avatar` nel nostro *asset pipeline* e ci carichiamo diversi disegni di persone e permettiamo all'utente di sceglierne una da un menu a cascata.

> Non facciamo caricare l'immagine all'utente perché l'archiviazione su amazon aws S3 o su google o su altra piattaforma ha dei costi e rallenta l'applicazione. Inoltre mi è successo che aws S3 ha cambiato delle policies e mi ha fatto crashare l'app. Quindi vanno implementati controlli per gestire questi eventi ed anche soluzioni che lavorano in background come sidekick per evitare rallentamenti. Insomma è molto più complesso far caricare delle immagini e gestire tutte le problematiche legate al fatto che sono archiviate su altre piattaforme. Molto meglio caricare delle immagini fisse di avatars e permettere agli utenti di sceglierne una.



## Risorse interne

- []()



## Risorse esterne

- []()



## Apriamo il branch "Avatar Enum"

```bash
$ git checkout -b ae
```



## Progettiamo un nuovo campo per la tabela users

Per far scegliere ad ogni utente un avatar dalla cartella `cartoon_avatar` ad ogni utente inseriamo un nuovo campo enum con le possibili scelte.

> Nel db postgresql si possono implementare dei campi di tipo *enum* ma per attivare la gestione *enum* di Rails usiamo la tipologia "integer" nel db. 
> Implementeremo la gestione del campo con la tipologia *enum* direttamente nel model più avanti in questo capitolo.

Alla tabella aggiungiamo la seguente colonna:

* cartoon_avatar    -> (integer) nel nostro caso 0 = "Anna", 1 = "Bob", ...



## Aggiungiamo il nuovo campo alla tabella users

Migration add column to table users

```bash
$ rails g migration AddCartoonAvatarToUsers cartoon_avatar:integer
```

Modifichiamo il migrate aggiungendo che il *valore di default* è "0".

***codice 01 - .../db/migrate/xxx_add_cartoon_avatar_to_users.rb - line: 1***

```ruby
    add_column :users, :cartoon_avatar, :integer, default: 0
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04_01-xxxx_add_language_to_users.rb)


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```

ed otteniamo la seguente modifica alla tabella *users*.

***codice n/a - .../db/schema.rb - line: 35***

```ruby
    t.integer "cartoon_avatar", default: 0
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04_02-db-schema.rb)



## Aggiorniamo il Model implementando ENUM

FORSE ENUM NON è LA SCELTA MIGLIORE. Forse possiamo lasciare il campo integer.

***codice 02 - .../models/user.rb - line: 3***

```ruby
  enum cartoon_avatar: {ann: 0, bob: 1}
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04_03-models-user.rb)



## salviamo su git

```bash
$ git add -A
$ git commit -m "add language field to users table"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:main
$ heroku run rails db:migrate
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo.



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_00-browser_tab_title_users_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/05_00-implement_language-it.md)

