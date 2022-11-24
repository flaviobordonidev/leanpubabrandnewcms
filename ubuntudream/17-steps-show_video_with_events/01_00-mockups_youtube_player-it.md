# <a name="top"></a> Cap 17.1 - Implementiamo il video

Ogni step si apre inizialmente solo con il player di un video che possiamo mettere a schermo intero. 
Alla fine del video il player scompare ed appare scritta la domanda fatta nel video ed il form per scrivere la risposta.
Su submit del form si va al secondo step con la seconda parte del video; e così via fino alla fine della lezione.

> Attenzione: <br/>
> Purtroppo sul browser Chrome, per motivi di sicurezza, il video può partire in automatico solo se è in mute.
> Fare dei test di usabilità per capire se è meglio far togliere il mute all'utente da un video che parte in automatico o se mettere il video senza mute e far premere play all'utente per far partire il video con l'audio.



## Risorse interne

- [code_references/video_players/youtube](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/video_players/01_00-youtube-it.md)
- [code_references/video_players/display_none_vs_visibility_hidden](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/video_players/02_00-display_none_vs_visibility_hidden-it.md)



## Apriamo il branch "Implementiamo il Video"

```bash
$ git checkout -b iv
```



## youtube embedded video - events

Di seguito gli eventi che si possono prendere dal player dei video su youtube.

`player.getPlayerState():Number`

Returns the state of the player. Possible values are:

- -1 – unstarted
- 0 – ended
- 1 – playing
- 2 – paused
- 3 – buffering
- 5 – video cued


`player.getCurrentTime():Number`

Returns the elapsed time in seconds since the video started playing.



## Lo scritto base dalla documentazione di Youtube del suo player 

Mettiamo il codice preso direttamente dalla documentazione di Youtube in un view di mockups.

- (YouTube Player API Reference for iframe Embeds)[https://developers.google.com/youtube/iframe_api_reference]


***code 01 - .../views/mockups/youtube_player.html.erb - line:1***

```html+erb
<!DOCTYPE html>
<html>
  <body>
    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>

    <script>
      // 2. This code loads the IFrame Player API code asynchronously.
      var tag = document.createElement('script');

      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      // 3. This function creates an <iframe> (and YouTube player)
      //    after the API code downloads.
      var player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          height: '390',
          width: '640',
          videoId: 'M7lc1UVf-VE',
          playerVars: {
            'playsinline': 1
          },
          events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
          }
        });
      }

      // 4. The API will call this function when the video player is ready.
      function onPlayerReady(event) {
        event.target.playVideo();
      }

      // 5. The API calls this function when the player's state changes.
      //    The function indicates that when playing a video (state=1),
      //    the player should play for six seconds and then stop.
      var done = false;
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING && !done) {
          setTimeout(stopVideo, 6000);
          done = true;
        }
      }
      function stopVideo() {
        player.stopVideo();
      }
    </script>
  </body>
</html>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_01-views-mockups-youtube_player.html.erb)



## Aggiungiamo nel controller

Mettiamo la chiamata a questa view specificando il layout di tipo "mockup" che è quello che ha una struttura vuota, non ha un html preimpostato.

***code 02 - .../app/controllers/mockups_controller.rb - line:1***

```ruby
  # youtube-video
  def youtube_video
    render layout: 'mockup'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_02-controllers-mockups_controller.rb)



## Aggiungiamo instradamento

Mettiamo adesso nella routes la chiamata alla view.

***code 03 - .../config/routes.rb - line:1***

```ruby
  get 'mockups/youtube_player'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_03-config-routes.rb)



## Visualizziamo preview

```bash
$ rails s -b 192.168.64.3
```

Sul browser andiamo all'url:

http://192.168.64.3:3000/mockups/youtube_player

> Se siamo sul browser google chrome non parte in automatico perché è stata implementata una misura per la privacy che prevede che i video possano partire in automatico solo se sono su mute, e quindi senza audio.

> Inoltre la prima volta dopo 6 secondi si interrompe perché su javascript è impostato `setTimeout(stopVideo, 6000);` <br/>
> La seconda volta continua senza interruzione perché su javascript è impostato `done = true;`



## Facciamo delle modifiche

Cambiamo il codice del punto 5:       

`// 5. The API calls this function when the player's state changes.`

Lo modifichiamo togliendo la parte di codice che inserisce lo stop al video solo la prima volta che viene riprodotto. Facciamo in modo che riproduca sempre il video per solo sei secondi.

Per far questo agiamo sulla variabile `done`.

Potremmo commentare il punto in cui la variabile è impostata a `true` alla riga 45.

***code n/a - .../views/mockups/youtube_player.html.erb - line:38***

```javascript
      // 5. The API calls this function when the player's state changes.
      //    The function indicates that when playing a video (state=1),
      //    the player should play for six seconds and then stop.
      var done = false;
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING && !done) {
          setTimeout(stopVideo, 6000);
          //done = true;
        }
      }
      function stopVideo() {
        player.stopVideo();
      }
```

Invece preferiamo pulire il codice togliendo la variabile ed i punti in cui è usata.

***code n/a - .../views/mockups/youtube_player.html.erb - line:41***

```javascript
      // 5. The API calls this function when the player's state changes.
      //    The function indicates that when playing a video (state=1),
      //    the player should play for six seconds and then stop.
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING) {
          setTimeout(stopVideo, 6000);
        }
      }
      function stopVideo() {
        player.stopVideo();
      }
```


Inoltre non siamo interessati ad interrompere il video dopo 6 secondi, ma ad intercettare quando il video finisce quindi modifichiamo anche questa parte di codice.

