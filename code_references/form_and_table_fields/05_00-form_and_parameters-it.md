# <a name="top"></a> Cap form_and_table_fields.2 - Sul sumbit del form aggiungere un params[]

Il trucco per aggiungere un params sul sumbit del nostro form è semplicemente quello di aggiungere un campo nascosto nel nostro form.


## Risorse interne

- [ubuntudream/39-users_search_i18n/01_00-install-mobility_ransack-it]()



## Risorse esterne

-[]()



## Esempio di form che cerca su campo multilingua

- vedi ubuntudream/39-users_search_i18n/01_00-install-mobility_ransack-it

In questo esempio vediamo come cercare un utente anche nella sua "bio" ed il testo string sul campo "bio" cambia a seconda della lingua che stiamo usando e la ricerca considera solo il contenuto in funzione della lingua che stiamo usando.

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

