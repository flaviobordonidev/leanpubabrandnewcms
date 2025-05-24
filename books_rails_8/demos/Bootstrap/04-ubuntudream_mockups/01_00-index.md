# <a name="top"></a> Selezione delle pagine

Adesso riportiamo i mockups usando tailwind installato su Ruby on Rails e sostituendo javascript scritto direttamente nella pagina html a javascript scritto con Stimulus.

Altra cosa che possiamo fare è creare il file config di tailwind in cui importiamo i valori light e dark in modo da rendere DRY (do not repeat yourself) gli stili Tailwind css scritti nelle varie views.




In questi capitoli creeremo i mockups della nostra app. Ossia delle pagine statiche con i dati inseriti direttamente nel codice, i "segnaposto", per definire la grafica della nostra app.


## La struttura della nostra applicazione

Di seguito, in ordine alfabetico, le varie pagine della nostra applicazione `ubuntudream`.

Nome pagina   | Descrizione
| :--         | :--
homepage      | la pagina iniziale che presenta le prossime lezioni per ogni tipologia
lessons_index | l'elenco di tutte le alule (che non è la homepage).
lessons_show  | la presentazione della lezione <br/> (ho scelto una lezione e mi si presenta una pagina prima dei vari *steps*)
lessons_show_end  | pagina per il completamento dell'esercizio
lessons_stesps_show | i vari video della lezione con seguente modulo per la risposta. <br/> Per esecuzione esercizio.
login         | per mettere utente e password ed accedere all'applicazione.
sign_up       | per registrarsi come nuovo utente
users_show    | per account utente
AUTHOR        | per costruire il corso


