# <a name="top"></a> Cap 11.2 - Rendiamo multilingua il titolo nel tab del browser per eg_posts

Attiviamo le traduzioni per il titolo nel tab del browser quando siamo nella pagine di EgPost.



## Apriamo il branch "Browser Tab EgPosts"

```bash
$ git checkout -b btep
```



## Implementiamo internazionalizzazione (i18n)

Creiamo delle nuove voci nei locales che aggiungeremo poi alle views.

***codice 01 - .../config/locales/it.yml - line:60***

```yaml
#-------------------------------------------------------------------------------
# Controllers (in ordine alfabetico)

  eg_posts:  eg_posts:
    index:
      html_head_title: "Tutti gli articoli"s
    show:
      html_head_title: "Art. %{id}"
    edit:
      html_head_title: "Modifica Art. %{id}"
    new:
      html_head_title: "Nuovo articolo"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)


***codice 02 - .../config/locales/en.yml - line:60***

```yaml
#-------------------------------------------------------------------------------
# Controllers (in alphabetical order)

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

Traduciamo index

***codice 03 - .../app/views/eg_posts/index.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "#{t 'eg_posts.index.html_head_title'}") %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_03-views-eg_posts-index.html.erb)

Traduciamo show

***codice 04 - .../app/views/eg_posts/show.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<%# provide(:html_head_title, "Articolo/Post: #{@eg_post.id}") %>
<%# provide(:html_head_title, "#{t '.html_head_title'}: #{@eg_post.headline}") %>
<% provide(:html_head_title, t('eg_posts.show.html_head_title', id: @eg_post.id)) %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_04-views-eg_posts-show.html.erb)

traduciamo edit

***codice 05 - .../app/views/eg_posts/edit.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, t('eg_posts.edit.html_head_title', id: @eg_post.id)) %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_05-views-eg_posts-edit.html.erb)

traduciamo new

***codice 06 - .../app/views/eg_posts/new.html.erb - line: 1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, t('eg_posts.new.html_head_title')) %>

<%# == Meta_data - end ====================================================== %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_06-views-eg_posts-new.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamolo il browser sull'URL:

* http://192.168.64.3:3000/eg_posts

Creando un nuovo articolo o aggiornando un articolo esistente vediamo i nuovi messaggi tradotti.



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

> In questo caso il comando `heroku run rails db:migrate` è superfluo lo lascio solo come promemoria per quando serve.



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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/01_00-eg_posts-seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/03_00-eg_posts-protected-it.md)
