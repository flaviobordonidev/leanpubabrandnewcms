# Inseriamo il puntamento al video su youtube o vimeo

E' veramente semplice. basta indicare il percorso del video dentro un tag **<iframe ...>**




## Apriamo il branch "Insert Video"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b iv
```




## L'articolo con il video

Visualizziamo in ogni pagina posts/show gli stessi due video; uno caricato su Youtube ed uno caricato su Vimeo. Mettiamo i video tramite "iframe".

I> Attenzione "http://" non funziona con rails che vuole il più sicuro "https://"

{id="02-10-01_01", title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<p>
  <strong>Video youtube:</strong>
  <%= @post.video_youtube %>

  # Esempio con youtube
  <div class="entry-image">
  	<iframe src='https://www.youtube.com/embed/9kiLJCtjaHI?rel=0&autoplay=1' frameborder='0' allowfullscreen></iframe>
  </div>
</p>

<p>
  <strong>Video vimeo:</strong>
  <%= @post.video_vimeo %>

  # Esempio con vimeo
  <div class="entry-image">
  	<iframe src="https://player.vimeo.com/video/87701971" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
  </div>
</p>
```

[Codice 01](#02-10-01_01all)

Per YouTube il parametro "autoplay=1" il video parte in automatico; con "autoplay=0" il video parte in manuale.




## Visualizziamo i video solo se abbiamo i campi impostati

{title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<p>
  <strong>Video youtube:</strong>
  <%= @post.video_youtube %>

  <% if @post.video_youtube.present? %>
    <div class="entry-image">
    	<iframe src='https://www.youtube.com/embed/9kiLJCtjaHI?rel=0&autoplay=1' frameborder='0' allowfullscreen></iframe>
    </div>
  <% end %>
</p>

<p>
  <strong>Video vimeo:</strong>
  <%= @post.video_vimeo %>

  <% if @post.video_vimeo.present? %>
    <div class="entry-image">
    	<iframe src="https://player.vimeo.com/video/87701971" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
    </div>
  <% end %>
</p>
```




# Passiamo dinamicamente il puntamento al video su youtube o vimeo

agiorniamo il nostro articolo inserendo i seguenti puntamenti:

* per YouTube = 
* per Vimeo = 

{title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<p>
  <strong>Video youtube:</strong>
  <%= @post.video_youtube %>

  <% if @post.video_youtube.present? %>
    <div class="entry-image">
      <iframe src="https://www.youtube.com/embed/<%= @post.video_youtube %>?rel=0&autoplay='0'" frameborder='0' allowfullscreen></iframe>
    </div>
  <% end %>
</p>

<p>
  <strong>Video vimeo:</strong>
  <%= @post.video_vimeo %>

  <% if @post.video_vimeo.present? %>
    <div class="entry-image">
    	<iframe src="https://player.vimeo.com/video/<%= @post.video_vimeo %>" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
    </div>
  <% end %>
</p>
```

Per youtube potevamo anche impostare che l'autoplay si attivava da parametro sull'url ad esempio aggiungendo "<%#= params[:autoplay] || 0 %>":

```
<iframe src='https://www.youtube.com/embed/<%#= @post.video_youtube %>?rel=0&autoplay='<%#= params[:autoplay] || 0 %>' frameborder='0' allowfullscreen></iframe>
```




### Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/posts/1




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add embedded youtube and vimeo videos on posts/show"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku iv:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge iv
$ git branch -d iv
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```









## Il codice del capitolo




[Codice 01](#02-10-01_01)

{id="02-10-01_01all", title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
```
