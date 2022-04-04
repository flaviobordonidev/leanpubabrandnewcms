# <a name="top"></a> Cap 21.3 - Virtual Attribute per campo data

Usiamo un attributo virtuale nel model per gestire il campo data formattato.



## Formattiamo il campo data

creiamo l'attributo virtuale "published_at_formatted".
Nel model nella sezione " # == Instance Methods ", sottosezione " ## getter method "

{id: "01-26-02_05", caption: ".../app/models/eg_post.rb -- codice 05", format: ruby, line-numbers: true, number-from: 13}
```
  ## getter method
  def published_at_formatted 
    if published_at.present?
      published_at.strftime('%-d %-b %Y')
      #"Pubblicato il #{published_at.strftime('%-d %-b %Y')}"
    else
      "non pubblicato"
    end
  end
```

Aggiorniamo index

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 38}
```
        <td><%= eg_post.published_at_formatted %></td>
```




## Aggiorniamo show

{id: "01-26-02_06", caption: ".../app/views/eg_posts/show.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 22}
```
<p>
  <strong>Pubblicato:</strong>
  <%= @eg_post.published_at_formatted %>
</p>
```


ATTENZIONE: Come possiamo vedere abbiamo già gestito un modo differente di formattazione della data che ci permette di includere anche l'internazionalizzazione con lingue differenti. Nel prossimo paragrafo implementeremo questo metodo I18n anche per la data di pubblicazione.




## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add published to views/eg_posts with automatic update of published_at"
```



## Pubblichiamo su heroku

```bash
$ git push heroku ps:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ps
$ git branch -d ps
```




## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
