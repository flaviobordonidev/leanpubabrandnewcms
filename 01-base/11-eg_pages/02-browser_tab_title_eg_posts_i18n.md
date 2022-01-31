{id: 01-base-11-eg_pages-04-browser_tab_title_eg_posts}
# Cap 11.4 -- Rendiamo multilingua il titolo nel tab del browser per eg_posts

Attiviamo le traduzioni per il titolo nel tab del browser.




## Apriamo il branch "Browser Tab EgPosts"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b btep
```





## Implementiamo internazionalizzazione (i18n)

Creiamo delle nuove voci nei locales che aggiungeremo poi alle views.

{id: "01-10-04_01", caption: ".../config/locales/it.yml -- codice 01", format: yaml, line-numbers: true, number-from: 4}
```
  eg_posts:
    index:
      html_head_title: "Tutti gli articoli"
    show:
      html_head_title: "Art."
    edit:
      html_head_title: "Modifica"
    new:
      html_head_title: "Nuovo articolo"
```



{id: "01-10-04_02", caption: ".../config/locales/en.yml -- codice 02", format: yaml, line-numbers: true, number-from: 4}
```
  eg_posts:
    index:
      html_head_title: "All posts"
    show:
      html_head_title: "Post"
    edit:
      html_head_title: "Edit"
    new:
      html_head_title: "New post"
```





## Aggiungiamo le chiamate alle views

traduciamo index

{id: "01-10-04_01", caption: ".../app/views/eg_posts/index.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<% provide(:html_head_title, "#{t '.html_head_title'}") %>
```

traduciamo show

{title=".../app/views/eg_posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, "#{t '.html_head_title'}: #{@eg_post.headline}") %>
```

traduciamo edit

{title=".../app/views/eg_posts/edit.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, "#{t '.html_head_title'} #{@eg_post.headline}") %>
```

traduciamo new

{title=".../app/views/eg_posts/new.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=3}
```
<% provide(:html_head_title, "#{t '.html_head_title'}") %>
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
$ git push heroku btep:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge btep
$ git branch -d btep
```




# Aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
