# <a name="top"></a> Applicazione con Tailwind [25/04/17]

Installiamo bootstrap



## Installiamo le gemme

Aggiungiamo queste gemme al Gemfile:
- [rubygems.org: dartsass-rails](https://rubygems.org/gems/dartsass-rails)
- [rubygems.org: bootstrap](https://rubygems.org/gems/bootstrap)

***Codice 01 - .../Gemfile - linea:65***

```ruby
gem "dartsass-rails"
gem "bootstrap", "~> 5.3.3"
```

Ed installiamole con `bundle`:

```shell
❯ bundle install
```

>note:
> dartsass-rails in fase di installazione mi da diversi warning di obsolescenza (Deprecation Warning) però ad oggi è la scelta più pulita con proshaft ed evita di installare vari pacchetti con yarn.

The dartsass gem is for sass support. Installata la gemma installiamo dartsass

```shell
❯ rails dartsass:install
```



## Aggiorniamo importmap

***Codice 02 - .../config/importmap.rb - linea:12***

```ruby
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
```



## Aggiorniamo application.js

The application.js file should be like this:

***Codice 03 - .../app/javascript/application.js - linea:1***

```javascript
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import LocalTime from "local-time"
LocalTime.start()

import "@popperjs/core";
// import "popper"
import "bootstrap"
```

>Nota;
> `import "popper"` NON funziona ed installata la navbar non vanno né i menù a cascata né l'hamburger menu.
> risolto con import `"@popperjs/core";` come segnalato in un commento in basso dell'articolo.
> Credo che il `;` alla fine della riga sia opzionale.



## Aggiorniamo lato css lo stylesheet

Per prima cosa, nella cartella `app/stylesheets` cambiamo l'estensione del file da `application.css` a `application.scss`, questo perché per bootstrap usiamo la gemma `dartsass-rails` lavorando con sass e l'estensione che lo gestisce è `.scss`.

Una volta cambiata l'estensione possiamo aggiungere nel file l'import di bootstrap.

***Codice 04 - .../app/stylesheets/application.scss - linea:12***

```scss
// Custom bootstrap variables must be set or imported *before* bootstrap.
 @import "bootstrap"
```



## Creiamo una pagina statica per fare le prove con bootstrap


```shell
❯ rails g controller Mockups test_a
```

Ed inseriamoci alcuni componenti bootstap

- [l'alert](https://getbootstrap.com/docs/5.3/components/alerts/)
- [i pulsanti](https://getbootstrap.com/docs/5.3/components/buttons/)
- [la navbar](https://getbootstrap.com/docs/5.3/components/navbar/)


```shell
<div class="alert alert-primary" role="alert">
  This is a primary alert—check it out!
</div>


<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-secondary">Secondary</button>
<button type="button" class="btn btn-success">Success</button>
<button type="button" class="btn btn-danger">Danger</button>
<button type="button" class="btn btn-warning">Warning</button>
<button type="button" class="btn btn-info">Info</button>
<button type="button" class="btn btn-light">Light</button>
<button type="button" class="btn btn-dark">Dark</button>

<button type="button" class="btn btn-link">Link</button>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" aria-disabled="true">Disabled</a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>
```



## Facciamo partire il server

Invece di usare `rails s` usiamo `bin/dev` perché questo permette di far partire anche dei processi ausiliari, *"auxiliaries watcher processes"*, ad esempio nel caso di utilizzo di `esbuild` o di `tailwindcss`.

```shell
❯ cd blog/
❯ bin/dev
```



## Risorse esterne

- [Medium: How to use bootstrap in rails8 - Shin Jiang - Nov 21, 2024](https://medium.com/@xnjiang/how-to-use-bootstrap-in-rails8-cd0d53f1c3bc)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
