# <a name="top"></a> Cap mix_and_go - Model View Controller


- BROWSER (http://localhost:3000/mypage) --request--> SERVER
- SERVER (Rails) --response--> BROWSER

Path: /my-page

## REQUEST

La *REQUEST* dal browser può arrivare in diverse forme di `http methods`:

- GET
- POST
- PUT (or PATCH)
- DELETE
- OPTIONS


## Il file routes

Questa parte è gestita dal file *routes.rb*

Esempio:

***code 01 - .../config/routes.rb - line:n/a***

```ruby
  get "/my-page", to: "site#index"
```

Method      : get
Path        : /my-page
Controller  : site
Action      : index


## Controllers -> views

I controllers passano i dati alle views.

Ad esepmio:

***code 02 - .../app/controllers/site_controller.rb - line:n/a***

```ruby
class SiteController < ApplicationController
  def index
    @name = "Cezar"
  end
end
```

> `@name` è una variabile di istanza.
> Questa variabile la posso richiamare dalla *view* associata (*site/index.html.erb*)

nella view abbiamo

***code 03 - .../app/views/site/index.html.erb - line:n/a***

```html+erb
Hello <%= @name %>
```


## Vediamo l'helper

***code n/a - .../app/views/site/index.html.erb - line:n/a***

```html+erb
Hello <span><%= @name.upcase %></span>
```

***code 04 - .../app/helpers/application_helper.rb - line:n/a***

```ruby
module ApplicationHelper
  def format_name(name)
    tag.span name.upcase
  end
end
```

Quindi la view risulta:

***code 05 - .../app/views/site/index.html.erb - line:n/a***

```html+erb
Hello <%= format_name(@name) %>
```


## Introduciamo il model

Creiamo un model in PORO (pure old Ruby object) senza far ereditare la classe.

*** models/person.rb ***

```ruby
class Person
  def self.name
    "Cezar"
  end
end  
```

nella controller abbiamo

```ruby
class SiteController < ApplicationController
  def index
    @name = Person.name
  end
end
```

