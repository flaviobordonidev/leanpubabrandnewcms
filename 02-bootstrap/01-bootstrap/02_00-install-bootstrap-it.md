# <a name="top"></a> Cap 1.2 - Installiamo Bootstrap

In rails 7 non c'è più l'esigenza di passare per webpack ed è tornato in auge l'asset-pipeline.

> Lo spiega bene lo sviluppatore rails *DAVID HEINEMEIER HANSSON (DHH)* nel suo post
> [Modern web apps without JavaScript bundling or transpiling - August 12, 2021](https://world.hey.com/dhh/modern-web-apps-without-javascript-bundling-or-transpiling-a20f2755)


Non mi ha funzionato l'installazione che prevede le due gemme 

- gem 'jsbundling-rails', '~> 1.0', '>= 1.0.2' # Bundle and transpile JavaScript in Rails with esbuild
- gem 'cssbundling-rails', '~> 1.1' # Bundle and process CSS with Bootstrap in Rails via Node.js

> che sono quelle che sono installate quando fai `rails new bl7_0 -j esbuild --css bootstrap --database=postgresql`

Provo quindi con la versione alternativa proposta da questi due articoli che vanno controcorrente ed usano `gem 'bootstrap'` e `gem "sassc-rails"`.

- [Rails 7, Bootstrap 5 and importmaps without nodejs](https://dev.to/coorasse/rails-7-bootstrap-5-and-importmaps-without-nodejs-4g8)
- [RAILS 7 BOOTSTRAP USING IMPORTMAP](https://jasonfleetwoodboldt.com/courses/stepping-up-rails/rails-7-bootstrap/)



## Risorse interne

- 99-rails_reference/boot_strap/01-bootstrap_intall



## Risorse esterne

- [GoRails #417 · October 11, 2021 - How to use Bootstrap with CSS bundling in Rails](https://gorails.com/episodes/bootstrap-css-bundling-rails?autoplay=1)
- [bootstrap sito ufficiale - Install RubyGems](https://getbootstrap.com/docs/5.1/getting-started/download/#rubygems)
- [How to add bootstrap 5 to an existing Rails 7 app](https://www.uday.net/add-bootstrap-5-to-an-existing-Rails-7-app)
- [Rails 7.0: Fulfilling a vision](https://rubyonrails.org/2021/12/15/Rails-7-fulfilling-a-vision)


Questi due articoli invece vanno controcorrente ed usano `gem 'bootstrap'` e `gem "sassc-rails"`.

- [Rails 7, Bootstrap 5 and importmaps without nodejs](https://dev.to/coorasse/rails-7-bootstrap-5-and-importmaps-without-nodejs-4g8)
- [RAILS 7 BOOTSTRAP USING IMPORTMAP](https://jasonfleetwoodboldt.com/courses/stepping-up-rails/rails-7-bootstrap/)




## Apriamo il branch "BootStrap"

```bash
$ git checkout -b bs
```



## Installiamo bootstrap

Stick with just `rails new app-name` (and not `rails new app-name -j esbuild --css bootstrap`).
This will setup exactly the tools I want: `sprockets` and `importmaps`. It will also setup automatically for me *stimulus* and *turbo*, which is great because I use them most of the time anyway.

> *sprockets* è un altro modo di riferirsi all'*asset-pipeline*

Add *bootstrap gem* and enable the *gem sassc-rails* in the Gemfile. This will allow us to compile bootstrap from SCSS without node.

Installiamo le seguenti due gemme:

- `gem 'bootstrap', '~> 5.1.3'`
- `gem sassc-rails`


> bootstrap
>
> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/bootstrap)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/twbs/bootstrap-rubygem)
>
> ed anche al [sito ufficiale di bootstrap](https://getbootstrap.com/docs/5.1/getting-started/download/#rubygems)


> sassc-rails
>
> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/sassc-rails)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/sass/sassc-rails)

***codice 01 - .../Gemfile - line:48***

```ruby
# Bootstrap 5 ruby gem for Ruby on Rails (Sprockets)
gem 'bootstrap', '~> 5.1', '>= 5.1.3'

# Integrate SassC-Ruby into Rails.
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_01-gemfile)

> La `gem 'sassc-rails'` è già presente commentata nel Gemfile in riga 46

Eseguiamo l'installazione delle gemme con bundle

```bash
$ bundle install
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies....
Using rake 13.0.6
Using concurrent-ruby 1.1.9
Using i18n 1.10.0
Using minitest 5.15.0
Using tzinfo 2.0.4
Using activesupport 7.0.2.2
Using builder 3.2.4
Using erubi 1.10.0
Using racc 1.6.0
Using nokogiri 1.13.3 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.14.0
Using rails-html-sanitizer 1.4.2
Using actionview 7.0.2.2
Using rack 2.2.3
Using rack-test 1.1.0
Using actionpack 7.0.2.2
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.2.2
Using globalid 1.0.0
Using activejob 7.0.2.2
Using activemodel 7.0.2.2
Using activerecord 7.0.2.2
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.2.2
Using mail 2.7.1
Using digest 3.1.0
Using io-wait 0.2.1
Using timeout 0.2.0
Using net-protocol 0.1.2
Using strscan 3.0.1
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.2.2
Using actionmailer 7.0.2.2
Using actiontext 7.0.2.2
Using public_suffix 4.0.6
Using addressable 2.8.0
Fetching execjs 2.8.1
Installing execjs 2.8.1
Fetching autoprefixer-rails 10.4.2.0
Installing autoprefixer-rails 10.4.2.0
Using aws-eventstream 1.2.0
Using aws-partitions 1.568.0
Using aws-sigv4 1.4.0
Using jmespath 1.6.1
Using aws-sdk-core 3.130.0
Using aws-sdk-kms 1.55.0
Using aws-sdk-s3 1.113.0
Using bcrypt 3.1.16
Using bindex 0.8.1
Using msgpack 1.4.5
Using bootsnap 1.10.3
Fetching popper_js 2.9.3
Installing popper_js 2.9.3
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.5.4
Using railties 7.0.2.2
Using ffi 1.15.5
Fetching sassc 2.4.0
Installing sassc 2.4.0 with native extensions
Using sprockets 4.0.3
Using sprockets-rails 3.4.2
Fetching tilt 2.0.10
Installing tilt 2.0.10
Fetching sassc-rails 2.1.2
Installing sassc-rails 2.1.2
Fetching bootstrap 5.1.3
Installing bootstrap 5.1.3
Using bundler 2.3.7
Using matrix 0.4.2
Using regexp_parser 2.2.1
Using xpath 3.2.0
Using capybara 3.36.0
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.4.0
Using orm_adapter 0.5.0
Using responders 3.0.1
Using warden 1.2.9
Using devise 4.8.1
Using mini_magick 4.11.0
Using ruby-vips 2.1.4
Using image_processing 1.12.2
Using importmap-rails 1.0.3
Using jbuilder 2.11.5
Using pagy 5.10.1
Using pg 1.3.3
Using puma 5.6.2
Using pundit 2.2.0
Using rails 7.0.2.2
Using rexml 3.2.5
Using rubyzip 2.3.2
Using selenium-webdriver 4.1.0
Using stimulus-rails 1.0.4
Using turbo-rails 1.0.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 23 Gemfile dependencies, 99 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/bl7_0 (bs)$
```

> Ensure that `sprockets-rails` is at least v2.3.2. <br/>
> `bundle info sprockets-rails` --> `sprockets-rails (3.4.2)`



## Concludiamo la parte CSS di Bootstrap

You can simply import Bootstrap styles in app/assets/stylesheets/application.scss:

```
// Custom bootstrap variables must be set or imported *before* bootstrap.
// here your custom bootstrap variables...
@import "bootstrap";
```

That's it for the CSS part. Running rails assets:precompile will generate what you want.

> The available *bootstrap variables* can be found [here](https://github.com/twbs/bootstrap-rubygem/blob/master/assets/stylesheets/bootstrap/_variables.scss).

> Make sure the file has *.scss* extension. If you have just generated a new Rails app, it may come with a *.css* file instead. If this file exists, it will be served instead of Sass, so rename it:
>
> `$ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss`
>
> Then, remove all the `*= require` and `*= require_tree` statements from the Sass file. Instead, use `@import` to import Sass files.
>
> Do not use `*= require` in Sass or your other stylesheets will not be able to access the Bootstrap mixins and variables.


Vediamo il nostro file `app/assets/stylesheets/application.css`.

> Da notare che l'estensione è `.css`

***codice 02 - .../app/assets/stylesheets/application.css - line:1***

```scss
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS (and SCSS, if configured) file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_02-assets-stylesheets-application.css)

Nel file c'è tutto commento eccetto le due righe `*= require` e `*= require_tree` che sembrano un commento ma in realtà sono attive.

> Questa parte di configurazione mi ricorda quella che facevamo su Rails 5.2.

Potremmo cancellare il file `app/assets/stylesheets/application.css` e creare il nuovo file `app/assets/stylesheets/application.scss` vuoto ma preferisco lasciare la parte di commento perché ci può essere utile navigando su internet e vedendo vecchi esempi di codice.

Quindi cancelliamo le due righe che non servono e cambiamo l'estensione del file da `.css` a `.scss`ed aggiungiamo la riga che richiama *bootstrap*.

Vediamo il risultato.

***codice 03 - .../app/assets/stylesheets/application.scss - line:1***

```scss
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS (and SCSS, if configured) file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 */

// Custom bootstrap variables must be set or imported *before* bootstrap.
// here your custom bootstrap variables...
@import "bootstrap";
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_03-assets-stylesheets-application.scss)


> Più avanti aggiungeremo anche la riga per le icone `@import 'bootstrap-icons/font/bootstrap-icons';`



## Precompiliamo l'asset-pipeline

Su sprocket (anche detto asset-pipeline), in automatico quando lanciamo il server è fatta una compilazione di tutti i files stylesheets e javascript. è possibile fare una pre-compilazione che ci aiuta e ci fa vedere se ci sono degli errori. 

```bash
$ rails assets:precompile
```

> Il precompile crea tanti file compressi `.gz` nella cartella `.../public/assets`

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$rails assets:precompile
I, [2022-03-24T15:39:46.321389 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/manifest-b84bfa46a33d7f0dc4d2e7b8889486c9a957a5e40713d58f54be71b66954a1ff.js
I, [2022-03-24T15:39:46.321897 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/manifest-b84bfa46a33d7f0dc4d2e7b8889486c9a957a5e40713d58f54be71b66954a1ff.js.gz
I, [2022-03-24T15:39:46.322384 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actiontext-75897e8fb5e3d81f58aa21e348efc72e19d98c9efbe8c73f250f5a15431d07e1.css
I, [2022-03-24T15:39:46.322753 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actiontext-75897e8fb5e3d81f58aa21e348efc72e19d98c9efbe8c73f250f5a15431d07e1.css.gz
I, [2022-03-24T15:39:46.326651 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-f9754ef55542bb1097a4fe8900a2d73ec9322b4b948584876e5302cf9ab7b411.css
I, [2022-03-24T15:39:46.327432 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-f9754ef55542bb1097a4fe8900a2d73ec9322b4b948584876e5302cf9ab7b411.css.gz
I, [2022-03-24T15:39:46.327806 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-a7fd3fc58be844f89656edec1ec73e18f9ab627e54b2aea67a97aad4613b6305.js
I, [2022-03-24T15:39:46.327962 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-a7fd3fc58be844f89656edec1ec73e18f9ab627e54b2aea67a97aad4613b6305.js.gz
I, [2022-03-24T15:39:46.328156 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/controllers/application-368d98631bccbf2349e0d4f8269afb3fe9625118341966de054759d96ea86c7e.js
I, [2022-03-24T15:39:46.328300 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/controllers/application-368d98631bccbf2349e0d4f8269afb3fe9625118341966de054759d96ea86c7e.js.gz
I, [2022-03-24T15:39:46.328486 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/controllers/hello_controller-549135e8e7c683a538c3d6d517339ba470fcfb79d62f738a0a089ba41851a554.js
I, [2022-03-24T15:39:46.328628 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/controllers/hello_controller-549135e8e7c683a538c3d6d517339ba470fcfb79d62f738a0a089ba41851a554.js.gz
I, [2022-03-24T15:39:46.328810 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/controllers/index-2db729dddcc5b979110e98de4b6720f83f91a123172e87281d5a58410fc43806.js
I, [2022-03-24T15:39:46.335027 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/controllers/index-2db729dddcc5b979110e98de4b6720f83f91a123172e87281d5a58410fc43806.js.gz
I, [2022-03-24T15:39:46.335241 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/turbo-7b0aa11f61631e9e535944fe9c3eaa4186c9df9d6c9d8b1d16a1ed3d85064cf0.js
I, [2022-03-24T15:39:46.335392 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/turbo-7b0aa11f61631e9e535944fe9c3eaa4186c9df9d6c9d8b1d16a1ed3d85064cf0.js.gz
I, [2022-03-24T15:39:46.335590 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/turbo.min-96cbf52c71021ba210235aaeec4720012d2c1df7d2dab3770cfa49eea3bb09da.js
I, [2022-03-24T15:39:46.335903 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/turbo.min-96cbf52c71021ba210235aaeec4720012d2c1df7d2dab3770cfa49eea3bb09da.js.gz
I, [2022-03-24T15:39:46.336091 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/turbo.min.js-2e71e75cec6429b11d9575a009df6f148e9c52fbae30baf2292ec44620163b6f.map
I, [2022-03-24T15:39:46.339917 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actiontext-28c61f5197c204db043317a8f8826a87ab31495b741f854d307ca36122deefce.js
I, [2022-03-24T15:39:46.340116 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actiontext-28c61f5197c204db043317a8f8826a87ab31495b741f854d307ca36122deefce.js.gz
I, [2022-03-24T15:39:46.340313 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/trix-1563ff9c10f74e143b3ded40a8458497eaf2f87a648a5cbbfebdb7dec3447a5e.js
I, [2022-03-24T15:39:46.340462 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/trix-1563ff9c10f74e143b3ded40a8458497eaf2f87a648a5cbbfebdb7dec3447a5e.js.gz
I, [2022-03-24T15:39:46.340656 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/trix-fe178d6f8c056d8e63aecb6557bc65676897f43e4aee3e68584437841a99fc23.css
I, [2022-03-24T15:39:46.340805 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/trix-fe178d6f8c056d8e63aecb6557bc65676897f43e4aee3e68584437841a99fc23.css.gz
I, [2022-03-24T15:39:46.340995 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/es-module-shims-98e5c1733b56bbd38eb81a6b95c76993d1549a149630db86b70b52ef7bf09f38.js
I, [2022-03-24T15:39:46.341143 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/es-module-shims-98e5c1733b56bbd38eb81a6b95c76993d1549a149630db86b70b52ef7bf09f38.js.gz
I, [2022-03-24T15:39:46.341336 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/es-module-shims.min-8b21b40925fc92896e87358f40a2a8aaea6bf306b34ee4a215ec09c59c6cb3ba.js
I, [2022-03-24T15:39:46.341483 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/es-module-shims.min-8b21b40925fc92896e87358f40a2a8aaea6bf306b34ee4a215ec09c59c6cb3ba.js.gz
I, [2022-03-24T15:39:46.341670 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/es-module-shims.js-b3dc1eaec0edc72cb130edacd5193386c67b6be171383614226d986a6b991ad4.map
I, [2022-03-24T15:39:46.343883 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-0ce1b26664523b4ad005eb6a6358abf11890dad17c46d207e5b61a04056d7b26.js
I, [2022-03-24T15:39:46.344041 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-0ce1b26664523b4ad005eb6a6358abf11890dad17c46d207e5b61a04056d7b26.js.gz
I, [2022-03-24T15:39:46.344232 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-autoloader-c584942b568ba74879da31c7c3d51366737bacaf6fbae659383c0a5653685693.js
I, [2022-03-24T15:39:46.344381 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-autoloader-c584942b568ba74879da31c7c3d51366737bacaf6fbae659383c0a5653685693.js.gz
I, [2022-03-24T15:39:46.344571 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-importmap-autoloader-db2076c783bf2dbee1226e2add52fef290b5d31b5bcd1edd999ac8a6dd31c44a.js
I, [2022-03-24T15:39:46.344937 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-importmap-autoloader-db2076c783bf2dbee1226e2add52fef290b5d31b5bcd1edd999ac8a6dd31c44a.js.gz
I, [2022-03-24T15:39:46.345122 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-loading-1fc59770fb1654500044afd3f5f6d7d00800e5be36746d55b94a2963a7a228aa.js
I, [2022-03-24T15:39:46.345267 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-loading-1fc59770fb1654500044afd3f5f6d7d00800e5be36746d55b94a2963a7a228aa.js.gz
I, [2022-03-24T15:39:46.345465 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus.min-900648768bd96f3faeba359cf33c1bd01ca424ca4d2d05f36a5d8345112ae93c.js
I, [2022-03-24T15:39:46.345614 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus.min-900648768bd96f3faeba359cf33c1bd01ca424ca4d2d05f36a5d8345112ae93c.js.gz
I, [2022-03-24T15:39:46.345792 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-autoloader-c584942b568ba74879da31c7c3d51366737bacaf6fbae659383c0a5653685693.js
I, [2022-03-24T15:39:46.345930 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-autoloader-c584942b568ba74879da31c7c3d51366737bacaf6fbae659383c0a5653685693.js.gz
I, [2022-03-24T15:39:46.346106 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-importmap-autoloader-db2076c783bf2dbee1226e2add52fef290b5d31b5bcd1edd999ac8a6dd31c44a.js
I, [2022-03-24T15:39:46.346247 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-importmap-autoloader-db2076c783bf2dbee1226e2add52fef290b5d31b5bcd1edd999ac8a6dd31c44a.js.gz
I, [2022-03-24T15:39:46.346419 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-loading-1fc59770fb1654500044afd3f5f6d7d00800e5be36746d55b94a2963a7a228aa.js
I, [2022-03-24T15:39:46.346559 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus-loading-1fc59770fb1654500044afd3f5f6d7d00800e5be36746d55b94a2963a7a228aa.js.gz
I, [2022-03-24T15:39:46.364484 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/stimulus.min.js-5cdf38f474c7d64a568a43e5de78b4313515aa0e4bd3d13fac297fffeba809f0.map
I, [2022-03-24T15:39:46.368112 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/activestorage-3ab61e47dd4ee2d79db525ade1dca2ede0ea2b7371fe587e408ee37b7ade265d.js
I, [2022-03-24T15:39:46.368293 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/activestorage-3ab61e47dd4ee2d79db525ade1dca2ede0ea2b7371fe587e408ee37b7ade265d.js.gz
I, [2022-03-24T15:39:46.368491 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/activestorage.esm-01f58a45d77495cdfbdfcc872902a430426c4391634ec9c3da5f69fbf8418492.js
I, [2022-03-24T15:39:46.368642 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/activestorage.esm-01f58a45d77495cdfbdfcc872902a430426c4391634ec9c3da5f69fbf8418492.js.gz
I, [2022-03-24T15:39:46.368830 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actioncable-da745289dc396d1588ddfd149d68bb8e519d9e7059903aa2bb98cfc57be6d66e.js
I, [2022-03-24T15:39:46.368975 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actioncable-da745289dc396d1588ddfd149d68bb8e519d9e7059903aa2bb98cfc57be6d66e.js.gz
I, [2022-03-24T15:39:46.369164 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actioncable.esm-3d92de0486af7257cac807acf379cea45baf450c201e71e3e84884c0e1b5ee15.js
I, [2022-03-24T15:39:46.369461 #9374]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/actioncable.esm-3d92de0486af7257cac807acf379cea45baf450c201e71e3e84884c0e1b5ee15.js.gz
ubuntu@ubuntufla:~/bl7_0 (bs)$
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* http://192.168.64.3:3000/

Vediamo che il pulsante di *logout* è già in stile bootstrap.



## Inseriamo il nav_bar

Questo componente di bootstrap ha bisogno di javascript per funzionare.

***codice 04 - .../app/views/mockups/page_a.html.erb - line:1***

```html+erb
<nav class="navbar navbar-expand-lg navbar-light bg-light">
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
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_04-views-mockups-page_a.html.erb)

Al momento si visualizza ma non funziona né il drop-down menu (menu a cascata), né funziona il menu che si crea quando stringi la finestra del browser (*hamburger menu*). Per farli funzionare dobbiamo attivare la parte di javascript.



## Concludiamo la parte Javascript di Bootstrap

For the javascript part we need to do three things:

Precompile the *bootstrap.min.js* that comes with the gem, by adding to *config/initializers/assets.rb*

***codice 05 - .../config/initializers/assets.rb - line:13***

```ruby
Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js )
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_05-config-initializers-assets.rb)


pin the compiled asset in *config/importmap.rb*.

***codice 06 - .../config/importmap.rb - line:10***

```ruby
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_06-config-importmap.rb)


Include bootstrap in your *app/javascript/application.js*.

***codice 07 - .../app/javascript/application.js - line:6***

```javascript
import "popper"
import "bootstrap"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_07-javascript-application.js)


> I prefer this approach rather than pinning a CDN because we avoid diverging versions of Bootstrap.



## Precompiliamo l'asset-pipeline

Per far funzionare javascript in locale dobbiamo fare il precompile.

```bash
$ rails assets:precompile
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$rails assets:precompile
I, [2022-03-24T16:13:53.566301 #9673]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-204534d7b1a4e47d676e3382e816c317dc63cd220b60c4ee3a02a13a2cbd3a8c.js
I, [2022-03-24T16:13:53.567357 #9673]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-204534d7b1a4e47d676e3382e816c317dc63cd220b60c4ee3a02a13a2cbd3a8c.js.gz
I, [2022-03-24T16:13:53.568878 #9673]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/bootstrap.min-20a034247d4d545a7a2d49d62ee00c40f53f825562ed9d6c9af1ad42383e67f6.js
I, [2022-03-24T16:13:53.569915 #9673]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/bootstrap.min-20a034247d4d545a7a2d49d62ee00c40f53f825562ed9d6c9af1ad42383e67f6.js.gz
I, [2022-03-24T16:13:53.570573 #9673]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/popper-f6f216e33a146423f2ff236cdf13e2b7472a4333e26a59bfafd1d42383c61682.js
I, [2022-03-24T16:13:53.576229 #9673]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/popper-f6f216e33a146423f2ff236cdf13e2b7472a4333e26a59bfafd1d42383c61682.js.gz
ubuntu@ubuntufla:~/bl7_0 (bs)$
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamolo il browser sull'URL:

* http://192.168.64.3:3000/

Vediamo che adesso il nav_bar funziona!!! ^_^



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "install bootstrap whitout node-js"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku bs:main
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo dopo aver conferma che bootstrap funziona correttamente



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-bootstrap/01_00-bootstrap_story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-bootstrap/03_00-bootstrap_complete-it.md)
