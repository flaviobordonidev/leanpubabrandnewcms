# <a name="top"></a> Cap 3.2 - Bootstrap verifichiamo il componente navbar

Verifichiamo i principali componenti di BootStrap.
Partiamo dalla barra di navigazione `navbar`.
- La parte css si verifica dall'estetica
- La parte js si verifica aprendo un drop down menu oppure stringendo il browser ed aprendo la barra di navigazione quando si restringe in un solo pulsante diventando un "hamburger menu".



## Risorse interne

- []()



## Risorse esterne

- [sito bootstrap: navbar](https://getbootstrap.com/docs/5.3/components/navbar/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.



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



## Navbar

Iniziamo dal componente navbar che installa una barra di navigazione.

- [navbar](https://getbootstrap.com/docs/5.3/components/navbar/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.

Copiamo ed incolliamo il codice di esempio.

[Codice 03 - .../app/views/mockups/test_a.html.erb - linea: 1]()

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
$ ./bin/dev
```

> In questo caso funziona anche con `$ rails s -b 192.168.64.4` ma con propshaft è meglio usare `./bin/dev`

Il fatto che si apra il menu a cascata, ed anche il menu "hamburger" quando riduci il browser, significa che la parte javascript di BootStrap sta funzionando.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

