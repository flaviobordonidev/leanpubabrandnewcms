# <a name="top"></a> Cap link_to.1 - Overview

Il comando link_to per creare dei link è uno dei più usati su rails.
Vediamo gli usi più comuni.



## Risorse esterne

-[rubyonrails api: link_to](https://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to)
- [Adding a class to link_to block](https://stackoverflow.com/questions/11545262/adding-a-class-to-link-to-block?answertab=trending#tab-top)



## Link_to su una riga

Usiamo l'helper `link_to`.
Il primo parametro è il "titolo" del link ed il secondo parametro è il path.

```html+erb
<%= link_to "vai a pagina b", mockups_page_b_path %>
```

> In semplice HTML, scriveremmo il link così: `<a href="/mockups/page_b">vai a pagina b</a>`



## Link_to su più righe (link_to block)

Per inserire più righe di codice associamo il link_to ad un blocco di codice `do ... end`.
In questo caso il primo parametro è il path.

```html+erb
<%= link_to mockups_page_b_path do %>
  vai a pagina b
<% end %>
```



## Link_to su più righe con stylesheet

Aggiungiamo lo stile tramite `class`.
ou need to add the URL as the first parameter, then the html options, e.g.:


```html+erb
<%= link_to mockups_page_b_path, class: "some_class" do %>
  vai a pagina b
<% end %>
```
