# <a name="top"></a> Cap 21.4 - Implementiamo internazionalizzazione per la data di pubblicazione

Implementiamo i18n aggiornando i "locales" per visualizzare la data nelle varie lingue.


 
## Verifichiamo dove eravamo rimasti

```bash
$ git status
$ git log
```



## Apriamo il branch

Continuiamo con il branch del capitolo precedente.



## internazionalizziamo nella variabile virtuale published_at_formatted

Aggiungiamo i18n nella variabile virtuale `published_at_formatted` nel model *EgPost* perché questo ci permette di gestire una logica più complessa.
Ad esempio nel nostro caso ci permette di visualizzare una stringa invece di un *"nil"* nel caso in cui l'articolo non sia pubblicato.<br/>
Aggiorniamo il `## getter method` nella sezione `# == Instance Methods` del model.

***codice 01 - .../app/models/eg_post.rb - line:31***

```ruby
  ## getter method
  def published_at_formatted 
    if published_at.present?
      #"Pubblicato il #{published_at.strftime('%-d %-b %Y')}"
      ActionController::Base.helpers.l published_at, format: :long
    else
      "non pubblicato"
    end
  end
```

> Per mettere gli *helpers* nei model devo puntare ad `ActionController::Base.helpers.` perché non sono direttamente disponibili nel model.

Continuare con l'internazionalizzazione anche per il *"non pubblicato"*.

***codice 01 - .../app/models/eg_post.rb - line:31***

```ruby
  ## getter method
  def published_at_formatted 
    if published_at.present?
      ActionController::Base.helpers.l published_at, format: :long
    else
      ActionController::Base.helpers.t 'eg_posts.not_published'
    end
  end
```

Aggiorniamo i *locales*.

***codice 02 - .../config/locales/it.yml - line:13***

```yaml
  eg_posts:
    not_published: "non è stato ancora pubblicato"
```


***codice 03 - .../config/locales/en.yml - line:13***

```yaml
  eg_posts:
    not_published: "It is not published yet"
```

> Facciamo una riflessione e valutiamo se, in questo caso, non è forse meglio trovare una visualizzazione che non ha bisogno della *variabile virtuale*.
>
> Magari giocandocela meglio con la parte di traduzione e l'helper *l*.



## Verifichiamo preview



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "I18n per published_at"
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
