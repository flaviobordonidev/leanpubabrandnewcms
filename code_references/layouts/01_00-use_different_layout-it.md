# <a name="top"></a> Cap 2.1 - Importiamo una pagina dal tema

# Come cambiare il layout




## Creiamo un nuovo layout

dentro le views/layouts aggiungere il file mylayout.html.erb




## Nuovo layout per una sola view

Dentro l'azione richiesta del controller mettere 

***codice: n/a - .../app/controllers/xxx_controller.rb - line:01***

```ruby
  def xxx
    ...
    render layout: 'mylayout'
    ...
  end
```

https://brandnewcms-flaviobordonidev.c9users.io/test_pages/slider




## Nuovo layout per tutte le views di una tabella


Dentro il controller mettere prima delle azioni

```ruby  
  layout "mylayout"
```
