{id: 01-base-09-manage_users-04-browser_tab_title_users}
# Cap 9.4 -- Titolo dinamico nel tab del browser

Vogliamo rendere dinamico il titolo che appare nel tab del browser. In questo capitolo introduciamo il "contenitore vuoto" yield(:my_variable).




## Apriamo il branch "Dynamic Title on Browser Tabs"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b dtbt
```




## Il "contenitore vuoto" yield(:html_head_title)

Implementiamo il cambio del titolo nel layout application con un "yield(:my_variable_name)" che è una specie di segna posto o di contenitore vuoto da riempire con delle chiamate fatte nelle altre views

{id: "01-09-03_01", caption: ".../app/views/layouts/application.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 4}
```
    <title><%= yield(:html_head_title) %> | Baseline6_0</title>
```

[tutto il codice](#01-09-03_01all)




## I contenuti del contenitore yield(:html_head_title)

Sulle views di nostro interesse collochiamo i contenuti per il nostro "contenitore vuoto" yield(:html_head_title). I contenuti sono passati al contenitore con il "provide(:html_head_title, "il mio contenuto")". Inseriamo il codice all'inizio tra dei divisori "<%# == Meta_data"

{id: "01-09-03_02", caption: ".../app/views/users/index.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "Tutti gli utenti") %>

<%# == Meta_data - end ====================================================== %>
```


{id: "01-09-03_03", caption: ".../app/views/users/show.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, @user.name) %>

<%# == Meta_data - end ====================================================== %>
```


{id: "01-09-03_04", caption: ".../app/views/users/edit.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "Modifica #{@user.name}") %>

<%# == Meta_data - end ====================================================== %>
```


{id: "01-09-03_05", caption: ".../app/views/users/new.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "Nuovo utente") %>

<%# == Meta_data - end ====================================================== %>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Spostandoci tra le varie views di users vediamo che cambia il nome sul tab del browser. Se non si riesce a leggere basta portarci il mouse sopra e si visualizza nel tooltip.




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Dynamic title on browser tabs"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku dtbt:master
```




## Chiudiamo il branch


se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge dtbt
$ git branch -d dtbt
```




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
