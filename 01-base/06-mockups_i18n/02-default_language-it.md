{id: 01-base-06-mockups_i18n-02-default_language}
# Cap 6.2 -- Lingua di default

Nel precedente capitolo eravamo rimasti con il web server attivo e la visualizzazione della lingua inglese.
In questo capitolo impostiamo come lingua di default l'italiano.




## Apriamo il branch

non serve perché è rimasto aperto dal capitolo precedente




## Scegliamo la lingua di default

sulla configurazione dell'applicazione dichiariamo quale sono le lingue a disposizione ed impostiamo la lingua di default cambiando il "locale" di default:

{id: "01-05-02_01", caption: ".../config/application.rb -- codice 01", format: ruby, line-numbers: true, number-from: 19}
```
    config.i18n.available_locales = [:en, :it]
    config.i18n.default_locale = :it
    config.i18n.fallbacks = true
```

[tutto il codice](#01-05-02_01all)




## Verifichiamo preview

Chiudiamo il webserver (CTRL+C) e lo riavviamo per permettere a Rails di caricare le modifiche al file config/application

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnoposto, ora c'è la lingua italiana.

* https://mycloud9path.amazonaws.com/mockups/page_a

![Fig. 01](chapters/01-base/05-mockups_i18n/02_fig01-i18n_page_a.png)




## Refactoring lingua di default

Spostiamo le linee di codice all'interno di config/initializers come richiesto dalle convenzioni rails.

Creiamo un nuovo file con estensione ".rb" che possiamo chiamare come vogliamo; scegliamo "i18n.rb".

{caption: ".../config/initializers/i18n.rb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
# Be sure to restart your server when you modify this file.

# Set the default language.
Rails.application.config.i18n.available_locales = [:en, :it]
Rails.application.config.i18n.default_locale = :it
Rails.application.config.i18n.fallbacks = true
```

Come si può vedere in questo caso abbiamo dovuto mettere tutto il percorso a partire da " Rails.appplication. " mentre quando eravamo su " application.rb " questo non era necessario perché ci trovavamo già all'interno della classe application che ereditava da " Rails::Application ".

Abbiamo inoltre aggiunto due linee di commento all'inizio.




## Salviamo su Git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "set i18n default_locale = :it"
```




## publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku mi:master
```

Verifichiamo in produzione

https://myapp-1-blabla.herokuapp.com/

![Fig. 02](chapters/01-base/05-mockups_i18n/02_fig02-heroku_i18n_page_a.png)




## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo




## Il codice del capitolo




{id: "01-05-02_01all", caption: ".../config/application.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bl60
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.default_locale = :it
    config.i18n.fallbacks = true
  end
end
```

[indietro](#01-05-02_01)