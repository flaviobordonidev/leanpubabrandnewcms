# <a name="top"></a> user_search_ransack - Cap.1 - Intalliamo la gemma `ransack`

Ransack ci semplifica molto la gestione delle ricerche nei records del database.

> Vedremo più avanti che ci semplifica molto la vita anche per le ricerche sui campi tradotti in più lingue perché per la traduzione in più lingue useremo la gemma `mobility` e lo stesso autore ha sviluppato anche la gemma `mobility-ransack` per supportare in modo trasparente tutte le ricerche impostate con ransack.


In questa serie di capitoli mettiamo la ricerca ransack ed anche la sua controparte fatta con metodo tradizionale per fare un confronto.



## Risorse interne


## Risorse esterne

-[Ransak documentation: External resources](https://activerecord-hackery.github.io/ransack/going-further/external-guides/)



## Installiamo la gemma

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/ransack)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/activerecord-hackery/ransack)

***Codice 01 - .../Gemfile - linea:54***

```ruby
# Add searching to your Rails application
gem 'ransack', '~> 3.2', '>= 3.2.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/10-pagination/01_01-gemfile.rb)

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Cerchiamo per first_name utente

Aggiorniamo il controller

***Codice 02 - .../controllers/users_controller.rb - linea:7***

```ruby
def index
  @q = User.ransack(params[:q])
  @users = @q.result(distinct: true)
end
```

Aggiorniamo la view

***Codice 03 - .../views/users/index.rb - linea:7***

```html+erb
<%= search_form_for @q do |f| %>
    <%= f.search_field :first_name_cont, placeholder: "Search..." %>
    <%= f.submit "Search!" %>
<% end %>
```

> la parte "ransack" è nel nome del campo "search_field" ossia: `:first_name_cont`.</br>
> Più specificamente il suffisso `_cont` che verifica i campi della tabella che "contengono" la stringa messa nell'input field "search".
> [Ransack: search-matches](https://activerecord-hackery.github.io/ransack/getting-started/search-matches/)



## Cerchiamo per first_name, last_name o nick_name utente

Il soprannome (nick_name) in tabella lo abbiamo chiamato "username".

***Codice 04 - .../views/users/index.rb - linea:7***

```html+erb
<%= search_form_for @q do |f| %>
    <%= f.search_field :first_name_or_last_name_or_username_cont, placeholder: "Search..." %>
    <%= f.submit "Search!" %>
<% end %>
```

