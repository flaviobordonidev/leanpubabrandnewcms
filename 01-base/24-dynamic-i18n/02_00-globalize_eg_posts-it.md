# <a name="top"></a> Cap 24.2 - Internazionalizziamo gli articoli

Usiamo Globalize per avere versioni in più lingue degli articoli di esempio.



## Apriamo il branch 

Continuiamo nel branch aperto nel capitolo precedente



## Usiamo globalize

Attiviamo l'internazionalizzazione sul database usando la gemma `globalize` installata precedentemente.
Indichiamo nel *model* i campi della tabella che vogliamo tradurre. 

Aggiorniamo il *model* nella sezione `# == Attributes`, sottosezione `## globalize`.

***codice 01 - .../app/models/eg_post.rb - line:14***

```ruby
  ## globalize
  translates :meta_title, :meta_description, :headline, :incipit, :fallbacks_for_empty_translations => true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_01-models-eg_post.rb)


I> il `translates ...` dentro il model va messo **prima** di fare il `db:migrate` altrimenti ci da errore!

Adesso creiamo un *migration* vuoto perché useremo il metodo di globalize `.create_translation_table`.

```bash
$ rails g migration create_eg_post_translations
```

Lavoriamo sul *migrate* usando il metodo `.create_translation_table` inserito nel model `EgPost` e passiamo i nomi dei campi che devono avere la traduzione.

***codice 02 - .../db/migrate/xxx_create_eg_post_transaltions.rb - line:1***

```ruby
class CreateEgPostTranslations < ActiveRecord::Migration[7.0]
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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)

Eseguiamo il *migrate*.

```bash
$ sudo service postgresql start
$ rails db:migrate
```

> Attenzione!<br/>
> È fondamentale cancellare dalla tabella principale `eg_posts` i campi per cui abbiamo attivato la traduzione. Nel nostro caso dobbiamo eliminare i campi: `meta_title`, `meta_description`, `headline`, `incipit`.
>
> L'opzione `remove_source_columns: true` ci risparmia di farlo manualmente.<br/> 
> (Possiamo verificare su db/schema)



## Archiviamo su Git

```bash
$ git add -A
$ git commit -m "add i18n to EgPosts"
```


## Aggiungiamo la colonna `description` agli articoli

Siccome vogliamo avere le traduzioni per `description` allora la aggiungiamo direttamente alla tabella delle traduzioni.

> Non l'abbiamo aggiunta da subito a scopo didattico, per far vedere come aggiungere successivamente una colonna alla traduzione.

Aggiungiamo `:description` al model nella sezione `# == Attributes`, sottosezione `## globalize`.

***codice 03 - .../app/models/eg_post.rb - line:14***

```ruby
  ## globalize
  translates :meta_title, :meta_description, :headline, :incipit, :description, :fallbacks_for_empty_translations => true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)

Poi prepariamo il migrate

```bash
$ rails g migration add_description_to_eg_post_translations
```

Lavoriamo sul *migrate* usando il metodo `.add_translation_fields!` inserito nel model "EgPost" e passando i nomi dei campi che devono avere la traduzione.

***codice 04 - ..../db/migrate/xxx_add_description_to_eg_post_translations.rb - line:1***

```ruby
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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)

Eseguiamo il migrate.

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Popoliamo la tabella da console

Usiamo la console di rails per popolare la tabella del database.

~~~~~~~~bash
$ sudo service postgresql start
$ rails c

-> EgPost.all
-> I18n.locale
-> EgPost.find 1
-> I18n.locale = :en
-> EgPost.find 1
-> EgPost.find(1).update(headline: "My first post", incipit: "Why writing this first post", locale: :en)
-> EgPost.find 1
-> I18n.locale = :it
-> EgPost.find 1

-> EgPost.find(2).update(headline: "My second post", incipit: "I'm getting addicted", locale: :en)
-> EgPost.find(3).update(headline: "My third post", incipit: "Now I'm an expert", locale: :en)
-> EgPost.find(4).update(headline: "I am bob and I am authorized", incipit: "The conference one", locale: :en)
-> EgPost.find(5).update(headline: "The conference number two", incipit: "Why the clouds are forming?", locale: :en)

-> I18n.locale = :en
-> EgPost.all
-> exit
~~~~~~~~




## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo capitolo.

***codice 04 - .../db/seeds.rb - line:1***

```ruby
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
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_02-db-migrate-xxx_create_eg_post_transaltions.rb)


Per popolare il database con i seed si possono usare i comandi:

```bash
$ rake db:seed
o
$ rake db:setup
```

- il "rake db:seed" esegue nuovamente tutti i comandi del file "db/seeds.rb". Quindi dobbiamo commentare tutti i comandi già eseguiti altrimenti si creano dei doppioni. Gli stessi comandi possono essere eseguiti manualmente sulla rails console e si lascia l'esecuzione del seed solo in fase di inizializzazione di tutto l'applicativo.
- il "rake db:setup" ricrea TUTTO il database e lo ripopola con "db/seeds.rb". Quindi tutto il database è azzerato ed eventuali records presenti sono eliminati.




## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://bl7-0.herokuapp.com/authors/eg_posts

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



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge igg
$ git branch -d igg
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_00-install_i18n_globalize-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/25-nested_forms_with_stimulus/01_00-stimulus-mockup-it.md)
