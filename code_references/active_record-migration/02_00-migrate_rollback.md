# Rake db:migrate -- Rake db:rollback 



## Per eseguire tutti i migrations

Risorse sul web:
  * http://stackoverflow.com/questions/23278880/would-i-need-to-undo-a-rails-generate-scaffold-after-i-undo-a-dbmigrate


title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~




# Per tornare indietro dell'ultimo migration:

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:rollback
~~~~~~~~

per tornare indietro di tre migrations basta eseguire tre rollbacks:

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:rollback
$ rake db:rollback
$ rake db:rollback
~~~~~~~~

si possono poi cancellare gli ultimi 3 file di migrations.


Se si era usato lo scaffold

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g scaffold Company name:string sector:string status:string memo:text
~~~~~~~~

Si può effettuare l'undo dell'intero scaffold

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails destroy scaffold Company name:string sector:string status:string memo:text
~~~~~~~~

o più semplicemente

title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails destroy scaffold Company
~~~~~~~~





---
---
---
---





## Annulliamo tutto

Arrivati fin qui ci siamo accorti, un po' tardi, che GLOBALIZE NON è più manutenuto e consigliano la nuova gemma mobility. Quindi annulliamo tutta la parte di installazione fatta fino a qui con globalize.

- Lato codice sfruttiamo *git*. (Annulliamo il branch senza fare il merge)
- Lato database facciamo un *db:migrate* rimuovendo le modifiche fatte. 



## Possiamo attivare il DROP DOWN che è presente nei migrates!!!

> GROSSO ERRORE USARE DB:ROLLBACK!! mi ha fatto casino. 
>
> Meglio fare un nuovo migrate per eliminare le modifiche, mandarlo anche su heroku e poi cancellare il branch senza fare il merge lato git.

Basta eseguire il `db:rollback`. Questo comando esegue l'ultimo migrate nella direzione contraria e quindi annulla le azioni fatte dal migrate.

```bash
$ rails db:rollback
```

> Non c'è bisogno di indicare il nome del migrate perché esegue sempre l'ultimo.<br/>

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (igg)$rails db:rollback
== 20220408091740 AddContentToEgPostTranslations: reverting ===================
-- remove_column(:eg_post_translations, :content)
   -> 0.0104s
== 20220408091740 AddContentToEgPostTranslations: reverted (0.0234s) ==========

ubuntu@ubuntufla:~/bl7_0 (igg)$
```

## Verifichiamo rimozione

Se guardiamo su *db/schema.rb* vediamo che nella tabella `eg_post_translations` non c'è più la colonna `:content`.

```ruby
  create_table "eg_post_translations", force: :cascade do |t|
    t.bigint "eg_post_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "meta_title"
    t.string "meta_description"
    t.string "headline"
    t.string "incipit"
    t.index ["eg_post_id"], name: "index_eg_post_translations_on_eg_post_id"
    t.index ["locale"], name: "index_eg_post_translations_on_locale"
  end
```



## Eseguiamo secondo rollback

Siccome abbiamo fatto due migrate dobbiamo eseguire un nuovo rollback.

```bash
$ rails db:rollback
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (igg)$rails db:rollback
== 20220408090009 CreateEgPostTranslations: reverting =========================
rails aborted!
StandardError: An error has occurred, this and all later migrations canceled:

undefined method 'content' for #<EgPost::Translation id: 4, eg_post_id: 6, locale: "it", created_at: "2022-04-08 09:02:49.948592000 +0000", updated_at: "2022-04-08 09:02:49.948592000 +0000", meta_title: nil, meta_description: nil, headline: "La conferenza tre", incipit: "Il sole è una stella nana">
Did you mean?  concern
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:18:in `block (2 levels) in change'
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:17:in `block in change'

Caused by:
NoMethodError: undefined method `content' for #<EgPost::Translation id: 4, eg_post_id: 6, locale: "it", created_at: "2022-04-08 09:02:49.948592000 +0000", updated_at: "2022-04-08 09:02:49.948592000 +0000", meta_title: nil, meta_description: nil, headline: "La conferenza tre", incipit: "Il sole è una stella nana">
Did you mean?  concern
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:18:in `block (2 levels) in change'
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:17:in `block in change'
Tasks: TOP => db:rollback
(See full trace by running task with --trace)
ubuntu@ubuntufla:~/bl7_0 (igg)$
```

Prende ERRORE!

Ovvio perché abbiamo lasciato ancora presente l'ultimo migrate di cui abbiamo già fatto il rollback.

