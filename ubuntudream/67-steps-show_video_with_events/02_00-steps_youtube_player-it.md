# <a name="top"></a> Cap 17.2 - Inseriamo player video su steps

Portiamo il player di youtube nella view *steps*.



## Apriamo il branch "Video Player su Steps"

```bash
$ git checkout -b vps
```



## Portiamo video player su *step*

Mettiamo il codice del `mockups/youtube_player` su `steps/show` all'inizio rispetto al codice esistente.

***Codice 01 - .../app/views/steps/show.html.erb - linea:01***

```html+erb
<!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
<div id="player"></div>

<ul id="player-commands-list"></ul>

<script>
  // 2. This code loads the IFrame Player API code asynchronously.
  var tag = document.createElement('script');
```

***Codice 01 - ...continua - linea:72***

```html+erb
<p style="color: green"><%= notice %></p>

<%= render @step %>

<p>
  <strong>Answers of logged User</strong>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_01-views-steps-show.html.erb)




## Passiamo la generica `form_tag ... id: "test-form"` alla `form_with(model: [@lesson, @step])`

Nel mockup abbiamo inserito un form generico con `form_tag` e l'abbiamo richiamata dal codice javascript dello script tramite il suo id. (`id: "test-form"`).

Cancelliamo questo form generico.

***Codice n/a - .../app/views/steps/show.html.erb - linea:01***

```diff
- <%= form_tag "", method: "get", id: "test-form", class: "bottom-pad" do %>
-   <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "rispondi..." %>
-   <%= content_tag :button, type: "submit", class: "btn btn-primary" do %>Invia<% end %>
- <% end %>
```

Al suo posto attiviamo il `<%= form_with(model: [@lesson, @step]` già presente su `steps/show`.
Diamogli `id: "answer-form"` ed aggiorniamo la chiamata nello `<script>`.

***Codice 02 - .../app/views/steps/show.html.erb - linea:87***

```html+erb
<%= form_with(model: [@lesson, @step], local: true, id: "answer-form") do |form| %>
  <!-- Creiamo nuovo Record -->
  <%= form.fields_for :answers, Answer.new do |answer| %>
    <%= render "answer_fields", form: answer %>
```

***Codice 02 - ...continua - linea:61***

```html+erb
      let formTest = document.getElementById('answer-form') // prendiamo il tag con id="answer-form"
      formTest.style.display = "block" //Mostriamo il form
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_02-views-steps-show.html.erb)




## Spostiamo vari elementi sul form

Siccome su steps/show vogliamo un solo video iniziale e alla fine del video il player scompare ed appare il solo form con la domanda, che è su step, ed il form per dare la risposta.

Invece su steps/index, che sarà visibile solo all'admin, mettiamo le varie domande della lezione e tutte le risposte dell'utente ad ogni domanda.

Facciamo un po' di spostamenti e riadattamenti del codice.

***Codice 03 - .../app/views/steps/index.html.erb - linea:06***

```html+erb
  <% @steps.each do |step| %>
    <%= render step %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_02-views-steps-show.html.erb)

***Codice 04 - .../app/views/steps/_steps_html.erb - linea:10***

```html+erb
    <%= step.question %>
  </p>

  <p>
    <strong>Answers of logged User</strong>
    <ul>
      <% step.answers.where(user_id: current_user.id).each do |answer| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_02-views-steps-show.html.erb)

***Codice 05 - .../app/views/steps/show.html.erb - linea:01***

```html+erb
<p>
  <strong>Lesson:</strong>
  <%#= step.lesson_id %>
  <%= @step.lesson.name %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_02-views-steps-show.html.erb)



## Lo style per nascondere il form

Mettiamo **temporaneamente** su *layouts/application* lo stile che nasconde il form *"test-form"*.

> Questo è **temporaneo** perché *layouts/application* è per tutta l'applicazione e molte altre views non hanno niente a che fare con la formattazione che stiamo mettendo.

***Codice 06 - .../app/views/layouts/application.html.erb - linea:38***

```html+erb
    <style>
    /*form-hidden*/
    #answer-form {
      background-color: lightblue;
      display: none; /*non visualizziamo il form*/
    }
    </style>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_02-views-steps-show.html.erb)



## Secondo modo per far partire Form nascosto in partenza

***code n/a - .../views/steps/show.html.erb - line:1***

```
<%= form_with(model: [@lesson, @step], local: true, id: "test-form", class: "fbhidden") do |form| %>
```

Per far partire il form nascosto abbiamo inserito questo codice nello stylesheet

***code n/a - .../app/assets/stylesheets/pofo/css/style.css - line:1***

