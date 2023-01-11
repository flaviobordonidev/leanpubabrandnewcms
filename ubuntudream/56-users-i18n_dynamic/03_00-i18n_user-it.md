# <a name="top"></a> Cap i18n_dynamic_database.2 - Internazionalizziamo gli utenti

Usiamo `mobility` per avere versioni in più lingue delle bio degli utenti.

(questo si avvicina all'esempio dei superheroes )
Facciamo la traduzione in italiano, portoghese ed inglese (:it, :pt, :en)

- Attiviamo anche tutti i capi bio nelle tre lingue sulla stessa view (bio_it, bio_pt, bio_en)
- Attiviamo la traduzione differenziata della parte statica "locale" con la parte dinamica "mobility_locale"
- Attiviamo un fallback
- Attiviamo il search



## Risorse interne

- []()



## Risorse esterne

- [Mobility Gem: How to store Rails translations inside a database](https://lokalise.com/blog/storing-rails-translations-in-database-with-mobility/)



## Apriamo il branch 

Continuiamo nel branch aperto nel capitolo precedente



## Usiamo mobility

Attiviamo l'internazionalizzazione sul database usando la gemma `mobility` installata precedentemente.
Indichiamo nel *model* i campi della tabella che vogliamo tradurre. 

Aggiorniamo il *model* nella sezione `# == Extensions`, sottosezione `## i18n dynamic`.

***Codice 01 - .../app/models/step.rb - linea:01***

```ruby
extend Mobility
translates :question, type: :string
translates :youtube_video_id, type: :string
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_01-models-eg_post.rb)


> Se inseriamo il nome di una colonna già presente nella tabella quello che succede è che viene bypassata.
> Se c'erano già dei valori presenti quelli restano nella tabella ma non ci accedi da Rails perché Rails passa tramite `mobility` e mette i valori nelle tabelle create da `mobility`; la tabella per i valori tradotti di tipo :string ed una tabella per i valori tradotti di tipo :text.</br>
> Praticamente lo stesso comportamento di ActiveRecord per le immagini o ActiveText che usa Trix per testo formattato RTF (rich text file).

> Personalmente credo sia più utile rimuovere dalla tabella la colonna che inseriamo in `translates`.



## Popoliamo la tabella da console

Usiamo la console di rails per popolare la tabella del database.

```bash
$ rails c

> stp = Step.first
> stp.question
> stp.question = "Domanda in italiano"
> I18n.locale
> I18n.locale = :en
> stp.question = "Question in english"
> stp.save

> I18n.locale
> Step.first.update(question: "Change in the question")
> exit
```

Esempio:

```ruby
ubuntu@ubuntufla:~/ubuntudream (lng)$rails c
Loading development environment (Rails 7.0.4) 
3.1.1 :005 > stp = Step.first
  Step Load (0.4ms)  SELECT "steps".* FROM "steps" ORDER BY "steps"."id" ASC LIMIT $1  [["LIMIT", 1]]
 =>                                                               
#<Step:0x00007f548ddbcd90                                         
...                                                               
3.1.1 :006 > stp
 => 
#<Step:0x00007f548ddbcd90                                         
 id: 1,                                                           
 question: "Quante persone ci sono?",                             
 answer: "Risposta1\nsono contento di questa risposta ^_^",       
 lesson_id: 1,                                                    
 created_at: Tue, 15 Nov 2022 21:52:49.604251000 UTC +00:00,      
 updated_at: Mon, 19 Dec 2022 01:16:36.153316000 UTC +00:00,      
 youtube_video_id: "ee1THdOuMoA">                                 
3.1.1 :007 > stp.question
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Load (0.5ms)  SELECT "mobility_string_translations".* FROM "mobility_string_translations" WHERE "mobility_string_translations"."translatable_id" = $1 AND "mobility_string_translations"."translatable_type" = $2 AND "mobility_string_translations"."key" = $3  [["translatable_id", 1], ["translatable_type", "Step"], ["key", "question"]]                                                  
 => nil                                                              
3.1.1 :009 > I18n.locale
 => :it 
3.1.1 :010 > I18n.locale = :en
 => :en 
3.1.1 :011 > stp.question
 => nil 
3.1.1 :002 > I18n.locale
 => :it 
3.1.1 :003 > stp = Step.first
  Step Load (3.3ms)  SELECT "steps".* FROM "steps" ORDER BY "steps"."id" ASC LIMIT $1  [["LIMIT", 1]]
 =>                                                                                  
#<Step:0x00007f57076cc720                                                            
...
3.1.1 :008 > stp.question = "la versione in italiano tradotta di: Quante persone ci sono?"
 => "la versione in italiano tradotta di: Quante persone ci sono?" 
3.1.1 :009 > stp.question
 => "la versione in italiano tradotta di: Quante persone ci sono?" 
3.1.1 :010 > stp
 => 
#<Step:0x00007f57076cc720                                                                                      
 id: 1,                                                                                                        
 question: "Quante persone ci sono?",                                                                          
 answer: "Risposta1\nsono contento di questa risposta ^_^",                                                    
 lesson_id: 1,                                                                                                 
 created_at: Tue, 15 Nov 2022 21:52:49.604251000 UTC +00:00,                                                   
 updated_at: Mon, 19 Dec 2022 01:16:36.153316000 UTC +00:00,                                                   
 youtube_video_id: "ee1THdOuMoA">                                                                              
3.1.1 :011 > I18n.locale = :en
 => :en 
3.1.1 :012 > stp
 => 
#<Step:0x00007f57076cc720                                                             
 id: 1,                                                                               
 question: "Quante persone ci sono?",                                                 
 answer: "Risposta1\nsono contento di questa risposta ^_^",                           
 lesson_id: 1,                                                                        
 created_at: Tue, 15 Nov 2022 21:52:49.604251000 UTC +00:00,                          
 updated_at: Mon, 19 Dec 2022 01:16:36.153316000 UTC +00:00,                          
 youtube_video_id: "ee1THdOuMoA">                                                     
3.1.1 :013 > stp.question
 => nil 
3.1.1 :014 > stp.question = "The english version of: How many persons there are?"
 => "The english version of: How many persons there are?" 
3.1.1 :015 > stp.question
 => "The english version of: How many persons there are?" 
3.1.1 :016 > stp
3.1.1 :016 > stp.save
3.1.1 :017 > exit
```

> Il primo record ha già un contenuto nella colonna "question". Ma quando lo interroghiamo interviene `mobility` e ci da `nil`. Quando mettiamo le traduzioni vediamo queste.





## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo capitolo.

***codice 04 - .../db/seeds.rb - line:1***

```ruby
puts "setting Steps data with I18n :it :en"
i18n.locale = :it
Step.new(question: "Qual è il tuo nome?").save
i18n.locale = :en
Step.last.update(question: "What is your name?")
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)


Per popolare il database con i seed si possono usare i comandi:

```bash
$ rake db:seed
o
$ rake db:setup
```

- il `rake db:seed` esegue nuovamente tutti i comandi del file *db/seeds.rb*. Quindi dobbiamo commentare tutti i comandi già eseguiti altrimenti si creano dei doppioni. Gli stessi comandi possono essere eseguiti manualmente sulla rails console e si lascia l'esecuzione del seed solo in fase di inizializzazione di tutto l'applicativo.
- il `rake db:setup` ricrea TUTTO il database e lo ripopola con *db/seeds.rb*. Quindi tutto il database è azzerato ed eventuali records presenti sono eliminati.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/authors/eg_posts

Le modifiche sono già presenti anche nel preview. Anche la modifica. Possiamo verificarlo cambiando la lingua nella barra di navigazione in alto.
Se creiamo un articolo in italiano possiamo mettere la versione inglese cambiando prima la lingua e poi sovrascriviamo la parte italiana. Questo farà sì che quando siamo in inglese vediamo l'inglese e se torniamo all'italiano lo rivediamo in italiano.


## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add i18n eg_posts seeds"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku igg:main
$ heroku run rake db:migrate
```

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

```bash
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente



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
