{id: 01-base-10-users_i18n-04-browser_tab_title_users_i18n}
# Cap 10.4 -- Rendiamo multilingua il titolo nel tab del browser

Attiviamo le traduzioni per il titolo nel tab del browser
Titolo dinamico nel tab del browser
Vogliamo rendere dinamico il titolo che appare nel tab del browser. In questo capitolo introduciamo il "contenitore vuoto" yield(:my_variable).




## Apriamo il branch 

continuiamo con lo stesso branch del capitolo precedente




## Implementiamo internazionalizzazione (i18n)

Creiamo delle nuove voci nei locales che aggiungeremo poi alle views.
Non mettiamo la traduzione per "show" perché richiamiamo solo il nome dell'utente. L'avremmo inserita se avessimo usato una frase tipo "Show user" ("Mostra utente").


{id: "01-10-04_01", caption: ".../config/locales/it.yml -- codice 01", format: yaml, line-numbers: true, number-from: 4}
```
  users:
    index:
      html_head_title: "Tutti gli utenti"
    edit:
      html_head_title: "Modifica"
    new:
      html_head_title: "Nuovo utente"
```



{id: "01-10-04_02", caption: ".../config/locales/en.yml -- codice 02", format: yaml, line-numbers: true, number-from: 4}
```
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

{title=".../app/views/users/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, "#{t 'users.index.html_head_title'}") %>
```

La chiamata per show la lasciamo così com'è

{title=".../app/views/users/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, @user.name) %>
```

traduciamo edit

{title=".../app/views/users/edit.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, "#{t 'users.edit.html_head_title'} #{@user.name}") %>
```

traduciamo new

{title=".../app/views/users/new.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, "#{t 'users.new.html_head_title'}") %>
```




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Internationalization title on browser tabs"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ui:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ui
$ git branch -d ui
```


aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
