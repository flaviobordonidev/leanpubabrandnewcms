# <a name="top"></a> Cap 11.2 - Rendiamo multilingua il titolo nel tab del browser per eg_posts

Attiviamo le traduzioni per il titolo nel tab del browser.



## Apriamo il branch "Browser Tab EgPosts"

```bash
$ git checkout -b btep
```



## Implementiamo internazionalizzazione (i18n)

Creiamo delle nuove voci nei locales che aggiungeremo poi alle views.

***codice 01 - .../config/locales/it.yml - line: 4***

```yaml
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



***codice 02 - .../config/locales/en.yml - line: 4***

```yaml
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

***codice 03 - .../app/views/eg_posts/index.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t '.html_head_title'}") %>
```

traduciamo show

***codice n/a - .../app/views/eg_posts/show.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t '.html_head_title'}: #{@eg_post.headline}") %>
```

traduciamo edit

***codice n/a - .../app/views/eg_posts/edit.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t '.html_head_title'} #{@eg_post.headline}") %>
```

traduciamo new

***codice n/a - .../app/views/eg_posts/new.html.erb - line: 3***

```html+erb
<% provide(:html_head_title, "#{t '.html_head_title'}") %>
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Internationalization title on browser tabs"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku btep:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge btep
$ git branch -d btep
```



# Aggiorniamo github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)