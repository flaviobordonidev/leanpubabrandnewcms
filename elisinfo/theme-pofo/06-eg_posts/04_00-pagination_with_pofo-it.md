# La paginazione in stile pofo

adattiamo la paginazione con lo stesso stile del tema pofo




## Apriamo il branch "Pagy to Pofo"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b pp
```




## Implementiamo la paginazione per posts_controller

Abbiamo già installato la gemma "pagy" nei capitoli precedenti. Adesso la usiamo per posts.

{id="03-04-03_01", title=".../app/controllers/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
    @pagy, @posts = pagy(Post.all.published.order(created_at: 'DESC'), items: 8)
```

[Codice 01](#03-04-03_01all)

Limitiamo ogni pagina ad otto articoli.




### Applichiamola al nostro caso che ha già i tags

{id="03-04-03_01", title=".../app/controllers/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
    if params[:tag].present?
      @pagy, @posts = pagy(Post.published.tagged_with(params[:tag]).order(created_at: 'DESC'), items: 2)
      #@posts = Post.published.tagged_with(params[:tag]).order(created_at: "DESC")
    else
      @pagy, @posts = pagy(Post.published.order(created_at: 'DESC'), items: 2)
      #@posts = Post.published.order(created_at: "DESC")
    end
```

[Codice 01](#03-04-03_01all)





### Implementiamo la paginazione in posts/index

Possiamo usare l'helper "pagy_nav()" messo a disposizione da pagy nel partial degli articoli.

{title="views/posts/pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=28}
```
    <!-- start pagination -->
    <%= sanitize pagy_bootstrap_nav(@pagy) %>
    <!-- end pagination -->
```




## Implementiamo un template personalizzato per pofo  

* https://ddnexus.github.io/pagy/api/frontend.html

Invece di usare un helper di pagy, usiamo un nostro partial. La chiamata risulta la seguente

***Codice 01 - .../app/views/posts/pofo_posts_content_section.html.erb - linea:28***

```
                <!-- start pagination -->
                <%= render 'pagy/nav_pofo', pagy: @pagy %>
```

adesso creiamo la cartella pagy e dentro creiamo il file "_nav_pofo.html.erb" copiandoci il contenuto di [bootstrap_nav.html.erb](https://github.com/ddnexus/pagy/blob/master/lib/templates/bootstrap_nav.html.erb)

***Codice 02 - .../app/views/pagy/_nav_pofo.html.erb - linea:01***

```html+erb
<%#
  This template is i18n-ready: if you don't use i18n, then you can replace the pagy_t
  calls with the actual strings ("&lsaquo; Prev", "Next &rsaquo;", "&hellip;").
  The link variable is set to a proc that returns the link tag.
  Usage: link.call( page_number [, text [, extra_attributes_string ]])
-%>
<% link = pagy_link_proc(pagy, 'class="page-link"') -%>
<%#                            -%><nav aria-label="pager"  class="pagy-nav-bootstrap pagy-bootstrap-nav pagination" role="navigation">
<%#                            -%>  <ul class="pagination">
<% if pagy.prev                -%>    <li class="page-item prev"><%== link.call(pagy.prev, pagy_t('pagy.nav.prev'), 'aria-label="previous"') %></li>
<% else                        -%>    <li class="page-item prev disabled"><a href="#" class="page-link"><%== pagy_t('pagy.nav.prev') %></a></li>
<% end                         -%>
<% pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36] -%>
<%   if    item.is_a?(Integer) -%>    <li class="page-item"><%== link.call(item) %></li>
<%   elsif item.is_a?(String)  -%>    <li class="page-item active"><%== link.call(item) %></li>
<%   elsif item == :gap        -%>    <li class="page-item disabled gap"><a href="#" class="page-link"><%== pagy_t('pagy.nav.gap') %></a></li>
<%   end                       -%>
<% end                         -%>
<% if pagy.next                -%>    <li class="page-item next"><%== link.call(pagy.next, pagy_t('pagy.nav.next'), 'aria-label="next"') %></li>
<% else                        -%>    <li class="page-item next disabled"><a href="#" class="page-link"><%== pagy_t('pagy.nav.next') %></a></li>
<% end                         -%>
<%#                            -%>  </ul>
<%#                            -%></nav>
```

Abbiamo adesso il partial "nav_pofo" che ha lo stesso comportamento e stile dell'helper pagy_bootstrap_nav, la sola differenza è che è leggermente più lento.




## Portiamo lo stile di pofo nel template pagy


{title="views/pagy/_nav_pofo.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<%#
  This template is i18n-ready: if you don't use i18n, then you can replace the pagy_t
  calls with the actual strings ("&lsaquo; Prev", "Next &rsaquo;", "&hellip;").
  The link variable is set to a proc that returns the link tag.
  Usage: link.call( page_number [, text [, extra_attributes_string ]])
-%>
<% link = pagy_link_proc(pagy, 'class="page-link"') %>
<div aria-label="pager"  class="pagination text-small text-uppercase text-extra-dark-gray" role="navigation">
  <ul>
    <% if pagy.prev %>
      <li class="page-item prev"><%== link.call(pagy.prev, '<i class="fas fa-long-arrow-alt-left margin-5px-right xs-display-none"></i> Prev', 'aria-label="previous"') %></li>
    <% else %>    
      <li class="page-item prev disabled"><a href="#" class="page-link"><i class="fas fa-long-arrow-alt-left margin-5px-right xs-display-none"></i> Prev</a></li>
    <% end %>
    <% pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36] %>
      <% if item.is_a?(Integer) %>    
        <li class="page-item"><%== link.call(item) %></li>
      <% elsif item.is_a?(String) %>    
        <li class="page-item active"><%== link.call(item) %></li>
      <% elsif item == :gap %>    
        <li class="page-item disabled gap"><a href="#" class="page-link"><%== pagy_t('pagy.nav.gap') %></a></li>
      <% end %>
    <% end %>
    <% if pagy.next %>
      <li class="page-item next"><%== link.call(pagy.next, 'Next <i class="fas fa-long-arrow-alt-right margin-5px-left xs-display-none"></i>', 'aria-label="next"') %></li>
    <% else %>    
      <li class="page-item next disabled"><a href="#" class="page-link">Next <i class="fas fa-long-arrow-alt-right margin-5px-left xs-display-none"></i></a></li>
    <% end %>
  </ul>
</div>
```




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/posts

E vediamo la paginazione.




## archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
```
$ git add -A
$ git commit -m "pagination with pofo style"
```




## Pubblichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
```
$ git push heroku pp:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout master
$ git merge pp
$ git branch -d pp
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{title="terminal", lang=bash, line-numbers=off}
```
$ git push origin master
```




## Il codice del capitolo


