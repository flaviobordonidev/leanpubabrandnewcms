# <a name="top"></a> Cap params.1 - Manteniamo i params sul render

Sul submit di un form, se prendiamo errore i parametri personalizzati non sono automaticamente passati. Per mantenerli dobbiamo aggiungere dei "campi nascosti".

## Risorse interne

- [ubuntudream/04-manage_users/03_00-no_password_repeat-it](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/03_00-no_password_repeat-it.md)



## Manteniamo sull'url alcuni params personalizzati sul submit del form

```html+erb
<%= form_with(url: "", method: "get", local:true) do %>

  <!-- Manteniamo sull'url alcuni params - start --> 
  <%= hidden_field_tag(:master_page, params[:master_page]) %><!-- utile quando master_page = people -->
  <!-- Manteniamo sull'url alcuni params - end --> 

  <%= label_tag label_master %>
  <%= text_field_tag :search_master, params[:search_master], class: "form-control", placeholder: "cerca..." %>
  <%= label_tag label_nested %>
  <%= text_field_tag :search_nested, params[:search_nested], class: "form-control", placeholder: "cerca..." %>
  <%= submit_tag "Cerca" %>
<% end %>
```


## params per visualizzare solo parte dei campi da editare

L'esigenza è quella di visualizzare una view con i campi di modifica dell'utente (edit account) senza i campi della password.
Per la modifica della password c'è un'altra view dedicata.

Invece di creare due views differenti facciamo tutto nella stessa view e mettiamo un "if...else...end" passando tramite il link un params che ci dice quali campi visualizzare.

Nel nostro esempio chiamiamo questo parametro `:shown_fields`.
Lo usiamo nei links della view `users/show` nel chiamare la view `users/edit`.

***Codice 01 - .../app/views/users/show.html.erb - line:06***

```html+erb
  <%= link_to "Edit this user", edit_user_path(@user, shown_fields: 'account') %> |
  <%= link_to "Edit this user password", edit_user_path(@user, shown_fields: 'password') %> |
  <%= link_to "Edit this user all", edit_user_path(@user, shown_fields: 'all') %> |
```

Quindi nella view `users/edit` usiamo il parametro con un *if...end*

***Codice n/a - .../app/views/users/_form.html.erb - line:06***

```html+erb
  <% if params[:shown_fields] == 'account' or params[:shown_fields] == 'all' %>
    <!-- i vari campi users (senza quelli della password) -->
  <% end %>

  <% if params[:shown_fields] == 'password' or params[:shown_fields] == 'all' %>
    <!-- i soli campi password e password_confirmation -->
  <% end %>
```

Questo funziona ma se ho un errore perdo il parametro `:shown_fields` perché l'azione `update` di `users_controller` in caso di errore fa un render della stessa view: <br/>
`format.html { render :edit, status: :unprocessable_entity }` </br>
...ed il render non riprende i parametri dall'url ma prende quelli passati dal submit del form con *POSTT*.

***Codice 02 - .../app/controllers/users_controller.rb - line:06***

```ruby
  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
```

Per risolverlo è sufficiente mettere un campo nascosto che mi ripassa il parametro.

***Codice 03 - .../app/views/users/_form.html.erb - line:06***

```html+erb
  <!-- Manteniamo sull'url alcuni params - start --> 
  <%= hidden_field_tag(:shown_fields, params[:shown_fields]) %>
  <!-- Manteniamo sull'url alcuni params - end --> 

  <p> ON "RENDER" MANTIENI my custom params - shown_fields = <%= params[:shown_fields] %> </p>

  <% if params[:shown_fields] == 'account' or params[:shown_fields] == 'all' %>
```

