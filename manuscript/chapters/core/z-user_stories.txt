# User Stories

vedi applicativo:

- http://www.pivotaltracker.com/help/gettingstarted

Vedi i primi due video di Pivotaltracker: "Getting Started" e "Writing Stories" perché spiegano un concetto molto importante dello sviluppo in team. Definire delle STORIE.
Pivotaltracker è praticamente una "kanban board" rivisitata in maniera intelligente.
Stiamo parlando di metodologia "Agile"
Tutto questo solo per dirti che su GITHUB nel nostro sviluppo chiameremo i nomi dei Branch con i nomi delle STORIE.
ft-nome_storia-001, bg-nome_storia-007, ....
le prime due lettere del nome del branch di Git/Github sono:
ft = feature (è una storia di tipo "core" ossia strategica e importante)
bg = bug
ch = chore (non è "core". E' una funzionalità minore)
Ogni volta che finiamo la parte di progetto sul branch si fa un merge su master e si assegna il tag usando il semantic-versioning.
http://semver.org/spec/v2.0.0.html

[...]
Types of Stories
There are four types of stories in Tracker: Features, Chores, Bugs, and Releases.

Feature Features are stories that provide verifiable business value to the team's customer (e.g., "Add a Special Instructions field to the checkout page," "Purchase history should load in half a second," and "Add a new method addToInventory to the public API"). Features are worth points and therefore must be estimated.

Chore Chores are stories that are necessary but provide no direct, obvious value to the customer (e.g., "Update SSL Certs"). They shouldn't need extra validation, so the states for chores are just Unstarted, Started and Accepted.(A chore is a story with no direct business value, but simply needs to be done, e.g. a “tech task”)

Bug Bugs represent unintended behavior that can be related to features (e.g., "Login box is wrong color" or "Price should be non-negative").

Release Releases are milestone markers that allow your team to track progress towards concrete goals (e.g., stakeholder or investor demos, software launches, etc.). It's possible to specify target dates for releases (more on those below). All stories for a milestone or release should go above the marker for it.

To help with the big picture, Epics can be used to describe, discuss, and visualize the progress of large features or themes that are larger than individual stories (more on epics below).
[...]

Descrivono l'applicazione e mettono le basi per scrivere i test o sviluppare in TDD (Test Driven Development)
Seguono una versione più completa del modello Situazione -> Problema -> Soluzione.

A> Caratteristica: <titolo>
A> 
A>   Scenario: 
A> 
A>     <contesto (Dato...) / evento (Qaundo...) / azione>
A> 
A> 
A>     Come ... <ruolo>                               
A> 
A>     Voglio ... <obbiettivo / risultato (Allora...) / esito >
A> 
A>     Così che ... <beneficio / scopo / perché / al fine di> 




## Esempio sulle manutenzioni

A> Caratteristica: Controllo delle manutenzioni
A> 
A>   Scenario: 
A> 
A>     un cliente chiama per un guasto
A> 
A> 
A>     Come tecnico
A> 
A>     Voglio sapere se è coperto da manutenzione/garanzia e con che SLAs
A> 
A>     Così che posso dare supporto ed eventualmente intervenire. Andando sull’azienda/cliente finale posso vedere tutte le soluzioni fornite comprese manutenzioni/garanzie e data di scadenza.
A> 
A>   Scenario: 
A> 
A>     voglio sollecitare i clienti con manutenzione in scadenza
A> 
A> 
A>     Come commerciale
A> 
A>     Voglio chiamare le persone che si occupano del rinnovo della manutenzione
A> 
A>     Così che possiamo fare un offerta/vendita



## Esempio sulla Mailing List

A> Caratteristica: Controllo delle manutenzioni
A> 
A>   Scenario: 
A> 
A>     Registrarsi su una Mailing List
A> 
A> 
A>     Come visitatore del sito web
A> 
A>     Voglio registrarmi nella mailing list
A> 
A>     Così che possa ricevere novità e annunci
A> 
A>   Scenario: 
A> 
A>     Unsubscribe
A> 
A> 
A>     Come utente registrato
A> 
A>     Voglio uscire dalla mailing list
A> 
A>     Così che smetta di ricevere emails



## Esempio sulla ATM

A> Caratteristica: Controllo delle manutenzioni
A> 
A>   Scenario: 
A> 
A>     Prelievo contanti
A> 
A> 
A>     Come intestatario del conto
A> 
A>     Voglio prelevare contanti dall'ATM
A> 
A>     Così che possa comprarmi una birra
A> 
A>   Scenario: 
A> 
A>     Prelevare troppo da un conto
A> 
A> 
A>     Come intestatario del conto saldo di 50€
A> 
A>     Voglio essere in grado di agitare la bacchetta magica
A> 
A>     Così che possa prelevare 100€

