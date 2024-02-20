# <a name="top"></a> Cap 3.2 - Testiamo Bootstrap

Verifichiamo che BootStrap è installato correttamente testando i suoi componenti principali.



## Risorse interne

- []()



## Risorse esterne

- [Rails 7, Bootstrap 5 e importmaps](https://www.youtube.com/watch?v=ZZAVy67YfPY)



## Il controller Mockups

Il controller `pages_controller` contiene pagine che utilizza l'utente.

Creiamo anche il controller `mockups_controller` che è più per lo sviluppatore, o meglio per il web designer, per tenere da parte i bozzetti statici dell'applicazione.

Al momento creiamo la pagina *test_a* sotto *mockups*.

```shell
$ rails g controller Mockups test_a
```

> *mockups* è una directory in cui mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

[Codice 01 - .../app/mockups/test_a.html.erb - linea: 1](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/05_01-mockups-test_a.html.erb)

```html
<h1>Pagina A di test</h1>
<p>this is the first test page</p>
```

[Codice 02 - .../config/routes.rb - linea: 15](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/05_02-config-routes.rb)

```ruby
  get 'mockups/test_a'
```




## Verifichiamo il navbar di bootstrp

QUESTO È IL MOMENTO GIUSTO PER CREARE LA PAGINA DI MOCKUPS

```shell
$ rails g controller Mockups test_a
```


[Codice 05 - .../app/views/mockups/test_a.html.erb - linea: 1]()

```shell
$ rails g controller Mockups test_a
```




## Navbar

Iniziamo dal componente navbar che installa una barra di navigazione.

- [navbar](https://getbootstrap.com/docs/5.2/components/navbar/)

Copiamo ed incolliamo il codice di esempio.

***code 01 - .../app/views/mockups/index.html.erb - line: 1***

```html+erb
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
```

in preview funziona.

```bash
$ rails s -b 192.168.64.3
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

> Il fatto che si apra il menu a cascata, ed anche il menu "hamburger" quando riduci il browser, significa che la parte javascript di BootStrap sta funzionando.

