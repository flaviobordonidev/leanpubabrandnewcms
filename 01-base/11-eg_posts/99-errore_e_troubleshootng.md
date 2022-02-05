# <a name="top"></a> Cap 11.98 - ERRORE E TROUBLESHOOTING

Un piccolo errore non faceva funzionare l'applicativo su Heroku. Vediamo cosa era successo.



## In locale funziona ma in produzione no.

Anche se in locale funzionava tutto su heroku avevo un errore quando premevo link per creare nuovo articolo.
guardando le log di heroku ho visto che il problema era sul controller per l'azione new. (Alquanto ovvio ^_^)
L'indizio importante è stato "unknown attribute 'author_id' for Post"

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku logs
  Completed 500 Internal Server Error in 12ms (ActiveRecord: 3.1ms)
  ActiveModel::UnknownAttributeError (unknown attribute 'author_id' for Post.):
  app/controllers/authors/posts_controller.rb:20:in `new'
```

Ho fatto un po' di prove da terminale e sembrava tutto ok, quando si è accesa la lampadina! Ci siamo scordati di aggiungere :author_id alla lista bianca per il massive assignment. Aggiunta la voce, problema risolto! :)

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=61}
```
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :body, :description, :author_id)
      end
```





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
