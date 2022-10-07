# <a name="top"></a> Cap 1.4 - Creiamo la pagina principale

La pagina principale, o di root, è quella che si visualizza digitando l'url base dell'applicazione.
Normalmente coincide con la homepage.



## Create the Hello World Landing Page

Al momento creiamo la pagina *page_a* sotto *mockups*.

```bash
$ rails g controller Mockups page_a
```

> *mockups* è una directory in cui mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

> Creiamo la view *page_a* e non *index* per evitare confusioni più avanti nello sviluppo dell'applicazione. Il nome *page_a* è molto diverso da nomi comunemente più usati.

***Code 01 - .../app/mockups/page_a.html.erb - line:1***

```html+erb
<h1>Hello world</h1>
<p>this is the homepage</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/theme-eduport-esbuild/01-new_app/04_01-mockups-page_a.html.erb)


***Code 02 - .../config/routes.rb - line:7***

```ruby
  root 'mockups#page_a'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/theme-eduport-esbuild/01-new_app/04_02-config-routes.rb)


Abbiamo il minimo necessario per poter andare in produzione.
Ma visto che abbiamo già installato BootStrap nella prossima sezione non andiamo subito in produzione ma avremo un po' di capitoli in cui implementiamo un po' di componenti BootStrap.
Andremo in produzione nella sezione successiva.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
