# <a name="top"></a> Cap 10.2 - Internazionalizzazione dei campi nei forms



## Apriamo il branch 

Continuiamo con lo stesso branch del capitolo precedente



## Inseriamo un segnaposto nei campi del form

Inseriamo un segnaposto nei campi del form (Input Placeholders). 
Possiamo dire a Rails di usare *i18n placeholder* passando il parametro `placeholder: true` nelle opzioni dei campi input del form.

***codice 01 - .../app/views/users/_form.html.erb - line: 1***

```html+erb
<%= form_with(model: user) do |form| %>
```

> Su Rails 6 usavo `<%= form_with(model: user, local: true) do |form| %>`.

***codice 01 - ...continua - line: 14***

```html+erb
  <div>
    <%= form.label :name, style: "display: block" %>
    <%= form.text_field :name, placeholder: true %>
  </div>

  <div>
    <%= form.label :email, style: "display: block" %>
    <%= form.text_field :email, placeholder: true %>
  </div>

  <div>
    <%= form.label :password, style: "display: block" %>
    <%= form.password_field :password, placeholder: true %>
  </div>

  <div>
    <%= form.label :password_confirmation, style: "display: block" %>
    <%= form.password_field :password_confirmation, placeholder: true %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_01-views-users-_form.html.erb)

> Su rails 6 usavo `<div class="field">`.


Diamo la traduzione al placeholder nei locales.

***codice n/a - .../config/locales/it.yml - line: 1***

```yaml
it:
  helpers:
    placeholder:
      user:
        name: "nome utente"
        email: "email"
        password: "password"
        password_confirmation: "conferma password"
```


***codice n/a - .../config/locales/en.yml - line: 1***

```yaml
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

Lato form non devo fare nulla. L'importante è che ci sia la ***label*** per ogni campo.

***codice n/a - .../app/views/users/_form.html.erb - line: 1***

```htnl+erb
    <%= form.label :name %>
  ...
    <%= form.label :email %>
  ...
    <%= form.label :password %>
  ...
    <%= form.label :password_confirmation %>
```

mettiamo la traduzione alle labels nei locales

***codice 02 - .../config/locales/it.yml - line: 1***

```yaml
  activerecord:
    attributes:
      user:
        name: "Nome utente" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Conferma password" # fallback for when label is nil
  helpers:
    label:
      user:
        name: "Nome utente"
        email: "Email"
        password: "Password"
        password_confirmation: "Conferma password"
    placeholder:
      user:
        name: "Nome utente"
        email: "Email"
        password: "Password"
        password_confirmation: "Conferma password"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_02-config-locales-it.yml)

***codice 03 - .../config/locales/en.yml - line: 1***

```yaml
  activerecord:
    attributes:
      user:
        name: "User name" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Password confirmation" # fallback for when label is nil
  helpers:
    label:
      user:
        name: "User name"
        email: "Email"
        password: "Password"
        password_confirmation: "Password confirmation"
    placeholder:
      user:
        name: "User name"
        email: "Email"
        password: "Password"
        password_confirmation: "Password confirmation"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_03-config-locales-en.yml)


Se il percorso tramite *helpers:* non è disponibile, *i18n* userà il percorso alternativo *activerecord:*.

> Lo possiamo verificare commentando nome utente sotto *helpers - label*.
>
>   *helpers: -> label: -> user: ->* `#name: "User name"`



## I pulsanti di *Submit*

Cambiamo i valori dei pulsanti di *Submit* per nuovo o aggiornamento utente.

Verifichiamo che il pulsante sia presente nel form.

***codice: n/a - .../app/views/users/_form.html.erb - line: 56***

```html+erb
<%= form_with(model: user, local: true) do |form| %>
  [...]
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

e traduciamo il suo valore sui locales

***codice: n/a - .../config/locales/it.yml - line: 1***

```yaml
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

***codice: n/a - .../config/locales/it.yml - line: 1***

```yaml
it:
  activerecord:
    [...]
    models:
      user: "utente"
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "users form fields i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
