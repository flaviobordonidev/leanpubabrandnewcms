{id: 01-base-12-format_i18n-00-overview_i18n}
# Cap 12.1 -- Formattiamo le date nelle varie lingue

Di default il comando di formattazione della data prende i nomi in inglese. Vediamo come implementare l'Italiano.




## I formati di default

[VEDI 99-rails_references/i18n/02-format_date_time_i18n]

Nella guida ufficiale di Rails https://guides.rubyonrails.org/i18n.html (questo link è anche indicato nel file iniziale locale/en.yml) al Capitolo "9 Contributing to Rails I18n" si rimanda al seguente link:

* https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

Qui ci sono già tante traduzioni in moltissime lingue.

Nella nostra applicazione partiamo dai seguenti formati:

* 01_01-config-locale-en-base.yml
* 01_02-config-locale-it-base.yml
  a cui abbiamo aggiunto le seguenti due linee che erano presenti solo in inglese:
  126 --> model_invalid: 'Validazione fallita: %{errors}'
  193 --> eb: EB




## Allineiamo i due files di traduzioni statiche

Allineiamo en.yml e it.yml

Allineo le traduzioni dello yaml italiano con quelle in inglese per semplificare successive variazioni. Tutte le righe restano identiche per le varie lingue.
Quindi, anche se di default ho già in Rails le traduzioni in inglese le prendiamo comunque da

* https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

Scegliamo l'inglese degli stati uniti:

* https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml

partiamo quindi da queste due traduzioni di base:

* [Italiano](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml)
* [Inglese](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml)

Ed aggiungiamo le nostre personalizzazioni, eventualmente con il commento "#customized" in fondo alla riga.

Attenzione:
Può sembrare comodo iniziare in basso e ripetere delle voci in una sezione customized ad esempio qualcosa del genere:


```
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

```
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

```
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



