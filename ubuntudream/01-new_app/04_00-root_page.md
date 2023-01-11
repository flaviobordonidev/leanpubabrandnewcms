# <a name="top"></a> Cap 1.4 - Creiamo la pagina principale

La pagina principale, o di root, è quella che si visualizza digitando l'url base dell'applicazione.
Normalmente coincide con la homepage.



## Risorse esterne

- [Come nominare la homepage](https://stackoverflow.com/questions/349743/welcome-home-page-in-ruby-on-rails-best-practice)



## Come nominare la homepage da un punto di vista Rails?

La soluzione migliore è di inserirla all'interno del controller `pages_controller` da dove richiamiamo pagine che non sono direttamente legate ad un ***model*** (e che quindi non hanno una tabella del database).



## Il controller Pages

Non usiamo né il "generate scaffold" né il "generate model" perché non abbiamo una corrispettiva tabella nel database, quindi evitiamo la tabella ed i models.
Usiamo invece il " generate controller " e gli associamo l'azione "home". 
(non gli associamo le classiche azioni restful: index, show, edit, new, ...)

I> ATTENZIONE: con "rails generate controller ..." -> usiamo il PLURALE ed otteniamo un controller al plurale.

```bash
$ rails g controller Pages home
```

non abbiamo nessun migrate perché non ci interfacciamo con il database.

> In realtà nel tutorial abbiamo usato `$ rails g controller Pages page_a`




## Il controller Mockups

Il controller Pages contiene pagine utilizzate dall'utente nell'usare l'applicazione.

Creiamo anche l'altro controller Mockups che è più per lo sviluppatore, o meglio per il web designer, per tenere da parte i bozzetti statici dell'applicazione.

Al momento creiamo la pagina *page_a* sotto *mockups*.

```bash
$ rails g controller Mockups page_a
```

> *mockups* è una directory in cui mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

***Code 01 - .../app/mockups/page_a.html.erb - line:1***

```html+erb
<h1>Hello world</h1>
<p>this is the homepage</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/04_01-mockups-index.html.erb)


***Code 02 - .../config/routes.rb - line:7***

```ruby
  root 'pages#home'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/04_01-mockups-index.html.erb)


Abbiamo il minimo necessario per poter andare in produzione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