Quindi **prima** di fare il rollback dobbiamo eliminare il file di migrate di cui abbiamo già fatto il rollback. Nel nostro caso `20220408091740_add_content_to_eg_post_translations.rb`.

- Eliminiamo il file `.../db/migrate/20220408091740_add_content_to_eg_post_translations.rb`

Adesso riproviamo il rollback.


```bash
$ rails db:rollback
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (igg)$rails db:rollback
== 20220408090009 CreateEgPostTranslations: reverting =========================
rails aborted!
StandardError: An error has occurred, this and all later migrations canceled:

undefined method `content' for #<EgPost::Translation id: 4, eg_post_id: 6, locale: "it", created_at: "2022-04-08 09:02:49.948592000 +0000", updated_at: "2022-04-08 09:02:49.948592000 +0000", meta_title: nil, meta_description: nil, headline: "La conferenza tre", incipit: "Il sole è una stella nana">
Did you mean?  concern
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:18:in `block (2 levels) in change'
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:17:in `block in change'

Caused by:
NoMethodError: undefined method `content' for #<EgPost::Translation id: 4, eg_post_id: 6, locale: "it", created_at: "2022-04-08 09:02:49.948592000 +0000", updated_at: "2022-04-08 09:02:49.948592000 +0000", meta_title: nil, meta_description: nil, headline: "La conferenza tre", incipit: "Il sole è una stella nana">
Did you mean?  concern
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:18:in `block (2 levels) in change'
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:17:in `block in change'
Tasks: TOP => db:rollback
(See full trace by running task with --trace)
ubuntu@ubuntufla:~/bl7_0 (igg)$rails db:rollback
== 20220408090009 CreateEgPostTranslations: reverting =========================
rails aborted!
StandardError: An error has occurred, this and all later migrations canceled:

undefined method `update' for :meta_title:Symbol

              f.update({name.to_sym => translated_record[name.to_s]})
               ^^^^^^^
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:18:in `block (2 levels) in change'
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:17:in `block in change'

Caused by:
NoMethodError: undefined method `update' for :meta_title:Symbol

              f.update({name.to_sym => translated_record[name.to_s]})
               ^^^^^^^
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:18:in `block (2 levels) in change'
/home/ubuntu/bl7_0/db/migrate/20220408090009_create_eg_post_translations.rb:17:in `block in change'
Tasks: TOP => db:rollback
(See full trace by running task with --trace)
ubuntu@ubuntufla:~/bl7_0 (igg)$

```

Mi continua a dare errori.
(ho anche tolto :content dal model EgPost)

