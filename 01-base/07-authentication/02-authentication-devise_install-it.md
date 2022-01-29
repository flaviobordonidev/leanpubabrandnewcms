# <a name="top"></a> Cap 7.2 - Login con Devise - installazione

Implementiamo la parte di autenticazione, ossia la parte di login, con la gemma ***devise***.
Aggiungiamo la gemma ***devise*** alla nostra applicazione per implementare la parte di autenticazione.
Devise permette di autenticare l'utente per mezzo di un login con user e password. 
Un utente si logga per avere il *SUO* ambiente di lavoro personalizzato.



## Risorse interne:

- 99-rails_references/authentication/02-devise



## Apriamo il branch "Login Devise Install"

```bash
$ git checkout -b ldi
```



## Installiamo la gemma devise

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/devise)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/plataformatec/devise)

{id: "01-07-02_01", caption: ".../Gemfile -- codice 01", format: ruby, line-numbers: true, number-from: 31}
```
# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.7', '>= 4.7.1'
```

[tutto il codice](#01-07-02_01all)


Eseguiamo l'installazione della gemma con bundle

{caption: "terminal", format: bash, line-numbers: false}
```
$ bundle install
```



## Lo script

Eseguiamo lo script di installazione di devise su rails (Anche noto con il nome di "generator").
Il "generator" installerà un inizializzatore che descrive tutte le opzioni di configurazione di Devise. E' importante leggere e seguire le varie azioni proposte.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g devise:install


ec2-user:~/environment/myapp (ldi) $ rails g devise:install
Running via Spring preloader in process 8570
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
```

Completiamo i 4 punti riportati sul testo che appare dopo devise:install.



### Punto 1

relativo alla parte di settaggio sia in sviluppo che in produzione.

{id: "01-07-02_02", caption: ".../config/environments/development.rb -- codice 02", format: ruby, line-numbers: true, number-from: 39}
```
  # Devise config
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

[tutto il codice](#01-07-02_02all)


Nel prossimo passaggio dobbiamo mettere l'host di produzione. Nel nostro caso quello di heroku. 
Per trovare il nome host su heroku usiamo il comando:

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku domains


user_fb:~/environment/bl6_0 (ldi) $ heroku domains
=== bl6-0 Heroku Domain
bl6-0.herokuapp.com
```

Adesso che abbiamo il nome dell'host su heroku lo possiamo usare nel file di configurazione.

{id: "01-07-02_03", caption: ".../config/environments/production.rb -- codice 03", format: ruby, line-numbers: true, number-from: 69}
```
  # Devise config
  config.action_mailer.default_url_options = { host: 'bl6-0.herokuapp.com', port: 3000 }
```

[tutto il codice](#01-07-02_03all)


I> Attenzione!
I>
I> Dobbiamo ricordarci di cambiare questo settaggio quando su Heroku punteremo al dominio definitivo. 
I>
I> (https://devcenter.heroku.com/articles/using-the-cli).



### punto 2.

Abbiamo già impostato la root sul root file e per il momento lo lasciamo così.

{id: "01-07-02_04", caption: ".../config/routes.rb -- codice 04", format: ruby, line-numbers: true, number-from: 3}
```
  root 'mockups#page_a'
```

[tutto il codice](#01-07-02_04all)



### punto 3.

mettiamo su layouts/application la visualizzazione dei messaggi di avviso


{caption: ".../app/views/layouts/application.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 13}
```
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
```

miglioriamoli un poco, quando installeremo bootstrap saranno ancora meglio.

{caption: ".../app/views/layouts/application.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 13}
```
    <p class="alert alert-info"><%= notice %></p>
    <p class="alert alert-warning"><%= alert %></p>
```

visualizziamoli solo quando servono

{id: "01-07-02_05", caption: ".../app/views/layouts/application.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 13}
```
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>
```

[tutto il codice](#01-07-02_05all)


Successivamente implementeremo un partial più completo **<%= render 'layouts/flash_messages' %>** ma per il momento va bene così.



### punto 4.

Copiamo le views di devise sulla app per permettere la personalizzazione.
Questa operazione la posticipiamo a dopo la creazione della tabella " users ".



## archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
```
$ git add -A
$ git commit -m "Install gem devise"
```



## Chiudiamo il branch

Lo chiudiamo in seguito



## Facciamo un backup su Github

Lo facciamo in seguito. Dopo la chiusura del branch.



## Il codice del capitolo


{id: "01-07-02_01all", caption: ".../Gemfile -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.7', '>= 4.7.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
```

[indietro](#01-07-02_01)




{id: "01-07-02_02all", caption: ".../config/environments/development.rb -- codice 02", format: ruby, line-numbers: true, number-from: 39}
```
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Devise config
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Allow connections to local server.
  config.hosts.clear
end
```

[indietro](#01-07-02_02)




{id: "01-07-02_03all", caption: ".../config/environments/production.rb -- codice 03", format: ruby, line-numbers: true, number-from: 1}
```
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "bl6_0_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Devise config
  config.action_mailer.default_url_options = { host: 'bl6-0.herokuapp.com', port: 3000 }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Inserts middleware to perform automatic connection switching.
  # The `database_selector` hash is used to pass options to the DatabaseSelector
  # middleware. The `delay` is used to determine how long to wait after a write
  # to send a subsequent read to the primary.
  #
  # The `database_resolver` class is used by the middleware to determine which
  # database is appropriate to use based on the time delay.
  #
  # The `database_resolver_context` class is used by the middleware to set
  # timestamps for the last write to the primary. The resolver uses the context
  # class timestamps to determine how long to wait before reading from the
  # replica.
  #
  # By default Rails will store a last write timestamp in the session. The
  # DatabaseSelector middleware is designed as such you can define your own
  # strategy for connection switching and pass that into the middleware through
  # these configuration options.
  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
end
```

[indietro](#01-07-02_03)




{id: "01-07-02_04all", caption: ".../config/routes.rb -- codice 04", format: ruby, line-numbers: true, number-from: 1}
```
Rails.application.routes.draw do

  root 'mockups#page_a'

  get 'mockups/page_a'
  get 'mockups/page_b'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

[indietro](#01-07-02_04)





{id: "01-07-02_05all", caption: ".../app/views/layouts/application.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!DOCTYPE html>
<html>
  <head>
    <title>Bl60</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>    
    <%= yield %>
  </body>
</html>
```

[indietro](#01-07-02_05)











[Codice 06](#01-07-02_06)

{id="01-07-02_06all", title=".../db/migrate/xxx_devise_create_users.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,               null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
```




[Codice 07](#01-07-02_07)

{id="01-07-02_07", title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
Rails.application.routes.draw do

  root 'example_static_pages#page_a'
  
  devise_for :users
  resources :users

  get 'example_static_pages/page_a'
  get 'example_static_pages/page_b'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/01-devise_story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03-devise-users-seeds-it.md)
