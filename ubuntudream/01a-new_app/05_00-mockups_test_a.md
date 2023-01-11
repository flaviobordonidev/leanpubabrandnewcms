# <a name="top"></a> Cap 1.4 - Creiamo la pagina principale

La pagina principale, o di root, è quella che si visualizza digitando l'url base dell'applicazione.
Normalmente coincide con la homepage.



## Risorse esterne

- []()



## Il controller Mockups

Il controller Pages contiene pagine utilizzate dall'utente nell'usare l'applicazione.

Creiamo anche l'altro controller Mockups che è più per lo sviluppatore, o meglio per il web designer, per tenere da parte i bozzetti statici dell'applicazione.

Al momento creiamo la pagina *test_a* sotto *mockups*.

```bash
$ rails g controller Mockups test_a
```

> *mockups* è una directory in cui mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

***Code 01 - .../app/mockups/test_a.html.erb - line:1***

```html+erb
<h1>Hello world</h1>
<p>this is the first test page</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/04_01-mockups-index.html.erb)


***Code 02 - .../config/routes.rb - line:7***

```ruby
  root 'mockups#test_a'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/04_01-mockups-index.html.erb)


Abbiamo il minimo necessario per poter andare in produzione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
