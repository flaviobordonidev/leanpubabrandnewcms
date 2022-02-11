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

Riportiamo queste traduzioni nei nostri files su *config/locale* e le allineiamo. 
Ossia facciamo in modo che nei due files allo stesso numero di riga corrisponda la stessa parte da tradurre.
Inoltre riportiamo le traduzioni all'interno dei gruppi di competenza. (es: `activerecord:`, `helpers:`, ...)

Aggiorniamo il nostro file della traduzione statica in italiano.

***codice 03 - .../config/locales/it.yml - line: 32***

```yaml
it:
  activerecord:
    attributes:
      user:
        name: "Nome utente" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Conferma password" # fallback for when label is nil
    errors:
      messages:
        record_invalid: 'Validazione fallita: %{errors}'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01_03-config-locales-it.yml)


Aggiorniamo il nostro file della traduzione statica in inglese.

***codice 04 - .../config/locales/en.yml - line: 32***

```yaml
en:
  activerecord:
    attributes:
      user:
        name: "User name" # fallback for when label is nil
        email: "Email" # fallback for when label is nil
        password: "Password" # fallback for when label is nil
        password_confirmation: "Password confirmation" # fallback for when label is nil
    errors:
      messages:
        record_invalid: 'Validation failed: %{errors}'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01_04-config-locales-en.yml)


Descrizioni dei cambi effettuati

1. Inserita la traduzione dei file scaricati sopra la traduzione dei *controllers*.
   Lasciato invariata tutta la traduzione dei *Controllers*; quella sotto la riga:

```yaml
#-------------------------------------------------------------------------------
# Controllers (in alphabetical order)
```

2. Inglobate le nostre traduzioni di `activerecord:` all'interno di quelle del file scaricato.

3. Inglobate le nostre traduzioni di `helpers:` all'interno di quelle del file scaricato.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser all'URL:

- mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "implement format_i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
$ heroku run rails db:migrate
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_postss/04-eg_redirect_after_login-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/02-format_date_time_i18n-it.md)
