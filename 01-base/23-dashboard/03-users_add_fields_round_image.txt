{id: 01-base-23-dashboard_style_users-03-users_add_fields_round_image}
# Cap 23.3 -- Aggiungiamo i campi Immagine e Bio agli utenti




## Apriamo il branch "Add Fields to Users"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b afu
```




## Aggiungiamo il campo Bio

Alla tabella "users" aggiungiamo la colonna "biography"

ATTENZIONE:
Non usate come nome di colonna "bio" perché su heroku prende errore essendo un nome riservato.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddBiographyToUsers biography:text
```

questo crea il migrate:

{id: "01-23-03_01", caption: ".../db/migrate/xxx_add_biography_to_users.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class AddBiographyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :biography, :text
  end
end
```

eseguiamo il migrate 

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```




## Aggiungiamo il campo Image

Poiché usiamo ActiveStorage non aggiungiamo nessuna colonna alla tabella users ma interveniamo lato model.
Attiviamo upload immagine per il model User nella sezione "# == Attributes"

{id: "01-23-03_02", caption: ".../models/user.rb -- codice 02", format: ruby, line-numbers: true, number-from: 12}
```
  ## ActiveStorage
  has_one_attached :account_image
```

[tutto il codice](#01-23-03_02all)

La chiamiamo account_image per differenziarla da eventuali altre immagini che volessimo inserire per gli "users".
Potevamo chiamarla semplicemente "image" ed avremmo avuto "@user.image" ma "@user.account_image" ci piaceva di più.




## Aggiorniamo il controller

Inseriamo i nostri nuovi campi "biography" e "account_image" nella whitelist

{id: "01-23-03_03", caption: ".../app/controllers/users_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 95}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_created_at, :role, :biography, :account_image)
    end
```

[tutto il codice](#01-23-03_03all)




## Implementiamo la pagina "_form"

Inseriamo la gestione dell'immagine e del campo di testo.

{id: "01-23-03_04", caption: ".../app/views/users/_form.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 74}
```
            <div class="field">
              <%= form.label :account_image %>
              <% if user.account_image.attached? %>
                <%= image_tag user.account_image.variant(resize_to_fit: [100, 100]) %>
              <% else %>
                    <p>Nessuna immagine presente</p>
              <% end %>
              <p><%= form.file_field :account_image %></p>
            </div>
```

{caption: ".../app/views/users/_form.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 62}
```
           <div class="field">
              <%= form.label :biography %>
              <%= form.text_area :biography, rows: "5", class: "form-control" %>
            </div>
```
[tutto il codice](#01-23-03_04all)




## Aggiorniamo la pagina "show"

{id: "01-23-03_05", caption: ".../app/views/users/show.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 23}
```
<p>
  <strong>Biography:</strong>
  <%= @user.biography %>
</p>

<p>
  <strong>Image:</strong>
  <% if @user.account_image.attached? %>
    <%= image_tag @user.account_image %>
  <% else %>
    Nessuna immagine presente
  <% end %>
</p>
```

[tutto il codice](#01-23-03_05all)

INFO:
non usiamo ".present?" perché darebbe sempre "true". Per verificare la presenza del file allegato dobbiamo usare ".attached?"




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

andiamo alla pagina con l'elenco degli articoli ossia sull'URL:

* https://mycloud9path.amazonaws.com/users/1




## Ridimensioniamo immagine e la rendiamo rotonda

Per ridimensionare l'immagine usiamo variant. Per rendere tonde le immagini aggiungiamo dello "style" css direttamente in linea.

{id: "01-23-03_06", caption: ".../app/views/users/_form.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 23}
```
         <li class="list-group-item">
            <div class="field">
              <%= form.label :account_image %>
              <% if user.account_image.attached? %>
                <%#= image_tag user.account_image.variant(resize_to_fit: [100, 100]), style: "border-radius: 50%" %>
                <%= image_tag user.account_image.variant(resize_to_fill: [100, 100, { gravity: 'North' }]), style: "border-radius: 50%" %>
                <%= image_tag user.account_image.variant(resize_to_fill: [100, 100, { gravity: 'South' }]), style: "border-radius: 50%" %>
                <%= image_tag user.account_image.variant(resize_to_fill: [100, 100, { gravity: 'East' }]), style: "border-radius: 50%" %>
                <%= image_tag user.account_image.variant(resize_to_fill: [100, 100, { gravity: 'West' }]), style: "border-radius: 50%" %>
                <%= image_tag user.account_image.variant(resize_to_fill: [100, 100, { gravity: 'Center' }]), style: "border-radius: 50%" %>
                <%= image_tag user.account_image.variant(resize_to_fill: [100, 100]), style: "border-radius: 50%" %>

                <%#= link_to 'Remove', delete_image_attachment_eg_post_path(user.account_image.id), method: :delete, data: { confirm: 'Are you sure?' } %>
              <% else %>
                    <p>Nessuna immagine presente</p>
              <% end %>
              <p><%= form.file_field :account_image %></p>
            </div>
          </li>
```

Nota: Se non mettiamo il parametro "gravity" viene usato quello di default che è "Center". Comunque è comodo avere nel codice un esempio di come passare i parametri a "variant", ossia utilizzando un hash "{ parameter1: 'value1', parameter2: 'value2'}" come terza voce dell'array "[]".




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

andiamo all'URL:

* https://mycloud9path.amazonaws.com/users/1




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add fields image and biography to users"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku afu:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge afu
$ git branch -d afu
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




