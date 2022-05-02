# <a name="top"></a> Cap 3.1 - Prepariamo le lezioni

Implementiamo le lezioni/esercizi di *visualizzazione guidata* di Ubuntudream.
In questo capitolo lavoriamo principalmente lato database. Creiamo la tabella lezioni (lessons), e mettiamo i *seeds* iniziali con alcuni dati di prova. 
Non interagiamo con le views e quindi non apriamo il preview nel browser ma usiamo solo la consolle.



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

Colonne principali

Colonna                 | Descrizione
----------------------- | -----------------------
`name:string`           | (255 caratteri) Nome esercizio / aula / lezione  (es: View of mount Vermon, The isle of the death, ...) - Questo appare nelle cards nell'index
`duration:integer`      | Quanto dura l'esercizio in media. (Uso un numero intero che mi rappresenta quanti **minuti** dura. es: 90 minuti, 180 minuti, ...)



Colonne secondarie

Colonna                   | Descrizione
------------------------- | -----------------------
`Categoria/Tag`           | 7. Interpretazione, Dipinto, Suoni ambiente, ... <br/> (vedi gemma taggable)
`blocco (lucchetto)`      | -> lock_value_percorsocoach1 (livello a cui devi essere per sbloccarlo?) <br/> -> lock_value_percorsocoach2 (indipendente dal percorsocoach1 ) <br/> Quindi metto tante colonne quanti sono i percorsicoach (attualmente è 1 solo ^_^)
`note:text`               | (molti caratteri) Note Aggiuntive - questo appare nello show. è un approfondimento sull'esercizio
`meta_title:string`       | Per il SEO
`meta_description:string` | Per il SEO


Tabelle collegate 1-a-molti (non c'è *chiave esterna* perché è sull'altra tabella)

Colonna    | Descrizione
---------- | -----------------------
`steps`    | una lezione è collegata a vari steps: azioni richieste (spesso sono domande a cui rispondere).