> Sono DELUSO da db:rollback :(

Procedo con un nuovo migrate di eliminazione della tabella delle traduzioni.




## Eliminiamo la tabella eg_post_translations

Per togliere la tabella eseguiamo il rollback ed eliminiamo il migrate?
Non è la scelta migliore perché abbiamo già pubblicato su heroku. 
Invece creiamo un nuovo migration di eliminazione della tabella.


```bash
$ rails g migration DropEgPostTranslations
```

Questo crea il migrate in basso.

***codice n/a - .../db/migrate/xxx_drop_eg_post_translations.rb - line. 1***

```ruby
class DropEgPostTranslations < ActiveRecord::Migration[7.0]
  def change
    drop_table :eg_post_translations
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_03-db-migrate-xxx_remove_role_admin_from_users.rb)


> Su *db/schema* che c'è ancora la tabella `eg_post_translations` perché non abbiamo eseguito il *db:migrate*.

Eseguiamo il migrate in modo da agire sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (igg)$rails db:migrate
== 20220408162011 DropEgPostTranslations: migrating ===========================
-- drop_table(:eg_post_translations)
   -> 0.0498s
== 20220408162011 DropEgPostTranslations: migrated (0.0503s) ==================

ubuntu@ubuntufla:~/bl7_0 (igg)$
```

> Adesso su *db/schema* che non c'è più la tabella `eg_post_translations`.



## Salviamo su git per eseguire il migrate anche in produzione su Heroku

```bash
$ git add -A
$ git commit -m "Remove table eg_post_translations"
```



## Togliamola anche dal database in produzione su Heroku

```bash
$ git push heroku igg:main
$ heroku run rails db:migrate
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (igg)$git push heroku igg:main
Enumerating objects: 22, done.
Counting objects: 100% (22/22), done.
Compressing objects: 100% (15/15), done.
Writing objects: 100% (15/15), 1.76 KiB | 903.00 KiB/s, done.
Total 15 (delta 9), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Building on the Heroku-20 stack
remote: -----> Using buildpacks:
.
.
.
remote: -----> Compressing...
remote:        Done: 234.5M
remote: -----> Launching...
remote:        Released v63
remote:        https://bl7-0.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/bl7-0.git
   489963b..a56eb82  igg -> main
ubuntu@ubuntufla:~/bl7_0 (igg)$heroku run rails db:migrate
Running rails db:migrate on ⬢ bl7-0... up, run.6020 (Free)
I, [2022-04-08T16:27:26.977062 #4]  INFO -- : Migrating to CreateEgPostTranslations (20220408090009)
== 20220408090009 CreateEgPostTranslations: migrating =========================
== 20220408090009 CreateEgPostTranslations: migrated (0.2981s) ================

I, [2022-04-08T16:27:27.287116 #4]  INFO -- : Migrating to DropEgPostTranslations (20220408162011)
== 20220408162011 DropEgPostTranslations: migrating ===========================
-- drop_table(:eg_post_translations)
   -> 0.0059s
== 20220408162011 DropEgPostTranslations: migrated (0.0060s) ==================

ubuntu@ubuntufla:~/bl7_0 (igg)$
```



## Chiudiamo il branch ed eliminiamo le modifiche

Per il database abbiamo dovuto eseguire il migrate con *remove_column* ma per il codice possiamo annullare tutte le modifiche semplicemente chiudendo il branch ed eliminandolo.

```bash
$ git checkout main
$ git branch -D igg
```

> **Non** eseguiamo `git merge` perché non vogliamo il codice usato in questo capitolo.
>
> Per eliminare il *branch* che non ha fatto il *merge* dobbiamo **forzare** l'eliminazione con `-D`.



## Togliamo il codice anche in produzione su Heroku

```bash
$ git push --force heroku main
```

> **Non** serve l'esecuzione sul database con `$ heroku run rails db:migrate`.



## Non Facciamo un backup su Github

Non dobbiamo fare nessun backup perché abbiamo annullato tutte le modifiche di questo capitolo.



## Guardiamo le colonne che Globalize ha tolto da EgPost

Sembra ci siano di nuovo! Sono sorpreso *_* ma felice ^_^!!!

***codice n/a - .../db/schema.rb - line. 1***

```ruby
  create_table "eg_posts", force: :cascade do |t|
    t.string "meta_title"
    t.string "meta_description"
    t.string "headline"
    t.string "incipit"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 19, scale: 4, default: "0.0"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.index ["user_id"], name: "index_eg_posts_on_user_id"
  end
```

Ho verificato in preview e **NON** ci sono :( mi da errore!!

Quindi riscriviamo tutto il database.

```bash
$ rails db:setup
```
> questo comando prima esegue i migrate creando le tabelle e poi esegue le query di inserimento tramite i seeds.

Ha funzionato anche se ha tolto tutti i dati inseriti manualmente.

Facciamolo anche su Heroku

```bash
$ heroku run rails db:setup
```


pg:reset
The PostgreSQL user your database is assigned doesn’t have permission to create or drop databases. To drop and recreate your database use pg:reset.

```bash
$ heroku pg:reset DATABASE
```



Ho eliminato il database da GUI interface e non riuscivo più a ricrearlo tramite CLI.

Ho poi trovato questo articolo che mi ha salvato: https://dev.to/prisma/how-to-setup-a-free-postgresql-database-on-heroku-1dc1

I passaggi per ricollegare il database sono:
- entri nell'app (nel nostro caso `bl7-0`)
- vai nel tab `Resources`
- Nel campo `Add-ons` scrivi ***Heroku Postgres*** e seleziona questo add-on
- Scegli il piano ***Hobby Dev - Free plan***
- Fatto! Adesso il database è di nuovo presente. Puoi collegarti da CLI ed eseguire `$ heroku run rake db:migrate`.

Riassumendo:
To attach a PostgreSQL database to the app you just created, you need to navigate to the Resources tab in the header of your newly created app's dahsboard. Then type Heroku Postgres into the Add-ons search field. When shown, select the suggested Heroku Postgres add-on from the dropdown.
The next popup asks you to choose a pricing plan for the database. Select the Hobby Dev - Free plan and click Provision.

---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_00-install_i18n_globalize-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/25-nested_forms_with_stimulus/01_00-stimulus-mockup-it.md)


