# <a name="top"></a> Cap 5.3 - Aggiungiamo un campo sulla tabella steps per il link dei video

Aggiungiamo nella tabella steps un campo per contenere il link dei vari video che carichiamo su youtube.



## Progettiamo i campi da aggiungere

Siccome vogliamo archiviare l'url del video di youtube da passare al player-video (l'id del video per la precisione), definiamo il nuovo campo da inserire nella tabella *steps*.

Colonne da aggiungere:

Colonna                   | Descrizione
------------------------- | -----------------------
`youtube_video_id:string` | (255 caratteri) The video ID will be located in the URL of the video page, right after the v= URL parameter.


In questa nuova colonna della tabella inseriamo dei valori legati al video di youtube.
Ad esempio per il video *UbuntuDream1-01* usiamo il seguente *video id:* ***c35p-hPFiE4***.

Di seguito due screen-shots in cui vediamo dove prendere il "Video link" o "Video id" che ci interessa.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/03_fig01-youtube_video_id.png)


![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/03_fig02-youtube_video_id.png)



## Aggiungiamo il campo del video_id

aggiungiamo il campo per il **video_id** di youtube nella tabella steps.
 
```bash
$ rails g migration AddYoutubeVideoIdToSteps youtube_video_id:string
```

vediamo il migrate generato

***Codice 01 - .../db/migrate/xxx_add_youtube_video_id_to_steps.rb - linea:01***

```ruby
class AddYoutubeVideoIdToSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :youtube_video_id, :string
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-step-answers/03_01-db-migrate-xxx_add_youtube_video_id_to_steps.rb)


eseguiamo il migrate 

```bash
$ rails db:migrate
```



## Aggiorniamo il controller

Aggiungiamo il campo alla withelist per permettere di passare il campo `youtube_video_id` su submit del form. Altrimenti non verrebbe caricato nel database.

***Codice 02 - .../db/controllers/steps_controller.rb - linea:90***

```
    # Only allow a list of trusted parameters through.
    def step_params
      params.require(:step).permit(:question, :lesson_id, :youtube_video_id, answers_attributes: [:_destroy, :id, :content, :user_id])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-step-answers/03_02-controllers-steps_controller.rb)



## Aggiorniamo la view

Aggiungiamo il campo nel partial form della cartella steps

***Codice 03 - .../app/views/steps/_form.html.erb - linea:20***

```html+erb
  <div>
    <%= form.label :youtube_video_id, style: "display: block" %>
    <%= form.text_field :youtube_video_id %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-step-answers/03_03-views-steps-_form.html.erb)

Nel codice javascript del player youtube prendiamo il video dal database.

***Codice 04 - .../app/views/steps/show.html.erb - linea:01***

```html+erb
      videoId: '<%= @step.youtube_video_id %>',
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-step-answers/03_04-views-steps-show.html.erb)



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/mockups/youtube_player




## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add dynamic youtube video"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge vps
$ git branch -d vps
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


## Publichiamo su render.com

Fa tutto da solo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/03_00-dynamic_video-it.md)
