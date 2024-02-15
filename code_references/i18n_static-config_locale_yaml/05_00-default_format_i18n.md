# <a name="top"></a> Cap 2.4 - Lo formattazioni base nelle varie lingue

Per la formattazione in più lingue di date, monete, numeri ed altro ...



## Risorse interne

- [ubuntudream/04-i18n_static/04_00-default_format_i18n-mockups-test_a]()



## Risorse esterne

- [guida ufficiale di Rails](https://guides.rubyonrails.org/i18n.html)
- [example translations data / elenco ufficiale lingue](https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale)
- [lingua en](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml)
- [lingua it](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml)

> guides.rubyonrails.org/i18n.html -> 9 Contributing to Rails I18n <br/>
> If you find your own locale (language) missing from our example translations data repository for Ruby on Rails, please fork the repository, add your data, and send a pull request.



## I formati preimpostati

Per la formattazione in più lingue di date, monete, numeri ed altro ci sono già dei files .yml predisposti.

Nei commenti iniziali del file di default en.yml è indicato:

```yaml
# To learn more about the API, please read the Rails Internationalization guide
# at https://guides.rubyonrails.org/i18n.html.
```

Questo file apre la guida di Rails al capitolo *Rails Internationalization (I18n) API*.
In fondo al capitolo, al paragrafo 9 *Contributing to Rails I18n*, c'è il link ai files preimpostati delle varie lingue:

- [example translations data](https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale)

Ci scarichiamo quelli per la lingua italiana e inglese.

- [Italiano - svenfuchs-it](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml)
- [Inglese - svenfuchs-en-US](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-US.yml)

> La lingua inglese potremmo anche non scaricarla perché su Rails è già presente nativamente ma scaricare il file `en.yml` ci permette di allineare bene le traduzioni con l'italiano.

Il file italiano così com'è stato scaricato.

[Codice 01 - https://github.com/svenfuchs/.../it.yml - line: 1]()

```yaml
---
it:
  activerecord:
    errors:
```

Il file inglese così com'è stato scaricato.

[Codice 02 - https://github.com/svenfuchs/.../en-US.yml - linea: 1]()

```yaml
---
en-US:
  activerecord:
    errors:
```



## Allineiamo i due files tra di loro

Compariamo i due files tra loro e li allineiamo.
Ossia facciamo in modo che nei due files allo stesso numero di riga corrisponda la stessa parte da tradurre.

> Su vscode -> tasto destro sul primo file e scegli "*select to compare*" -> tasto destro sul secondo file e scegli "*Compare wiht selected*".

Ho aggiunto due righe nel file italiano.

[Codice 03 - https://github.com/svenfuchs/.../it-allined.yml - line: 1](05_03-svenfuchs-it-allined)

```yaml
---
it:
  activerecord:
    errors:
```

Non ho cambiato nulla nel file inglese.

[Codice 04 - https://github.com/svenfuchs/.../en-US-allined.yml - linea: 1](05_04-svenfuchs-en-US-allined)

```yaml
---
en-US:
  activerecord:
    errors:
```



## Riportiamo il contenuto dei due files preimpostati nei files sulla nostra applicazione Rails

Riportiamo queste traduzioni nei nostri files su *config/locale* e le allineiamo. 

Aggiorniamo il nostro file della traduzione statica in italiano.

[Codice 05 - .../config/locales/it.yml - linea: 30]()

```yaml
#---
# Repository di Rails: dati di traduzione allineati (in ordine alfabetico)

it:
  activerecord:
    errors:
      messages:
        record_invalid: 'Validazione fallita: %{errors}'
```

Aggiorniamo il nostro file della traduzione statica in inglese.

[Codice 06 - .../config/locales/en.yml - line: 30]()

```yaml
#---
# Rail repository: translations data allined (in alphabetical order)

en-US:
  activerecord:
    errors:
      messages:
        record_invalid: 'Validation failed: %{errors}'
```



## Verifichiamo preview

Facciamo partire il webserver

```shell
$ rails s -b 192.168.64.4
```

E apriamo il browser all'URL:

- `http://192.168.64.4:3000/mockups/test_a`
- `http://192.168.64.4:3000/mockups/test_a?locale=en`
- `http://192.168.64.4:3000/mockups/test_a?locale=it`
- `http://192.168.64.4:3000/mockups/test_a?locale=es`



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/04_00-eg_redirect_after_login-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/02_00-format_date_time_i18n-it.md)
