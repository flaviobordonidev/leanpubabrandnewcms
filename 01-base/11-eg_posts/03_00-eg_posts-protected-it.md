# <a name="top"></a> Cap 11.3 - Protezione degli articoli con devise

Attiviamo una *protezione* con devise che si sovrappone al concetto di *autorizzazione* che vedremo più avanti.
In pratica rendiamo alcune pagine non visibili a meno di non fare login, a meno di non autenticarsi.

> In questo caso l'autenticazione porta con se un'autorizzazione basica. 
>
> Tutte le persone che si autenticano sono autorizzate a vedere la pagina, invece le persone che non si autenticano non sono autorizzate a vedere la pagina.

La "vera" autorizzazione la vedremo nei prossimi capitoli e permetterà di dare diversi livelli di autrizzazione alle varie persone che si autenticano a seconda del loro "ruolo".



## Apriamo il branch "Protect EgPosts"

```bash
$ git checkout -b pep
```



## Attiviamo la protezione 

La protezione è attivata a livello di controller. Proteggiamo *eg_posts*.

***codice 01 - .../app/controllers/eg_posts_controller.rb - line: 2***

```ruby
before_action :authenticate_user!
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)

> *before_action* ha sostituito il "deprecated" *before_filter*

> Attenzione! <br/>
> For Rails 5, note that *protect_from_forgery* is no longer prepended to the *before_action* chain, so if you have set *authenticate_user* before *protect_from_forgery*, your request will result in "Can't verify CSRF token authenticity." 
> To resolve this, either ***change the order*** in which you call them, or use protect_from_forgery prepend: true.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- mycloud9path.amazonaws.com/

Verifichiamo di non essere loggati e proviamo ad entrare in:

- mycloud9path.amazonaws.com/eg_posts
- mycloud9path.amazonaws.com/eg_posts/1
- mycloud9path.amazonaws.com/eg_posts/1/edit
- mycloud9path.amazonaws.com/eg_posts/new

Saremo reinstradati nella pagina di login. 
Effettuato login con successo entreremo nella pagina richiesta inizialmente.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Activate Devise protection for eg_posts"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku pep:main
$ heroku run rails db:migrate
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pep
$ git branch -d pep
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01-overview_i18n-it.md)
