# <a name="top"></a> Cap 11.98 - Protezione della homepage (root_path)

> Attenzione se Proteggiamo anche la pagina root (homepage) con devise abbiamo un comportamento "strano"

In questo caso al primo login si entra nella homepage. 
Se si riprova a fare login - http://localhost:3000/users/sign_in - quando si è già loggati allora si viene reinstradati su users/show.

Meglio lasciare la homepage pubblica con il link che ti fa fare login all'area riservata (protetta da devise + pundit).



[TODO]



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
