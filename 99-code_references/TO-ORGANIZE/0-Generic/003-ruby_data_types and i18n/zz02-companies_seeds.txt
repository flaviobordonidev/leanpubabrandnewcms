# Creiamo le tabelle delle aziende

in questo capitolo lavoreremo principalmente lato database. Creeremo la tabella aziende e metteremo i seed iniziali ed alcuni dati di prova. Non avremo nessuna interazione lato views e quindi non apriremo il browser per usare la web gui su http://localhost:3000
Eseguendo gli scaffolds la web gui è creata in automatico ma in questo capitolo non la utilizzeremo. Utilizzeremo invece la console di rails "$ rails c".




## Apriamo il branch

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b cs
~~~~~~~~




## companies - scaffold

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> uso il SINGOLARE

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g scaffold Company name:string sector:string status:integer taxation_number_first:string taxation_number_second:string memo:text
~~~~~~~~

Per il campo stauts abbiamo

- cliente
- fornitore
- cliente e fornitore
- cliente e fornitore (potenziale)
- fornitore e cliente (potenziale)
- cliente (potenziale) e fornitore (potenziale)

useremo:

http://www.austinstory.com/rails-select-tag-and-options-for-select-explained/
<%= select_tag(:status, options_for_select([['cliente', 1], ['fornitore', 2], ['cliente e fornitore', 3], ['cliente e fornitore (potenziale)', 4], ['fornitore e cliente (potenziale)', 5], ['cliente (potenziale) e fornitore (potenziale)', 6]]))%>

http://stackoverflow.com/questions/5200213/rails-3-f-select-options-for-select

Non uso una tabella status (che ha anche il plurale irregolare) con relazione 1-a-molti perché ho solo 6 records. Non uso questo:

https://www.youtube.com/watch?v=rf6B9oo1zPY 07:50
<%= f.collection_select :state_id, State.order(:name), :id, :name, include_blank: true %>

https://rubyplus.com/articles/3691-Dynamic-Select-Menus-in-Rails-5

Mi resta da risolvere il problema dell'internazionalizzazione ma lo risolvo in maniera statica con locale/en e locale/it. 

Altre informazioni che non ho messo perché possono essere raccolte nel campo memo sono:

* corporate:string

questo crea il migrate:

{title=".../db/migrate/xxx_create_companies.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :sector
      t.integer :status
      t.string :taxation_number_first
      t.string :taxation_number_second
      t.text :memo

      t.timestamps
    end
  end
end
~~~~~~~~

I> sector:string il settore merceologico dell'azienda
I>
I> Taxation_number_first in italiano è la P.IVA. In inglese è il VAT number. In Brasile è il CNPJ.
I>
I> Taxation_number_second in italiano è il Codice Fiscale. In inglese è Company Registration Number.

Effettuiamo il migrate del database per creare la tabella "companies" sul database

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rake db:migrate
~~~~~~~~


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add scaffold Company"
~~~~~~~~




## Usiamo globalize - i18n - dynamic

prima ancora di iniziare i semi mi attivo per l'internazionalizzazione sul database (i18n dynamic).

Attiviamo l'internazionalizzazione sul database usando la gemma globalize installata precedentemente.
Indichiamo sul modello i campi della tabella che vogliamo tradurre. 

{title=".../app/models/company.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class Company < ApplicationRecord

  # globalize required ---------------------------------------------------------
  translates :sector, :memo, :fallbacks_for_empty_translations => true
  #-----------------------------------------------------------------------------
end
~~~~~~~~

I> il "translates ..." dentro il model va messo prima di fare il db:migrate altrimenti ci da errore!

adesso creiamo un migration vuoto perché useremo il metodo di globalize ".create_translation_table"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration create_companies_translations
~~~~~~~~

Lavoriamo sulla migration usando il metodo .create_translation_table sul model "Company" e passando i nomi dei campi che devono avere la traduzione.

{title=".../db/migrate/xxx_create_companies_transaltions.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class CreateCompaniesTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        Company.create_translation_table!({
          sector: :string,
          memo: :text
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        Company.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rake db:migrate
~~~~~~~~

E' fondamentale cancellare dalla tabella principale "companies" i campi con traduzione, ossia "sector, status, memo".
L'opzione ** remove_source_columns: true ** ci risparmia di farlo manualmente.


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add Company I18n"
~~~~~~~~




## seed 

Di seguito mostriamo come popolare la tabella in automatico ma noi eseguiremo la procedura manuale descritta nel prossimo paragrafo.

{title=".../db/seeds.rb", lang=ruby, line-numbers=on, starting-line-number=29}
~~~~~~~~
puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC", sector: "Chemical", locale: :en).save
Company.last.update(sector: "Chimico", locale: :it)
~~~~~~~~

I> Non usiamo nè "$ rake db:seed" nè "$ rake db:setup" perché popoliamo la tabella manualmente.


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add seed companies"
~~~~~~~~






## Popoliamo manualmente la tabella

Usiamo la console di rails per popolare la tabella del database.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails c
> Company.new(name: "ABC", sector: "Chemical", locale: :en).save
> Company.last.update(sector: "Chimico", locale: :it)
~~~~~~~~


aggiungiamo una seconda persona giocando un po' con la console...

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ $ rails c
irb> Company.all
irb> c1 = Company.first
irb> c1.sector
irb> I18n.locale
irb> I18n.locale = :en
irb> c1.sector
irb> Company.new(name:"Azienda Autobus SpA", sector:"Trasportation").save
irb> c2 = Company.find 2
irb> c2.sector
irb> I18n.locale = :it

irb> c2.sector
irb> c2.sector = "Trasporti"
irb> c2.sector
irb> c2.save

irb> exit
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add seed companies"
~~~~~~~~

I> Questo git commit è solo per lasciare un commento perché le modifiche fatte sul database non sono passate tramite git.



## Publichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push heroku cs:master
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
$ git merge cs
$ git branch -d cs
~~~~~~~~




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push origin master
~~~~~~~~