



## Analizziamo il codice di style.scss

Cerchiamo di capire cosa ci serve e cosa no.
Il file fa varie chiamate ad altri files attraverso `@import ...` e proviamo a capire il flusso del codice per poter poi sapere dove intervenire per fare delle modifiche.

Proviamo a commentare la parte "Bootstrap core" perché abbiamo già implementato Bootstrap attraverso la gemma rails `bootstrap` e tramite `importmap`.

***code 02 - .../app/assets/stylesheets/application.scss - line:1***

```scss
// Bootstrap variables
@import "../vendor/bootstrap/scss/functions";
@import "../vendor/bootstrap/scss/variables";

// Theme variables
@import "variables";

// User variables
@import "user-variables";

// Bootstrap core
//@import "../vendor/bootstrap/scss/bootstrap";
```


[DAFA]











## Precompile per lo stylesheets

Nell'asset_pipeline l'unico file che si può chiamare direttamente dalla view è "assets/stylesheets/application.scss" questo file è detto file manifest ed è da questo file che dovremmo chiamare tutti gli altri.
Nel nostro caso siccome richiamiamo i vari files di style direttamente dalla view dobbiamo dichiararle all'applicazione. Questa "dichiarazione" è chiamata "precompile". 

Per i nuovi files si può usare tutte le volte che si fanno modifiche il comando

```bash
$ rails assets:precompile
```

Oppure si può aggiungere al config/application che fa in automatico il precompile.

***code n/a - .../config/application.rb - line:21***

```ruby
    # precompile assets pofo stylesheets                                                             
    config.assets.precompile += ['pofo/css/animate.css',
                                 'pofo/css/bootstrap.min.css',
                                 'pofo/css/et-line-icons.css',
                                 'pofo/css/font-awesome.min.css',
                                 'pofo/css/themify-icons.css',
                                 'pofo/css/swiper.min.css',
                                 'pofo/css/justified-gallery.min.css',
                                 'pofo/css/magnific-popup.css',
                                 'pofo/revolution/css/settings.css',
                                 'pofo/revolution/css/layers.css',
                                 'pofo/revolution/css/navigation.css',
                                 'pofo/css/bootsnav.css',
                                 'pofo/css/style.css',
                                 'pofo/css/responsive.css'
                                ]
```

Non seguiamo la convenzione Rails dell'asset_pipeline che prevede di passare per i files manifest perché non li vogliamo attivare per tutta l'applicazione, ma vogliamo richiamarli solo dalle pagine in cui è espressamente fatta la chiamata.

I> Attenzione!
I>
I> Modificando application.rb è necessario riavviare il server rails (rails s ...) per includere le modifiche.



![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/02_fig01-edu_index_4.png)

