# <a name="top"></a> Cap 10.2 - Internazionalizzazione dei campi nei forms



## Apriamo il branch 

Continuiamo con lo stesso branch del capitolo precedente



## Inseriamo un segnaposto nei campi del form

Inseriamo un segnaposto nei campi del form (Input Placeholders). 
Possiamo dire a Rails di usare *i18n placeholder* passando il parametro `placeholder: true` nelle opzioni dei campi input del form.

***codice 01 - .../app/views/users/_form.html.erb - line: 31***

```html+erb
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

***codice 02 - .../config/locales/it.yml - line: 1***

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

***codice 02 - .../config/locales/en.yml - line: 1***

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

Se il percorso tramite *helpers:* non è disponibile, *i18n* userà il percorso alternativo *activerecord:*.

Lo possiamo verificare commentando nome utente.

***codice: n/a - .../config/locales/it.yml - line: 1***

```yaml
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



## salviamo su git

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



---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
