# <a name="top"></a> Cap 3.1 - Prepariamo le lezioni

Le lezioni sono le varie aule di visualizzazione guidata. Nello specifico quelle di livello base, ossia quelle che ci preparano ai percorsi più strutturati.

In questo capitolo lavoreremo principalmente lato database. Creeremo la tabella lezioni, lessons, e metteremo i seed iniziali ed alcuni dati di prova. Non avremo nessuna interazione lato views e quindi non apriremo il browser per usare la web gui.
Eseguendo gli scaffolds la web gui è creata in automatico ma in questo capitolo non la utilizzeremo. Utilizzeremo invece la console di rails `$ rails c`.


## Risorse interne

- [99-code_references/active_records/20_00-sharks_and_posts](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/active_records/20_00-sharks_and_posts.md)



## Risorse esterne

- [How To Create Nested Resources for a Ruby on Rails Application](https://www.digitalocean.com/community/tutorials/how-to-create-nested-resources-for-a-ruby-on-rails-application)



## Apriamo il branch "Lessons Seeds"

```bash
$ git checkout -b ls
```



## Progettiamo la tabela lessons

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali:

- name:string             -> (255 caratteri) Nome esercizio / aula / lezione  (es: View of mount Vermon, The isle of the death, ...) - Questo appare nelle cards nell'index
- duration:integer        -> quanto dura l'esercizio in media. (Uso un numero intero che mi rappresenta i **minuti** di durata. es: 90 minuti, 180 minuti, ...)


Colonne secondarie:

- Categoria/Tag               -> 7. Interpretazione, Dipinto, Suoni ambiente, ...
                                (vedi gemma taggable)
- blocco (lucchetto)          -> lock_value_percorsocoach1 (livello a cui devi essere per sbloccarlo?) 
                              -> lock_value_percorsocoach2 (indipendente dal percorsocoach1 )
                               Quindi metto tante colonne quanti sono i percorsicoach (attualmente è 1 solo ^_^)
- note:text               -> (molti caratteri) Note Aggiuntive - questo appare nello show. è un approfondimento sull'esercizio
- meta_title:string       -> Per il SEO
- meta_description:string -> Per il SEO


Tabelle collegate 1-a-molti (non ho campi di chiave esterna perché saranno sull'altra tabella)

-  steps    -> una lezione è collegata a vari steps: azioni richieste (spesso sono domande a cui rispondere).


Tabelle collegate molti-a-1 (chiavi esterne)

-  tags?!?  -> vedi gemma taggable



## Impementiamo tabella lessons

Creiamo la tabella iniziale con le sole colonne principali.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Lesson name:string duration:integer
```


vediamo il migrate generato

*** code 01 - .../db/migrate/xxx_create_lessons.rb - line:1 ***

```ruby
class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :duration

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_01-db-migrate-xxx_create_lessons.rb)


Effettuiamo il migrate del database per creare la tabella sul database.

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add scaffold Lesson"
```



## Progettiamo la tabela steps

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali:

- question:string         -> (100 caratteri) Le domande per aiutarti a immaginare
- answer:text             -> (molti caratteri) Le risposte scritte dall'utente (Attenzione! più avanti si toglierà da qui e si creerà una tabella answers da associare a users perché ogni utente avrà le sue personali risposte.)


Colonne secondarie:

- nessuna


Tabelle collegate 1-a-molti (non ho campi di chiave esterna perché saranno sull'altra tabella)

-  nessuna


Tabelle collegate molti-a-1 (chiavi esterne)

-  lesson:references

La cosa bella di " user:references " è che, oltre a creare un migration "ottimizzato" per la relazione uno a molti, ci predispone parte della relazione uno-a-molti anche lato model.



## Impementiamo tabella Steps

Creiamo la tabella con i vari passi di ogni lezione.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Step question:string answer:text lesson:references
```

l'attributo `:references` imposta un'associazione tra i modelli *Lesson* e *Step*. Nello specifico, assicura che una chiave esterna che rappresenta ogni voce di lezione nella tabella del database delle lezioni venga aggiunta alla tabella del database dei passi.
(This will ensure that a foreign key representing each lesson entry in the lessons database's table is added to the steps database's table.)

vediamo il migrate generato

*** code 02 - .../db/migrate/xxx_create_steps.rb - line:1 ***

```ruby
class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :question
      t.text :answer
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_02-db-migrate-xxx_create_steps.rb)

Come puoi vedere, la tabella include una colonna per una chiave esterna di lezione (lesson foreign key). Questa chiave assumerà la forma di *[model_name]_id*. (nel nostro caso: *lesson_id*).


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Aggiungiamo la relazione uno-a-molti

Verifichiamo la relazione nel model Step, aggiungiamo i commenti e la mettiamo su "# == Relationships".

*** code 03 - .../app/models/step.rb - line:11 ***

```ruby
class Step < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-one
  belongs_to :lesson

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_03-models-step.rb)


Verifichiamo la relazione nel model Lesson, aggiungiamo i commenti e la mettiamo su "# == Relationships".

*** code 04 - .../app/models/lesson.rb - line:11 ***

```ruby
class Lesson < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-one
  has_many :steps, dependent: :destroy

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_04-models-lesson.rb)


Analizziamo il codice:

- dependent: :destroy -> questa opzione fa in modo che quando eliminiamo una lezione in automatico vengano eliminati anche tutti i suoi steps.






## seed 

Prepariamo i "semi" per un inserimento dei records in automatico.

{id: "01-08-01_01", caption: ".../db/seeds.rb -- codice 03", format: ruby, line-numbers: true, number-from: 29}
```
puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)

puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)
```

Possiamo aggiungere il seme/record alla tabella.

```bash
$ rails db:seed
```

> Nota: `$ rails db:setup` svuoterebbe tutta la tabella prima di inserire i records.

Invece, a scopo didattico, li aggiungiamo manualmente.



## Popoliamo manualmente la tabella

Usiamo la console di rails per popolare la tabella del database.


{caption: "terminal", format: bash, line-numbers: false}
```
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



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add companies Manually"
```

> Nota: Questo git commit è solo per lasciare un commento perché le modifiche fatte sul database non sono passate tramite git.



## Publichiamo su heroku

```bash
$ git push heroku cs:main
$ heroku run rake db:migrate
```

> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

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
$ git checkout main
$ git merge cs
$ git branch -d cs
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```
