# <a name="top"></a> Cap 10.3 - Rendiamo multilingua il titolo nel tab del browser

Attiviamo le traduzioni per il titolo nel tab del browser
Titolo dinamico nel tab del browser
Vogliamo rendere dinamico il titolo che appare nel tab del browser. In questo capitolo introduciamo il "contenitore vuoto" yield(:my_variable).



## Apriamo il branch 

continuiamo con lo stesso branch del capitolo precedente



## Implementiamo internazionalizzazione (i18n)

Creiamo delle nuove voci nei locales che aggiungeremo poi alle views.
Non mettiamo la traduzione per "show" perché richiamiamo solo il nome dell'utente. L'avremmo inserita se avessimo usato una frase tipo "Show user" ("Mostra utente").

***codice 01 - .../config/locales/it.yml - line: 4***

```yaml
  users:
    index:
      html_head_title: "Tutti gli utenti"
    edit:
      html_head_title: "Modifica"
    new:
      html_head_title: "Nuovo utente"
```


***codice 02 - .../config/locales/en.yml - line: 4***

```yaml
  users:
    index:
      html_head_title: "All users"
    edit:
      html_head_title: "Edit"
    new:
      html_head_title: "New post"
```



## Aggiungiamo le chiamate alle views

traduciamo index

***codice n/a - .../app/views/users/index.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t 'users.index.html_head_title'}") %>
```

La chiamata per show la lasciamo così com'è

***codice n/a - .../app/views/users/show.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, @user.name) %>
```

traduciamo edit

***codice n/a - .../app/views/users/edit.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t 'users.edit.html_head_title'} #{@user.name}") %>
```

traduciamo new

***codice n/a - .../app/views/users/new.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t 'users.new.html_head_title'}") %>
```



## salviamo su git

```bash
$ git add -A
$ git commit -m "Internationalization title on browser tabs"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge ui
$ git branch -d ui
```

aggiorniamo github

```bash
$ git push origin master
```



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
