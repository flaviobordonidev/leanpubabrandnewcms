{id: 01-base-19-rich_text_editor-01-story}
# Cap 19.1 -- Storia dei "rich text editors"

In rails 6 la gemma "trix" è incorporata e diventa Action Text!
Action Text è un nuovissimo framework su Rails 6 che rende la creazione, la modifica e la visualizzazione di contenuti RTF (Rich Text Content) nelle applicazioni super facili. È un'integrazione tra l'editor di Trix, l'elaborazione di file ActiveStorage e processamento immagini, e un flusso di elaborazione di testo che lega tutto insieme.

Risorse interne:

* 99-rails_references/Action_text/overview


## Gestione del testo con WYSIWYG

Per gestire il testo con un editor visuale (What You See Is What You Get) fino a Rails 5.2 si installavano delle gemme.
Le più note erano:

* TRIX - Open source gratuito sviluppato da BaseCamp
* FROALA - Eccellente WYSIWYG a pagamento una tantum
* TinyMCE - Ottimo WYSIWYG a pagamento continuativo

Ma da Rail 6.0 è stato introdotto un nuovo framework nativo basato su Trix. Il suo nome è Action Text.






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
