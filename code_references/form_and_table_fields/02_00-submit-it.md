


## Come mettere sytle nel bottone *submit*


***code n/a - .../app/views/steps/show.html.erb - line:n/a***

```html+erb
  <%= form.submit class: "btn btn-lg btn-primary"%>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/03_04-views-steps-show.html.erb)

> Se usiamo solo `form.submit` **non** mettiamo la virgola "," prima di `class:`.


***code n/a - .../app/views/steps/show.html.erb - line:n/a***

```html+erb
  <%= form.submit "esegui", class: "btn btn-lg btn-primary" %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/03_04-views-steps-show.html.erb)

> Se mettiamo la *scritta che va sul pulsane*, nel nostro caso la scritta: "esegui", allora **dobbiamo** mettere la virgola ",".

