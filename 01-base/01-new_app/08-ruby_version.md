{id: 01-base-01-new_app-07-ruby_version}
# Cap 1.7 -- Versione Ruby sul Gemfile




## Verifichiamo la versione di Ruby sul Gemfile

Verifichiamo che la versione di ruby scritta in automatico sul Gemfile coincida con quella che stiamo usando.
Questo è usato sia dal bundler che da Heroku.

verifichiamo la versione di ruby che stiamo usando

{caption: "terminal", format: bash, line-numbers: false}
```
$ ruby -v


user_fb:~/environment/bl6_0 (master) $ ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
```

verifichiamo sul gemfile 


{id: "01-01-07_01", caption: ".../Gemfile -- codice 01", format: ruby, line-numbers: true, number-from: 4}
```
ruby '2.6.3'
```

[tutto il codice](#01-01-07_01all)

I> La versione viene riportata senza il numero di patch ('2.6.3' e non '2.6.3p62').


Ed una volta usato il "bundle install" l'installato viene registrato sul file: Gemfile.lock

{caption: "terminal", format: bash, line-numbers: false}
```
$ bundle install

$ bundle update
$ bundle install
```

I> Lo stesso Heroku che tratteremo più avanti da un warning se non trova la versione di ruby fissata




## Il codice del capitolo




{id: "01-01-07_01all", caption: ".../Gemfile -- codice 01", format: yaml, line-numbers: true, number-from: 1}
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

[indietro](#01-01-07_01)
