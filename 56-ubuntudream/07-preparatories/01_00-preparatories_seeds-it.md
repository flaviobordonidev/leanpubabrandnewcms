# <a name="top"></a> Cap 7.1 - Lezioni propedeutiche

Sono le lezioni presenti al lato di ogni esercizio/lezione di visualizzazione.


> Forse era meglio chiamare gli esercizi di visualizzazione "exercises" invece di "lessons"...



## Risorse interne

- []()



## Il nome della tabella

Questi lezioni sono propedeutiche agli esercizi di visualizzazione.

> propedeutica: <br/>
> Serie di nozioni il cui apprendimento ha valore preparatorio per lo studio di una determinata disciplina.

In inglese la traduzione più carina è `preparatory`.
Verifichiamo il plurale nella rails console in modo da non avere sorprese.

***rails console***

```ruby
$ rails c
> "preparatory".pluralize
 => "preparatories" 
> "preparatories".singularize
 => "preparatory"
```

Esempio:

```ruby
3.1.1 :003 > "preparatory".pluralize
 => "preparatories" 
3.1.1 :004 > "preparatories".singularize
 => "preparatory" 
3.1.1 :005 > 
```

Questa tabella non ha vari step ogni "lezione propedeutica" (`preparatory`). è una tabella con tanti records ogni lezione. 

> Se cambio lingua cambia l'url del video.








## Vediamo i campi

- description?!?



## Progettiamo la tabela lessons

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali

Colonna                   | Descrizione
------------------------- | -----------------------
`name:string`             | (255 caratteri) Nome lezione propedeutica
`duration:integer`        | Quanto dura la lezione in media. (Uso un numero intero che mi rappresenta quanti **minuti** dura. es: 90 minuti, 180 minuti, ...)
`youtube_video_id:string` | (255 caratteri) The video ID will be located in the URL of the video page, right after the v= URL parameter.
`description:text`        | questa usa rich text?!? oppure descrizione breve? forse non serve perché la mettiamo direttamente nel codice visto che questa è una tabella che è popolata inizialmente ed è strettamente legata al codice.


Colonne secondarie

- nessuna


Tabelle collegate 1-a-molti (non c'è *chiave esterna* perché è sull'altra tabella)

nessuna

Tabelle collegate molti-a-1 (c'è *chiave esterna*)

Colonna                   | Descrizione
------------------------- | -----------------------
`users?!?`                |



## Implementiamo tabella preparatories

Creiamo la tabella iniziale con le sole colonne principali.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Preparatory name:string duration:integer youtube_video_id:string
```


vediamo il migrate generato

***code 01 - .../db/migrate/xxx_create_preparatories.rb - line:1***

```ruby
class CreatePreparatories < ActiveRecord::Migration[7.0]
  def change
    create_table :preparatories do |t|
      t.string :name
      t.integer :duration
      t.string :youtube_video_id

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/07-preparatories/01_01-db-migrate-xxx_create_lessons.rb)


Effettuiamo il migrate del database per creare la tabella sul database.

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## I semi (*seeds*)

Prepariamo i "semi" per un inserimento dei records in automatico.

***code 02 - .../db/seeds.rb - line:29***

```ruby
puts "setting the Preparatory lessons"
Preparatory.new(name: "La bottiglia d’acqua", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "Mettiamoci comodi", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "Nessuna interruzione", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "Leggerezza", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "Calma", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "Respirazione", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "Contrazioni muscolari", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "POSIZIONE DI VITTORIA", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "POSIZIONE DI COMANDO", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "POSIZIONE DI CONFIDENZA", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "POSIZIONE DI FORZA", duration: 10, youtube_video_id: "blabla").save
Preparatory.new(name: "POSIZIONE ZEN", duration: 10, youtube_video_id: "blabla").save
```

Nel database di sviluppo (*development*) i records li inseriamo manualmente nel prossimo paragrafo.

> Per inserire i semi il comando è `$ rails db:seed`. Questo aggiunge a tutte le tabelle del database i nuovi records dei *seeds* a quelli attualmente presenti.

> Nota: il comando `$ rails db:setup` svuota tutte le tabelle del database e poi inserisce i nuovi records dei *seeds*.



## Popoliamo manualmente le tabella del database di sviluppo

Usiamo la console di rails per popolare la tabella del database di sviluppo (*development*).

```bash
$ sudo service postgresql start
$ rails c

> Lesson.new(name: "View of mount Vermon", duration: 90).save
> Lesson.new(name: "The island of death", duration: 90).save

> exit
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add scaffold Preparatory"
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
