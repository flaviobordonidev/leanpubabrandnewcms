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


> il `translates ...` dentro il model va messo **prima** di fare il `db:migrate` altrimenti ci da errore!

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


## Aggiungiamo la colonna *content* agli articoli

La colonna *content* è quella che abbiamo inserito tramite *Action Text* e non la vediamo su *db/schema* perché è un campo dichiarato direttamenta nel *model* con `has_rich_text :content`.

Per attivare la traduzione anche per questa colonna basta che l'aggiungiamo direttamente alla tabella delle traduzioni.

> Non l'abbiamo aggiunta da subito a scopo didattico, per far vedere come aggiungere successivamente una colonna alla tabella delle traduzioni.

Aggiungiamo `:content` al model nella sezione `# == Attributes`, sottosezione `## globalize`.

***codice 03 - .../app/models/eg_post.rb - line:14***

```ruby
  ## globalize
  translates :meta_title, :meta_description, :headline, :incipit, :content, :fallbacks_for_empty_translations => true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_03-models-eg_post.rb)

Poi prepariamo il migrate

```bash
$ rails g migration add_content_to_eg_post_translations
```

Lavoriamo sul *migrate* usando il metodo `.add_translation_fields!` inserito nel model "EgPost" e passando i nomi dei campi che devono avere la traduzione.

***codice 04 - ..../db/migrate/xxx_add_description_to_eg_post_translations.rb - line:1***

```ruby
class AddContentToEgPostTranslations < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|

      dir.up do
        EgPost.add_translation_fields! content: :text
      end

      dir.down do
        remove_column :eg_post_translations, :content
      end
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_04-db-migrate-xxx_add_description_to_eg_post_translations.rb)

Eseguiamo il migrate.

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Popoliamo la tabella da console

Usiamo la console di rails per popolare la tabella del database.

```bash
$ sudo service postgresql start
$ rails c

-> EgPost.all
-> I18n.locale
-> EgPost.first
-> I18n.locale = :en
-> EgPost.first
-> EgPost.first.update(headline: "My first post", incipit: "Why writing this first post", locale: :en)
-> EgPost.first
-> I18n.locale = :it
-> EgPost.first

-> EgPost.find(3).update(headline: "My second post", incipit: "I'm getting addicted", locale: :en)

-> I18n.locale = :en
-> EgPost.all
-> exit
```

> Gli altri li inseriamo direttamente da interfaccia grafica.



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
