{id: 01-base-15-authorization-01-theory}
# Cap 15.1 -- Parte teorica sull'autorizzazione

Finalmente attiviamo la sicurezza implementando le autorizzazioni alle varie azioni.


Dal login alla gestione degli accessi alle varie funzioni si passa per 3 fasi principali:

* Autenticazione è essere in grado di verificare l'identità dell'utente. E' fare accesso/login --> per la nostra applicazione abbiamo usato "Devise"
* Ruolificazione è dare un ruolo ad ogni utente. --> per la nostra applicazione abbiamo usato "enum"
* Autorizzazione è chi può fare cosa una volta autenticato. (è dare livelli di accesso differente) --> per la nostra applicazione, come vediamo in questo capitolo, usiamo "Pundit"




## Non apriamo il branch 

Non serve perché questo capitolo è una panoramica che ha solo teoria




## Pundit

Abbiamo visto come Devise permette di autenticare un utente facendogli fare login. Inoltre Devise si sovrappone un poco a Pundit perché ha una sorta di autorizzazione a livello di view.
Possiamo infatti indicare quali sono le pagine che per essere viste hanno bisogno che un utente sia autenticato (abbia fatto login).

Quindi possiamo dire che Devise ha una sorta di autorizzazione a livello di view.
Similmente possiamo dire che Pundit ha una autorizzazione a livello di tabelle.

I> La verità è che con Devise puoi non visualizzare le pagine se la persona non ha fatto login (non è autenticata).
I> Invece con Pundit puoi autorizzare la persona che ha fatto login a fare determinate azioni in funzione del suo ruolo.

Ogni file di policy (set di regole di autorizzazione) ha un corrispettivo file model ed è quindi legato alla tabella del database.
Con pundit autorizziamo le azioni da fare sul database. Nell'esempio qui in basso abbiamo un'idea:

s : show
n : new/create
e : edit/update
d : destroy
* : autorizzato solo per un ristretto set di records. (senza asterisco è autorizzato per tutti i records)

       tabelle: | users   | posts     | companies | products | offers | invoices |
----------------------------------------------------------------------------------
admin           | s,n,e,d | s,-,e,d   |
moderator       | -,-,-,- | s*,-,-,d  |
author          | -,-,-,- | s*,n,e,d  |
contabile       | -,-,-,- | s*,-,-,-  |
tecnico         | -,-,-,- | s*,-,-,-  |
commerciale     | -,-,-,- | s*,-,-,-  |
supervisore     | s,-,-,- | s,-,-,-   |


Vediamo più in dettaglio le autorizzazioni per la tabella Posts:

Tabella Posts
  admin
    show : all records
    new  : no
    edit : all records
    destroy : any record
  moderator
    show : only published records
    new  : no
    edit : no
    destroy : only published records
  author
    show : all published and any of his own records
    new  : yes
    edit : all his own records
    destroy : any of his own record
  ...
  ...
  ...


