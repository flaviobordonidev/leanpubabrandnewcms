# Come cambiare il layout




## Creiamo un nuovo layout

dentro le views/layouts aggiungere il file mylayout.html.erb




## Nuovo layout per una sola view

Dentro l'azione richiesta del controller mettere 

~~~~~~~~
  def xxx
    ...
    render layout: 'mylayout'
    ...
  end
~~~~~~~~

https://brandnewcms-flaviobordonidev.c9users.io/test_pages/slider




## Nuovo layout per tutte le views di una tabella


Dentro il controller mettere prima delle azioni

~~~~~~~~  
  layout "mylayout"
~~~~~~~~


