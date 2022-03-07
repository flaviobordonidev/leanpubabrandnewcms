# <a name="top"></a> Cap 15.1 - Parte teorica sull'autorizzazione

Finalmente attiviamo la sicurezza implementando le autorizzazioni alle varie azioni.

Dal login alla gestione degli accessi alle varie funzioni si passa per 3 fasi principali:

fase                 | descrizione                                             | verifica e assegnazione                                    | implementazione
-------------------- | ------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------------------------
***Autenticazione*** | è essere in grado di verificare l'identità dell'utente. | Lo facciamo facendo il login.                              | per la nostra applicazione usiamo la gemma *Devise*.
***Ruolificazione*** | è dare un ruolo ad ogni utente.                         | Lo da l'amministratore sulla tabella *users*.              | per la nostra applicazione usiamo *enum*.
***Autorizzazione*** | è chi può fare cosa una volta autenticato.              | Nell'app sono definiti i diversi livelli di accesso per ogni ruolo. | per la nostra applicazione usiamo la gemma *Pundit*.



## Non apriamo il branch 

Non serve aprire un branch perché questo capitolo è una panoramica che ha solo teoria.



## Pundit

Abbiamo visto che Devise permette di **autenticare** un utente facendogli fare login.

Inoltre Devise si sovrappone un poco a Pundit perché ha una sorta di **autorizzazione a livello di view**.
Possiamo infatti indicare quali sono le pagine che per essere viste hanno bisogno che un utente sia **autenticato** (abbia fatto login).

Invece con Pundit puoi **autorizzare** la persona che ha fatto login a fare determinate azioni in funzione del suo ruolo.
In Pundit abbiamo dei file di policy. Ogni file di policy (set di regole di autorizzazione) ha un corrispettivo file model ed è quindi legato alla tabella del database.

Quindi possiamo dire che:
- Devise ha un'autorizzazione a livello di view.
- Pundit ha un'autorizzazione a livello di azioni sul database.

Con pundit autorizziamo le azioni da fare sul database. 
Di seguito vediamo una panoramica delle autorizzazioni che implementeremo per la tabella *users* ed *eg_posts*.

Legenda autorizzazioni:

s       | n          | e           | d        | -
------- | ---------- | ----------- |--------- | ---------
show    | new/create | edit/update | destroy  | non autorizzato

> Con asterisco "*" vuol dire autorizzato solo per un ristretto set di records. (senza asterisco è autorizzato per tutti i records)


utenti          | users   | eg_posts    |
--------------- | ------- | ----------- |
admin           | s,n,e,d | s,-,e,d     |
moderator       | -,-,-,- | s\*,-,-,d\* |
author          | -,-,-,- | s\*,n,e\*,d\* |
user            | -,-,-,- | s\*,-,-,-   |

Vediamo più in dettaglio le autorizzazioni per la tabella *posts*.

- admin
  - show : all records
  - new  : no
  - edit : all records
  - destroy : any record
- moderator
  - show : only published records
  - new  : no
  - edit : no
  - destroy : only published records
- author
  - show : all published and any of his own posts
  - new  : yes
  - edit : all his own records
  - destroy : any of his own record
- user
  - show : all published but none unpublished
  - new  : no
  - edit : no
  - destroy : no



## Salviamo su git

Non c'è nulla di nuovo da salvare.



## Pubblichiamo su Heroku

Non c'è nulla di nuovo da pubblicare.



## Chiudiamo il branch

Non lo abbiamo proprio aperto.



## Facciamo un backup su Github

Non c'è nulla di nuovo da archiviare.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01-enum-i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/02-authorization-pundit-it.md)
