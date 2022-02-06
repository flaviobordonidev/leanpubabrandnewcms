# <a name="top"></a> Cap 10.1 - Internazionalizzazione dei messaggi

Al momento abbiamo lasciato dei messaggi scritti direttamente nel codice ma questo non ci permette di gestire più lingue. Passiamo i messaggi attraverso i files "locales".



## Apriamo il branch "Users_controllers I18n"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b ui
```



## I messaggi nei controllers

Gestiamo i messaggi *notice* ed *alerts* in *users_controller*.

Internazionalizziamo l'azione *create*.

***codice 01 - .../app/controllers/users_controller.rb - line: 31***

```html+erb
        format.html { redirect_to user_url(@user), notice: t(".notice") } # notice: "User was successfully created."
```


Internazionalizziamo l'azione *update*.

***codice 01 - ...continua - line: 31***

```html+erb
        format.html { redirect_to user_url(@user), notice: t(".notice") } # notice: "User was successfully updated."
```

Internazionalizziamo l'azione *destroy*.

***codice 01 - ...continua - line: 31***

```html+erb
        redirect_to users_url, notice: t(".notice") unless @user == current_user # notice: "User was successfully destroyed."
        redirect_to users_url, notice: t(".notice_logged_in") if @user == current_user #  notice: "The logged in user cannot be destroyed."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_05-views-users-new.html.erb)


Aggiorniamo i files locales

***codice 02 - .../config/locales/it.yml - line: 1***

```yaml
it:
  users:
    create:
      notice: "L'utente è stato creato con successo."
    update:
      notice: "L'utente è stato aggiornato con successo."
    destroy:
      notice: "L'utente è stato eliminato con successo."
      notice_logged_in: "L'utente loggato non può essere eliminato."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_05-views-users-new.html.erb)


***codice 03 - .../config/locales/en.yml - line: 1***

```yaml
en:
  users:
    create:
      notice: 'User was successfully created.'
    update:
      notice: 'User was successfully updated.'
    destroy:
      notice: "User was successfully destroyed."
      notice_logged_in: "The logged in user cannot be destroyed."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_05-views-users-new.html.erb)



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
