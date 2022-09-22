# <a name="top"></a> Cap 2.2 - Assets stylesheets external css

In questo capitolo spostiamo lo `<style>` inline che nel capitolo precedente abbiamo messo sul `layers/bs_demo`. 
Lo spostiamo 3 volte a scopo didattico:

- prima spostiamo il codice in `assets/stylesheets/application`.
  (Questo è un passaggio temporaneo che influenza tutta l'applicazione e non è la soluzione più pulita e più elegante.)
- poi lo spostiamo su un file esterno che richiamiamo da `assets/stylesheets/application`.
  (Questo è un passaggio temporaneo.)
- Infine sganciamo il file esterno da `assets/stylesheets/application` e lo leghiamo direttamente al layer `bs_demo` facendo una nuova chiamata nell'`<head>`.



## Risorse esterne

- esempi dal [sito ufficiale di BootStrap](https://getbootstrap.com/docs).
- [Bootstrap 5 tutorial - 20:01](https://www.youtube.com/watch?v=rQryOSyfXmI&list=PLl1gkwYU90QkvmT4uLM5jzLsotJZtLHgW)



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente



## Spostiamo il codice di *style* su *stylesheets/application*

Commentiamo, o cancelliamo, il codice relativo allo *style* su *layouts/bs_demo*.

***codice 01 - .../app/views/layouts/bs_demo.html.erb - line:9***

```html+erb
<!--
    <style>
      [class*="container"] {
        background-color: #91A181;
        border: 1px solid #676E5F;
      }
      [class*="row"] {
        background-color: #E5E6D5;
        border: 1px solid #CCD5AB;
      }
      [class*="col"] {
        background-color: #FCDDFC;
        border: 1px solid #DA8D6E;
      }
    </style>
-->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/02_01-views-layouts-bs_demo.html.erb)


Ed inseriamo quel codice direttamente su *stylesheets/application* senza i tags `<style> ... </style>`.

***codice 02 - .../app/assets/stylesheets/application.scss - line:25***

```scss
[class*="container"] {
  background-color: #91A181;
  border: 1px solid #676E5F;
}
[class*="row"] {
  background-color: #E5E6D5;
  border: 1px solid #CCD5AB;
}
[class*="col"] {
  background-color: #FCDDFC;
  border: 1px solid #DA8D6E;
}
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/02_02-assets-stylesheets-application.scss)


> Se proviamo senza compilare **non** funziona.

Precompiliamo il codice.

```bash
$ rails assets:precompile
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/bs_grid

Vediamo che lo stile è ancora presente.

> Attenzione! usando l'asset pipeline dopo ogni modifica **dobbiamo** eseguire il *precompile* (`rails assets:precompile`)



## Creiamo un file esterno che richiamiamo da *stylesheets/application*

Creiamo il file *custom_bs_demo.scss* e spostiamoci il codice.

***codice 03 - .../app/assets/stylesheets/custom_bs_demo.scss - line:1***

```scss
[class*="container"] {
  background-color: #91A181;
  border: 1px solid #676E5F;
}
[class*="row"] {
  background-color: #E5E6D5;
  border: 1px solid #CCD5AB;
}
[class*="col"] {
  //background-color: #FCDDFC;
  background-color: #ddf7fc;
  border: 1px solid #DA8D6E;
}
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/02_01-views-layouts-bs_demo.html.erb)


Richiamiamolo da *stylesheets/application.scss*  con il comando `@import "custom_bs_demo";`.

***codice 04 - .../app/assets/stylesheets/application.scss - line:25***

```scss
@import "custom_bs_demo";
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/02_04-assets-stylesheets-application.scss)


Precompiliamo il codice.

```bash
$ rails assets:precompile
```

> Per passare le modifiche **dobbiamo** precompilare.
> Altrimenti resta la situazione precedente alle modifiche.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/bs_grid

Vediamo che lo stile è ancora presente. 
(Abbiamo cambiato il colore delle colonne in azzurrino.)

> Attenzione! usando l'asset pipeline dopo ogni modifica **dobbiamo** eseguire il *precompile* (`rails assets:precompile`)



## Richiamiamo il file esterno direttamente da *layers/bs_demo*

Questo ultimo passaggio ci porta ad una situazione più flessibile che associa il nuovo file di stile `custom_bs_demo.scss` direttamente dal layout che ci interessa (`bs_demo.html.erb`).
In questo modo lo stile non è applicato a tutta l'applicazione ma solo alle views che ci interessano. (ossia solo alle views che usano il layout `bs_demo.html.erb`).

Commentiamo, o eliminiamo, la chiamata su `application.scss`.

***codice 05 - .../app/assets/stylesheets/application.scss - line:25***

```scss
//@import "custom_bs_demo";
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/02_05-assets-stylesheets-application.scss)


Inseriamo la chiamata direttamente sul layer  `bs_demo.html.erb`.

***codice 06 - .../app/views/layouts/bs_demo.html.erb - line:27***

```html+erb
    <%= stylesheet_link_tag "custom_bs_demo", "data-turbo-track": "reload" %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/02_04-assets-stylesheets-application.scss)


Precompiliamo il codice.

```bash
$ rails assets:precompile
```

> Per passare le modifiche **dobbiamo** precompilare.
> Altrimenti resta la situazione precedente alle modifiche.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/bs_grid

Vediamo che lo stile è ancora presente. 
(Abbiamo cambiato il colore delle colonne in azzurrino.)

> Attenzione! usando l'asset pipeline dopo ogni modifica **dobbiamo** eseguire il *precompile* (`rails assets:precompile`)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement custom style for bootstrap demo"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku bs:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge bs
$ git branch -d bs
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_00-grid_margin_padding-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/03_00-gutter-it.md)
