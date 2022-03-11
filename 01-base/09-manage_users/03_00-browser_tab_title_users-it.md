# <a name="top"></a> Cap 9.3 - Titolo dinamico nel tab del browser

Vogliamo rendere dinamico il titolo che appare nel tab del browser. In questo capitolo introduciamo il "contenitore vuoto" yield(:my_variable).



## Apriamo il branch "Dynamic Title on Browser Tabs"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b dtbt
```



## Il "contenitore vuoto" yield(:html_head_title)

Implementiamo il cambio del titolo nel *layout application* con un `yield(:my_variable_name)` che è una specie di segna posto o di contenitore vuoto da riempire con delle chiamate fatte nelle altre views.

***codice 01 - .../app/views/layouts/application.html.erb - line: 4***

```html+erb
    <title><%= yield(:html_head_title) %> | Baseline6_0</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_01-views-layouts-application.html.erb)



## I contenuti del contenitore yield(:html_head_title)

Sulle views di nostro interesse collochiamo i contenuti per il nostro "contenitore vuoto" yield(:html_head_title). I contenuti sono passati al contenitore con il "provide(:html_head_title, "il mio contenuto")". Inseriamo il codice all'inizio tra dei divisori "<%# == Meta_data"

***codice 02 - .../app/views/users/index.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "All users") %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_02-views-users-index.html.erb)


***codice 03 - .../app/views/users/show.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, @user.name) %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_03-views-users-show.html.erb)


***codice 04 - .../app/views/users/edit.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "Edit #{@user.name}") %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_04-views-users-edit.html.erb)


***codice 05 - .../app/views/users/new.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "New user") %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_05-views-users-new.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users

Spostandoci tra le varie views di users vediamo che cambia il nome sul tab del browser. 
Se non si riesce a leggere basta portarci il mouse sopra e si visualizza nel tooltip.



## salviamo su git

```bash
$ git add -A
$ git commit -m "Dynamic title on browser tabs"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku dtbt:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge dtbt
$ git branch -d dtbt
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_00-users_protected-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/01_00-users_controllers_i18n-it.md)
