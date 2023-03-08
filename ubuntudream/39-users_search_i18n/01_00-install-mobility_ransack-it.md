# <a name="top"></a> Cap 38.4 - Installiamo mobility-ransack

Questa gemma permette di agganciare ransack a mobility e quindi di effettuare le ricerche su campi multilingua.



## Risorse interne

- []()



## Risorse esterne

- [sito ufficiale gemma: mobility-ransack](https://github.com/shioyama/mobility-ransack)
- [Mobility gem + Rails : how to perform a join with LIKE query on a translated model](https://stackoverflow.com/questions/51132753/mobility-gem-rails-how-to-perform-a-join-with-like-query-on-a-translated-mod)



## Apriamo il branch




## Installiamo la gemma "mobility-ransack"

Per fare le ricerche su campi con più lingue installiamo la gemma mobility-ransack.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mobility-ransack)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/shioyama/mobility-ransack)


***codice 01 - .../Gemfile - line:76***

```ruby
# Search attributes translated by Mobility with Ransack.
gem 'mobility-ransack', '~> 1.2', '>= 1.2.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/27-i18n_dynamic/02_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Abilitiamo il ransack plugin in Mobility

Abilitiamo il plug-in ransack nella configurazione di Mobility.
`Mobility.configure do ...` --> `plugins do ...`

***Codice 02 - .../config/initializers/mobility.rb - line:116***

```ruby
    # Ransack
    #
    # Enable the ransack plugin 
    #
    ransack
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/27-i18n_dynamic/02_01-gemfile.rb)

> This will enable the ransack plugin for all models. 



## Disabilitiamo il ransack plugin in modelli specifici

Disable ransack plugin by passing false to the ransack option.

Esempio:

***Codice n/a - .../models/post.rb - linea:n/a***

```ruby
class Post < ApplicationRecord
  extend Mobility
  translates :foo, ransack: false
end
```


## Effettuiamo la ricerca 

You can search on foo with Ransack just like any untranslated attribute, e.g. if Post has a title attribute translated with the Jsonb backend:

```ruby
Post.ransack(title_cont: "foo").result
#=> SELECT "posts".* FROM "posts" WHERE ("posts"."title" ->> 'en') ILIKE '%foo%'
```

Other backends work exactly the same way.

Estendiamo la ricerca delle persone anche alla loro bio (perché è il campo in più lingue)

> Attenzione!
> Oltre ad essere multilingua il campo bio è anche ActiveText!!!
> (In realtà no. non lo ho reso ActiveText ma è solo string. L'ActiveText la attiveremo per i quadri...)


***Codice 03 - .../views/users/index.rb - linea:7***

```html+erb
<%= search_form_for @q do |f| %>
		<%= hidden_field_tag :locale, params[:locale] %>
    <%= f.search_field :first_name_or_last_name_or_username_or_bio_cont, placeholder: "Search..." %>
    <%= f.submit "Search!" %>
<% end %>
```

> Per far sì che mantenga la lingua dobbiamo passargli anche il parametro "locale" e questo lo facciamo attraverso un campo nascosto che chiamiamo `:locale` a cui passiamo il valore attuale del locale `params[:locale]`.


La versione con anche lo style:

```html+erb
								<!-- Search with Ransack -->
								<%= search_form_for @q, class: "rounded position-relative" do |f| %>
									<div class="input-group mb-3">
										<%= hidden_field_tag :locale, params[:locale] %>
										<%= f.search_field :first_name_or_last_name_or_username_or_bio_cont, autofocus: true, class: "form-control", placeholder: "Search...", 'aria-label': "Search", 'aria-describedby': "button-search" %>
										<%#= f.submit "Search", class: "btn btn-outline-secondary", id: "button-search"%>
										<%= button_tag type: 'submit', class: "btn btn-outline-secondary", id: "button-search" do %>
											<i class="fas fa-search fs-6 "></i>
										<% end %>
									</div>
								<% end %>
```





---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_00-users_form_i18n-it.md)
