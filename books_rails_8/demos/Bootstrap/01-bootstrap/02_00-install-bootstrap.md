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

// import "popper"
import "@popperjs/core";
import "bootstrap"
```

>Nota;
> `import "popper"` NON funziona ed installata la navbar non vanno né i menù a cascata né l'hamburger menu.
> risolto con import `"@popperjs/core";` come segnalato in un commento in basso dell'articolo.
> Credo che il `;` alla fine della riga sia opzionale.



## Aggiorniamo lato css lo stylesheet

Per prima cosa, nella cartella `app/assets/stylesheets` cambiamo l'estensione del file da `application.css` a `application.scss`, questo perché per bootstrap usiamo la gemma `dartsass-rails` lavorando con sass e l'estensione che lo gestisce è `.scss`.

> dartsass:install potrebbe creare già il file application.scss in aggiunta a application.css possiamo cancellarlo e cambiare l'estensione di application.css

Una volta cambiata l'estensione possiamo aggiungere nel file l'import di bootstrap.

***Codice 04 - .../app/assets/stylesheets/application.scss - linea:12***

```scss
// Custom bootstrap variables must be set or imported *before* bootstrap.
 @import "bootstrap"
```

Adesso è tutto configurato. Nel prossimo capitolo iniziamo a usare i componenti di bootstrap.



## Risorse esterne

- [Medium: How to use bootstrap in rails8 - Shin Jiang - Nov 21, 2024](https://medium.com/@xnjiang/how-to-use-bootstrap-in-rails8-cd0d53f1c3bc)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
