# <a name="top"></a> Cap 5.2 - Inseriamo player video su steps

Portiamo il player di youtube nella view *steps*.



## Apriamo il branch "Video Player su Steps"

```bash
$ git checkout -b vps
```



## Portiamo video player su *step*

Mettiamo il codice del player su *steps/show*.

***code 01 - .../app/views/steps/show.html.erb - line:1***

```html+erb
<%= render @step %>

    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>

    <ul id="player-commands-list"></ul>

    <script>
      // 2. This code loads the IFrame Player API code asynchronously.
      var tag = document.createElement('script');
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_01-views-steps-show.html.erb)

Mettiamo l'***id "test-form"*** al `form_with` su *steps/_step*.

***code 02 - .../app/views/steps/_step.html.erb - line:1***

```html+erb
<div id="<%= dom_id step %>">
  <%= form_with(model: [@lesson, step], local: true, id: "test-form") do |form| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_02-views-steps-_step.html.erb)

Mettiamo **temporaneamente** su *layouts/application* lo stile che nasconde il form *"test-form"*.

> Questo è **temporaneo** perché *layouts/application* è per tutta l'applicazione e molte altre views non hanno niente a che fare con la formattazione che stiamo mettendo.

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_03-views-layouts-application.html.erb)


***Altro modo per far partire Form nascosto in partenza***

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



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1


Notiamo il comportamento:

- usando il link_to *next* il player **non** si vede.
- usando il submit del form il player **non** si vede.
- se facciamo il refresh della pagina il video si mostra ma non parte in automatico.
- se cambiamo il numero dello step direttamente nell'url si comporta come se facessimo il refresh.

Vediamo che il player è visualizzato ed il form per la risposta non è presente.
Facciamo partire il video e alla fine del video il player scompare ed appare il form per rispondere alla domanda.



## Aggiungiamo tre video

Per non avere sempre lo stesso video nelle varie pagine creiamo una certa dinamicità popolando la variabile *fbvalue* con tre identificativi differenti di video di youtube a seconda dello step in cui ci troviamo.

***code 04 - .../app/views/steps/show.html.erb - line:5***

```html+erb
<% fbvalue = "QwG30ZZFSyI" if @step.id == 1 %>
<% fbvalue = "0Nm5AvhKpQQ" if @step.id == 2 %>
<% fbvalue = "5ZKcIbWxhh0" if @step.id == 3 %>
```

> Attenzione: <br/>
> Assicurarsi che i tre steps consecutivi della *lessons/1* abbiano gli *id* riportati nel codice.



***code 04 - ...continua - line:25***

```javascript
  function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
      height: '390',
      width: '640',
      //videoId: 'M7lc1UVf-VE',
      videoId: '<%= fbvalue %>',
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_04-views-steps-show.html.erb)


> Si presenta un *bug* causato da *turbo*. Facendo click sul link_to *next* il player resta non visibile.
> Per visualizzarlo siamo costretti a fare un refresh della pagina.



## Debug - evitare refresh pagina

Per evitare di dover rifare il refresh della pagina una prima soluzione *temporanea* è quella di disabilitare "turbo" nel link_to specifico.

***code 05 - .../views/steps/show.html.erb - line:109***

```
  <%= link_to 'Next>', lesson_step_path(@lesson, @step.next.id), data: { turbo: false } if @step.next.present? %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_04-views-steps-show.html.erb)

> per disabilitare turbo usiamo `data: { turbo: false }`.
>
> Potevamo usare anche `'data-turbo' => "false"` o `'data-turbo': "false"`.

Lo stesso problema lo abbiamo nel submit del form con la risposta.
Anche in questo caso interveniamo in prima battuta con un workaround disattivando turbo nel submit del form

***code 06 - .../views/steps/_step.html.erb - line:2***

```
  <%= form_with(model: [@lesson, step], local: true, id: "test-form", html: {'data-turbo' => "false"}) do |form| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_04-views-steps-show.html.erb)

> per disabilitare turbo usiamo `html: {'data-turbo' => "false"}`.
>
> Potevamo usare anche `html: {data: { turbo: false }}` o `html: {'data-turbo': "false"}`.



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



## Altro modo di nascondere il form iniziale

Possiamo mettere `style: "display: none;"` direttamente nel tag del form

***code n/a - .../app/views/steps/_step.html.erb - line:3***

```html+erb
  <%= form_with(model: [@lesson, step], local: true, id: "test-form", html: {'data-turbo' => "false", style: "display: none;" }) do |form| %>
```

e poi lo togliamo tramite javascript nel codice dello youtube player al termine del video

***code n/a - .../app/views/steps/show.html.erb - line:79***

```javascript
							let formTest = document.getElementById('test-form') // prendiamo il tag con id="test-form"
							formTest.style.display = "block" //Mostriamo il form
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/03_00-dynamic_video-it.md)