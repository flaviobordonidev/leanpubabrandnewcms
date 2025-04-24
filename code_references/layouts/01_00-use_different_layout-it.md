# <a name="top"></a> Usare un layout diverso

Per applicare un layout diverso da quello di default `views/layouts/application.html.erb`



## Creiamo un nuovo layout

dentro le `views/layouts` aggiungere il file `mylayout.html.erb`



## Nuovo layout per una sola azione del controller e relativa view

Dentro l'azione richiesta del controller mettere 

***codice: n/a - .../app/controllers/mines_controller.rb - line:01***

```ruby
class MinesController < ApplicationController

  def myaction
    ...
    render layout: 'mylayout'
  end
```



## Nuovo layout per tutte le azioni del controller e relative views

Dentro il controller mettere prima delle azioni

***codice: n/a - .../app/controllers/mines_controller.rb - line:01***

```ruby
class MinesController < ApplicationController
  layout "mylayout"

  def myaction
    ...
  end
```
