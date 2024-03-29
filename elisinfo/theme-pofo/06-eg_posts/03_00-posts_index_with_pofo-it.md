# Blog - visualiziamo elelnco articoli

rendiamo dinamica la pagina degli articoli prendendo i dati dal database.
Adattiamo la parte dinamica della nostra pagina posts/index al tema pofo




## Apriamo il branch "Posts Index"

```bash
$ git checkout -b pi
```




## Aggiorniamo la view posts/index - Il partial pofo_posts_content_section

Passiamo i dati della tabella al partial

{id="02-06-01_01", title=".../app/views/posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=2}
```
        <%= render "pofo_posts_content_section", posts: @posts %>
```

[Codice 01](#02-06-01_01all)

In questo caso il nome della variabile è al plurale " posts " perché è un elenco di articoli.




## Passiamo la variabile d'istanza @posts al partial

Per rendere dinamici i contenuti del tema pofo passiamo al partial pofo_posts_content_section la variabile d'istanza @posts che è un oggetto contenente l'elenco degli articoli pubblicati.

{title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<%= render "pofo_posts_content_section", posts: @posts %>
```




## Usiamo l'elenco degli articoli preso dal database

Facciamo un passaggio intermedio prima di passare alla gestione dinamica dell'elenco passiamo i dati dei primi due records della tabella posts.

Mettiamo l'immagine dal database se presente.

{title=".../app/views/posts/_pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=11}
```
                                    <%#= image_tag "pofo/blog-img98.jpg", alt: "" %>
                                    <%= image_tag posts.first.main_image if posts.first.main_image.attached?  %>
```

{title=".../app/views/posts/_pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=32}
```
                                    <%#= image_tag "pofo/blog-img99.jpg", alt: "" %>
                                    <%= image_tag posts.second.main_image if posts.second.main_image.attached?  %>
```

Mettiamo l'incipit dal database del primo e del secondo articolo

{title=".../app/views/posts/_pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=16}
```
                                <a href="blog-post-layout-01.html" class="post-title text-medium text-extra-dark-gray width-90 display-block md-width-100"><%= posts.first.incipit %></a>
```

{title=".../app/views/posts/_pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=37}
```
                                <a href="blog-post-layout-02.html" class="post-title text-medium text-extra-dark-gray width-90 display-block md-width-100"><%= posts.second.incipit %></a>
```




## Implementiamo tutto l'elenco

Isoliamo la parte di codice che descrive il singolo articolo e la mettiamo all'interno di un ciclo creando dinamicamente un articolo per ogni record nel database.
E' come se preparassimo dei partials per rendere DRY il codice ed avessimo "_post1", "_post2", "_post3", etc.

{title=".../app/views/posts/_pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=37}
```
                  <% posts.each do |post| %>
                    <!-- start post item -->
                    <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 margin-80px-bottom sm-margin-50px-bottom xs-margin-30px-bottom wow fadeInUp">
                        <div class="blog-post blog-post-style2">
                            <div class="blog-post-images overflow-hidden margin-25px-bottom xs-margin-15px-bottom">
                                <a href="blog-post-layout-01.html">
                                    <%#= image_tag "pofo/blog-img98.jpg", alt: "" %>
                                    <%= image_tag post.main_image if post.main_image.attached?  %>
                                </a>
                            </div>
                            <div class="post-details">
                                <a href="blog-post-layout-01.html" class="post-title text-medium text-extra-dark-gray width-90 display-block md-width-100"><%= post.incipit %></a>
                                <div class="separator-line-horrizontal-full bg-medium-light-gray margin-20px-tb xs-margin-15px-tb"></div>
                                <div class="author">
                                    <%= image_tag "pofo/avtar-01.jpg", alt: "", class: "border-radius-100" %>
                                    <span class="text-medium-gray text-uppercase text-extra-small padding-15px-left display-inline-block">by <a href="blog-grid.html" class="text-medium-gray">Jay Benjamin</a>&nbsp;&nbsp;|&nbsp;&nbsp;20 April 2017</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end post item -->
                  <% end %>
```

Evidenziamo gli elementi dinamici:

{title=".../app/views/posts/_pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=off}
```
<% posts.each do |post| %>
  <%= image_tag post.main_image if post.main_image.attached?  %>
  <%= post.incipit %>
<% end %>
```




## git



## heroku




Nel prossimo capitolo implementiamo il pagination dinamicamente.

