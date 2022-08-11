ATTENZIONE SPOSTIAMO QUESTO CAPITOLO NELLA SEZIONE "07-style"


# Companies index style

Mettiamo lo stile preso dal nostro tema (nel nostro caso POFO).

Lavoriamo sul view index in modo da visualizzare l'elenco di aziende.
Al momento NON INSERIAMO LE PERSONE ANNIDATE perché quelle faranno parte di company_person_maps index.

Qui puliamo e creiamo la visualizzazione a Livello 1 delle aziende (non implementiamo il secondo livello perché quando ho attivo il secondo livello vado su un'altra view/pagina model1_model2_maps; ad esempio: company_person_maps.
Quindi abbiamo la possibilità di:

* Creare nuova azienda
* Vedere indice aziende
* Vedere il dettaglio dell'azienda, ossia lo show. (questa è un'azione che in elisinfo non usiamo. mettiamo tutto su index)
* Vedere la traduzione in più lingue



## Apriamo il branch "Companies Index Style"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b cis
```




## Aggiorniamo la view

Adesso lavoriamo lato front-end. La view su cui operiamo è "index" in cui abbiamo la lista di tutte le aziende.




## Passiamo il codice del mockups

Ci passiamo tutto il codice del mockup "s1p4_company_index" (da -> a):

* .../app/views/mockups/s1p4_company_index.html.erb -> .../app/views/companies/index.html.erb


{id: "01-03-01_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!doctype html>
<html class="no-js" lang="en">
  <head>
    <!-- title -->
```

[tutto il codice](#01-03-01_01all)

![Fig. 01](chapters/01-base/03-mockups/01_fig01-views-mockups-page_a.png)

Adesso potrebbe anche funzionare ma il codice HTML che mandiamo al browser è sbagliato perché stiamo utilizzando il layout "application" e non "yield".
Funziona tutto perché, nei precedenti capitoli, abbiamo già attiato le chiamate stylesheet_pack_tag javascript_pack_tag ad "application" ed aggiornato il codice collegato.
Nel prossimo capitolo aggiustiamo il codice distribuendolo in maniera corretta tra il layout "application" e la pagina/view "home". 




## Puliamo il codice

Verifichiamo che il codice "<html> ... <head> ..." della pagina/view "companies/index" corrisponde a quello nel layout "application" in cui abbiamo già spostato nei precedeti capitoli il codice creando la view "pages/home".
Il codice coincide e quindi semplicemente lo eliminiamo dalla pagina "companies/index" se fosse stato differente avremmo utilizzato lo "yield content" come abbiamo fatto per il "title" che si presenta nel tab del browser.
Togliamo anche tutto il codice relativo al menu di navigazione.


{id: "01-03-01_01", caption: ".../views/companies/index.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 1}
```
    <!-- start form style 01 section -->
    <section class="wow fadeIn padding-one-all" id="start-your-project">
      <div class="container">
        <div class="row justify-content-center">
```

[tutto il codice](#01-03-01_01all)




## Incorporiamo la parte dinamica

Adesso è arrivato il momento di incorporare la parte dinamica all'interno del codice del mockup.


{id: "01-03-01_01", caption: ".../views/companies/index.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
    <!-- start companies section -->
    <section class="wow fadeIn padding-one-all">
      <div class="container">
        <div class="row">
          <!--<div class="col-md-10 col-sm-12 col-xs-12 center-col">-->
          <div class="col-12">
            <ul class="blog-comment">

              <% @companies.each do |company| %>
                <li>

...
                      <%= link_to edit_company_path(company), class: "text-extra-dark-gray text-uppercase alt-font font-weight-600 text-small" do %>
                        <%= company.name %> - <%= company.building %> - <%= company.id %> (Cliente)
                      <% end %>

...
                    <%= link_to new_company_path, class: "btn btn-small btn-transparent-white lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto" do %>
                      <%= image_tag "pofo/icon_new.png", class: "img-circle width-85 xs-width-100", alt: "" %>
                    <% end %>
```

[tutto il codice](#01-03-01_01all)


Al momento NON INSERIAMO LE PERSONE ANNIDATE perché quelle faranno parte di company_person_maps index.




## Il pagination

Implementiamo quanto già visto in 11-theme-pofo/06-eg_posts/04-pagination_with_pofo




## Implementiamo un template personalizzato per pofo  

Invece di usare un helper di pagy, usiamo un nostro partial. La chiamata risulta la seguente

{title="views/posts/pofo_posts_content_section.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=28}
~~~~~~~~
                <!-- start pagination -->
                <%= render 'pagy/nav_pofo', pagy: @pagy %>
~~~~~~~~

adesso creiamo la cartella pagy e dentro creiamo il file "_nav_pofo.html.erb" copiandoci il contenuto di [bootstrap_nav.html.erb](https://github.com/ddnexus/pagy/blob/master/lib/templates/bootstrap_nav.html.erb)

{title="views/pagy/_nav_pofo.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
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
~~~~~~~~

Abbiamo adesso il partial "nav_pofo" che ha lo stesso comportamento e stile dell'helper pagy_bootstrap_nav, la sola differenza è che è leggermente più lento.




## Portiamo lo stile di pofo nel template pagy


{title="views/pagy/_nav_pofo.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
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
~~~~~~~~




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails s
~~~~~~~~

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/posts

E vediamo la paginazione.




## archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "pagination with pofo style"
~~~~~~~~


