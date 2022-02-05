{id: 01-base-29-dynamic-i18n-02-eg_posts_globalize}
# Cap 29.2 -- Internazionalizziamo gli articoli

Usiamo Globalize per avere versioni in più lingue degli articoli di esempio.




## Verifichiamo dove eravamo rimasti

{caption: "terminal", format: bash, line-numbers: false}
```
$ git log
$ git status
```




## Apriamo il branch 

continuiamo nel branch aperto nel capitolo precedente




## Usiamo globalize

Attiviamo l'internazionalizzazione sul database usando la gemma globalize installata precedentemente.
Indichiamo nel "model" i campi della tabella che vogliamo tradurre. 
Sezione "# == Attributes" sottosezione "## globalize".

{id: "01-29-02_01", caption: ".../app/models/eg_post.rb -- codice 01", format: ruby, line-numbers: true, number-from: 14}
```
  ## globalize
  translates :meta_title, :meta_description, :headline, :incipit, :fallbacks_for_empty_translations => true
```

[tutto il codice](#01-29-02_01all)


I> il "translates ..." dentro il model va messo prima di fare il "db:migrate" altrimenti ci da errore!

adesso creiamo un migration vuoto perché useremo il metodo di globalize ".create_translation_table"

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration create_eg_post_translations
```


Lavoriamo sul "migrate" usando il metodo ".create_translation_table" inserito nel model "EgPost" e passando i nomi dei campi che devono avere la traduzione.

{id: "01-29-02_02", caption: ".../db/migrate/xxx_create_eg_post_transaltions.rb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
class CreateEgPostTranslations < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      
      dir.up do
        EgPost.create_translation_table!({
          meta_title: :string,
          meta_description: :string,
          headline: :string,
          incipit: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        EgPost.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
```

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```

E' fondamentale cancellare dalla tabella principale "eg_posts" i campi per cui abbiamo attivato la traduzione.
In questo caso i campi: "meta_title, meta_description, headline, incipit".

L'opzione "remove_source_columns: true" ci risparmia di farlo manualmente. (Possiamo verificare su db/schema)


{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add i18n to EgPosts"
```




## Aggiungiamo anche la colonna "description" agli articoli

Siccome vogliamo avere le traduzioni per "description" allora la aggiungiamo direttamente alla tabella delle traduzioni.

La aggiungiamo prima al model.

{id: "01-29-02_03", caption: ".../app/models/eg_post.rb -- codice 03", format: ruby, line-numbers: true, number-from: 14}
```
  ## globalize
  translates :meta_title, :meta_description, :headline, :incipit, :description, :fallbacks_for_empty_translations => true
```

Poi prepariamo il migrate

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration add_description_to_eg_post_translations
```

Lavoriamo sul "migrate" usando il metodo ".add_translation_fields!" inserito nel model "EgPost" e passando i nomi dei campi che devono avere la traduzione.

{id: "01-29-02_04", caption: ".../db/migrate/xxx_add_description_to_eg_post_translations.rb -- codice 04", format: ruby, line-numbers: true, number-from: 1}
```
class AddDescriptionToEgPostTranslations < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|

      dir.up do
        EgPost.add_translation_fields! description: :text
      end

      dir.down do
        remove_column :eg_post_translations, :description
      end
    end
  end
end
```

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```




## Popoliamo la tabella da console

Usiamo la console di rails per popolare la tabella del database.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails c

> EgPost.all
> I18n.locale
> EgPost.find 1
> I18n.locale = :en
> EgPost.find 1
> EgPost.find(1).update(headline: "My first post", incipit: "Why writing this first post", locale: :en)
> EgPost.find 1
> I18n.locale = :it
> EgPost.find 1

> EgPost.find(2).update(headline: "My second post", incipit: "I'm getting addicted", locale: :en)
> EgPost.find(3).update(headline: "My third post", incipit: "Now I'm an expert", locale: :en)
> EgPost.find(4).update(headline: "I am bob and I am authorized", incipit: "The conference one", locale: :en)
> EgPost.find(5).update(headline: "The conference number two", incipit: "Why the clouds are forming?", locale: :en)

> I18n.locale = :en
> EgPost.all
> exit
~~~~~~~~




## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo capitolo.

{title=".../db/seeds.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "setting the Select_Relateds data with I18n :en :it"
SelectRelated.new(name: "favorites", metadata: "favorites", bln_homepage: TRUE, bln_people: TRUE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "favoriti", locale: :it)

SelectRelated.new(name: "people", metadata: "people", bln_homepage: TRUE, bln_people: FALSE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "persone", locale: :it)

SelectRelated.new(name: "companies", metadata: "companies", bln_homepage: TRUE, bln_people: TRUE, bln_companies: FALSE, locale: :en).save
SelectRelated.last.update(name: "aziende", locale: :it)

SelectRelated.new(name: "contacts", metadata: "contacts", bln_homepage: FALSE, bln_people: TRUE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "contatti", locale: :it)

SelectRelated.new(name: "addresses", metadata: "addresses", bln_homepage: FALSE, bln_people: TRUE, bln_companies: TRUE, locale: :en).save
SelectRelated.last.update(name: "indirizzi", locale: :it)
~~~~~~~~

Per popolare il database con i seed si possono usare i comandi:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:seed
o
$ rake db:setup
~~~~~~~~

* il "rake db:seed" esegue nuovamente tutti i comandi del file "db/seeds.rb". Quindi dobbiamo commentare tutti i comandi già eseguiti altrimenti si creano dei doppioni. Gli stessi comandi possono essere eseguiti manualmente sulla rails console e si lascia l'esecuzione del seed solo in fase di inizializzazione di tutto l'applicativo.
* il "rake db:setup" ricrea TUTTO il database e lo ripopola con "db/seeds.rb". Quindi tutto il database è azzerato ed eventuali records presenti sono eliminati.




## Verifichiamo preview

Le modifiche sono già presenti anche nel preview. Anche la modifica. Possiamo verificarlo cambiando la lingua nella barra di navigazione in alto.
Se creiamo un articolo in italiano possiamo mettere la versione inglese cambiando prima la lingua e poi sovrascriviamo la parte italiana. Questo farà sì che quando siamo in inglese vediamo l'inglese e se torniamo all'italiano lo rivediamo in italiano.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add i18n eg_posts seeds"
~~~~~~~~

I> Questo git commit è solo per lasciare un commento perché le modifiche fatte sul database non sono passate tramite git.







## Publichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push heroku sr:master
$ heroku run rake db:migrate
~~~~~~~~

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku run rails c
~~~~~~~~

E rieseguire i passi già fatti nel paragrafo precedentemente




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge sr
$ git branch -d sr
~~~~~~~~




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo







---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
