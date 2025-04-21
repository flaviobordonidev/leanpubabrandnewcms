# <a name="top"></a> Applicazione con Tailwind [25/04/17]

Installiamo Tailwind CSS



## Installiamo le gemme

Aggiungiamo queste gemme al Gemfile:

```shell
❯ bundle add tailwindcss-ruby
❯ bundle add tailwindcss-rails
```

> note:
> se il solo comando `bundle ...` non dovesse funzionare usare `./bin/bundle ...`

I due comandi appena dati non fanno altro che aggiungere le seguenti due righe in fondo al file `Gemfile` ed eseguire già `bundle install` per installare le gemme. Vediamo il  `Gemfile`.

***Codice 01 - .../Gemfile - linea:65***

```ruby
gem "tailwindcss-ruby", "~> 4.1"

gem "tailwindcss-rails", "~> 4.2"
```

Vediamo che sono già stata installate le gemme. Rilanciando il comando di installazione ci dirà che è già tutto installato.

```shell
❯ bundle install
```

Abbiamo verificato che le gemme sono installate. Adesso dobbiamo lanciare lo script per installare tailwindcss nella nosta app, ossia per inserire le linee di codice nei vari files per far si che tutto funzioni.

```shell
❯ rails tailwindcss:install
```

> note:
> se il solo comando `rails ...` non dovesse funzionare usare `./bin/rails ...`

I files aggiornati sono:
- app/views/layouts/application.html.erb
- app/assets/builds/.keep
- app/assets/builds/tailwind.css
- .gitignore
- app/assets/tailwind/application.css
- Procfile.dev
- intallato `foreman`

Abbiamo finito!
Adesso verifichiamo.



## Creiamo una pagina statica per fare le prove con Tailwind css


```shell
❯ rails g controller Mockups test_a
```

Ed inseriamoci alcuni componenti bootstap

- [l'alert](https://getbootstrap.com/docs/5.3/components/alerts/)
- [i pulsanti](https://getbootstrap.com/docs/5.3/components/buttons/)
- [la navbar](https://getbootstrap.com/docs/5.3/components/navbar/)


```shell
<h1 class="text-3xl font-bold underline">
  Hello world!
</h1>
```










## Verifichiamo importmap

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






## Facciamo partire il server

Invece di usare `rails s` usiamo `bin/dev` perché questo permette di far partire anche dei processi ausiliari, *"auxiliaries watcher processes"*, ad esempio nel caso di utilizzo di `esbuild` o di `tailwindcss`.

```shell
❯ cd blog/
❯ bin/dev
```

Nel nostro caso non abbiamo processi ausiliari e quindi parte solo il webserver `puma`.

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/00-set_the_environment/02-rubyonrails/02_fig01-rails_starting_screen.png)

vediamo il risultato della gestione dei post all'url: `http://127.0.0.1:3000/posts`

Verrà visualizzata la view `posts/index`

All'url: `http://127.0.0.1:3000/posts.json`

Verrà visualizzata il file json. Questo normalmente è gestito come web API.



## Risorse esterne

- [Install Tailwind CSS with Ruby on Rails](https://tailwindcss.com/docs/installation/framework-guides/ruby-on-rails)


- [Learn Tailwind CSS – Course for Beginners](https://www.youtube.com/watch?v=ft30zcMlFao)

- [Tailwind CSS Full Course for Beginners | Complete All-in-One Tutorial | 3 Hours](https://www.youtube.com/watch?v=lCxcTsOHrjo)


- [1 - Multi-line Classes | Uncommon TailwindCSS](https://www.youtube.com/watch?v=MyK4TMa_jRI&list=PLmfauxg0uEuqmiIMbyg9Iz3LefJZLqrzS&index=3)
- [2 - Color Palettes | Uncommon TailwindCSS](https://www.youtube.com/watch?v=y4DrhAz6ewI&list=PLmfauxg0uEuqmiIMbyg9Iz3LefJZLqrzS)
- [3 - My Only TailwindCSS Components | Uncommon TailwindCSS](https://www.youtube.com/watch?v=NYelOQWAfhs&list=PLmfauxg0uEuqmiIMbyg9Iz3LefJZLqrzS&index=2)
- [4 - Don't Repeat Yourself | Uncommon TailwindCSS](https://www.youtube.com/watch?v=vlmQPt5g7YE&list=PLmfauxg0uEuqmiIMbyg9Iz3LefJZLqrzS&index=4)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
