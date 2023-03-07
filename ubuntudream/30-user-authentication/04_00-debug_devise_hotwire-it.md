# <a name="top"></a> Cap 4.3 - Debug devise per turbo

Su Rails 7.0 è stato introdotto *hotwire* e *devise* ad oggi 06/11/2022 non è pienamente compatibile.
Nello specifico non supporta l'intercettamento delle chiamate html da parte di *turbo_stream*.



## Risorse esterne

- [devise-auth-setup-in-rails-7](https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be)
- [Go Rails video](https://gorails.com/episodes/devise-hotwire-turbo)
- [Go Rails: github - initializer/devise](https://github.com/gorails-screencasts/hotwire-devise/blob/master/config/initializers/devise.rb)
- [Go Rails: github - devise_controller](https://github.com/gorails-screencasts/hotwire-devise/blob/master/app/controllers/users/devise_controller.rb)



## Principale debug

Il principale debug è quello di aggiungere `turbo_stream` al `navigational_formats` nell'initializers/devise.

***Codice n/a - .../config/initializers/devise.rb - linea:n/a***

```ruby
  # config.navigational_formats = ['*/*', :html]
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

Ma questa ed altre modifiche che è bene implementare le vediamo nel prossimo paragrafo.



## Tutte le modifiche di debug

Effettuiamo le varie modifiche suggerite.

***Codice 01 - .../config/initializers/devise.rb - linea:12***

```ruby
# Turbo doesn't work with devise by default.
# Keep tabs on https://github.com/heartcombo/devise/issues/5446 for a possible fix
# Fix from https://gorails.com/episodes/devise-hotwire-turbo
Rails.application.reloader.to_prepare do
  class TurboFailureApp < Devise::FailureApp
    def respond
      if request_format == :turbo_stream
        redirect
      else
        super
      end
    end

    def skip_format?
      %w(html turbo_stream */*).include? request_format.to_s
    end
  end
end
```

***Codice 01 - .../continue - linea:39***

```ruby
  # ==> Controller configuration
  # Configure the parent class to the devise controllers.
  # config.parent_controller = 'DeviseController'
  config.parent_controller = 'Users::DeviseController'
```

***Codice 01 - .../continue - linea:287***

```ruby
  # config.navigational_formats = ['*/*', :html]
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

***Codice 01 - .../continue - linea:302***

```ruby
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-user-authentication/04_01-config-initializers-devise.rb)

Creiamo il novo file `devise_controller` dentro `controllers/users` così come abbiamo definito qui sopra nel parametro `config.parent_controller`.

***Codice 02 - .../app/controllers/users/devise_controller.rb - linea:01***

```ruby
class Users::DeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
```

fine delle modifiche di debug.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Debug devise for hotwire"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_00-lessons_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_00-nested_routes-it.md)
