# <a name="top"></a> Cap link_to.1 - Inseriamo immagini

Creiamo immagini cliccabili.


## Risorse esterne

- [Articolo simpatico per LINK_TO](https://mixandgo.com/blog/how-to-use-link_to-in-rails)



## Link_to con immagini

Sfrutta il link_to su più righe.

```html+erb
<%= link_to books_path do %>
  <%= image_tag "Book Collection" %>
<% end %>
```
