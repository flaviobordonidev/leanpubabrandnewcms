# <a name="top"></a> Cap 10.1 - Installiamo gemma Pagy per la paginazione (pagination)

Per dividere l'elenco su più pagine.
Le gemme che vanno per la maggiore sono: will_paginate, kaminari e pagy. Scegliamo pagy perché è mooolto più veloce.



## Risorse interne

- [99-rails_references/views/pagination]()



## Apriamo il branch "Pagination with Pagy"

```bash
$ git checkout -b pp
```



## Pagy overview

A differenza di *will_paginate* e *kaminari* che si integrano in ActiveRecord, la gemma *pagy* resta più indipendente e lavora come una classe *plain ruby* esterna.
Ad esempio la dobbiamo includere per i controllers `include Pagy::Backend` e la dobbiamo includere per le views `include Pagy::Frontend`.

Inoltre nel controller non abbiamo chiamate "integrate" in ActiveRecord come ad esempio nell'azione `index` di un blog. Vediamo degli esempi:

- *will_paginate* : `@blog_posts = BlogPost.all.pagination(params[:page])`
- *kaminari*      : `@blog_posts = BlogPost.all.page(params[:page])`
- *pagy*          : `@pagy, @blog_posts = pagy(BlogPost.all)`

> Invece di avere un "aggancio" `.page` o `.pagination` la gemma `pagy` ha una funzione che accetta tutto l'ActiveRecord e ci crea un oggetto `@pagy` dedicato alla paginazione.



## Installiamo la gemma

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/pagy)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/ddnexus/pagy)

***codice 01 - .../Gemfile - line:57***

```ruby
# Agnostic pagination in plain ruby
gem 'pagy', '~> 5.10', '>= 5.10.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/10-pagination/01_01-gemfile.rb)

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Aggiungiamo il Backend al nostro controller

Abbiamo due scelte:

1. inseriamo "include" su *ogni controller* in cui ci serve la paginazione (come facciamo con devise per l'autorizzazione)
2. inseriamo "include" su *application_controller* e di conseguenza su tutti i controllers (perché ereditano tutti dalla classe di application_controller) 

Scegliamo di includere la paginazione in tutti i controllers perché per quelli che non la utilizzano non crea nessun problema.

***codice 02 - .../app/controllers/application_controller.rb - line:5***

```ruby
include Pagy::Backend
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_02-controllers-application_controller.rb)



## Aggiungiamo il Frontend alle nostre pagine

Includiamo la paginazione anche in *application_helper* in modo da rendere disponibili gli helpers di pagy a tutte le views.

***codice 03 - .../app/helpers/application_helper.rb - line:2***

```ruby
  include Pagy::Frontend
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_04-helpers-application_helper.rb)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Install pagination with pagy"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/16-rolification/05_00-authorization-more_roles-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/02_00-eg_posts_pagination-it.md)
