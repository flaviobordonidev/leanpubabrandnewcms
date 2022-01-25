{id: 01-base-10-users_i18n-01-users_controllers_i18n}
# Cap 10.1 -- Internazionalizzazione dei messaggi

Al momento abbiamo lasciato dei messaggi scritti direttamente nel codice ma questo non ci permette di gestire più lingue. Passiamo i messaggi attraverso i files "locales".




## Apriamo il branch "Users_controllers I18n"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b ui
```




## I messaggi nei controllers

Gestiamo i messaggi "notice" ed "alerts" in users_controller

azione create

{id: "01-10-01_01", caption: ".../app/controllers/users_controller.rb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 31}
```
        format.html { redirect_to @user, notice: t(".notice") }
```

azione update

{caption: ".../app/controllers/users_controller.rb -- continua", format: HTML+Mako, line-numbers: true, number-from: 31}
```
          redirect_to @user, notice: t(".notice")
```


Aggiorniamo i files locales

{id: "01-10-01_02", caption: ".../config/locales/it.yml -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
it:
  users:
    create:
      notice: "L'utente è stato creato con successo."
    update:
      notice: "L'utente è stato aggiornato con successo."
```

{id: "01-10-01_03", caption: ".../config/locales/en.yml -- codice 03", format: yaml, line-numbers: true, number-from: 1}
```
en:
  users:
    create:
      notice: 'User was successfully created.'
    update:
      notice: 'User was successfully updated.'
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
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

