# <a name="top"></a> Cap 5.3 - Aggiungiamo un campo sulla tabella steps per il link dei video

Aggiungiamo nella tabella steps un campo per contenere il link dei vari video che carichiamo su youtube.



## Progettiamo i campi da aggiungere

Siccome vogliamo archiviare l'url del video di youtube da passare al player-video (l'id del video per la precisione), definiamo il nuovo campo da inserire nella tabella *steps*.

Colonne da aggiungere:

Colonna                   | Descrizione
------------------------- | -----------------------
`youtube_video_id:string` | (255 caratteri) The video ID will be located in the URL of the video page, right after the v= URL parameter.


![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/03_fig01-youtube_video_id.png)


![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/03_fig02-youtube_video_id.png)



## Aggiungiamo il campo del video_id

aggiungiamo il campo per il `video_id` di youtube nella tabella steps.
 
```bash
$ rails g migration AddYoutubeVideoIdToSteps youtube_video_id:string
```

vediamo il migrate generato

***code 01 - .../db/migrate/xxx_add_youtube_video_id_to_steps.rb - line:1***

```ruby
class AddYoutubeVideoIdToSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :youtube_video_id, :string
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/04_01-db-migrate-xxx_add_youtube_video_id_to_steps.rb)


eseguiamo il migrate 

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Aggiorniamo il controller

Aggiungiamo il campo alla withelist per permettere di passare il campo `youtube_video_id` su submit del form. Altrimenti non verrebbe caricato nel database.

***code 02 - .../db/controllers/steps_controller.rb - line:84***

```
    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:question, :answer, :lesson_id, :youtube_video_id, answers_attributes: [:_destroy, :id, :content])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/04_02-controllers-steps_controller.rb)



## Aggiorniamo la view

aggiungiamo il campo nel partial form della cartella steps

***code 03 - .../app/views/steps/_form.html.erb - line:1***

```
  <div class="field">
    <%= form.label :youtube_video_id %>
    <%= form.text_field :youtube_video_id %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/04_02-controllers-steps_controller.rb)

Prendiamo il video dal database

{title=".../app/views/steps/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
      videoId: '<%= @step.youtube_video_id %>',
```
