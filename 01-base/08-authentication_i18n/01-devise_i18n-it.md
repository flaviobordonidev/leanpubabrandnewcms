# <a name="top"></a> Cap 8.1 - Devise internazionalizzazione

Abilitiamo la traduzione i18n per i messaggi generati da devise.



## Vediamo dove eravamo rimasti

Diamo un'occhiata alla log di git per vedere l'ultimo commit effettuato.

```bash
$ git log
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (main) $ git log
commit d138fbe6682bb01ea7cd1a4544b2cde21f59ea94 (HEAD -> main, origin/main, heroku/main)
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Mon Jan 31 00:46:48 2022 +0000

    New layout entrance for login

commit f3fe49ab40f81a4ab8456f0bb6bb03d262b3e7f1
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Sun Jan 30 23:20:27 2022 +0000

    devise routes with controllers

commit f4ddfc667a4a6d50436d3c8317a65286d68fe06c (heroku/master)
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Sun Jan 30 12:15:38 2022 +0000

user_fb:~/environment/bl7_0 (main) $
```

> L'ultimo fatto riguardava il nuovo layout *entrance* per il login con devise.



## Apriamo il branch "Devise I18n"

```bash
$ git checkout -b di
```



## Il file devise.it.yml

In fase di installazione Devise ha creato il file *...config/locales/devise.en.yml* con tutte le frasi in inglese. 

> Ricordiamoci che i messaggi sono passati con le flash keys *:notice* and *:alert* quindi devono essere attivi sui views altrimenti non vengono visualizzati.

I messaggi di informazione e avviso di devise li abbiamo messi a livello di layout così li abbiamo su tutte le views.


***codice 01 - .../config/routes.rb - line: 14***

```html+erb
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>   
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01_01-views-layouts-application.html.erb)


> A titolo esemplificativo abbiamo visualizzato il codice in *views/layouts/application* tanto è lo stesso anche nel layout alternativo *views/layouts/entrance*.



## La traduzione fatta riga per riga

Un approccio didattico per la traduzione in italiano potrebbe essere quello di duplicare il file rinominandolo *devise.it.yml*.
Andremmo poi a cambiare *:en* con *:it* e a tradurre le varie stringhe.

***codice n/a - .../config/locales/devise.it.yml - line: 1***

```yaml
# Additional translations at https://github.com/plataformatec/devise/wiki/I18n

it:
  devise:
    confirmations:
      confirmed: "Il tuo indirizzo email è stato confermato con successo."
```

> il codice con ***n/a*** non lo usiamo nella nostra app.



## Usiamo il file già tradotto

Oppure, più semplicemente, andiamo su *https://github.com/plataformatec/devise/wiki/I18n* e prendiamo il file già tradotto in italiano.


> verifichiamo le [traduzioni dei messaggi di devise](https://github.com/plataformatec/devise/wiki/I18n)
>
> scegliamo la [lingua italiana](https://gist.github.com/iwan/91c724774594c8b484c95ff1db5d1a15)

Scarichiamo il file *devise.it.yml* dal sito web e lo uploadiamo nella cartella *config/locale* della nostra applicazione Rails.

> Oppure creiamo il nuovo file *devise.it.yml* su *config/locale* e facciamo copia/incolla della traduzione. 

***codice 02 - .../config/locales/devise.it.yml - line: 1***

```yaml
# Italian translation for Devise 4.2
# Date: 2016-08-01
# Author: epistrephein, iwan
# Note: Thanks to xpepper (https://gist.github.com/xpepper/8052632)
# Additional translations at https://github.com/plataformatec/devise/wiki/I18n

it:
  devise:
    confirmations:
      confirmed: "Il tuo account è stato correttamente confermato."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01_02-config-locale-devise.it.yml)



## Aggiungiamo alcune traduzioni mancanti

confrontando il file con quello inglese generato automaticamente da devise impostiamo le traduzioni mancanti

***codice 03 - .../config/locales/devise.it.yml - line: 31***

```yaml
      email_changed:
        subject: "Email reimpostata"
```

***codice 03 - ...continua - line: 52***

{caption: ".../config/locale/devise.it.yml -- segue", format: yaml, line-numbers: true, number-from: 52}
```yaml
      updated_but_not_signed_in: "Il tuo account è stato aggiornato correttamente, ma poiché la password è stata modificata, è necessario accedere nuovamente"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01_03-config-locale-devise.it.yml)

Adesso tutti i messaggi di devise sono tradotti in italiano.



## verifichiamo che funziona tutto

```bash
$ sudo service postgresql start
$ rails s
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add login_devise i18n"
```



## Publichiamo su heroku

```bash
$ git push heroku di:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge di
$ git branch -d di
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/05-devise-dedicated_layout-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01-devise_i18n-it.md)
