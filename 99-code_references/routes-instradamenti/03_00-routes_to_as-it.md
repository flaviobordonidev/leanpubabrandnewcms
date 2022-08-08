# <a name="top"></a> Cap routes.5 - Vediamo come indicare percorsi alternativi



## Il percorso "standard"

Per convenzione scriviamo il percorso con prima il nome del controller e poi il nome dell'azione e a rails non servono altre informazioni per capire come eseguire il codice.

***code 01 - .../app/views/site/first.html.erb - line:3***

```ruby
  get "site/first"
  get "site/second"
  post "site/third"
```


```bash
$ rails routes
```


## Percorso personalizzato

Se diamo un percorso differente, ad esempio non inseriamo il nome del controller, allora dobbiamo specificare a Rails qual è il controller e l'azione da eseguire. E questo lo facciamo con l'opzione `to: "controller_name#action_name"`

***code 01 - .../app/views/site/first.html.erb - line:3***

```ruby
  get "/first", to: "site#first", as: :first_page
  get "/second", to: "site#second", as: :second_page
  post "/third", to: "site#third", as: :third_page
```

> l'opzione `as: :first_page` personalizza il path (ad esempio quello che usiamo nel link_to)
> in questo caso il path è: `first_page_path`
