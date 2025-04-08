# <a name="top"></a> Cap 18.2 - Aggiungiamo colonne alla tabella lessons

Guardando le varie descrizioni presenti nel `mockups/lessons_show` realizziamo che servono altre colonne nella tabella `lessons`.



## Apriamo il branch "Update Lessons Table"

```bash
$ git checkout -b ult
```



## Rivediamo progetto tabela lessons

> Abbiamo aggiornato le colonne secondarie al capitolo [ubuntudream/15-lessons-steps/01_00-lessons_steps_seeds-it]()

vediamo la parte delle Colonne secondarie che ci interessa adesso.

Colonne secondarie

Colonna                   		| Descrizione
|:-                       		| :-
`picture_image -> model` 			| Foto del quadro (via upload ActiveStorage)
`picture_author_image -> model`	| Foto dell'autore del quadro (via upload ActiveStorage)
`picture_author_name:string` 	| Nome autore (eg: Joachim Ferdinand Richardt)
`picture_museum_name:string` 	| Nome museo (eg: Young museum)
`description_rtf -> model`		| Descrizione del corso e del quadro. (via trix di ActiveText)<br/>Questo lo introduciamo nei prossimi capitoli.

> rtf = rich text format = testo con grassetto, sottolineato, bullet points e altro.<br/>

> Tutte le volte che si potrebbe usare una colonna di tipo `:text`, eg: `description:text`, è probabile che si possa usare invece una variabile sul model di tipo ActiveText.

- Le FAQ non so se vale la pena farle come una tabella separata od un file di testo RTF (eg: `faq:text`).


## Aggiungiamo i nuovi campi alla tabella lessons

Migration add columns to table lessons

```bash
$ rails g migration AddColumnsToLessons picture_author_name:string picture_museum_name:string
```

Vediamo il migrate.

***Codice 01 - .../db/migrate/xxx_add_coluns_to_lessons.rb - linea:03***

```ruby
    add_column :lessons, :picture_author_name, :string
    add_column :lessons, :picture_museum_name, :string
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/18-style-lessons_steps/02_01-db-migrate-xxx_add_coluns_to_lessons.rb)


Effettuiamo il migrate 

```bash
$ rails db:migrate
```

ed otteniamo le seguenti modifiche alla tabella.

***Codice n/a - .../db/schema.rb - line: 35***

```ruby
  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_author_name"
    t.string "picture_museum_name"
  end
```



## Aggiorniamo il model per upload immagini via ActiveStorage

Aggiorniamo il model per upload immagini via ActiveStorage.



## Aggiorniamo controller

Inseriamo le nuove variabili nella whitelist



## Aggiorniamo views _form

Aggiungiamo i nuovi campi per le nuove variabili.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/03_00-dynamic_video-it.md)
