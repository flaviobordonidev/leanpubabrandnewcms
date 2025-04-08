# <a name="top"></a> Cap 18.9 -- Rinnoviamo IAM user su AWS

Eliminando l'utente IAM user che sta validando le immagini per il nostro sito, perdiamo accesso a tutte le immagini.
In questo capitolo creeremo un nuovo IAM user e lo assoceremo al nostro sito per ripristinare tutte le immagini.



## Apriamo il branch "New Iam User"

```bash
$ git checkout -b niu
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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/08_00-aws_s3-restrict_permissions-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/01_00-text_wysiwyg-story-it.md)
