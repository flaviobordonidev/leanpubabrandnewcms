# <a name="top"></a> Cap 7.1 - Lezioni propedeutiche

Sono le lezioni di preparazione che vanno viste prima di fare la lezione di visualizzazione (sono propedeutiche). Una volta fatte non è necessario rifarle tutte le volte ma le lascio sempre presenti al lato di ogni lezione di visualizzazione nel caso uno voglia ripassare qualche passaggio.



## Risorse interne

- []()



## Il nome della tabella

Queste lezioni sono propedeutiche agli esercizi di visualizzazione.

> propedeutica: <br/>
> Serie di nozioni il cui apprendimento ha valore preparatorio per lo studio di una determinata disciplina.

In inglese la traduzione più carina è `preparatory`.
Verifichiamo il plurale nella ***rails console*** in modo da non avere sorprese.

```ruby
$ rails c
> "preparatory".pluralize
 => "preparatories" 
> "preparatories".singularize
 => "preparatory"
```

> A differenza della tabella `lessons` la tabella `preparatories` non ha vari step ogni record. Non ha un annidamento.

> `preparatories` è un misto tra `lessons` e `steps`. L'utente non admin interagisce con la sola view show che gli fa vedere il video, come farebbe step, ma non c'è il form finale con la domanda. Una volta finito il video torna alla pagina precedente, che è la lessons/show da cui è stato chiamato.



## Progettiamo la tabela preparatories

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali

Colonna                   | Descrizione
|:-                       |:-
`name:string`             | (255 caratteri) Nome lezione propedeutica
`duration:integer`        | Quanto dura la lezione in media. (Uso un numero intero che mi rappresenta quanti **minuti** dura. es: 90 minuti, 180 minuti, ...)
`youtube_video_id:string` | (255 caratteri) The video ID will be located in the URL of the video page, right after the v= URL parameter.


> Se cambio lingua cambia il valore di `youtube_video_id`, ossia l'url del video.
> Ma questo lo vediamo più avanti quando introduciamo l'internazionalizzazione sul database.


Colonne secondarie

Colonna                   | Descrizione
------------------------- | -----------------------
`description:text`        | questa usa rich text?!? oppure descrizione breve?

Tabelle collegate 1-a-molti (non c'è *chiave esterna* perché è sull'altra tabella)

nessuna

Tabelle collegate molti-a-1 (c'è *chiave esterna*)

nessuna



## Implementiamo tabella preparatories

Creiamo la tabella iniziale con le sole colonne principali.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Preparatory name:string duration:integer youtube_video_id:string
```


vediamo il migrate generato

***Codice 01 - .../db/migrate/xxx_create_preparatories.rb - linea:01***

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/22-preparatories/01_01-db-migrate-xxx_create_preparatories.rb)


Effettuiamo il migrate del database per creare la tabella sul database.

```bash
$ rails db:migrate
```



## I semi (*seeds*)

Prepariamo i "semi" per un inserimento dei records in automatico.

***Codice 02 - .../db/seeds.rb - linea:29***

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



## Chiudiamo il branch

Lo chiudiamo nei prossimi capitoli.



## Facciamo un backup su Github

Lo facciamo nei prossimi capitoli.



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



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_00-lessons_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_00-nested_routes-it.md)
