# <a name="top"></a> Link per tornare indietro di più pagine

[25/05/23]
Per implementare un pulsante di navigazione indietro ("backward navigation") in Ruby on Rails, puoi usare una semplice combinazione di HTML/ERB e JavaScript. Ci sono vari approcci, ma il più comune e compatibile è sfruttare window.history.back() in JavaScript.


## Soluzione semplice (JS inline)
Inseriamo il pulsante con la funzione che naviga indietro nel browser. È come premere il pulsante "indietro" del browser.

***Codice 01 - .../app/views/articles/show.html.erb - linea:24***

```html
<button onclick="window.history.back()">Torna indietro</button>
```

Questo pulsante userà la cronologia del browser per tornare alla pagina precedente.

Se preferisci usare un link (<a>), funziona allo stesso modo:

***Codice 01 - .../app/views/articles/show.html.erb - linea:24***

```html
<%= link_to 'Torna indietro', '#', onclick: 'window.history.back(); return false;' %>
```

Il problema di questa soluzione è che se vado in edit e salvo tornando indietro mi torna anche nel form di edit. Oppure se vado su delle pagine che sono intermediarie e non voglio ripassarci tornando indietro questo non riesco a farlo con questa soluzione.



## Server-side: redirect to fallback

Questo è un caso particolare che non ci interessa ma potrebbe essere utile in alcuni casi.
In alcuni casi potresti voler usare una logica nel controller per tornare indietro, ad esempio con redirect_back:

```ruby
redirect_back(fallback_location: root_path)
```

Ma questa è una navigazione post-azione, tipica dopo `create`, `update`, o `destroy`.


