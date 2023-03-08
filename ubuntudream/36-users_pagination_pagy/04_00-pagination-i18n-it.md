# <a name="top"></a> Cap 13.4 - Inseriamo le traduzioni nella Paginazione

Internazionalizziamo la paginazione (Pagy::I18n).



## Risorse interne

- []()



## Risorse esterne

- [Pagy::I18n](https://ddnexus.github.io/pagy/api/i18n#gsc.tab=0)



## Attiviamo le traduzioni di default i18n

Creiamo il nuovo file `pagy.rb` nella cartella `.../config/initializer` ed inseriamo le lingue che usiamo.

***Codice n/a - .../config/initializer/pagy.rb - linea:01***

```ruby
# https://ddnexus.github.io/pagy/api/i18n#gsc.tab=0
# load the "de", "en" and "es" built-in locales:
# the first :locale will be used also as the default locale
Pagy::I18n.load({ locale: 'it' },
                { locale: 'en' })
```




## Personalizziamo le traduzioni

***Codice n/a - .../config/initializer/pagy.rb - linea:01***

```ruby
# load the "en" built-in locale, a custom "es" locale, and a totally custom locale complete with the :pluralize proc:
Pagy::I18n.load({ locale: 'en' },
                { locale: 'es',
                  filepath: 'path/to/pagy-es.yml' },
                { locale:    'xyz',  # not built-in
                  filepath:  'path/to/pagy-xyz.yml',
                  pluralize: lambda{ |count| ... } })
```




## Per la traduzione invece del modulo "Pagy::I18n" usiamo i "locales"

Visto che abbiamo `pagy/_nav_edu`,il nostro partial con la formattazione del pagination, possiamo inserire direttamente lì le traduzioni sfruttando i "locales" con `t('path.del.locale')`.

Usiamo le segunti variabili:
- pagy.nav.prev
- pagy.nav.gap
- pagy.nav.next

nel codice di esempio di pagy sono usate da:
- `pagy_t('pagy.nav.prev')`
- `pagy_t('pagy.nav.gap')`
- `pagy_t('pagy.nav.next')`

***Codice 02 - .../views/pagy/_nav_edu.html.erb - linea:08***

```html+erb
<% if pagy.prev                -%>    <li class="page-item prev"><%== link.call(pagy.prev, t('pagy.nav.prev'), 'aria-label="previous"') %></li>
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

Noi le sostituiamo con le chiamate ai locales.

***Codice 03 - .../views/pagy/_nav_edu.html.erb - linea:08***

```html+erb
<% link = pagy_link_proc(pagy, link_extra: 'class="page-link"') -%>
<%#                            -%><nav aria-label="pager"  class="pagy-bootstrap-nav" role="navigation">
<%#                            -%>  <ul class="pagination">
<% if pagy.prev                -%>    <li class="page-item prev"><%== link.call(pagy.prev, t('pagy.nav.prev'), 'aria-label="previous"') %></li>
<% else                        -%>    <li class="page-item prev disabled"><a href="#" class="page-link"><%= t('pagy.nav.prev') %></a></li>
<% end                         -%>
<% pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36] -%>
<%   if    item.is_a?(Integer) -%>    <li class="page-item"><%== link.call(item) %></li>
<%   elsif item.is_a?(String)  -%>    <li class="page-item active"><%== link.call(item) %></li>
<%   elsif item == :gap        -%>    <li class="page-item disabled gap"><a href="#" class="page-link"><%= t('pagy.nav.gap') %></a></li>
<%   end                       -%>
<% end                         -%>
<% if pagy.next                -%>    <li class="page-item next"><%== link.call(pagy.next, t('pagy.nav.next'), 'aria-label="next"') %></li>
<% else                        -%>    <li class="page-item next disabled"><a href="#" class="page-link"><%= t('pagy.nav.next') %></a></li>
<% end                         -%>
<%#                            -%>  </ul>
<%#                            -%></nav>
```


Andiamo ad inserirle nei locales

***Codice n/a - .../config/locales/en.yml - linea:36***

```yaml
  pagy:
    nav:
      prev: "< prev"
      gap: "-blank-"
      next: "next >"
```


***Codice n/a - .../config/locales/en.yml - linea:36***

```yaml
  pagy:
    nav:
      prev: "< prec"
      gap: "-vuoto-"
      next: "succ >"
```


***Codice n/a - .../config/locales/en.yml - linea:36***

```yaml
  pagy:
    nav:
      prev: "< ant"
      gap: "-branco-"
      next: "próx >"
```




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_00-gem-pagy-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/03_00-users_pagination-it.md)