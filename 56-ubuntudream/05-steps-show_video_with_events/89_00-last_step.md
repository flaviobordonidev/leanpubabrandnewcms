



## Ultimo passo

Nell'ultimo step non visualizziamo il form ma un link alla pagina di ringraziamento...
Meglio ancora se siamo nell'ultima pagina degli step sul submit del form andiamo sulla pagina di ringraziamento in cui ti informiamo della fine dell'esercizio.
Questa pagina potrebbe essere una "landing-page" di getresponse in cui abbiamo già riempito il campo email ed il campo nome utente.
In questo caso il submit ci fa tornare all'index del nostro sito rails ma abbiamo caricato una nuova email list percui il cliente riceverà un'email di complimenti ed una successiva email che gli dice quando sarà attivo il prossimo esercizio.

Iniziamo reindirizzando alla pagina https://www.google.it/

***code 01 - .../app/controllers/steps_controller.rb - line:70***

```
          if @step.id < @lesson.steps.last.id
            redirect_to lesson_step_path(@lesson, @step.id+1), notice: 'Passo successivo'
          else
            #redirect_to lesson_steps_path(@lesson), notice: 'Fine Aula'
            redirect_to "https://www.google.it/"
          end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-step-show_video_with_events/01_02-controllers-mockups_controller.rb)


altrimenti la pagina finale è sulla ns app e mettiamo un link alla nuova pagina.

***code 01 - .../app/controllers/steps_controller.rb [alternativa] - line:70***

```
          if @step.id < @lesson.steps.last.id
            redirect_to lesson_step_path(@lesson, @step.id+1), notice: 'Passo successivo'
          else
            redirect_to lesson_steps_path(@lesson), notice: 'Fine Aula'
            #redirect_to "https://www.google.it/"
          end
```

aggiungiamo il link all'URL esterno

***code 01 - .../views/steps/show.html.erb - line:1***

```
<%= link_to 'Google', 'https://www.google.it/', :target => '_blank' %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-step-show_video_with_events/01_02-controllers-mockups_controller.rb)

Quello che funziona meglio è andare direttamente alla pagina esterna ma è fondamentale avere poi la possibilità di tornare alla nostra applicazione.
Ad esempio se invece della pagina di google andiamo su una nostra landing-page fatta ad esempio su getresponse (o sendinblue o aweber o mailerlite o altre) possiamo far lasciare l'email e sul submit avere un backlink alla nostra applicazione.
Ma questo lo implementeremo più avanti.
