# <a name="top"></a> Cap 76.1 - Salva la risposta solo se utile per capitolo diario

In questo capitolo salviamo la risposta solo se è utile per un _capitolo del diario_.

Su UbuntuDream ci sono vari "_diari_" con vari capitoli al loro interno. Questi diari tengono traccia dell'avanzamento di introspezione che sta facendo l'utente. Molte risposte non serve che siano registrate nel database perché sono solo utili alla visualizzazione che si sta facendo; ma alcune risposte invece è bene archiviarle. Saranno poi riproposte all'interno del relativo capitolo del diario.

I diari hanno una loro tabella con loro campi ma ho un pulsante nella view del diario che mi fa una query di tutte le risposte fatte con le visualizzazioni che mi sono utili per quel capitolo/pagina del diario.
Posso leggerle e riportare il succo della mia riflessione sulla pagina del diario. Una volta usate, se voglio, posso cancellare le risposte che non mi servono più.



## Risorse interne

- [code_references/active_record-migration/06_00-add_column](/Users/FB/leanpubabrandnewcms/code_references/active_record-migration/06_00-add_column.md)
- []()



## Apriamo il branch "Save Answer If"

```bash
$ git checkout -b sai
```



## Aggiungiamo il campo "diary_chap" alla tabella *steps*

In ogni "passo" della "lezione" definiamo se l'eventuale risposta deve essere registrata e per quale capitolo del diario può servire.

Definiamo la colonna:

Colonna                 | Descrizione
| :-                    | :-
`diary_chap:integer`    | (numero intero) La risposta è salvata su db solo se "diary_chap > 0"

Codifica del numero intero:

- diario A chapters da 1 a 1000 : diary_chap = 1..1000
- diario B chapters da 1 a 1000 : diary_chap = 1001..2000
- diario C chapters da 1 a 1000 : diary_chap = 2001..3000


Aggiungiamo la colonna:

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration AddDiaryChapToSteps diary_chap:integer
```

vediamo il migrate generato

***Codice 01 - .../db/migrate/xxx_add_diary_chap_to_steps.rb - linea:3***

```ruby
    add_column :steps, :diary_chap, :integer, default: 0
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/migrate/06_01-db-migrate-xxx_add_price_to_eg_posts.rb)

> il parametro `, default: 0` lo abbiamo aggiunto manualmente.


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ rails db:migrate
```



## Aggiorniamo il controller *steps_controller*

Aggiungiamo il campo `:diary_chap` a `step_params`.

***Codice 02 - .../app/controllers/steps_controller.rb - linea:108***

```ruby
    # Only allow a list of trusted parameters through.
    def step_params
      params.require(:step).permit(:id, :question, :lesson_id, :youtube_video_id, :diary_chap, answers_attributes: [:_destroy, :id, :content, :user_id])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/migrate/06_01-db-migrate-xxx_add_price_to_eg_posts.rb)

In questo modo quando facciamo il sumbit del form sia per "create" che per "update" la voce del campo del form "diary_chap" sarà immagazzinata nel database.



## Aggiorniamo le views

Adesso aggiungiamo il campo "diary_chap" nel form.

***Codice 03 - .../views/steps/_form_.html.erb - linea:20***

```html+erb
  <div>
    <%= form.label :diary_chap, style: "display: block" %>
    <%= form.number_field :diary_chap %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_04-views-steps-show.html.erb)




***Codice 04 - .../views/steps/show.html.erb - linea:196***

```html+erb
			<p>Diary-chap: <%= @step.diary_chap %></p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_04-views-steps-show.html.erb)






## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1

E clicchiamo in edit. Adesso abbiamo anche il campo numerico "diary_chap". Se lasciamo il valore null o zero allora la risposta non sarà archiviata. Se invece mettiamo un valore maggiore di zero allora la risposta sarà archiviata nella tabella answers.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add diary_chap to table steps"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ln
$ git branch -d ln
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## Publichiamo su render.com

Lo fa in automatico prendendo gli aggiornamenti dal backup su Github.

Verifichiamo preview in produzione.

Andiamo all'url:

- https://ubuntudream.onrender.com/lessons/1/steps

E diamo le risposte ai vari steps della prima lezione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_00-steps_sequence-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/02_00-users_answers-it.md)
