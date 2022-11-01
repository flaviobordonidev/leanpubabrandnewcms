# blabla

In questo capitolo riporto quello che ho già fatto ^_^

In pratica attivo users_index ed il fatto che l'amministratore ha dei links e pulsanti in più per gestire gli altri utenti.

Se invece siamo loggati come user possiamo cambiare solo noi stessi.
(questo lo gestiremo anche a livello di autorizzazione con *pundit*)




## Admin Buttons su users/show

Mettiamo i pulsanti solo per l'amministratore che gli permettono di fare le modifiche all'utente visualizzato.

***Codice 01 - .../app/views/users/show.html.erb - linea:15***

```html+erb
        <!-- Breadcrumb -->
        <div class="d-flex justify-content-between">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb breadcrumb-dark breadcrumb-dots mb-0">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item"><%= link_to "Users", users_path %></li>
              <li class="breadcrumb-item active" aria-current="page">User <%= @user.id %></li>
            </ol>
          </nav>
					<!-- Buttons for Admin -->
					<div class="d-flex align-items-center mt-2 mt-md-0">
						<%= link_to "Edit this user", edit_user_path(@user, shown_fields: 'account'), class: "btn btn-success mb-0 mx-1" %>
						<%= link_to "Edit this user password", edit_user_path(@user, shown_fields: 'password'), class: "btn btn-success mb-0 mx-1" %>
						<%= link_to "Edit this user all", edit_user_path(@user, shown_fields: 'all'), class: "btn btn-success mb-0 mx-1" %>
						<%= link_to "Back to users", users_path, class: "btn btn-success mb-0 mx-1" %>
						<%= button_to "Destroy this user", @user, method: :delete, class: "btn btn-danger mb-0 mx-1" %>
					</div>
        </div>
```

> `<div class="d-flex justify-content-between">` la classe `.justify-content-between` ci permette di avere il *nav / breadcrums* a sinistra ed gli *admin buttons* tutti a destra.
>
> vedi [BootStrap doc: flex - justify-content](https://getbootstrap.com/docs/4.0/utilities/flex/#justify-content)

