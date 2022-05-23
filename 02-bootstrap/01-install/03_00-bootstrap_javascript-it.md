# <a name="top"></a> Cap 1.3 - Attiviamo il javascript di Bootstrap

Implementiamo la parte javascript di Bootstrap.
Completiamo la parte di installazione di boostrap aggiungendo la funzionalità "inline" per il css solo lato development perché ci aiuta in fase di debug.

Vediamo che l'installazione di BootStrap è andata a buon fine sia lato *stylesheets (scss)* che *javascript (js)*.



## Inseriamo il nav_bar

Questo componente di bootstrap ha bisogno di javascript per funzionare.

***codice 01 - .../app/views/mockups/page_a.html.erb - line:1***

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

***codice 02 - .../config/initializers/assets.rb - line:13***

```ruby
Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js )
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_05-config-initializers-assets.rb)


pin the compiled asset in *config/importmap.rb*.

***codice 03 - .../config/importmap.rb - line:10***

```ruby
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_06-config-importmap.rb)


Include bootstrap in your *app/javascript/application.js*.

***codice 04 - .../app/javascript/application.js - line:6***

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



## Verifichiamo il *viewport*

Così come consigliato nel [Bootstrap sito ufficiale: Starter template](https://getbootstrap.com/docs/5.1/getting-started/introduction/#starter-template) è importante assegnare il ***viewport*** perché è questo che gestisce la parte **responsive** di bootstrap.

> Se non c'è quando stringo la finestra del browser invece di avere l'*hamburger menu* il *nav_bar* resta uguale e si attiva le barra di scorrimento laterale sotto alla finestra del browser.

Verifichiamo che sia presente nel layout.

***codice 01 - .../app/views/layouts/application.html.erb - line:5***

```html+erb
    <meta name="viewport" content="width=device-width, initial-scale=1">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_01-views-layouts-application.html.erb)



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
$ git commit -m "Implement javascript on bootstrap"
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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-install/02_00-install-bootstrap-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-install/04_00-bootstrap_icons-it.md)