***code 04 - .../views/mockups/youtube_player.html.erb - line:38***

```javascript
      // 5. The API calls this function when the player's state changes.
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING) {
          console.log("PLAYING");
        }
        if (event.data == YT.PlayerState.PAUSED) {          
          console.log("PAUSED");
        }
        if (event.data == YT.PlayerState.ENDED) {          
          console.log("ENDED - Evviva ^_^");
        }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_04-views-mockups-youtube_player.html.erb)

Aprendo sul browser la **javascript console**, ad esempio nel menu di Chrome è su ***view/Developer/JavaScript Console***, vediamo loggate tutte le azioni di pausa, start e fine del video.



## Interagiamo con JavaScript nel DOM HTML

Adesso invece di scrivere a console quando parte o si interrompe un video inseriamo da javascript dei tags `<li></li>` all'interno di una *unordered list* `<ul></ul` che preimpostiamo.

***code 05 - .../views/mockups/youtube_player.html.erb - line:7***

```html+erb
    <ul id="player-commands-list"></ul>
```

***code 05 - ...continua - line:40***

```javascript
      // 5. The API calls this function when the player's state changes.
      function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING) {
          console.log("PLAYING");
          let pcl = document.getElementById('player-commands-list'); // mettiamo su una variabile il tag <ul id="player-commands-list"></ul>
          let li = document.createElement('li'); // creiamo un nuovo tag <li></li>
          li.textContent = 'PLAYING'; // inseriamo il valore tra il tag <li></li>
          pcl.insertBefore(li, pcl.firstElementChild); // insert a new node before the first list item
        }
        if (event.data == YT.PlayerState.PAUSED) {          
          console.log("PAUSED");
          let pcl = document.getElementById('player-commands-list'); // mettiamo su una variabile il tag <ul id="player-commands-list"></ul>
          let li = document.createElement('li'); // creiamo un nuovo tag <li></li>
          li.textContent = 'PAUSED'; // inseriamo il valore tra il tag <li></li>
          pcl.insertBefore(li, pcl.firstElementChild); // insert a new node before the first list item
        }
        if (event.data == YT.PlayerState.ENDED) {          
          console.log("ENDED - Evviva ^_^");
          let pcl = document.getElementById('player-commands-list'); // mettiamo su una variabile il tag <ul id="player-commands-list"></ul>
          let li = document.createElement('li'); // creiamo un nuovo tag <li></li>
          li.textContent = 'ENDED'; // inseriamo il valore tra il tag <li></li>
          pcl.insertBefore(li, pcl.firstElementChild); // insert a new node before the first list item
        }
      }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_05-views-mockups-youtube_player.html.erb)



## Nascondiamo il video quando termina e visualizziamo il form per la risposta

Prepariamo il form generico per la risposta

***code 06 - .../views/mockups/youtube_player.html.erb - line:25***

```html+erb
  <body>
    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>

    <%= form_tag "", method: "get", id: "test-form", class: "bottom-pad" do %>
      <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "rispondi..." %>
      <%= content_tag :button, type: "submit", class: "btn btn-primary" do %>Invia<% end %>
    <% end %>

    <ul id="player-commands-list"><li></li></ul>
```

Diamogli un po' di stile e non lo visualizziamo inizialmente `display: none;`.

***code 06 - ...continua - line:2***

```html+erb
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
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
</head> 
```

Quando finisce il video nascondiamo il player e visualizziamo il form *"test-form"*.

***code 06 - ...continua - line:83***

```javascript
        if (event.data == YT.PlayerState.ENDED) {          
          console.log("ENDED - Evviva ^_^");
          let pcl = document.getElementById('player-commands-list'); // prendiamo il tag <ul id="player-commands-list"></ul>
          let li = document.createElement('li'); // creiamo un nuovo tag <li></li>
          li.textContent = 'ENDED'; // inseriamo il valore tra il tag <li></li>
          pcl.insertBefore(li, pcl.firstElementChild); // insert a new node before the first list item
          let playerDiv = document.getElementById('player') // prendiamo il tag con id="player"
          playerDiv.style.display = "none" //Nascondiamo il player
          let formTest = document.getElementById('test-form') // prendiamo il tag con id="test-form"
          formTest.style.display = "block" //Mostriamo il form
        }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_06-views-mockups-youtube_player.html.erb)


Comando                | Descrizione
---------------------- | -------------------------
`Visibility: hidden;`  | nasconde l'elemento **ma**  the element will still take up the same space as before. The element will be hidden, but still affect the layout.
`Display: none;`       | The element will be hidden, and the page will be displayed as if the element is not there.


Abbiamo completato a livello di mockup. Ora non ci resta che implementarlo.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1


Effettuiamo il login ed inseriamo alcune risposte. Poi andiamo sulla console e verifichiamo le risposte date dall'utente loggato.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Mockup youtube_player"
```



## Publichiamo su heroku

Come fatto per il database locale di sviluppo (*bl7_development*), prima di eseguire il migrate su heroku cancelliamo tutti i records dalla tabella *answers* altrimenti riceviamo errore perché nella tabella *answers* la chiave esterna *user_id*, che serve per la relazione uno-a-molti fra *users* ed *answers*, non può essere vuota.

```bash
$ git push heroku iv:main
```

Verifichiamo preview su heroku.

Andiamo all'url:

- https://bl7-0.herokuapp.com/mockups/youtube_player



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge iv
$ git branch -d iv
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/02_00-users_answers-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/02_00-steps_youtube_player-it.md)
