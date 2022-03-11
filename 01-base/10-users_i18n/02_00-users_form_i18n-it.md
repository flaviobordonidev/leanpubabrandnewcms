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

***codice n/a - .../config/locales/it.yml - line:33***

```yaml
  helpers:
    placeholder:
      user:
        name: "nome utente"
        email: "email"
        password: "password"
        password_confirmation: "conferma password"
```


***codice n/a - .../config/locales/en.yml - line:33***

```yaml
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

***codice n/a - .../app/views/users/_form.html.erb - line:15***

```htnl+erb
    <%= form.label :name ... %>
  ...
    <%= form.label :email ... %>
  ...
    <%= form.label :password ... %>
  ...
    <%= form.label :password_confirmation ... %>
```

mettiamo la traduzione alle labels nei locales

***codice 02 - .../config/locales/it.yml - line:33***

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

***codice 03 - .../config/locales/en.yml - line:33***

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
  <div>
    <%= form.submit %>
  </div>
```

> Su rails 6 era `<div class="actions"><%= form.submit %></div>`

e traduciamo il suo valore sui locales sotto *helpers:*.

***codice: n/a - .../config/locales/it.yml - line: 55***

```yaml
    submit:
      user:
        create: "Crea %{model}"
        update: "Aggiorna %{model}"
```


## Traduciamo il nome del model

Traduciamo il suo valore sui locales sotto *activerecord:*.

***codice: n/a - .../config/locales/it.yml - line: 40***

```yaml
    models:
      user: "utente"
```


## Vediamo il risultato finale dei locales

***codice 04 - .../config/locales/it.yml - line: 32***

```yaml
it:
  activerecord:
    attributes:
      user:
        name: "Nome utente" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Conferma password" # fallback for when label is nil
    models:
      user: "utente"
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
    submit:
      user:
        create: "Crea %{model}"
        update: "Aggiorna %{model}"
  mockups:
    page_a:
      headline: "Questa è l'homepage"
      first_paragraph: "Il testo mostrato è o passato da un 'file di traduzione' e questo significa che la nostra applicazione è pronta a supportare più lingue."
      link_to_page_B: "Andiamo alla pagina B"
  users:
    create:
      notice: "L'utente è stato creato con successo."
    update:
      notice: "L'utente è stato aggiornato con successo."
    destroy:
      notice: "L'utente è stato eliminato con successo."
      notice_logged_in: "L'utente loggato non può essere eliminato."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_04-config-locales-it.yml)


***codice 05 - .../config/locales/en.yml - line: 32***

```yaml
en:
  activerecord:
    attributes:
      user:
        name: "User name" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Password confirmation" # fallback for when label is nil
    models:
      user: "user"
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
    submit:
      user:
        create: "Create %{model}"
        update: "Update %{model}"
  mockups:
    page_a:
      headline: "This is the homepage"
      first_paragraph: "The text showed here is passed via a 'translation file' and this means that our application is ready to support more languages."
      link_to_page_B: "Let's go to page B."
  users:
    create:
      notice: 'User was successfully created.'
    update:
      notice: 'User was successfully updated.'
    destroy:
      notice: "User was successfully destroyed."
      notice_logged_in: "The logged in user cannot be destroyed."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_05-config-locales-en.yml)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

Apriamo il browser sull'URL:

- http://192.168.64.3:3000/users



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "users form fields i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



## Chiudiamo il branch

lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/01_00-users_controllers_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_00-browser_tab_title_users_i18n-it.md)
