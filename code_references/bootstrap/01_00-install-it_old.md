# <a name="top"></a> Cap 3.1 - Installiamo Bootstrap

In rails 7 non c'è più l'esigenza di passare per webpack ed è tornato in auge l'asset-pipe-line.
Inoltre nell'asset-pipeline al posto di *Sprockets* adesso c'è il più leggero *Propshaft*.



## Risorse interne

- []()



## Risorse esterne

- [The Plan for Rails 8](https://fly.io/ruby-dispatch/the-plan-for-rails-8/)
- [Installing Bootstrap Rails 7: A Step-by-Step Guide](https://medium.com/@gjuliao32/installing-bootstrap-rails-7-a-step-by-step-guide-0fc4a843d94f)
- [Bootstrap 5 in Rails 7 - importmaps & sprockets](https://blog.eq8.eu/til/how-to-use-bootstrap-5-in-rails-7.html)
- [Adding Bootstrap To Rails 7 Using Import map And Solve The Dropdown Problem](https://www.youtube.com/watch?v=tSu8xF0A2ek)
- [Rails 7, Bootstrap 5 e importmaps](https://www.youtube.com/watch?v=ZZAVy67YfPY)



## Cos'è impportmap

Da Rails 7 la gemma `importmap` è installata di default ed in ogni nuova applicazione è presente il suo file di configurazione.

[Codice 01 - .../config/importmap.rb - line: 51]()

```ruby
# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
```

Inportmap è un "indice di libreria" che ti permette di puntare a varie librerie o tramite CDN (quindi repositories remoti) o facendo il download dei pacchetti che ti servono rendondoli disponibili alla nostra applicazione.

Per usare queste librerie, o pacchetti, dobbiamo dire alla nostra applicazione di importarli.

Ad esempio se andiamo sulla cartella *javascript* vediamo alcuni esempi di import.

[Codice 02 - .../app/javascript/application.js - line: 1]()

```javascript
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
```



## Installiamo la gemma `bootstrap`

Adesso iniziamo ad installare *bootstrap*. Partiamo dalla gemma rails.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/bootstrap)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/twbs/bootstrap-rubygem)

[Codice 03 - .../Gemfile - line:45]()

```ruby
# HTML, CSS, and JavaScript framework 
gem 'bootstrap', '~> 5.2', '>= 5.2.1'

# Use Sass to process CSS
gem "sassc-rails"

## ATTENZIONE il tutorial di medium.com suggerisce di usare:
#gem 'cssbundling-rails'

# e non parla di sassc-rails

```

> Il tutorial github della gemma ci chiede: Ensure that sprockets-rails is at least v2.3.2.

> Abbiamo inoltre decommentato la gemma `sassc-rails` che serve a bootstrap.

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```

Esempio

```ruby
ubuntu@ubuntufla:~/ubuntudream (main)$bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...
Using rake 13.0.6
Using concurrent-ruby 1.1.10
Using i18n 1.12.0
Using minitest 5.16.3
Using tzinfo 2.0.5
Using activesupport 7.0.4
Using builder 3.2.4
Using erubi 1.11.0
Using racc 1.6.0
Using nokogiri 1.13.8 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.19.0
Using rails-html-sanitizer 1.4.3
Using actionview 7.0.4
Using rack 2.2.4
Using rack-test 2.0.2
Using actionpack 7.0.4
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.4
Using globalid 1.0.0
Using activejob 7.0.4
Using activemodel 7.0.4
Using activerecord 7.0.4
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.4
Using mail 2.7.1
Using digest 3.1.0
Using timeout 0.3.0
Using net-protocol 0.1.3
Using strscan 3.0.4
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.4
Using actionmailer 7.0.4
Using actiontext 7.0.4
Using public_suffix 5.0.0
Using addressable 2.8.1
Using execjs 2.8.1
Using autoprefixer-rails 10.4.7.0
Using bindex 0.8.1
Using msgpack 1.5.6
Using bootsnap 1.13.0
Fetching popper_js 2.11.6
Installing popper_js 2.11.6
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.0
Using railties 7.0.4
Using ffi 1.15.5
Using sassc 2.4.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using tilt 2.0.11
Using sassc-rails 2.1.2
Fetching bootstrap 5.2.1
Installing bootstrap 5.2.1
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.5.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.6.2
Using importmap-rails 1.1.5
Using jbuilder 2.11.5
Using pg 1.4.3
Using puma 5.6.5
Using rails 7.0.4
Using redis 4.8.0
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.4.0
Using stimulus-rails 1.1.0
Using turbo-rails 1.1.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 18 Gemfile dependencies, 83 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/ubuntudream (main)$
```



## Importiamo bootstrap nel nostro stylesheets

Innanzitutto, siccome abbiamo attivato Sass (Scss), dobbiamo cambiare l'estensione del file stylesheets/application da `.css` a `.scss`.

Prima                         | Dopo
| :---                        | :--- 
`stylesheets/application.css` | `stylesheets/application.scss`

> be sure you replace your `application.css` with `application.scss`. 
> (That means app/assets/stylesheets/application.css should not exist!)


Adesso aggiorniamo il file.

[Code 04 - .../app/assets/stylesheets/application.scss - line:01]()

```scss
@import "bootstrap";
```

> Nota:
> Cancelliamo le due righe:<br/>
> `*= require_tree .`<br/>
> `*= require_self`<br/>
> perché non sono un semplice commento ma dei comandi che non ci servono.



## Aggiungiamo Bootstrap 5 JS al nostro progetto Rails via importmaps

```bash
$ bin/importmap pin bootstrap --download
```

> l'opzione `--download` scarica localmente la libreria.
> se non la usavamo si creava un puntamento ai CDN (repositories remoti)

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (main)$bin/importmap pin bootstrap --download
Pinning "bootstrap" to vendor/javascript/bootstrap.js via download from https://ga.jspm.io/npm:bootstrap@5.2.1/dist/js/bootstrap.esm.js
Pinning "@popperjs/core" to vendor/javascript/@popperjs/core.js via download from https://ga.jspm.io/npm:@popperjs/core@2.11.6/lib/index.js
ubuntu@ubuntufla:~/ubuntudream (main)$
```

L'esecuzione del comando aggiunge il codice JS, le librerie, e le righe per bootstrap and popperjs su config/importmaps.rb

[Codice n/a - .../config/importmap.rb - line: 51]()

```ruby
pin "bootstrap" # @5.2.1
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.6
```

> `popper` è una libreria di javascript che è utilizzata per il componenete `tooltips` di BootStrap.

ATTENZIONE!
CON LE DUE RIGHE IN ALTO **NON** FUNZIONA!!! (Anche se a vederle sembrano giuste)

Dobbiamo cambiarle:

[Codice 05 - .../config/importmap.rb - line: 51]()

```ruby
pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
```

> Non mi è chiaro perché così funziona ma mi adeguo *_* <br/>
> Anche le istruzioni su github della gemma bootstrap riportano righe simili...


Se **NON** avessimo fatto il download avremmo avuto delle chiamate differenti al CDN `ga.jspm.io` che è quello di default. Ad oggi una delle due ha anche un problema infatti consigliano di usare un CDN differente. Nell'esempio di seguito è usato il CDN `unpkg.com`.

Quick Note:
For some reason popperjs acts broken in my Rails7 project when I load it from default ga.jspm.io CDN. That’s why I recommend to load it from unpkg.com:

[Codice n/a - .../config/importmap.rb - line:1]()

```ruby
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.2/dist/esm/index.js" # use unpkg.com as ga.jspm.io contains a broken popper package
```



## Attiviamo le librerie

Then you need to just import bootstrap and popper in your application.js

[Codice 06 - .../app/javascript/application.js - line: 1]()

```javascript
import "popper"
import "bootstrap"
```



## Implementiamo pre-compilazione della libreria

Vamos necessitar que essas bibilotecas se compilem de alguma forma en desarollo para poterla utilizarla.
Para poderse servirla dallo asset-pipeline.

[Codice 07 - .../config/initializers/assets.rb - linea: 1]()

```ruby
Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js )
```

Abbiamo finito per l'installazione


## Layout files

Make sure your layout (app/views/application.html.erb) contains:

[Codice 08 - .../app/views/layouts/application.html.erb - linea: 1]()

```html+erb
<%# ... %>
<head>
<%# ... %>
<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>  <%# this loads Sprockets/Rails asset pipeline %>
    <%= javascript_importmap_tags %> <%#  this loads JS from importmaps %>
    <%# ... %>
  </head>
  <!-- ... -->
```
