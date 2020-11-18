# Creiamo le tabelle delle persone

in questo capitolo lavoreremo principalmente lato database. Creeremo la tabella persone e metteremo i seed iniziali ed alcuni dati di prova. Non avremo nessuna interazione lato views e quindi non apriremo il browser per usare la web gui su http://localhost:3000
Eseguendo gli scaffolds la web gui è creata in automatico ma in questo capitolo non la utilizzeremo. Utilizzeremo invece la console di rails "$ rails c".




## Apriamo il branch "People Seeds"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b ps
~~~~~~~~




## People - scaffold

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.
Lo scaffold crea su routes la voce resources, crea il modulo, il migration, e tutte le views un controller con le 7 azioni in stile restful:

index, show, new, edit, create, update e destroy. 

I> ATTENZIONE: con "rails generate scaffold ..." -> uso il SINGOLARE

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g scaffold Person title:string first_name:string last_name:string homonym:string memo:text
~~~~~~~~

Altre informazioni che non ho messo perché possono essere raccolte nel campo memo sono:

* tax_code:string il codice fiscale della persona
* sex:string e non boolean perché oltre maschio e femmina esiste anche la possibilità transgend/transex/... Inoltre è più semplice la gestione per le varie lingue con un menu a cascata (dropdown menu).
* nationality_id:integer 
* born_date:date 
* born_city_id:integer

questo crea il migrate:

{title=".../db/migrate/xxx_create_people.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :homonym
      t.text :memo

      t.timestamps
    end
  end
end
~~~~~~~~


Effettuiamo il migrate del database per creare la tabella "people" sul database

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add scaffold Person"
~~~~~~~~




## Usiamo globalize - i18n - dynamic

prima ancora di iniziare i semi mi attivo per l'internazionalizzazione sul database (i18n dynamic).

Attiviamo l'internazionalizzazione sul database usando la gemma globalize installata precedentemente.
Indichiamo sul modello i campi della tabella che vogliamo tradurre. 

{title=".../app/models/person.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class Person < ApplicationRecord

  # globalize required ---------------------------------------------------------
  translates :title, :homonym, :memo, :fallbacks_for_empty_translations => true
  #-----------------------------------------------------------------------------
end
~~~~~~~~

I> il "translates ..." dentro il model va messo prima di fare il db:migrate altrimenti ci da errore!

adesso creiamo un migration vuoto perché useremo il metodo di globalize ".create_translation_table"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration create_people_translations
~~~~~~~~

Lavoriamo sulla migration usando il metodo .create_translation_table sul model "Person" e passando i nomi dei campi che devono avere la traduzione.

{title=".../db/migrate/xxx_create_people_transaltions.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class CreatePeopleTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        Person.create_translation_table!({
          title: :string,
          homonym: :string,
          memo: :text
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        Person.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
~~~~~~~~


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~

E' fondamentale cancellare dalla tabella principale "people" i campi con traduzione, ossia "title, homonymy, memo".
L'opzione ** remove_source_columns: true ** ci risparmia di farlo manualmente.

Altrimenti avremmo dovuto fare:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration RemoveTranslatedFieldsFromPeople title:string homonym:string memo:text
~~~~~~~~

{title="db/migrate/xxx_remove_translated_fields_from_people.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
remove_column :people, :title, :string
remove_column :people, :homonym, :string
remove_column :people, :memo, :text
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add Person I18n"
~~~~~~~~




## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo paragrafo.

{title=".../db/seeds.rb", lang=ruby, line-numbers=on, starting-line-number=25}
~~~~~~~~
puts "setting the Person data with I18n :en :it"
Person.new(title: "Mr.", first_name: "Jhon", last_name: "Doe", locale: :en).save
Person.last.update(title: "Sig.", locale: :it)
~~~~~~~~

I> Non usiamo nè "$ rake db:seed" nè "$ rake db:setup" perché popoliamo la tabella manualmente.


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add seed people"
~~~~~~~~




## Popoliamo manualmente la tabella

Usiamo la console di rails per popolare la tabella del database.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c
irb> Dossier.new(name: "2017tt100", description: "8029NTS con IRIG-B per centrali eoliche", locale: :it).save
~~~~~~~~


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add popolate people"
~~~~~~~~

I> Questo git commit è solo per lasciare un commento perché le modifiche fatte sul database non sono passate tramite git.




## Publichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push heroku ps:master
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
$ git merge ps
$ git branch -d ps
~~~~~~~~




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push origin master
~~~~~~~~