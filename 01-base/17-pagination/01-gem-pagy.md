# <a name="top"></a> Cap 17.1 - Installiamo gemma Pagy per la paginazione (pagination)

Per dividere l'elenco su più pagine.
Le gemme che vanno per la maggiore sono: will_paginate, kaminari e pagy. Scegliamo pagy perché è mooolto più veloce.



## Risorse interne

- [99-rails_references/views/pagination]()



## Apriamo il branch "Pagination with Pagy"

```bash
$ git checkout -b pp
```



## Pagy overview

A differenza di will_paginate e kaminari che si integrano in ActiveRecord, la gemma pagy resta più indipendente e lavora come una classe plain ruby esterna.
Ad esempio la dobbiamo includere per i controllers "include Pagy::Backend" e la dobbiamo includere per le views "include Pagy::Frontend".
Inoltre nel controller non abbiamo chiamate "integrate" in ActiveRecord come ad esempio nell'azione "index" di un blog:

- will_paginate : @blog_posts = BlogPost.all.pagination(params[:page])
- kaminari      : @blog_posts = BlogPost.all.page(params[:page])
- pagy          : @pagy, @blog_posts = pagy(BlogPost.all)

Invece di avere un aggancio *.page* o *.pagination* la gemma pagy ha una funzione che accetta tutto l'ActiveRecord e ci crea un oggetto "@pagy" dedicato alla paginazione.



## Installiamo la gemma

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/pagy)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/ddnexus/pagy)

***codice 01 - .../Gemfile - line: 37***

```ruby
# Agnostic pagination in plain ruby
gem 'pagy', '~> 3.7', '>= 3.7.2'
```

[tutto il codice](#01-17-01_01all)

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Aggiungiamo il Backend al nostro controller

Abbiamo due scelte:

1. inseriamo "include" su ogni controller in cui ci serve la paginazione (come facciamo con devise per l'autorizzazione)
2. inseriamo "include" su application_controller e di conseguenza su tutti i controllers (perché ereditano tutti dalla classe di application_controller) 

Scegliamo di includere la paginazione in tutti i controllers perché per quelli che non la utilizzano non crea nessun problema.

***codice 02 - .../app/controllers/application_controller.rb - line: 1***

```ruby
include Pagy::Backend
```

[tutto il codice](#01-15-04_02all)



## Aggiungiamo il Frontend alle nostre pagine

includiamo la paginazione anche in application_helper in modo da rendere disponibili gli helpers di pagy a tutte le views

***codice 04 - .../app/helpers/application_helper.rb - line: 1***

```ruby
  include Pagy::Frontend
```

[tutto il codice](#01-15-04_04all)




## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Install pagination with pagy"
```



## Pubblichiamo su heroku

```bash
$ git push heroku pp:master
```



## Chiudiamo il branch

Lo chiudiamo nei prossimi capitoli. 
Al momento lo lasciamo aperto per implementare il pagination su *eg_posts* ed *users*.



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
