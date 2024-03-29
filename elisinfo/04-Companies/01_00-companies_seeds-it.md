# <a name="top"></a> Cap 4.1 - Tabella aziende (companies)

In questo capitolo lavoreremo principalmente lato database. Creeremo la tabella aziende e metteremo i seed iniziali ed alcuni dati di prova. Non avremo nessuna interazione lato views e quindi non apriremo il browser per usare la web gui.

> Eseguendo gli scaffolds la web gui è creata in automatico ma in questo capitolo non la utilizzeremo. 

Utilizzeremo invece la console di rails "$ rails c".

Per le traduzioni:

* per le traduzioni i18n statiche usiamo i files yaml di config/locale
* per le traduzioni i18n dinamiche usiamo globalize




## Apriamo il branch "Companies Seeds"

```bash
$ git checkout -b cs
```



## Progettiamo la tabela companies

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali:

- name:string             -> (100 caratteri) Ragione Sociale 
- building:string         -> (100 caratteri) Edificio / Dipartimento
- address:string          -> (255 caratteri) Indirizzo. (Non è una nested_form perché voglio 1 solo indirizzo ogni building per scopi di usabilità. Se un edificio ha due indirizzi il secondo lo metto nel campo note)
- sector:string           -> il settore merceologico dell'azienda
- client_type:integer     -> (lista ENUM) Cliente (no, servizi, beni, beni e servizi)
- client_rate:integer     -> (numero 1..6) Cliente_punteggio (3 stelle compresi riempimenti a metà)
- supplier_type:integer   -> (lista ENUM) Fornitore (no, servizi, beni, beni e servizi)
- supplier_rate:integer   -> (numero 1..6) Fornitore_punteggio (3 stelle compresi riempimenti a metà)
- note:text               -> (molti caratteri) Note Aggiuntive
- tax_number_1:string     -> in italiano è la P.IVA. In inglese è il VAT number. In Brasile è il CNPJ.
- tax_number_2:string     -> in italiano è il Codice Fiscale. In inglese è Company Registration Number.


Colonne secondarie:

- meta_title:string       -> Per il SEO
- meta_description:string -> Per il SEO
- logo                    -> Lo implemento con activerecord file upload.


Possibili colonne che però non usiamo:

- corporate:string        -> Appartenenza ad una corporate. La metto nel campo note. In futuro sviluppo una relazione 1-a-molti tra la stessa tabella companies (self-references); questo è fatto nel model.


Tabelle nested_form:

- Telefono [nested_form]
- Email [nested_form]
- Social [nested_form]


Tabelle collegate 1-a-molti (chiavi esterne)

-  user:references
-  person:references

La cosa bella di " user:references " è che, oltre a creare un migration "ottimizzato" per la relazione uno a molti, ci predispone parte della relazione uno-a-molti anche lato model.


Per le traduzioni:

- più avanti traduciamo la parte enum con i files yaml in config/locale
- per le note interne non è necessario implementare la traduzione
- per il resto dei campi sono informazioni che restano uguali nelle varie lingue (nomi propri, numeri, indirizzi, ...)



## Impementiamo tabella companies

Creiamo la tabella iniziale con le sole colonne principali.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Company name:string building:string address:string client_type:integer client_rate:integer supplier_type:integer supplier_rate:integer note:text sector:string tax_number_1:string tax_number_2:string
```


vediamo il migrate generato

***code 01 - .../db/migrate/xxx_create_companies.rb - line:01***

```
class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :building
      t.string :address
      t.integer :client_type
      t.integer :client_rate
      t.integer :supplier_type
      t.integer :supplier_rate
      t.text :note
      t.string :sector
      t.string :tax_number_1
      t.string :tax_number_2

      t.timestamps
    end
  end
end
```

[tutto il codice](#01-08-01_01all)


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Salviamo su git

```bash
$ git add -A
$ git commit -m "add scaffold Company"
```



## Usiamo globalize - i18n - dynamic

prima ancora di iniziare i semi mi attivo per l'internazionalizzazione sul database (i18n dynamic).

Attiviamo l'internazionalizzazione sul database usando la gemma globalize che abbiamo già installato nei capitoli precedenti. (vedi: 01-base/29-dynamic-i18n/01-install_i18n_globalize)
Indichiamo sul modello i campi della tabella che vogliamo tradurre. 

***code 02 - .../app/models/company.rb - line:07***

```
  ## globalize required
  translates :building, :note, :sector, :fallbacks_for_empty_translations => true
```

[tutto il codice](#01-08-01_02all)

I> il "translates" dentro il model va messo prima di fare il db:migrate altrimenti ci da errore!

adesso creiamo un migration vuoto perché useremo il metodo di globalize ".create_translation_table"


```bash
$ rails g migration create_companies_translations
```

Lavoriamo sulla migration usando il metodo .create_translation_table sul model "Company" e passando i nomi dei campi che devono avere la traduzione.

***code 03 - .../db/migrate/xxx_create_companies_transaltions.rb - line:01***

```ruby
class CreateCompaniesTranslations < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      
      dir.up do
        Company.create_translation_table!({
          building: string,
          note: :text,
          sector: :string
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
```


```bash
$ sudo service postgresql start
$ rake db:migrate
```

E' fondamentale cancellare dalla tabella principale "companies" i campi con traduzione, ossia "sector, status, memo".
L'opzione "remove_source_columns: true" ci risparmia di farlo manualmente.



## Salviamo su git

```bash
$ git add -A
$ git commit -m "add Company I18n"
```



## seed 

Popolare la tabella in automatico con un solo record. Nel prossimo paragrafo aggiungiamo altri records manualmente.

***code n/a - .../db/seeds.rb - line:29***

```ruby
puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)
```


Aggiungiamo il seme/record alla tabella.

```bash
$ rails db:seed
```

I> Nota: "$ rails db:setup" avrebbe svuotato la tabella prima di inserire il record.



## Salviamo su git

```bash
$ git add -A
$ git commit -m "add seed companies"
```



## Popoliamo manualmente la tabella

Usiamo la console di rails per popolare la tabella del database.

```bash
$ sudo service postgresql start
$ rails c
> Company.new(name: "DEF srl", sector: "Pharmaceutical", locale: :en).save
> Company.last.update(sector: "Farmaceutico", locale: :it)

> Company.all
> c1 = Company.first
> c1.sector
> I18n.locale
> I18n.locale = :en
> c1.sector

> Company.new(name:"GHI SpA", sector:"Breweries").save
> c3 = Company.last
> c3.sector
> I18n.locale = :it
> c3.sector
> c3.sector = "Birrerie"
> c3.sector
> c3.save

> c2 = Company.find 2

> exit
```



## Salviamo su git

```bash
$ git add -A
$ git commit -m "add companies Manually"
```

I> Nota: Questo git commit è solo per lasciare un commento perché le modifiche fatte sul database non sono passate tramite git.



## Publichiamo su heroku

```bash
$ git push heroku cs:master
$ heroku run rake db:migrate
```

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

```bash
$ heroku run rails db:seed
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente


Verifichiamo preview su heroku.

Andiamo all'url:

- https://elisinfo.herokuapp.com/companies

E verifichiamo che l'elenco delle aziende è popolato.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge cs
$ git branch -d cs
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```
