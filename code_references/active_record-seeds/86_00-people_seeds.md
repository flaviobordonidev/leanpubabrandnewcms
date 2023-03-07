# Creiamo le tabelle delle persone


## People - scaffold

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.
Lo scaffold crea su routes la voce resources, crea il modulo, il migration, e tutte le views un controller con le 7 azioni in stile restful: index, show, new, edit, create, update e destroy. 

> ATTENZIONE: con "rails generate scaffold ..." -> uso il SINGOLARE

```bash
$ rails g scaffold Person title:string first_name:string last_name:string homonym:string memo:text
```

questo crea il migrate:

***Codice 01 - .../db/migrate/xxx_create_people.rb - linea:1***

```ruby
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
```

Effettuiamo il migrate del database per creare la tabella "people" sul database

```bash
$ rake db:migrate
```



## seed

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo paragrafo.

***Codice n/a - .../db/seeds.rb linea:01***

```ruby
puts "setting the Person data with I18n :en :it"
i18n.locale = "it"
Person.new(title: "Mr.", first_name: "Jhon", last_name: "Doe").save
Person.last.update(title: "Sig.", locale: :it)
```

> Con `$ rake db:seed` aggiungiamo il Sig. Jhon.
