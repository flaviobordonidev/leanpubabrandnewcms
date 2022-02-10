# <a name="top"></a> Cap 11.2 - Rendiamo multilingua il titolo nel tab del browser per eg_posts

Attiviamo le traduzioni per il titolo nel tab del browser quando siamo nella pagine di EgPost.



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
      html_head_title: "Art. %{id}"
    edit:
      html_head_title: "Modifica Art. %{id}"
    new:
      html_head_title: "Nuovo articolo"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)


***codice 02 - .../config/locales/en.yml - line: 4***

```yaml
  eg_posts:
    index:
      html_head_title: "All posts"
    show:
      html_head_title: "Post %{id}"
    edit:
      html_head_title: "Edit Post %{id}"
    new:
      html_head_title: "New post"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_02-config-locales-en.yml)

> Nella traduzione su *show* ed *edit* passiamo il parametro *id* che corrisponde al numero dell'articolo.



## Aggiungiamo le chiamate alle views

traduciamo index

***codice 03 - .../app/views/eg_posts/index.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "#{t 'eg_posts.index.html_head_title'}") %>

<%# == Meta_data - end ====================================================== %>
```

traduciamo show

***codice 04 - .../app/views/eg_posts/show.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<%# provide(:html_head_title, "Articolo/Post: #{@eg_post.id}") %>
<%# provide(:html_head_title, "#{t '.html_head_title'}: #{@eg_post.headline}") %>
<% provide(:html_head_title, t('eg_posts.show.html_head_title', id: @eg_post.id)) %>

<%# == Meta_data - end ====================================================== %>
```

traduciamo edit

***codice 05 - .../app/views/eg_posts/edit.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, t('eg_posts.edit.html_head_title', id: @eg_post.id)) %>

<%# == Meta_data - end ====================================================== %>
```

traduciamo new

***codice 06 - .../app/views/eg_posts/new.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, t('eg_posts.new.html_head_title')) %>

<%# == Meta_data - end ====================================================== %>
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
$ heroku run rails db:migrate
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge btep
$ git branch -d btep
```



# Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
