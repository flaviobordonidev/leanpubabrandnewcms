# <a name="top"></a> Cap form_with.2b - Hidden fields


## Campo nascosto preso dal Model

```html+erb
  <%= form.hidden_field :diary_chap %>
```

Esempio:

***code n/a - .../app/views/steps/show.html.erb - line:n/a***

```html+erb
<% if current_user == "admin" %>
  <p>fanculo: <%= form.number_field :diary_chap %> cazzo</p>
<% else %>
  <%= form.hidden_field :diary_chap %>
<% end %>
```

> Questo in realtà non ho la certezza che serva che sia presente nel form.
> Credo che possa essere acquisito nel controller ugualmente con [params:] oppure in modo diverso... ma devo approfondire.



## Campo nascosto NON preso dal Model

Questo è un campo nascosto creato solo nel view che ci permette di passare un parametro su submit del form

```html+erb
		<%= hidden_field_tag :locale, params[:locale] %>
```

Esempio

***Codice 03 - .../views/users/index.rb - linea:7***

```html+erb
<%= search_form_for @q do |f| %>
		<%= hidden_field_tag :locale, params[:locale] %>
    <%= f.search_field :first_name_or_last_name_or_username_or_bio_cont, placeholder: "Search..." %>
    <%= f.submit "Search!" %>
<% end %>
```
