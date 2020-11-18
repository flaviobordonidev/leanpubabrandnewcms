# Paginazione

Per dividere l'elenco su più pagine.
Le gemme che vanno per la maggiore sono: will_paginate, kaminari e pagy. Scegliamo pagy perché è mooolto più veloce.


Risorse interne:

* 01-base/17-pagination/01-gem-pagy


Risorse web:

* [GoRails pagy](https://gorails.com/episodes/pagination-with-pagy-gem)
* [How to ufficiale. verso il fondo ha anche "Using Templates"](https://ddnexus.github.io/pagy/how-to.html)
* [git page ufficiale](https://github.com/ddnexus/pagy)




## PAGY

* https://ddnexus.github.io/pagy/api/pagy.html

Attribute Readers
Pagy exposes all the instance variables needed for the pagination through a few attribute readers. They all return integers (or nil), except the vars hash:

Reader	Description
count   : the collection :count
page    : the current page number
items   : the actual number of items in the current non-empty page (can be less than the requested :items variable)
pages   : the number of total pages in the collection (same as last but with cardinal meaning)
last    : the number of the last page in the collection (same as pages but with ordinal meaning)
offset  : the number of items skipped from the collection in order to get the start of the current page (:outset included)
from    : the collection-position of the first item in the page (:outset excluded)
to      : the collection-position of the last item in the page (:outset excluded)
prev    : the previous page number or nil if there is no previous page
next    : the next page number or nil if there is no next page
vars    : the variables hash



## Esempio


```
<!-- start pagination -->
<%# link = pagy_link_proc(pagy, 'class="page-link"') %> <!-- inizializzo "link" con pagy e attivo già l'opzione class="page-link". Questo mi impedisce di riusarlo -->
<% link = pagy_link_proc(pagy) %>
<div class="col-12 d-flex justify-content-center">
  <div class="row">
    <div class="col-auto">
      <% if pagy.prev %>
        <%== link.call(pagy.prev, '<i class="fas fa-long-arrow-alt-left margin-5px-right d-none d-md-inline-block"></i> Prev', 'class="btn btn-medium btn-transparent-black lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto"') %>
        <% else %>    
        <a href="#" class="btn btn-medium btn-transparent-black lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto disabled"><i class="fas fa-long-arrow-alt-left margin-5px-right d-none d-md-inline-block"></i> Prev</a>
      <% end %>
    </div>
    <div class="col-auto">
      <span class="margin-5px-top d-table d-lg-inline-block">Pagina <%= params[:page] %> ( <%= pagy.page %> ) di <%= pagy.pages %> (totale items = <%= pagy.count %>)</span>
    </div>
    <div class="col-auto">
      <% if pagy.next %>
        <%== link.call(pagy.next, 'Next <i class="fas fa-long-arrow-alt-right margin-5px-left d-none d-md-inline-block"></i>', 'class="btn btn-medium btn-transparent-black lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto"') %>
      <% else %>    
        <a href="#" class="btn btn-medium btn-transparent-black lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto disabled">Next <i class="fas fa-long-arrow-alt-right margin-5px-left d-none d-md-inline-block"></i></a>
      <% end %>
    </div>
  </div>
</div>
<!-- end pagination -->
```

Le righe più interessanti

```
<%== link.call(pagy.prev, '<i class="fas fa-long-arrow-alt-left margin-5px-right d-none d-md-inline-block"></i> Prev', 'class="btn btn-medium btn-transparent-black lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto"') %>
<span class="margin-5px-top d-table d-lg-inline-block">Pagina <%= params[:page] %> ( <%= pagy.page %> ) di <%= pagy.pages %> (totale items = <%= pagy.count %>)</span>
<%== link.call(pagy.next, 'Next <i class="fas fa-long-arrow-alt-right margin-5px-left d-none d-md-inline-block"></i>', 'class="btn btn-medium btn-transparent-black lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto"') %>
```