```
/* ===================================
    by FLAVIO
====================================== */

/* class hidden per far iniziare nascosta */
.fbhidden {display: none;}
```

La cosa più corretta è fare uno stylesheet custom dedicato all'applicazione e non andare a modificare lo stylesheet del template.



## Terzo modo per far partire Form nascosto in partenza

Possiamo mettere `style: "display: none;"` direttamente nel tag `html: {}` del form.

***code n/a - .../app/views/steps/_step.html.erb - line:3***

```html+erb
<%= form_with(model: [@lesson, @step], local: true, id: "answer-form", html: {style: "display: none;"}) do |form| %>
```



## Il codice che visualizza il Form

Il codice per visualizzare il form lo abbiamo visto nel capitolo precedente ed è nel javascript del player youtube -> nell'azione al termine del video.

***code n/a - .../app/views/steps/show.html.erb - line:79***

```javascript
							let formTest = document.getElementById('test-form') // prendiamo il tag con id="test-form"
							formTest.style.display = "block" //Mostriamo il form
```



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1

Vediamo che il player è visualizzato ed il form per la risposta non è presente.
Facciamo partire il video e alla fine del video il player scompare ed appare il form per rispondere alla domanda.

> Si presenta un *bug* causato da *turbo*. Facendo click sul link_to *next* il player resta non visibile.
> Per visualizzarlo siamo costretti a fare un refresh della pagina.

Notiamo il comportamento:

- usando il submit del form il player **non** si vede nella pagina seguente.
- usando il link_to *next* il player **non** si vede nella pagina seguente.
- usando il link_to *prev* il player **non** si vede nella pagina precedente.
- se facciamo il refresh della pagina il video si mostra ma non parte in automatico.
- se cambiamo il numero dello step direttamente nell'url si comporta come se facessimo il refresh.

Questo comportamento è dovuto a *turbo* che evita il refresh di tutta la pagina.



## Debug - forzare refresh pagina

Per evitare di dover rifare il refresh della pagina una prima soluzione *temporanea* è quella di disabilitare "turbo" e questo forza il refresh di tutta la pagina html.

Togliamo *turbo* dal submit del form.

***Codice 07 - .../views/steps/show.html.erb - linea:109***

```
<%= form_with(model: [@lesson, @step], local: true, id: "answer-form", html: {'data-turbo': "false", style: "display: none;"}) do |form| %>
```

Togliamo *turbo* dai links prev e next.

***Codice 07 - ...continua - linea:109***

```ruby
  <%= link_to '<Prev', lesson_step_path(@lesson, @step.prev.id), 'data-turbo': false if @step.prev.present? %>
  <%= @step.id %>
  <%= link_to 'Next>', lesson_step_path(@lesson, @step.next.id), 'data-turbo': false if @step.next.present? %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_04-views-steps-show.html.erb)

> per disabilitare turbo abbiamo usato `'data-turbo': "false"`. <br/>
> Potevamo usare anche `'data-turbo' => "false"` o `data: { turbo: false }`.



## Verifichiamo preview


```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1


Notiamo il comportamento differente:

- usando il link_to *next* il player si vede ma il video **non** parte in automatico.
- usando il submit del form il player si vede e il video parte in automatico anche se non è in mute.
- se facciamo il refresh della pagina il video si mostra ma non parte in automatico
- se cambiamo il numero dello step direttamente nell'url si comporta come se facessimo il refresh.





## Cambio statico di video nei primi 3 steps

Per non avere sempre lo stesso video nelle varie pagine carichiamo 3 video differenti assegnando alla variabile *yt_video_id* tre identificativi differenti di video di youtube a seconda dello step in cui ci troviamo.

***Codice 08 - .../app/views/steps/show.html.erb - linea:07***

```html+erb
<% fbvalue = "QwG30ZZFSyI" if @step.id == 1 %>
<% fbvalue = "0Nm5AvhKpQQ" if @step.id == 2 %>
<% fbvalue = "5ZKcIbWxhh0" if @step.id == 3 %>
```

> Attenzione: <br/>
> Assicurarsi che i tre steps consecutivi della *lessons/1* abbiano gli *id* riportati nel codice:<br/>
> *lessons/1/steps/1*, *lessons/1/steps/2* e *lessons/1/steps/3*.

***code 08 - ...continua - line:27***

```javascript
  function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
      height: '390',
      width: '640',
      //videoId: 'M7lc1UVf-VE',
      videoId: '<%= fbvalue %>',
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/02_08-views-steps-show.html.erb)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/03_00-dynamic_video-it.md)
