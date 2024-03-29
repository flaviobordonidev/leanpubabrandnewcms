# Blog - visualiziamo articolo

Iniziamo dalla pagina dell'articolo. 
rendiamo dinamica la pagina dell'articolo prendendo i dati dal database.




## Apriamo il branch "Posts Show"

continuiamo con quello aperto nel capitolo precedente





## Aggiorniamo la view posts/show - Il partial pofo_page_title_section2

Passiamo i dati della tabella al partial

{id="02-06-01_01", title=".../app/views/posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
        <%= render "pofo_page_title_section2", post: @post %>
```

[Codice 01](#02-06-01_01all)




### Immagine presa dal database

apriamo il partial e sostituiamo la chiamata dell'immagine da

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
        <!--<section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%#= image_path('pofo/parallax-bg54.jpg') %>');">-->
        <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= url_for(@post.main_image) %>');">
```


impostiamo un'immagine di default nel caso non sia caricata nessuna immagine nel database altrimenti avremmo un errore

{id="02-06-01_01", title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
        <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= post.main_image.attached? ? url_for(@post.main_image) : image_path('pofo/parallax-bg55.jpg') %>');">
```

[Codice 06](#02-06-01_01all)




### Titolo preso dal database

inseriamo il testo del titolo dal database

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
<h1 class="text-white alt-font font-weight-600 margin-10px-bottom"><%= @post.title %></h1>
```

[Codice 06](#02-06-01_01all)




### Lavoriamo la riga statica con Data, Nome Autore e Tags

la seguente riga di codice racchiude diversi campi statici da rendere dinamici 

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
                    <span class="text-white opacity6 alt-font no-margin-bottom text-uppercase text-small"><%= post.updated_at %>25 April 2017&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;by <a href="blog-masonry.html" class="text-white">Jay Benjamin</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="blog-masonry.html" class="text-white">Design</a>, <a href="blog-masonry.html" class="text-white">Branding</a></span>
```

Riscriviamo la linea di codice di span mandando a capo in modo da poter trattare lina per linea

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```

                    <span class="text-white opacity6 alt-font no-margin-bottom text-uppercase text-small">
                        <%= l @post.published_at, format: :short %>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                        by <a href="blog-masonry.html" class="text-white"><%= @post.user.name %></a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                        <a href="blog-masonry.html" class="text-white"><%= @post.tags.first %></a>, 
                        <a href="blog-masonry.html" class="text-white"><%= @post.tags.last %></a>
                    </span>
```

quindi trattiamo nei prossimi paragrafi le singole parti al suo interno 




#### Data pubblicazione presa dal database

inseriamo la data di pubblicazione dal database usando la stessa formattazione del tema pofo ossia "25 APRIL 2017"

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<%= l @post.published_at, format: :short if @post.published_at.present? %>
```

[Codice 06](#02-06-01_01all)


la variabile "@post.published_at" l'abbiamo formattata con l'helper rails per il locale (it.yml) 

{id="01-05-01_01", title=".../config/locales/it.yml", lang=yaml, line-numbers=on, starting-line-number=4}
```
  time:
    formats:
      short: "ora %d %^B %Y" 
```

[Codice 01](#01-05-01_01all)

le variabili sono le stesse di quelle di ".strftime("%d %^B %Y")" di cui questi sono i parametri più usati:

- %Y - Anno con incluso il secolo, ossia almeno con 4 cifre. Può essere anche negativo. Es: -0001, 0000, 1995, 2009, 14292, etc.
- %y - Anno senza il secolo, ossia con solo 2 cifre. Es: 00..99

- %m  - Mese,  zero-padded (01..12).            Es: gennaio è rappresentato con "01"
- %B  - Mese, con nome pieno.                   Es: gennaio è rappresentato con "January"
- %^B - Mese, con nome pieno in maiuscolo.      Es: gennaio è rappresentato con "JANUARY"
- %b  - Mese, con nome abbreviato.              Es: gennaio è rappresentato con "Jan"
- %^b - Mese, con nome abbreviato in maiuscolo. Es: gennaio è rappresentato con "JAN"

- %d  - Giorno del mese,   zero-padded (01..31). Es: il primo di gennaio è rappresentato con "01"
- %j  - Giorno dell'anno (001..366)
- %A  - Giorno della settimana nome pieno.                        Es: domenica è rappresentata con "Sunday"
- %a  - Giorno della settimana abbreviato.                        Es: domenica è rappresentata con "Sun"
- %w  - Giorno della settimana in numero (0..6) con Sunday is 0.  Es: domenica è rappresentata con "0"

- %H - Hour of the day, 24-hour clock, zero-padded (00..23)
- %M - Minute of the hour (00..59)
- %S - Second of the minute (00..59)

Per approfondimenti vedi 01-beginning/03-mockups/03-format_date_time e 01-beginning/05-mockups_i18n/05-format_date_time_i18n

Inoltre abbiamo messo la condizione " if @post.published_at.present? " per evitare errore nel caso non sia presente nessun valore.




#### Autore preso dal database

Sostituiamo la parte statica " <a href="blog-masonry.html" class="text-white">Jay Benjamin</a> " con la parte dinamica " <a href="blog-masonry.html" class="text-white"><%= @post.user.name %></a> ".

Successivamente implementiamo il " link_to " di rails:

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<%= link_to "@post.user.name" author_account_path, class: "text-white" %>
```




#### Tags presi dal database

Per i tags dobbiamo implementare un ciclo. (per approfondimenti vedi 02-cms_base/11-acts-as-taggable/02-tag_links)

Iniziamo prendento il primo e l'ultimo:

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<a href="blog-masonry.html" class="text-white"><%= @post.tags.first %></a>, 
<a href="blog-masonry.html" class="text-white"><%= @post.tags.last %></a>
```


Adesso implementiamo il ciclo per i tags senza i links 

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<% post.tags.each do |tag| %>
  <%= tag == post.tags.last ? "#{tag.name}" : "#{tag.name}," %>
<% end %>
```


Adesso implementiamo il ciclo per i tags con i links con in HTML (<a></a>)

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<% @post.tags.each do |tag| %>
  <%#= tag == @post.tags.last ? "#{tag.name}" : "#{tag.name}," %>
  <%= tag == @post.tags.last ? sanitize("<a href='blog-masonry.html' class='text-white'>#{tag.name}</a>") : sanitize("<a href='blog-masonry.html' class='text-white'>#{tag.name}</a>,") %>
<% end %>
```


Adesso implementiamo il ciclo per i tags con i links in Rails (link_to)

{title=".../app/views/posts/_pofo_page_title_section2.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<% post.tags.each do |tag| %>
  <%= tag == post.tags.last ? link_to("#{tag.name}", root_path, class: 'text-white') : link_to("#{tag.name},", root_path, class: 'text-white') %>
<% end %>
```




## Aggiorniamo la view posts/show - Il partial pofo_blog_content_section

Questa sezione è quella che nel precedente capitolo abbiamo chiamato " central_paraghraph ".
Per il nome del partial abbiamo lasciato l'indicazione degli sviluppatori del tema Pofo.

{title=".../app/views/posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
        <%= render "pofo_blog_content_section", post: @post %>
```




## Il partial pofo_blog_content_section

Sostituiamo il testo statico con il valore dei campi della tabella posts. Per i campi su cui è installato Trix utiliziamo il "sanitize".

{id="02-06-01_01", title=".../app/views/posts/pofo_blog_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
```
<!-- start blog content section -->
<section class="wow fadeIn">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12 last-paragraph-no-margin xs-text-center">
                <h5 class="font-weight-600 text-extra-dark-gray alt-font"><%= post.paraghraph_title1 %></h5>
                <p><%= post.paragraph_content1 %></p>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <%#= image_tag "pofo/blog-details-img7.jpg", alt: "", class: "width-100 margin-50px-tb" %>
                <%= post.paragraph_image1.attached? ? image_tag(@post.paragraph_image1, alt: "", class: "width-100 margin-50px-tb") : image_tag('pofo/blog-details-img7.jpg', alt: "", class: "width-100 margin-50px-tb") %>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12 xs-text-center">
                <div class="col-md-6 col-sm-12 col-xs-12 no-padding-left last-paragraph-no-margin sm-margin-30px-bottom xs-no-padding-lr">
                    <span class="text-extra-dark-gray font-weight-600 alt-font margin-10px-bottom display-block text-medium"><%= post.paragraph_title2 %></span>
                    <p class="width-90 xs-width-100"><%= sanitize post.paragraph_content2 %></p>
                </div>
                <div class="col-md-6 col-sm-12 col-xs-12 no-padding-left last-paragraph-no-margin xs-no-padding-lr">
                    <span class="text-extra-dark-gray font-weight-600 alt-font margin-10px-bottom display-block text-medium"><%= post.paragraph_title3 %></span>
                    <p class="width-90 xs-width-100"><%= sanitize post.paragraph_content3 %></p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end blog content section -->
```

[Codice 03](#02-06-01_01all)




## Aggiorniamo la view posts/show - Il partial pofo_parallax_section

Questa sezione è quella che nel precedente capitolo abbiamo chiamato " parallax_paraghraph ".

{title=".../app/views/posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=82}
```
        <%= render "pofo_parallax_section", post: @post %>
```




## Il partial pofo_parallax_section

Sostituiamo il testo statico con il valore dei campi della tabella posts. Per i campi su cui è installato Trix utiliziamo il "sanitize".

{id="02-06-01_01", title=".../app/views/posts/pofo_parallax_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
<section class="wow fadeIn parallax big-section" data-stellar-background-ratio="0.4" style="background-image: url('<%= post.paragraph_image4.attached? ? url_for(@post.paragraph_image4) : image_path('pofo/parallax-bg55.jpg') %>')">
```

{title=".../app/views/posts/pofo_parallax_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=9}
```
                    <h5 class="font-weight-600 alt-font text-extra-dark-gray"><%= post.paragraph_title4 %></h5>
                    <p><%= sanitize post.paragraph_content4 %></p>
```

[Codice 04](#02-06-01_01all)




## Aggiorniamo la view posts/show - Il partial pofo_post_section

Questa sezione è quella ...

{title=".../app/views/posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=82}
```
        <%= render "pofo_post_section", post: @post %>
```




## Il partial pofo_post_section

Sostituiamo immagine.

{id="02-06-01_01", title=".../app/views/posts/_pofo_post_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
        <figure class="wp-caption alignright">
          <%= post.paragraph_image5.attached? ? image_tag(@post.paragraph_image5, alt: "") : image_tag('pofo/blog-details-img10.jpg', alt: "") %><figcaption class="wp-caption-text"><%= post.paragraph_image_label5 %></figcaption>
        </figure>
```

[Codice 05](#02-06-01_01all)




## Aggiorniamo la view posts/show - Il partial pofo_post_author_section

Questa sezione è quella dedicata all'autore. Non ci serve passare la variabile "@posts"; useremo il collegamento uno a molti "@post.user".

{title=".../app/views/posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=82}
```
        <%= render "pofo_post_author_section, post: @post" %>
```




## Il partial pofo_post_author_section

Note sull'autore. Useremo " post.user " perché l'autore è l'utente che lo ha creato ed ha con lui una relazione uno-a-molti. Invece " current_user " è l'utente che ha fatto login e che può leggere anche posts di altri autori.

Aggiorniamo l'immagine

{id="02-06-01_01", title=".../app/views/posts/pofo_post_author_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=32}
```
<%= post.user.account_image.attached? ? image_tag(@post.user.account_image, alt: "", class: "img-circle width-100px") : image_tag('pofo/avtar-01.jpg', alt: "", class: "img-circle width-100px") %>
```

il titolo e la biografia

{title=".../app/views/posts/pofo_post_author_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=35}
```
                        <a href="blog-post-layout-05.html#" class="text-extra-dark-gray text-uppercase alt-font font-weight-600 margin-10px-bottom display-inline-block text-small"><%= post.user.name %></a>
                        <p><%= sanitize post.user.biography %></p>
```

[Codice 06](#02-06-01_01all)




## Gli altri partials

li lasciamo come mockups. Li risolveremo nei prossimi capitoli.




## verifico




## git



## heroku



## chiudo branch



## il codice



