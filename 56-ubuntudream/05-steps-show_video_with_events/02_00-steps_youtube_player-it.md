# <a name="top"></a> Cap 5.2 - Inseriamo player video su steps

Portiamo il player di youtube nella view *steps*.


## Apri branch



## Portiamo video player su *step*

Mettiamo il codice dal player su *steps/show* ed il form su *steps/_step*.

***code 01 - .../app/views/steps/show.html.erb - line:1***

```html+erb

```


***code 02 - .../app/views/steps/_step.html.erb - line:1***

```html+erb

```

Inoltre mettiamo lo stile che nasconde il form inizialmente in *layouts/application*.
Questo è **temporaneo** perché layouts/application è per tutta l'applicazione e molte altre views non hanno niente a che fare con la formattazione che stiamo mettendo.

***code 03 - .../app/views/layouts/application.html.erb - line:9***

```html+erb
    <style>
    /*form-hidden*/
    #test-form {
      width: 100%;
      padding: 50px 0;
      text-align: center;
      background-color: lightblue;
      margin-top: 20px;
      display: none; /*non visualizziamo il form*/
    }
    #test-form .form-control {
      width: 90%;
      margin: 0 auto;
      margin-bottom: 10px;
      /*float: none;*/
    }
    #test-form .btn {
      width: 90%;
    }
    </style>
```











## Attiviamo un nuovo video all'avvio di una nuova pagina

Abbiamo già visto come far partire un video sfruttando il player di youtube nei capitoli precedenti.
Adesso lo usiamo partendo al caricamento della pagina ed alla fine del video mostriamo il form per rispondere alla domanda.
Per non avere sempre lo stesso video nelle varie pagine creiamo una certa dinamicità popolando la variabile *fbvalue* con tre identificativi differenti di video di youtube a seconda dello step in cui ci troviamo.

***code 01 - .../views/steps/show.html.erb - line:1***

```
<% fbvalue = "QwG30ZZFSyI" if @step.id == 1 %>
<% fbvalue = "0Nm5AvhKpQQ" if @step.id == 2 %>
<% fbvalue = "5ZKcIbWxhh0" if @step.id == 3 %>
```

***code 01 - ...continua - line:1***

```
  function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
      height: '390',
      width: '640',
      videoId: '<%= fbvalue %>',
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-step-show_video_with_events/01_02-controllers-mockups_controller.rb)



## Alla fine del video nascondiamo il video e mostriamo il form per la risposta

***code 01 - .../views/steps/show.html.erb - line:1***

```
<%= form_with(model: [@lesson, @step], local: true, id: "test-form", class: "fbhidden") do |form| %>
  <div class="field">
    <%= @step.question %>
  </div>
  <!-- Creiamo nuovo Record -->
  <%= form.fields_for :answers, Answer.new do |answer| %>
    <%= render "answer_fields", form: answer %>
  <% end %>
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

***code 01 - ...continua - line:1***

```
    if (event.data == YT.PlayerState.ENDED) {          
```

***code 01 - ...continua - line:1***

```
      let playerDiv = document.getElementById('player') // prendiamo il tag con id="player"
      playerDiv.style.display = "none" //Nascondiamo il player
      let formTest = document.getElementById('test-form') // prendiamo il tag con id="test-form"
      formTest.style.display = "block" //Mostriamo il form
    }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-step-show_video_with_events/01_02-controllers-mockups_controller.rb)


Per far partire il form nascosto abbiamo inserito questo codice nello stylesheet

/elisinfo/app/assets/stylesheets/pofo/css/style.css

```
/* ===================================
    by FLAVIO
====================================== */

/* class hidden per far iniziare nascosta */
.fbhidden {display: none;}
```

La cosa più corretta è fare uno stylesheet custom dedicato all'applicazione e non andare a modificare lo stylesheet del template.





Notiamo il comportamento differente:

* se usiamo il link in basso va avanti ma il video non si mostra (o forse non si crea)
* se usiamo il submit del form il video si crea e parte anche in automatico anche se non è in mute.
* se facciamo il refresh della pagina il video si mostra ma non parte in automatico
* se cambiamo il numero dello step direttamente nell'url si comporta come se facessimo il refresh 

A noi ci dice bene perché usiamo il submit del form per andare avanti ^_^ 




## Ultima pagina

Nell'ultima pagina non visualizziamo il form ma un link alla pagina di ringraziamento...
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
