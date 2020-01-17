{id: 01-base-13-roles-01-roles-overview}
# Cap 13.1 -- Ruoli; la teoria

I ruoli da assegnare alle persone che si autenticano con Devise (ossia che fanno login). A seconda del ruolo si avranno delle autorizzazioni ad operare (Pundit).

Dal login alla gestione degli accessi alle varie funzioni si passa per 3 fasi principali:

* Autenticazione è essere in grado di verificare l'identità dell'utente. E' fare accesso/login --> per la nostra applicazione abbiamo usato "Devise"
* Ruolificazione è dare un ruolo ad ogni utente. --> per la nostra applicazione, come vediamo in questo capitolo, usiamo "enum"
* Autorizzazione è chi può fare cosa una volta autenticato. (è dare livelli di accesso differente) --> per la nostra applicazione useremo "Pundit"




## Non apriamo il branch 

Non serve perché questo capitolo è una panoramica che ha solo teoria




## Le 3 forme principali di assegnari i ruoli

Esistono tre forme principali di assegnare i ruoli:

* admin - livello base di autorizzazione
* enum - copre quasi la totalità delle esigenze di autorizzazione
* rolify - massima flessibilità con una gemma ed una tabella roles con relazione molti-a-molti. La maggior parte delle applicazioni non ha un livello di sofisticazione per cui è richiesto rolify.




## Admin

E' un semplice campo binario che permette di dividere solo tra amministratore e tutti gli "altri".




## Enum

E' un campo con un elenco di scelte e ci permette di gestire praticamente tutte le autorizzazioni che vogliamo.




## Rolify

E' una gemma che permette di fare complesse gestioni dei ruoli ma le applicazioni dove sia realmente necessario sono rare perché spesso se si analizza con calma la gestione dei ruoli che vogliamo implementare si riesce quasi sempre a ricondurle ad una gestion con "Enum".

Questo è l'approccio più flessibile nella gestione dei ruoli. E' come una relazione molti-a-molti con polimorfismo.
Possiamo essere estremamente flessibili, ma nella maggior parte dei casi non ci serve questo livello di flessibilità.




## enum vs rolify

*** DA RIVEDERE ***

* Se vogliamo gestire un Blog e fare in modo che un autore possa modificare solo i suoi records
  è sufficiente Pundit con una relazione uno a molti user->posts
  altrimenti usiamo Rolify assegnando il ruolo di autore in fase di creazione di articolo (current_user.add_role :author, @post)

* Se, come autori, vogliamo condividere (sharing) un nostro post con altri utenti.
  per avere solo Pundit dobbiamo creare una relazione molti-a-molti con tabella user_post_maps
  altrimenti usiamo Rolify assegnando il ruolo di autore ad un collega con un link reinstradato ad un metodo personalizzato nel controller.

* Se vogliamo gestire che un utente veda solo le transazioni dell'azienda a cui appartiene 
  con solo Pundit dobbiamo creare più relazioni.
  Aggiungendo Rolify usiamo le sue relazioni.

* Se vogliamo assegnare più autorizzazioni ad un utente es: pass_area1, pass_area2, pass_area3
  con solo Pundit dobbiamo creare più campi enum o gestire su un unico campo tutte le combinazioni : 1, 2, 3, 1e2, 1e3, 2e3, 1e2e3.
  aggiungendo Rolify questa gestione è più semplice