Tabelle collegate molti-a-1 (c'è *chiave esterna*)

Colonna                   | Descrizione
------------------------- | -----------------------
`tags?!?`                 | vedi gemma taggable



## Implementiamo tabella lessons

Creiamo la tabella iniziale con le sole colonne principali.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Lesson name:string duration:integer
```


vediamo il migrate generato

***code 01 - .../db/migrate/xxx_create_lessons.rb - line:1***

```ruby
class CreateLessons < ActiveRecord::Migration[7.0]
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

Colonna                 | Descrizione
----------------------- | -----------------------
`question:string`       | (100 caratteri) Le domande per aiutarti a immaginare
`answer:text`           | (molti caratteri) Le risposte scritte dall'utente (Attenzione! più avanti si toglierà da qui e si creerà una tabella answers da associare a users perché ogni utente avrà le sue personali risposte.)


Colonne secondarie:

- nessuna


Tabelle collegate 1-a-molti (non ho campi di chiave esterna perché saranno sull'altra tabella)

-  nessuna


Tabelle collegate molti-a-1 (chiavi esterne)

Colonna                 | Descrizione
----------------------- | -----------------------
`lesson:references`     | crea la chiave esterna *lesson_id*


> `lesson:references` crea un migration "ottimizzato" perché inserisce un indice per velocizzare la ricerca sulla tabella nella relazione uno a molti. Inoltre imposta anche una parte della relazione uno-a-molti nel model.

> L'attributo `lesson:references` imposta un'associazione tra i modelli *Lesson* e *Step*. Nello specifico, assicura che una chiave esterna che rappresenta ogni voce di lezione nella tabella del database delle lezioni venga aggiunta alla tabella del database degli *steps*. (This will ensure that a foreign key representing each lesson entry in the lessons databases table is added to the steps database's table.)



## Implementiamo tabella Steps

Creiamo la tabella con i vari passi di ogni lezione.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Step question:string answer:text lesson:references
```

vediamo il migrate generato

***code 02 - .../db/migrate/xxx_create_steps.rb - line:1***

```ruby
class CreateSteps < ActiveRecord::Migration[7.0]
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


> Il migration include una colonna per una chiave esterna (foreign_key) di *lesson*. 
> Questa diventerà in tabella una colonna con nome: *[model_name]_id*. (nel nostro caso: *lesson_id*).<br/>


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```

> Su *.../db/schema.rb* nel `create_table "steps"...` abbiamo `t.bigint "lesson_id", null: false`.



## Aggiungiamo la relazione uno-a-molti

Nel model *Step*, aggiungiamo i commenti e posizioniamo la relazione su *# == Relationships*.

***code 03 - .../app/models/step.rb - line:1***

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

Nel model *Lesson*, aggiungiamo i commenti e mettiamo la relazione su "# == Relationships".

***code 04 - .../app/models/lesson.rb - line:1***

```ruby
class Lesson < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## one-to-many
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

- `dependent: :destroy` -> questa opzione fa in modo che quando eliminiamo una *lesson* in automatico vengano eliminati anche tutti i suoi *steps*.



## I semi (*seeds*)

Prepariamo i "semi" per un inserimento dei records in automatico.

***code 05 - .../db/seeds.rb - line:29***

```ruby
puts "setting the first Lesson and Steps data"
Lesson.new(name: "View of mount Vermon", duration: 90).save
Lesson.last.steps.build(name: "Domanda1").save
Lesson.last.steps.build(name: "Domanda2").save

puts "setting the second Lesson and Steps data"
Lesson.new(name: "The island of death", duration: 90).save
Lesson.last.steps.build(name: "Domanda1").save
Lesson.last.steps.build(name: "Domanda2").save
```

Nel database di sviluppo (*development*) i records li inseriamo manualmente nel prossimo paragrafo.

> Per inserire i semi il comando è `$ rails db:seed`. Questo aggiunge i nuovi records dei *seeds* a quelli attualmente presenti in tabella.

> Nota: il comando `$ rails db:setup` svuota tutta la tabella prima di inserire i records dei *seeds*.



## Popoliamo manualmente le tabella del database di sviluppo

Usiamo la console di rails per popolare la tabella del database di sviluppo (*development*).

```bash
$ sudo service postgresql start
$ rails c

> Lesson.new(name: "View of mount Vermon", duration: 90).save
> Lesson.last.steps.new(question: "Domanda1", answer: "Risposta1").save
> Lesson.last.steps.new(question: "Domanda2", answer: "Risposta2").save

> Lesson.new(name: "The island of death", duration: 90).save
> Lesson.last.steps.new(question: "Come ti chiami?", answer: "Risposta1").save
> Lesson.last.steps.new(question: "Domanda2").save

> Lesson.all
> Step.all
> Lesson.first.steps
> Lesson.second.steps

> exit
```

Potreste trovare anche l'uso di `build` al posto di `new` nel creare collections. Questo aveva senso prima di Rails 3 ma da Rails 4 in poi è superato.

Esempio con uso di `build`

```bash
> Lesson.new(name: "The island of death", duration: 90).save
> Lesson.last.steps.build(question: "Domanda1").save
> Lesson.last.steps.build(question: "Domanda2").save
```


> Il metodo `build` è disponibile grazie all'associazione `has_many` che abbiamo definito nel modello *Lesson*. Questo ci consente di creare una *collection* di oggetti *steps* associati ad una specifica istanza di *lesson*, utilizzando la chiave esterna `lesson_id` che esiste nella tabella *steps*.

> `build` and `new` are **aliases** as defined in **ActiveRecord::Relation**.
> 
> So if class Foo has_many Bars, the following have identical effects: <br/>
> `foo.bars.new` <=> `foo.bars.build` <br/>
> `Bar.where(:foo_id=>foo.id).new` <=> `Bar.where(:foo_id=>foo.id).build` <br/>
> And `if !foo.new_record?` <br/>
> `foo.bars.new` <=> `Bar.where(:foo_id=>foo.id).new`



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add scaffold Steps"
```



## Publichiamo su heroku

```bash
$ git push heroku cs:main
$ heroku run rake db:migrate
```

> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

```bash
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente

> Per popolarla attraverso i "semi" eseguiamo il comando: `$ heroku run rails db:seed`



## Verifichiamo preview su heroku.

Andiamo all'url:

- https://elisinfo.herokuapp.com/lessons
- https://elisinfo.herokuapp.com/steps

E verifichiamo che l'elenco delle *lezioni* e degli *steps* è popolato.



## Chiudiamo il branch

Lo chiudiamo nei prossimi capitoli.



## Facciamo un backup su Github

Lo facciamo nei prossimi capitoli.


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_00-lessons_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_00-nested_routes-it.md)
