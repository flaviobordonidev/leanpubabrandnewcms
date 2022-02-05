# visualizziamo solo il tipo di contenuto selezionato nel menu a cascata

Facciamo lavorare il nostro menu a cascata. Visualizziamo nella pagina posts/show solo il tipo di contenuto selezionato nel menu a cascata.




## Apriamo il branch "Filter on Content_type"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b fct
```



## Visualizziamo in funzione di content_type

utilizziamo lo switch case..when per visualizzare solo il tipo di articolo selezionato su @post.type_of_content.

Lo switch avrà la seguente struttura:

{title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<% case @post.type_of_content %>
<% when "image" %>
  <% raise "image" %>
<% when "video_youtube" %>
  <% raise "video_youtube" %>
<% when "video_vimeo" %>
  <% raise "video_vimeo" %>
<% when "audio" %>
  <% raise "audio" %>
<% else %>
  <% raise "menu a cascata type_of_content null o con valore non consentito" %>
<% end %>
```

completiamo il tutto 

{id="02-10-02_01", title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<p>
  <% case @post.type_of_content %>
  <% when "image" %>
    <% if @post.main_image.attached? %>
      <%= image_tag @post.main_image %>
    <% else %>
      <p>Nessuna immagine presente</p>
    <% end %>
  <% when "video_youtube" %>
    <% if @post.video_youtube.present? %>
      <%= @post.video_youtube %>
      <div class="entry-image">
      	<!--<iframe src='https://www.youtube.com/embed/9kiLJCtjaHI?rel=0&autoplay=1' frameborder='0' allowfullscreen></iframe>-->
        <iframe src="https://www.youtube.com/embed/<%= @post.video_youtube %>" frameborder='0' allowfullscreen></iframe>
      </div>
    <% else %>
      <p>Nessun video YouTube presente</p>
    <% end %>
  <% when "video_vimeo" %>
    <% if @post.video_vimeo.present? %>
      <%= @post.video_vimeo %>
      <div class="entry-image">
      	<iframe src="https://player.vimeo.com/video/<%= @post.video_vimeo %>" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
      </div>
    <% else %>
      <p>Nessun video Vimeo presente</p>
    <% end %>
  <% when "audio" %>
      <p>Audio da implementare</p>
  <% else %>
    <p> raise "menu a cascata type_of_content null o con valore non consentito" </p>
  <% end %>
</p>
```

[Codice 01](#02-10-02_01all)




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
$ git commit -m "add case when to show according content_type"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku fct:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge fct
$ git branch -d fct
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#02-10-02_01)

{id="02-10-02_01all", title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
```






---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
