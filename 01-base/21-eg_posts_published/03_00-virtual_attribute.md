# <a name="top"></a> Cap 21.3 - Virtual Attribute per campo data

Usiamo un attributo virtuale nel model per gestire il campo data formattato.



## Formattiamo il campo data

Creiamo l'attributo virtuale `published_at_formatted`.<br/>
Creiamo un `## getter method` nella sezione `# == Instance Methods` del model.

***codice 01 - .../app/models/eg_post.rb - line:31***

```ruby
  ## getter method
  def published_at_formatted 
    if published_at.present?
      "Pubblicato il #{published_at.strftime('%-d %-b %Y')}"
    else
      "non pubblicato"
    end
  end
```



## Aggiorniamo index e show

Aggiorniamo il partial della view.

***codice 02 - .../app/views/eg_posts/_eg_post.html.erb - line:54***

```html+erb
    <%= eg_post.published_at_formatted %>
```

> ATTENZIONE: Come possiamo vedere nei capitoli precedenti abbiamo già gestito in modo differente la formattazione della data. Un modo che ci permette di includere anche l'internazionalizzazione con lingue differenti. Nel prossimo paragrafo implementeremo questo metodo I18n anche per la data di pubblicazione.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts

Vediamo la data di pubblicazione passata con una *variabile virtuale*.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add virtual attribute published_at_formatted"
```



## Pubblichiamo su heroku

```bash
$ git push heroku ps:main
```



## Chiudiamo il branch

Lo chiudiamo nei prossimi capitoli



## Facciamo un backup su Github

Lo facciamo nei prossimi capitoli



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/02_00-publish-form-submit-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/04_00-published_at_i18n-it.md)
