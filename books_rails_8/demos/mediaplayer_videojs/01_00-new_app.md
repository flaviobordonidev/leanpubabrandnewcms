# <a name="top"></a> Media Players per Rails 8

[25/05/10]
Prepariamo una nuova app con un video e successivamente ci installeremo il media-player `videojs`.



## Una selezione di scelte

Tra le varie scelte di player mi sono ristretto a due:

- [videojs](videojshttps://videojs.com) (player consolidato con molta documentazione) 
- [vidstack](https://vidstack.io/) (player nuovo molto bello ma non ho trovato tutorials con rails)
  - [plyr](https://plyr.io/) (Obsoleto. Su github scrivono: “🎉	Plyr is merging into Vidstack”)

Noi abbiamo scelto `videojs`.
Quello che mi ha convinto di più è `videojs` perché è un video/audio player consolidato con molta documentazione.



## Iniziamo creando l'app `mediaplayer_videojs`


```shell
❯ cd /Users/fb/ror
❯ rails new mediaplayer_videojs
❯ cd mediaplayer_videojs
```



## Generiamo `Article`

Generiamo un articolo con il campo in cui inserire il video che visualizzeremo con il mediaplayer `videojs`.

```shell
❯ rails g scaffold Article title content
```



## Implementiamo `ActiveStorage`

ActiveStorage ci serve per immagazinare i files video.

```shell
❯ rails active_storage:install
❯ rails db:prepare
```



## Aggiungiamo il campo `video`

Inseriamo il campo "video" nella ns tabella "articles".
Aggiungiammo nel model.

***Codice 01 - .../app/models/article.rb - linea:2***

```ruby
  has_one_attached :video
```


Permettiamo la possibilità di usarla nel controller.

***Codice 02 - .../app/controllers/articles_controller.rb - linea:66***

```ruby
    # Only allow a list of trusted parameters through.
    def article_params
      params.expect(article: [ :title, :content, :video ])
```


Aggiungiamo il campo al partial "_form".

***Codice 03 - .../app/views/articles/_form.html.erb - linea:24***

```html
  <div>
    <%= form.label :video, style: "display: block" %>
    <%= form.file_field :video %>
  </div>
```


Aggiungiamo instradamento di *root* su "routes".

***Codice 04 - .../config/routes.rb - linea:14***

```ruby
  root "articles#index"
```



## Facciamo partire il server

Invece di usare `rails s` usiamo `bin/dev` perché questo permette di far partire anche dei processi ausiliari, *"auxiliaries watcher processes"*, ad esempio nel caso di utilizzo di `esbuild` o di `tailwindcss`.

```shell
❯ bin/dev
```

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`

Creiamo un nuovo articolo e carichiamoci un video ".mp4".
Funziona ma non si vede il video.



## Facciamo vedere il video

Per visualizzare il video diamo il percorso di dov'è immagazinato in ActiveRecord al tag html `<video>`.

***Codice 05 - .../app/views/articles/show.html.erb - linea:24***

```html
<video>
  <source src="<%= rails_blob_path(@article.video) %>" />
</video>
```

- [w3schools: video tag](https://www.w3schools.com/tags/tag_video.asp)
- [developer.mozilla: video tag](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/video)

Adesso se facciamo refresh sul browser vediamo il video come se fosse un'immagine. 
Per farlo partire fare click con tasto destro e selezionare "play" dal menu che appare.



## Risorse esterne

Una risorsa importante è ChatGPT.
(Tip: Usa ChatGPT per aiutarti mentre implementi)

Sito ufficiale:
- [videojs.com](https://videojs.com/)
- [Github: videojs](https://github.com/videojs/video.js)

Tutorials:
- [Episode 17 Implementing VideoJs in Ruby on Rails](https://www.youtube.com/watch?v=SRZZuUDDbb8&t=552s)
- [How to Create a video player with video.js](https://dev.to/gabrielalao/how-to-create-a-video-player-with-videojs-43fp)
- [How can I make a video playing with video.js keep playing in the background on iOS?](https://stackoverflow.com/questions/78201786/how-can-i-make-a-video-playing-with-video-js-keep-playing-in-the-background-on-i)
- [How to Use VideoJs Player On Your Website](https://www.youtube.com/watch?v=J-Z-XvH2wiM)
- [videojs and rails](https://discuss.rubyonrails.org/t/videojs-and-rails/69043/2)



---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)

