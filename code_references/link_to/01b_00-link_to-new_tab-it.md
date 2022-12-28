# <a name="top"></a> Cap link_to.1b - Link to external page

Usiamo link_to per aprire la pagina su un nuovo tab o windows



## Risorse esterne

-[External Links](https://human-se.github.io/rails-demos-n-deets-2021/demos/links-external/)



## Link_to parametro per nuova pagina

L'opzione da usare è `, target: '_blank'`.

```html+erb
<%= link_to "vai a pagina b", mockups_page_b_path, target: '_blank' %>
```

> In semplice HTML, scriveremmo il link così: `<a href="/mockups/page_b" target=”_blank”>vai a pagina b</a>`



## Link_to per pagina esterna

Vediamo un link ad una pagina di un sito diverso. (external link)

```html+erb
  <%= link_to 'Goatlandia Farm Animal Sanctuary',
    'https://www.goatlandia.org',
    target: '_blank'
  %>
```
