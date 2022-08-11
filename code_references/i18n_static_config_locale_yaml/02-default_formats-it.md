# <a name="top"></a> Cap 99.i18n_static_config_locale_yaml.02 - Formattiamo le date nelle varie lingue

Di default il comando di formattazione della data prende i nomi in inglese. Vediamo come implementare l'Italiano.


## Risorse interne

- [vedi: 01-base/12-format_i18n/01-overview_i18n-it](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01-overview_i18n-it.yml)



## Risorse esterne

- [guida ufficiale di Rails](https://guides.rubyonrails.org/i18n.html)
- [file della traduzione in italiano](https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale)



## I formati di default

Per la formattazione in più lingue di date, monete, numeri ed altro ci sono già dei files .yml predisposti.

Noi scarichiamo quello per la lingua inglese e quello per la lingua italiana e li allineiamo.
Durante l'allineamento facciamo anche alcune correzioni e aggiunte.

> abbiamo aggiunto le seguenti due linee che erano presenti solo in inglese:
> - line: 126 -> `model_invalid: 'Validazione fallita: %{errors}'`
> - line: 193 -> `eb: EB`


***codice 01 - .../config/locle/it.yml - line: 1***

```yaml
  ...
  # fine del file di traduzione preso da Github
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)


***codice 02 - .../config/locle/en.yml - line: 1***

```yaml
  ...
  # fine del file di traduzione preso da Github
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)


> I files sono stati presi da https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale <br/>
> Ci siamo arrivati tramite il link https://guides.rubyonrails.org/i18n.html che è riportato sia nel file iniziale locale/en.yml, sia nella guida ufficiale di Rails al Capitolo "9 Contributing to Rails I18n". 






## Allineiamo i due files di traduzioni statiche

Allineiamo en.yml e it.yml

Allineo le traduzioni dello yaml italiano con quelle in inglese per semplificare successive variazioni. Tutte le righe restano identiche per le varie lingue.
Quindi, anche se di default ho già in Rails le traduzioni in inglese le prendiamo comunque da

* https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

Scegliamo l'inglese degli stati uniti:

* https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml

partiamo quindi da queste due traduzioni di base:

- [Italiano](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml)
- [Inglese](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml)

Ed aggiungiamo le nostre personalizzazioni, eventualmente con il commento "#customized" in fondo alla riga.

Attenzione:
Può sembrare comodo iniziare in basso e ripetere delle voci in una sezione customized ad esempio qualcosa del genere:

***codice n/a - ... - line: 1***

```yaml
  ...
  # fine del file di traduzione preso da Github
  
  # Mine Customized Translations ----------------------------------------------

  time:
    formats:
      short: "il giorno %d %^B %Y"
      long: "%A %d %^B %Y alle %H:%M e %S secondi"
```

Questo funziona anche ma si innescano dei problemi e degli errori poco chiari. Ad esempio se commento solo "short" e "long" non sono attivati quelli di default; devo commentare anche "formats" e "time".
Ossia un nuovo blocco più in basso annulla tutto quello che era presente nelle righe precedenti.
Se ad esempio creo questa:

***codice n/a - ... - line: 1***

```yaml
  ...
  # fine del file di traduzione preso da Github
  
  # Mine Customized Translations ----------------------------------------------

  time:
    formats:
      my_cutom_short: "il giorno %d %^B %Y"
```

Automaticamente ho disabilitato le traduzioni "short" e "long" che sono nelle righe precedenti.

Quindi è meglio NON creare linee duplicate!!!

Nell'esempio in alto è bene aggiungere la linea nel blocco "time" "formats" già esistente:

***codice n/a - ... - line: 1***

```yaml
  time:
    am: am
    formats:
      default: "%a %d %b %Y, %H:%M:%S %z"
      long: "%d %B %Y %H:%M"
      short: "%d %b %H:%M"
      my_cutom_short: "il giorno %d %^B %Y"
    pm: pm
  ...
  # fine del file di traduzione preso da Github
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
