# <a name="top"></a> Cap 1.4 - Creiamo la pagina principale

La pagina principale, o di root, è quella che si visualizza digitando l'url base dell'applicazione.
Normalmente coincide con la homepage.



## Create the Hello World Landing Page

Al momento creiamo la pagina *index* sotto *mockups*.

```bash
$ rails g controller Mockups index
```

> *mockups* è una directory in cui mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

***Code 01 - .../app/mockups/index.html.erb - line:4***

```html+erb
<h1>Hello world</h1>
<p>this is the homepage</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/04_01-mockups-index.html.erb)


***Code 02 - .../config/routes.rb - line:7***

```ruby
  root 'mockups#index'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/04_01-mockups-index.html.erb)


Abbiamo il minimo necessario per poter andare in produzione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
