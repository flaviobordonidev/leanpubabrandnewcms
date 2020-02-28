{id: 01-base-25-pagination-style-01-style_pagination}
# Cap 25.1 -- Stile alla paginazione

Implementiamo lo stile Bootsrap alla paginazione che abbiamo implementato al capitolo 01-beginning/11-pagination/01-gem-pagy



 
## Verifichiamo dove eravamo rimasti

{caption: "terminal", format: bash, line-numbers: false}
```
$ git status
$ git log
```




## Apriamo il branch "Style Pagination"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b sp
```




## Aggiungiamo estensione per bootstrap

Per inserire delle estensioni in pagy dobbiamo creare il file config/initializers/pagy.rb

{id: "01-25-01_01", caption: ".../config/initializers/pagy.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
require 'pagy/extras/bootstrap'
```

questo ci permette di usare degli altri helpers nella nostra view 

I> per un pagy.rb con tutte le possibili opzioni: https://github.com/ddnexus/pagy/blob/master/lib/config/pagy.rb




## Usiamo nuovo helper sulla pagina index di users

{id: "01-25-01_02", caption: ".../app/views/users/index.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= sanitize pagy_bootstrap_nav(@pagy) %>
```

[tutto il codice](#01-25-01_02all)




## Usiamo nuovo helper sulla pagina index di eg_posts

{id: "01-25-01_03", caption: ".../app/views/eg_posts/index.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= sanitize pagy_bootstrap_nav(@pagy) %>
```

[tutto il codice](#01-25-01_03all)






## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add pagination style"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku sp:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge sp
$ git branch -d sp
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo





[Codice 01](#02-09-01_01)

{id="02-09-01_01all", title=".../Gemfile", lang=ruby, line-numbers=on, starting-line-number=1}
```
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# API clients for AWS S3 services. Comunicazione con Amazon Web Service S3 per ActiveStorage
gem "aws-sdk-s3", require: false

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.5'

# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.0'

# The most popular HTML, CSS, and JavaScript framework. http://getbootstrap.com
gem 'bootstrap', '~> 4.2', '>= 4.2.1'
# Use jquery as the JavaScript library
gem 'jquery-rails'

# slugging and permalink for Active Record. For creating human-friendly strings URLs and use as if they were numeric ids.
gem 'friendly_id', '~> 5.2', '>= 5.2.5'

# A rich text editor for everyday writing 
gem 'trix-rails', '~> 2.0', require: 'trix'

# Agnostic pagination in plain ruby
gem 'pagy', '~> 1.3', '>= 1.3.2'

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
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
```




[Codice 02](#02-09-01_02all)

{id="02-09-01_02", title=".../app/controllers/application_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource_or_scope)
    users_path
    #current_user
  end

  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end

  private

    def user_not_authorized
      redirect_to request.referrer || root_path, notice: "You are not authorized to perform this action."
    end
end
```




[Codice 04](#02-09-01_04)

{id="02-09-01_04all", title=".../app/helpers/application_helper.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
module ApplicationHelper
  include Pagy::Frontend
end
```
