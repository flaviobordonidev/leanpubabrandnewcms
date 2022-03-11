# <a name="top"></a> Cap 10.3 - Rendiamo multilingua il titolo nel tab del browser

Attiviamo le traduzioni per il titolo nel tab del browser: *titolo dinamico nel tab del browser*.

Rendiamo dinamico il titolo che appare nel tab del browser. 
In questo capitolo introduciamo il "contenitore vuoto" ***yield(:my_variable)***.



## Apriamo il branch 

continuiamo con lo stesso branch del capitolo precedente



## Implementiamo internazionalizzazione (i18n)

Creiamo delle nuove voci nei locales che aggiungeremo poi alle views.

***codice 01 - .../config/locales/it.yml - line: 4***

```yaml
  users:
    index:
      html_head_title: "Tutti gli utenti"
    new:
      html_head_title: "Nuovo utente"
    edit:
      html_head_title: "Modifica"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_01-config-locales-it.yml)


***codice 02 - .../config/locales/en.yml - line: 4***

```yaml
  users:
    index:
      html_head_title: "All users"
    new:
      html_head_title: "New post"
    edit:
      html_head_title: "Edit"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_02-config-locales-en.yml)


> Invece di metterle in *ordine alfabetico* le mettiamo come si *presentano nel controller*: 
> ***index, show, new, edit, create, update, destroy.***
>
> Non abbiamo inserito la voce *show* perché richiamiamo solo il nome dell'utente. 
> L'avremmo inserita se avessimo usato una frase tipo "Show user" ("Mostra utente").



## Aggiungiamo le chiamate alle views

traduciamo index

***codice 03 - .../app/views/users/index.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t 'users.index.html_head_title'}") %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_03-views-users-index.html.erb)


La chiamata per show la lasciamo così com'è

***codice 04 - .../app/views/users/show.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, @user.name) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_04-views-users-show.html.erb)


traduciamo edit

***codice 05 - .../app/views/users/edit.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t 'users.edit.html_head_title'} #{@user.name}") %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_05-views-users-edit.html.erb)


traduciamo new

***codice 06 - .../app/views/users/new.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t 'users.new.html_head_title'}") %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/03_06-views-users-new.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamolo il browser sull'URL:

* http://192.168.64.3:3000/users

Andando nelle varie *views* vediamo che il nome del *tab* del browser ha la traduzione in funzione della lingua selezionata.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Internationalization title on browser tabs"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database.



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_00-users_form_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04_00-language_enum-it.md)
