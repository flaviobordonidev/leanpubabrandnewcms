# <a name="top"></a> Cap 13.3 - Applichiamo stile personalizzato alla Paginazione

Applichiamo uno stile personalizzato alla paginazine "pagy".


## Risorse interne

- [01-base/18-pagination/01-gem-pagy]()
- [11-theme-pofo/06-eg_posts/04-pagination_with_pofo]()
- [elisinfo-04-companies-21_00-index_style-it]()



## Implementiamo un template personalizzato per pofo  

Seguiamo la documentazione ufficiale [pagy: main doc](https://ddnexus.github.io/pagy/api/frontend.html) per visualizzare un partial con la formattazione della parte di paginazione.

> Questo rallenta leggermente l'applicazione ma ci permette di cambiare stile.

Tra le *views* creiamo la cartella `pagy` e dentro creiamo il partial `_nav_edu.html.erb` e ci copiamo il contenuto di [bootstrap_nav.html.erb](https://github.com/ddnexus/pagy/blob/master/lib/templates/bootstrap_nav.html.erb)

***Codice 01 - .../app/views/pagy/_nav_edu.html.erb - linea:01***

```html+erb
<%#
  This template is i18n-ready: if you don't use i18n, then you can replace the pagy_t
  calls with the actual strings ("&lsaquo; Prev", "Next &rsaquo;", "&hellip;").

  The link variable is set to a proc that returns the link tag.
  Usage: link.call( page_number [, text [, extra_attributes_string ]])
-%>
<% link = pagy_link_proc(pagy, link_extra: 'class="page-link"') -%>
<%#                            -%><nav aria-label="pager"  class="pagy-bootstrap-nav" role="navigation">
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

Abbiamo adesso il partial "_nav_edu" che ha lo stesso comportamento e stile dell'helper pagy_bootstrap_nav, la sola differenza è che è leggermente più lento. A partire da questo possiamo fare delle modifiche ed eventualmente implementare lo stile del nostro tema.

Invece di usare uno degli helper di pagy, usiamo il partial. La chiamata risulta la seguente

***Codice 02 - .../app/views/users/index.html.erb - linea:132***

```html+erb
							<!-- Pagination -->
							<%#= sanitize pagy_nav(@pagy) %>
              <%= render 'pagy/nav_edu', pagy: @pagy %>
```


## Portiamo lo stile di eduport nel template pagy

[DAFA]

Non ho implementato le modifiche del tema eduport perché mi piace di più così com'è ^_^.
 
{title="views/pagy/_nav_pofo.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```



## Verifichiamo preview

```
$ rails s
```



## archiviamo su git

```
$ git add -A
$ git commit -m "pagination with pofo style"
```

