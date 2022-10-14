# <a name="top"></a> Cap 4.2 - Implementiamo la sicurezza e la protezione di Devise

Rendiamo non accessibili le pagine di gestione degli utenti a chi non è autenticato.

> Questa è una forma base di *autorizzazione* ma la vera *autorizzazione* è basata su ruoli differenti che hanno i vari utenti che fanno login / che si *autenticano*.

> Quando implementeremo la parte di *autorizzazione* nei prossimi capitoli disattiveremo temporaneamente la non accessibilità creata con Devise alle pagine a cui possono accedere solo gli utenti loggati.



## Risorse interne

- [99-rails_references-authentication_devise-02-devise]



## Risorse esterne

- [devise-auth-setup-in-rails-7](https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be)
- [Go Rails video](https://gorails.com/episodes/devise-hotwire-turbo)
- [Go Rails: github - initializer/devise](https://github.com/gorails-screencasts/hotwire-devise/blob/master/config/initializers/devise.rb)
- [Go Rails: github - devise_controller](https://github.com/gorails-screencasts/hotwire-devise/blob/master/app/controllers/users/devise_controller.rb)



## Apriamo il branch "Protect With Login"

```bash
$ git checkout -b pwl
```



## Proteggiamo le views users

Permettiamo l'accesso alle views users solo a chi ha fatto login, ossia a chi si è autenticato.

***codice 01 - .../app/controllers/users_controller.rb - line: 2***

```
  before_action :authenticate_user!
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-controllers-users_controller.rb)

> *before_action* ha sostituito il deprecato *before_filter*



## Risolviamo bug tra Rails 7 e devise

La parte hot-wire di Rails 7, e specificamente *turbo-drive*, ad oggi 13-10-2022, crea un problema di refresh con devise. In questo paragrafo la risolviamo.

> Questa soluzione è tratta dal seguente articolo: https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be

Now, we need to do something a little special for Rails 7. Rails 7 includes Turbo as a cornerstone component. Turbo lets you run asynchronous page updates without writing any Javascript (which is nifty) but it does it by hijacking the normal flow of submitting forms and following links.
Devise isn’t (yet) prepared for that and it won’t be able to display flash messages — which it relies heavily on — by default. 
We need to alter the code that Devise generates for us to deal with Turbo.

So, once you’ve run rails generate `devise:install` we need to alter the Devise initializer config in several places beyond what the Devise README instructs us to do and add a controller as Devise’s parent controller.

Credit where it’s due: these changes are from [Go Rails video](https://gorails.com/episodes/devise-hotwire-turbo) on the topic which also explains why these changes are necessary.



DEVISE INITIALIZER

***Codice 02 - .../app/controllers/turbo_devise_controller.rb - linea:01***

```ruby
class TurboDeviseController < ApplicationController
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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_04-controllers-turbo_devise_controller.rb)

Inoltre dobbiamo aggiungere e attivare alcuni parametri sulla *configurazione di inizializzazione di devise*.
Vediamo come si presenta la configurazione iniziale:

***codice 05 - .../config/initializers/devise.rb - line: 1***

```ruby
# frozen_string_literal: true

# Assuming you have not yet modified this file, each configuration option below
# is set to its default value. Note that some are commented out while others
# are not: uncommented lines are intended to protect your configuration from
# breaking changes in upgrades (i.e., in the event that future versions of
# Devise change the default values for those options).
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_05-config-initializers-devise.rb)


Di seguito facciamo le modifiche:

***codice 06 - .../config/initializers/devise.rb - line:11***

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

***codice 06 - ...continua - line:37***

```ruby
  # ==> Controller configuration
  # Configure the parent class to the devise controllers.
  config.parent_controller = 'TurboDeviseController'
```

***codice 06 - ...continua - line:276***

```ruby
 # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  #
  # If you have any extra navigational formats, like :iphone or :mobile, you
  # should add them to the navigational formats lists.
  #
  # The "*/*" below is required to match Internet Explorer requests.
  # config.navigational_formats = ['*/*', :html]
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

***codice 06 - ...continua - line:296***

```ruby
  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  #
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_06-config-initializers-devise.rb)



## Salviamo su git

```bash
$ git add -A
$ git commit -m "Implement devise protection to users and more"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pwl
$ git branch -d pwl
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## Pubblichiamo su Heroku

```bash
$ git push heroku pwl:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/01_00-manage_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
