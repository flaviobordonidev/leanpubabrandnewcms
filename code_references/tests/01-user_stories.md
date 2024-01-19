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

Feature: <titolo>

	Scenario:<context/event/action>					| cucumber "Given" and "When"
		As a <role> 															
		I want <goal/result/outcome/>					| cucumber "Then"
		so that <benefit/purpose/why/in order to> 


---
Cucumber
	Scenario: <name>
		Given <context>
		When  <event/action>
		Then	<outcome>
Tip:
To get a good "scenario name" 
	don't focus on the outcome (the Then part) 
	but on summarizing the context (Given) and event (When).

--
Feature: 			<feature name>
	In order to 	<meet some goal> 
	As a 			<type of stakeholder>
	I want 			<a feature>

Scenario: 	<scenario name>
	Given 	<the context>
	When	<the event>
	Then	<the outcome>

---
Feature: Withdraw Cash
	In order to buy beer
	As an account holder
	I want to withdraw cash from the ATM

Scenario: Withdraw too much from an account in credit 
	Given I have $50 in my account
	When I wave my magic wand
	And I withdraw $100
	Then I should receive $100

---
Tip:
To get a good "scenario name" 
	don't focus on the outcome (the Then part) 
	but on summarizing the context (Given) and event (When).

---

Feature: *Contact Page*
	in order to (outcome)	: send a message to the owner of the website
	As a (role) 			: visitor to the website
	I want (...)			: I want to fill out a form with my name, email address, and some text

--

> Caratteristica (Feature): <titolo>
> 
>   Scenario: 
> 
>     <contesto (Dato...) / evento (Qaundo...) / azione>
> 
> 
>     Come ... <ruolo>                               
> 
>     Voglio ... <obbiettivo / risultato (Allora...) / esito >
> 
>     Così che ... <beneficio / scopo / perché / al fine di> 




## Esempio sulle manutenzioni

Feature: Controllo delle manutenzioni

	Scenario:un cliente chiama per un guasto
		As a tecnico
		I want to know if its covered from maintenance/guarantee and with what SLAs
		so that i can do the support and eventually the intervent.

	Scenario: voglio sollecitare i clienti con manutenzione in scadenza
		As a commerciale
		I want to call the person that deal with the maintenance renewance
		So that we can make an offer/sales


> Caratteristica: Controllo delle manutenzioni
> 
>   Scenario: 
> 
>     un cliente chiama per un guasto
> 
> 
>     Come tecnico
> 
>     Voglio sapere se è coperto da manutenzione/garanzia e con che SLAs
> 
>     Così che posso dare supporto ed eventualmente intervenire. Andando sull’azienda/cliente finale posso vedere tutte le soluzioni fornite comprese manutenzioni/garanzie e data di scadenza.
> 
>   Scenario: 
> 
>     voglio sollecitare i clienti con manutenzione in scadenza
> 
> 
>     Come commerciale
> 
>     Voglio chiamare le persone che si occupano del rinnovo della manutenzione
> 
>     Così che possiamo fare un offerta/vendita


## Esempio sulla Mailing List

Feature: Mailing List

	Scenario:Join Mailing List
		As a visitor to the website
		I want to join a mailing list
		so that I can receive news and announcements

	Scenario:	Unsubscribe
		As a subscriber
		I whant to unsubscribe from the mailing list
		so that I stop receiving emails


> Caratteristica: Controllo delle manutenzioni
> 
>   Scenario: 
> 
>     Registrarsi su una Mailing List
> 
> 
>     Come visitatore del sito web
> 
>     Voglio registrarmi nella mailing list
> 
>     Così che possa ricevere novità e annunci
> 
>   Scenario: 
> 
>     Unsubscribe
> 
> 
>     Come utente registrato
> 
>     Voglio uscire dalla mailing list
> 
>     Così che smetta di ricevere emails


## Esempio sulla ATM

Feature: ATM

	Scenario:Withdraw Cash
		As an account holder
		I want to withdraw cash from the ATM
		so that I can buy a beer

	Scenario: Withdraw too much from an account in credit 
		As an account holder with $50 in my account
		I want to be able to wave my magic wand
		so that I can withdraw $100

> Caratteristica: Controllo delle manutenzioni
> 
>   Scenario: 
> 
>     Prelievo contanti
> 
> 
>     Come intestatario del conto
> 
>     Voglio prelevare contanti dall'ATM
> 
>     Così che possa comprarmi una birra
> 
>   Scenario: 
> 
>     Prelevare troppo da un conto
> 
> 
>     Come intestatario del conto saldo di 50€
> 
>     Voglio essere in grado di agitare la bacchetta magica
> 
>     Così che possa prelevare 100€

