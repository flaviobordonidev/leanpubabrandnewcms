# <a name="top"></a> Cap 1.5 - Creiamo dei mockups di test

Aggiungiamo delle pagine per dei test iniziali, specialmente per lo stile grafico (mockups).



## Risorse esterne

- []()



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

Abbiamo il minimo necessario per poter andare in produzione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
