# <a name="top"></a> Cap 1.4 - Creiamo la pagina principale

La pagina principale, o di root, è quella che si visualizza digitando l'url base dell'applicazione.
Normalmente coincide con la homepage.



## Risorse esterne

- [Come nominare la homepage](https://stackoverflow.com/questions/349743/welcome-home-page-in-ruby-on-rails-best-practice)



## Come nominare la homepage da un punto di vista Rails?

La soluzione migliore è di inserirla all'interno del controller `pages_controller` da dove richiamiamo pagine che non sono direttamente legate ad un ***model*** (e che quindi non hanno una tabella del database).



## Il controller Pages

Non usiamo né il `generate scaffold` né il `generate model` perché non abbiamo una corrispettiva tabella nel database, quindi evitiamo la tabella ed i models. Usiamo invece il `generate controller` e gli associamo l'azione "home".
(non gli associamo le classiche azioni restful: index, show, edit, new, ...)

> ATTENZIONE: con `rails generate controller ...` -> usiamo il **PLURALE** ed otteniamo un controller al plurale.

```bash
$ rails g controller Pages home
```

non abbiamo nessun migrate perché non ci interfacciamo con il database.


## La view index

[Codice 01 - .../views/pages/home.html.rrb - linea: 1](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/04_01-views-pages-home.html.erb)

```html
<h1>Pages#home</h1>
<p>Find me in app/views/pages/home.html.erb</p>
```



## Gli instradamenti (routes)

[Codice 02 - .../config/routes.rb - linea: 7](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/04_02-config-routes.rb)

```ruby
  root 'pages#home'
```

> https://guides.rubyonrails.org/routing.html#using-root
> You should put the root route at the top of the file, because it is the most popular route and should be matched first.
> The routes.rb file is processed from top to bottom when a request comes in. The request will be dispatched to the first matching route. If there is no matching route, then Rails returns HTTP status 404 to the caller.

> ECCEZIONE
> Rails 7.1 ha aggiunto la riga `get "up" => "rails/health#show", as: :rails_health_check` e questa va prima di `root ...` perché la sua funzione è quella di permettere di controllare da remoto che l'applicazione rails sia attiva. (It add an endpoint to your routes file to act as a heartbeat. You can point to many services or monitoring tools to check for downtime.)

Abbiamo il minimo necessario per poter andare in produzione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
