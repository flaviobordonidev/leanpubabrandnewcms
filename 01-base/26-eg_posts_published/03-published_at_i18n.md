{id: 01-base-26-eg_posts_published-03-published_at_i18n}
# Cap 26.3 -- Implementiamo internazionalizzazione per la data di pubblicazione

Implementiamo i18n aggiornando i "locales" per visualizzare la data nelle varie lingue. (Nel nostro caso italiano e inglese)



 
## Verifichiamo dove eravamo rimasti

{caption: "terminal", format: bash, line-numbers: false}
```
$ git status
$ git log
```




## Apriamo il branch

Continuiamo con il branch del capitolo precedente.




## internazionalizziamo nella variabile virtuale published_at_formatted

Aggiungiamo i18n nella variabile virtuale published_at_formatted nel model eg_posts perché questo ci permette di gestire una logica più complessa.
Ad esempio nel nostro caso ci permette di visualizzare una stringa invece di un "nil" nel caso in cui l'articolo non sia pubblicato.


{id: "01-26-03_01", caption: ".../app/models/eg_post.rb -- codice 01", format: ruby, line-numbers: true, number-from: 13}
```
  ## getter method
  def published_at_formatted 
    if published_at.present?
      #published_at.strftime('%-d %-b %Y')
      #"Pubblicato il #{published_at.strftime('%-d %-b %Y')}"
      ActionController::Base.helpers.l published_at, format: :long
    else
      "non pubblicato"
    end
  end
```

Per mettere gli helpers nei model devo puntare ad "ActionController::Base.helpers." perché non sono direttamente disponibili nel model.
E' bene fare una riflessione e valutare se, in questo caso, non è forse meglio trovare una visualizzazione che non ha bisogno della variabile virtuale.

Comunque volendo continuare su questa strada internazionalizziamo anche il "non pubblicato"


{id: "01-26-03_02", caption: ".../config/locales/it.yml -- codice 02", format: yaml, line-numbers: true, number-from: 13}
```
  eg_posts:
    not_published: "non è stato ancora pubblicato"
```


{id: "01-26-03_03", caption: ".../config/locales/en.yml -- codice 03", format: yaml, line-numbers: true, number-from: 13}
```
  eg_posts:
    not_published: "It is not published yet"
```


{id: "01-26-03_01", caption: ".../app/models/eg_post.rb -- codice 01", format: ruby, line-numbers: true, number-from: 13}
```
  ## getter method
  def published_at_formatted 
    if published_at.present?
      ActionController::Base.helpers.l published_at, format: :long
    else
      ActionController::Base.helpers.t 'eg_posts.not_published'
    end
  end
```





## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "I18n per published_at"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ps:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ps
$ git branch -d ps
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo







---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
