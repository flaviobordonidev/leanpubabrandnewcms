{id: 01-base-10-users_i18n-03-users_form_i18n}
# Cap 10.3 -- Internazionalizzazione dei campi nei forms




## Apriamo il branch 

continuiamo con lo stesso branch del capitolo precedente




## Inseriamo un segnaposto nei campi del form

Inseriamo un segnaposto nei campi del form (Input Placeholders). Possiamo dire a Rails di usare "i18n placeholder" passando il parametro "placeholder: true" nelle opzioni dei campi input del form.

{caption: ".../app/views/users/_form.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 31}
```
<%= form_with(model: user, local: true) do |form| %>
  ...
  <div class="field">
    <%= form.label :name %>
    <%= form.text_field :name, placeholder: true %>
  </div>

  <div class="field">
    <%= form.label :email %>
    <%= form.text_field :email, placeholder: true %>
  </div>

  <div class="field">
    <%= form.label :password %>
    <%= form.text_field :password, placeholder: true %>
  </div>

  <div class="field">
    <%= form.label :password_confirmation %>
    <%= form.text_field :password_confirmation, placeholder: true %>
  </div>
```


diamo la traduzione al placeholder nei locales

{id: "01-10-01_02", caption: ".../config/locales/it.yml -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
it:
  helpers:
    placeholder:
      user:
        name: "nome utente"
        email: "email"
        password: "password"
        password_confirmation: "conferma password"
```

{id: "01-10-01_03", caption: ".../config/locales/en.yml -- codice 03", format: yaml, line-numbers: true, number-from: 1}
```
en:
  helpers:
    placeholder:
      user:
        name: "user name"
        email: "email"
        password: "password"
        password_confirmation: "password confirmation"
```




## Labels

Lato form non devo fare nulla. L'importante è che ci sia la "label" per ogni campo.

{caption: ".../app/views/users/_form.html.erb", format: HTML+Mako, line-numbers: true, number-from: 31}
```
    <%= form.label :name %>
  ...
    <%= form.label :email %>
  ...
    <%= form.label :password %>
  ...
    <%= form.label :password_confirmation %>
```


mettiamo la traduzione alle labels nei locales

{id: "01-10-01_02", caption: ".../config/locales/it.yml -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
it:
  ...
  activerecord:
    attributes:
      user:
        name: "Nome utente" # fallback for when label is nil
  ...
  helpers:
    label:
      user:
        name: "Nome utente"
```

Se il percorso tramite "helpers:" non è disponibile, i18n userà il percorso alternativo "activerecord:".


Lo possiamo verificare commentando nome utente:

{id: "01-10-01_02", caption: ".../config/locales/it.yml", format: yaml, line-numbers: true, number-from: 1}
```
it:
  ...
  activerecord:
    attributes:
      user:
        name: "Nome utente (backup label)" # fallback for when label is nil
  ...
  helpers:
    label:
      user:
        #name: "Nome utente"
```




## I pulsanti di "Submit"

Cambiamo i valori dei pulsanti di "submit" per nuovo o aggiornamento utente.

Verifichiamo che il pulsante sia presente nel form

{caption: ".../app/views/users/_form.html.erb", format: HTML+Mako, line-numbers: true, number-from: 56}
~~~~~~~~
<%= form_with(model: user, local: true) do |form| %>
  [...]
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
~~~~~~~~


e traduciamo il suo valore sui locales

{id: "01-10-01_02", caption: ".../config/locales/it.yml", format: yaml, line-numbers: true, number-from: 1}
```
it:
  [...]
  helpers:
    [...]
    submit:
      user:
        create: "Crea %{model}"
        update: "Aggiorna %{model}"
```




## Traduciamo il nome del model


{id: "01-10-01_02", caption: ".../config/locales/it.yml", format: yaml, line-numbers: true, number-from: 1}
```
it:
  activerecord:
    [...]
    models:
      user: "utente"
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users





## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "users form fields i18n"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ui:master
```




## Chiudiamo il branch

lo lasciamo aperto per il prossimo capitolo




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
