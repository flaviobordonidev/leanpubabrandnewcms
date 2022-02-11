# <a name="top"></a> Cap 12.1 - Formattiamo le date nelle varie lingue

Di default il comando di formattazione della data prende i nomi in inglese. Vediamo come implementare l'Italiano.


## Risorse interne

- [VEDI 99-rails_references/i18n/02-format_date_time_i18n]()



## Risorse esterne

- [guida ufficiale di Rails](https://guides.rubyonrails.org/i18n.html)
- [elenco lingue](https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale)
- [lingua en](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml)
- [lingua it](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml)



## Apriamo il branch "Formats i18n"

```bash
$ git checkout -b fin
```



## I formati di default

Per la formattazione in più lingue di date, monete, numeri ed altro ci sono già dei files .yml predisposti.

Noi scarichiamo quello per la lingua inglese e quello per la lingua italiana.

- [Italiano - svenfuchs-it](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml)
- [Inglese - svenfuchs-en-US](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml)

> Anche se di default ho già in Rails le traduzioni in inglese le prendiamo comunque perché nel prossimo paragrafo allineeremo i due files *.yml*.

> I files sono stati presi da https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale <br/>
> Ci siamo arrivati tramite il link https://guides.rubyonrails.org/i18n.html che è riportato sia nel file iniziale locale/en.yml, sia nella guida ufficiale di Rails al Capitolo "9 Contributing to Rails I18n". 

Il file italiano così com'è stato scaricato.

***codice 01 - https://github.com/svenfuchs/.../it.yml - line: 1***

```yaml
---
it:
  activerecord:
    errors:
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01_01-svenfuchs-it.yml)

Il file inglese così com'è stato scaricato.

***codice 02 - https://github.com/svenfuchs/.../en-US.yml - line: 1***

```yaml
---
en-US:
  activerecord:
    errors:
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01_02-svenfuchs-en-US.yml)




## Allineiamo i due files

 e li allineiamo.
Durante l'allineamento facciamo anche alcune correzioni e aggiunte.
Ed aggiungiamo le nostre personalizzazioni, eventualmente con il commento "#customized" in fondo alla riga.

> abbiamo aggiunto le seguenti due linee che erano presenti solo in inglese:
> - line: 126 -> `model_invalid: 'Validazione fallita: %{errors}'`
> - line: 193 -> `eb: EB`




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
