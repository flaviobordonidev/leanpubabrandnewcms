ciao,  ecco a modo di esempio i casi d'uso che abbiamo scritto per il tavolo touch. per una descrizione delle CRC Card ecco il link di wikipedia: http://en.wikipedia.org/wiki/Class-responsibility-collaboration_card  ciao, Gianluca Paroniti

Analisi del software Tag-Team per T3 (T2)


Introduzione
In questo documento viene eseguita l’analisi funzionale del software Tag-Team per T3 (T2). T2 è il software deputato alla gestione delle interazioni tra utenti e tavolo touch ovvero all’interazione degli utenti che utilizzano il tavolo touch come medium per riunioni collaborative. Il metodo utilizzato per questa analisi funzionale è quello dei casi d’uso, per caso d’uso si intende l’analisi delle necessità degli utenti che interagiscono con il tavolo.
Nello specifico si utilizzerà il seguente formato nella descrizione dei casi d’uso:



(#xx) NOME DEL CASO D’USO

	•	Attore principale: una descrizione dell’attore che esegue le operazioni descritte dal caso d’uso in questione
	•	Precondizioni: le condizioni che si devono verificare affinché il caso d’uso possa verificarsi
	•	Lo scenario principale di successo: una descrizione granulare possibilmente a passi del modo in cui l’applicazione gestisce il caso d’uso in questione
	•	Scenari alternativi: se lo scenario principale non si verifica quello che succede
	•	Requisiti speciali: una lista di requisiti che non sono parte dello scenario principale o di quello alternativo
	•	Questioni aperte: una lista di possibili problematiche a cui si deve far fronte per il funzionamento del caso d’uso




Casi d’uso
Elenco dei possibili casi d’uso:
#00 stato del T2 senza nessun utente;
#01 log primo utente (moderatore);
#02 log utente;
#03 privilegi di moderazione;
	#03.1 condivisione dei privilegi di moderazione;
	#03.1 cessione dei privilegi di moderazione;
	#03.1 richiesta dei privilegi di moderazione;
#04 interazione utente - navigatore;
#05 apertura moduli utente;
#05.1 interazione utente modulo rubrica;
#05.2 interazione utente modulo agenda;
#05.3 interazione utente modulo ToDo;
#05.4 interazione utente modulo visualizza file
#05.5 interazione utente modulo blocknotes
#06 interazione utente - area di lavoro;
#07 interazione utente - finestre in area di lavoro;
#08 interazione utente moderatore - navigatore;
#09 visualizzazione a tutto schermo;
#10 stand-by utente;
#11 logout utente;
#12 logout utente moderatore.



(#00) TAVOLO IN STANDBY

	•	Attore principale: Nessun utente.
	•	Precondizioni: il tavolo è acceso e il software T2 è avviato. 
	•	Lo scenario principale di successo: Sul tavolo è presente un lock screen stile quello Android 4.2.
	•	Scenari alternativi: al posto del lock screen compare una schermata “ooops!” e il codice di bug.
	•	Requisiti speciali: I plug-in di Adobe devono essere installati il software Air per l’installazione di T2 deve avere pre-compilato l’applicazione.
	•	Questioni aperte: nessuna rilevata.



(#01) LOG PRIMO UTENTE (MODERATORE)

	•	Attore principale: utente che accede per primo al tavolo.
	•	Precondizioni: il tavolo è acceso e in modalità standby, l’utente ha attivato l’app T1 sul suo mobile.
	•	Lo scenario principale di successo: 
	•	l’utente tocca un qualsiasi punto sul tavolo;
	•	l’icona di lock screen si avvicina al punto toccato;
	•	l’utente effettua la gesture di unlock;
	•	Compare al posto dell’icona di lock screen un cerchio con scritto: “poggia qui il tuo dispositivo mobile”;
	•	l’utente appoggia il cellulare all’interno del cerchio;
	•	il cerchio si attiva e diventa il navigatore;
	•	compare l’area di lavoro rettangolare.
	•	Scenari alternativi: 
	•	l’utente appoggia subito il cellulare sul tavolo:
	•	il lockscreen si avvicina comunque all’utente.
	•	lo sblocco avviene come nello scenario di successo;
	•	nel cerchio compare la scritta: “poggia qui il tuo cellulare”;
	•	l’utente lo sposta nel cerchio.
	•	l’utente non ha attivato l’app T1:
	•	sotto al cerchio compare la scritta: “attiva T1 sul tuo dispositivo mobile e riappoggialo nel cerchio”.
	•	l’utente alza il cellulare e dopo aver attivato t1 lo ripoggia nel cerchio.
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: gestione del multitouch casuale di una persona seduta al tavolo.



(#02) LOG UTENTE

	•	Attore principale: un altro utente accede al tavolo.
	•	Precondizioni: il tavolo è acceso e in modalità standby, l’utente ha attivato l’app T1 sul suo mobile ed è stata già attivata una sessione da un altro utente.
	•	Lo scenario principale di successo: 
	•	l’utente tocca un qualsiasi punto sul tavolo;
	•	l’icona di lock screen si avvicina al punto toccato;
	•	l’utente effettua la gesture di unlock; 
	•	Compare al posto dell’icona di lock screen un cerchio con scritto: “poggia qui il tuo dispositivo mobile”;
	•	l’utente appoggia il cellulare all’interno del cerchio;
	•	il cerchio si attiva e diventa il navigatore;
	•	compare l’area di lavoro rettangolare.
	•	Scenari alternativi: 
	•	l’utente appoggia subito il cellulare sul tavolo:
	•	il lockscreen si avvicina comunque al punto toccato.
	•	lo sblocco avviene come nello scenario di successo;
	•	nel cerchio compare la scritta: “poggia qui il tuo cellulare”;
	•	l’utente lo sposta nel cerchio alzandolo.
	•	l’utente non ha attivato l’app T1:
	•	sotto al cerchio compare la scritta: “attiva T1 sul tuo dispositivo mobile e riappoggialo nel cerchio”.
	•	l’utente alza il cellulare e dopo aver attivato T1 lo ripoggia nel cerchio.
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: gestione del multitouch casuale di una persona seduta al tavolo.



(#03) PRIVILEGI DI MODERAZIONE

	•	Attori principali: l’utente moderatore che vuole condividere con un altro utente i privilegi di moderazione e l’utente che riceve o richiede i privilegi di moderazione.

(#03.1) CONDIVISIONE DEI PRIVILEGI DI MODERAZIONE
	•	Attore principale: l’utente moderatore che vuole condividere con un altro utente i privilegi di moderazione.
	•	Precondizioni: il tavolo è acceso e c’è già almeno un utente loggato e con l’area di lavoro attiva, gli utenti loggati devono essere almeno 2.
	•	Lo scenario principale di successo: 
	•	l’utente clicca l’icona della voce di menu di amministrazione;
	•	compare nell’area di lavoro un cerchio con il menu di amministrazione;
	•	l’utente sceglie la voce “Condividi Privilegi”;
	•	l’utente seleziona l’altro utente a cui vuole passare i privilegi di moderazione.
	•	Scenari alternativi: 
	•	l’utente clicca l’icona della voce di menu di amministrazione;
	•	compare nell’area di lavoro un cerchio con un menu operativo;
	•	l’utente sceglie la voce “Moderazione” > “Condividi Privilegi”;
	•	tutti gli utenti presenti al tavolo sono già loggati come moderatori;
	•	compare un cerchio di alert con scritto: “Tutti gli utenti sono moderatori. OK”
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: gestione del multitouch casuale di una persona seduta al tavolo, separazione ad aree di lavoro dei controlli multitouch.

(#03.2) CESSIONE DEI PRIVILEGI DI MODERAZIONE
	•	Attore principale: l’utente moderatore che vuole cedere ad un altro utente i privilegi di moderazione.
	•	Precondizioni: il tavolo è acceso e c’è già almeno un utente loggato e con l’area di lavoro attiva, gli utenti loggati devono essere almeno 2.
	•	Lo scenario principale di successo: 
	•	l’utente clicca l’icona della voce di menu di amministrazione;
	•	compare nell’area di lavoro un cerchio con il menu amministrazione;
	•	l’utente sceglie la voce “Moderazione” > “Cedi Privilegi”;
	•	l’utente seleziona l’altro utente a cui vuole cedere i privilegi di moderazione.
	•	Scenari alternativi: 
	•	l’utente clicca l’icona della voce di menu di amministrazione;
	•	compare nell’area di lavoro un cerchio con un menu operativo;
	•	l’utente sceglie la voce “Moderazione” > “Cedi Privilegi”;
	•	tutti gli utenti presenti al tavolo sono già loggati come moderatori;
	•	compare un cerchio di alert con scritto: “Tutti gli utenti sono moderatori. OK”
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: gestione del multitouch casuale di una persona seduta al tavolo, separazione ad aree di lavoro dei controlli multitouch.

(#03.3) RICHIESTA DEI PRIVILEGI DI MODERAZIONE
	•	Attore principale: l’utente che vuole avere da un altro utente i privilegi di moderazione.
	•	Precondizioni: il tavolo è acceso e c’è già almeno un utente loggato e con l’area di lavoro attiva, gli utenti loggati devono essere almeno 2.
	•	Lo scenario principale di successo: 
	•	l’utente clicca l’icona della voce di menu di amministrazione;
	•	compare nell’area di lavoro un cerchio con il menu amministrazione;
	•	l’utente sceglie la voce “Moderazione” > “Richiedi Privilegi”;
	•	l’utente seleziona l’altro utente a cui vuole chiedere i privilegi di moderazione.
	•	Scenari alternativi: 
	•	
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: gestione del multitouch casuale di una persona seduta al tavolo, separazione ad aree di lavoro dei controlli multitouch.



(#04) INTERAZIONE UTENTE - NAVIGATORE

	•	Attore principale: utente che interagisce sul tavolo.
	•	Precondizioni: il tavolo è acceso e in una delle due modalità, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1, il cellulare si trova nel cerchio di navigazione.
	•	Lo scenario principale di successo: 
	•	il navigatore è il cerchio principale in cui è poggiato il dispositivo mobile dell’utente, intorno al cerchio ci sono dei cerchi più piccoli che attivano, quando toccati, il modulo relativo;
	•	l’utente sposta il cellulare appoggiato nel cerchio;
	•	il navigatore si sposta nell’area di lavoro rimanendo sempre in primo piano;
	•	quando il navigatore raggiunge il confine dell’area di lavoro inizia a spostare l’area;
	•	l’area di lavoro rimane sempre attaccata con il suo lato maggiore al bordo del tavolo;
	•	Lo spostamento si arresta al contatto con un altra area di lavoro.
	•	Scenari alternativi: 
	•	l’utente stacca dal tavolo il cellulare:
	•	il navigatore diventa neutro e compare un messaggio: “vuoi abbandonare la riunione? SI, NO”;
	•	SI, l’area di lavoro si chiude
	•	NO, l’area di lavoro va in pausa.
	•	l’utente fa scorrere il cell. al di là della sua area di lavoro:
	•	il navigatore diventa neutro e compare un messaggio: “vuoi abbandonare la riunione? SI, NO”;
	•	SI, l’area di lavoro si chiude
	•	NO, l’area di lavoro va in pausa.
	•	Requisiti speciali: 
	•	Questioni aperte: gestione del multitouch in aree specifiche del tavolo.



(#05) APERTURA MODULI UTENTE

	•	Attore principale: utente che interagisce con il navigatore.
	•	Precondizioni: il tavolo è acceso e in modalità team o free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	l’utente clicca una voce di menu e trascina fuori il modulo che vuole attivare;
	•	nell’area di lavoro rettangolare viene presentata l’opportuna schermata applicativa centrata rispetto al punto dove il dito dell’utente si è staccato dall’area di lavoro.
	•	Scenari alternativi: 
	•	il cellullare non è pienamente sincronizzato con l’applicazione richiesta:
	•	Compare un cerchio di alert con scritto: “Attendere la sincronizzazione dei dati...”
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: gestione del multitouch casuale di una persona seduta al tavolo, separazione del multitouch sulle aree di lavoro.

(#05.1) INTERAZIONE UTENTE MODULO RUBRICA *
	•	Lo scenario principale di successo: 
	•	l’utente trascina la voce di menu rubrica;
	•	nell’area di lavoro rettangolare viene presentato l’elenco dei contatti in rubrica.

(#05.2) INTERAZIONE UTENTE MODULO AGENDA *
	•	Lo scenario principale di successo: 
	•	l’utente trascina la voce di menu agenda;
	•	nell’area di lavoro rettangolare viene presentato il calendario impostato al giorno corrente.

(#05.3) INTERAZIONE UTENTE MODULO TODO *
	•	Lo scenario principale di successo: 
	•	l’utente trascina la voce di menu ToDo;
	•	nell’area di lavoro rettangolare viene presentata la lista delle cose da fare ordiante per data di inserimento.

(#05.4) INTERAZIONE UTENTE MODULO VISUALIZZA FILE *
	•	Lo scenario principale di successo: 
	•	l’utente trascina la voce di menu visualizza file;
	•	nell’area di lavoro rettangolare viene presentato l’elenco dei file e directory sincronizzati con il cellulare.

(#05.5) INTERAZIONE UTENTE MODULO BLOCKNOTES *
	•	Lo scenario principale di successo: 
	•	l’utente trascina la voce di menu blocknotes;
	•	nell’area di lavoro rettangolare viene presentato l’elenco delle note sincronizzate con il cellulare.

(#05.6) INTERAZIONE UTENTE MODULO INVIA AD ALTRO UTENTE *
	•	Lo scenario principale di successo: 
	•	l’utente sposta un elemento degli altri moduli in questo cerchio di menu;
	•	Da questa si aprono altri cerchi nella direzione degli altri partecipanti e l’utente vi deposita il file o l’informazione che vuole far ricevere, 
	•	è presente anche un cerchio più grande per spedire il file a tutti.

* Nota: I casi d’uso associati ai moduli saranno trattati nelle apposite specifiche.



(#06) INTERAZIONE UTENTE - AREA DI LAVORO

	•	Attore principale: utente che interagisce con l’area di lavoro.
	•	Precondizioni: il tavolo è acceso e in modalità team o free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo:
	•	nella modalità free la dimensione iniziale dell’area di lavoro è di 1/8 la dimensione del tavolo, nella modalità team è di 1/numero partecipanti alla riunione.
	•	l’utente può allargare o restringere la sua area di lavoro tenendo due dita ferme e allontanando due dita dell’altra mano, in una sorta di pinch to zoom a 4 dita.
	•	Scenari alternativi: 
	•	l’utente sbaglia gesture: non c’è nessuna segnalazione. È comunque presente nell’area di lavoro (in basso a destra) un punto interrogativo con una panoramica delle gesture utilizzabili con il T2.
	•	Requisiti speciali: È possibile confinare le gesture in una porzione del pannello touch.
	•	Questioni aperte: Partizione delle gesture in un area di lavoro. 



(#07) INTERAZIONE UTENTE - FINESTRE IN AREA DI LAVORO

	•	Attore principale: utente che interagisce con le varie finestre aperte nell’area di lavoro.
	•	Precondizioni: il tavolo è acceso e in modalità team o free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	L’utente può chiudere le finestre dei vari moduli chiudendo le cinque dita
	•	L’utente le può zoomare con un classico pinch-to-zoom.
	•	le sposta tramite un panning sulla porzione in alto della finestra.
	•	Ne scorre i contenuti facendo scorrere le due dita.
	•	le finestre non possono uscire dall’area di lavoro, semplicemente non son più pannabili quando toccano il bordo.
	•	Scenari alternativi: 
	•	l’utente sbaglia gesture: non c’è nessuna segnalazione. È comunque presente nell’area di lavoro (in basso a destra) un punto interrogativo con una panoramica delle gesture utilizzabili con il T2.
	•	Requisiti speciali: I driver di PQLabs e di GestureWorks correttamente installati.
	•	Questioni aperte: Il solito problema della divisione in aree delle gesture e dei touch



(#08) INTERAZIONE UTENTE MODERATORE - NAVIGATORE

	•	Attore principale: l’utente moderatore interagisce con il navigatore nell’area di lavoro.
	•	Precondizioni: il tavolo è acceso e in modalità team, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	Il moderatore della riunione ha un menù speciale di configurazione della riunione in cui può decidere:
	•	quale utente sta parlando in quel momento e se accettare la visualizzazione a tutto schermo da parte di quell’utente
	•	può chiudere la riunione cliccando sull’apposito pulsante di uscita. La finestra di alert chiederà: “Vuoi veramente chiudere la riunione?”
	•	può configurare i livelli della visualizzazione a tutto schermo e decidere quale è attivo in quel momento.
	•	Scenari alternativi: 
	•	Il moderatore vuole uscire dalla riunione nel momento di sincronizzazione finale degli altri utenti compare un messaggio: “T2 in sincronizzazione... Attendere per la chiusura della riunione”
	•	Requisiti speciali: 
	•	Questioni aperte: 



(#09) VISUALIZZAZIONE A TUTTO SCHERMO

	•	Attore principale: uno degli utenti che interagiscono con il tavolo chiedono di poter visualizzare un contenuto a tutto schermo.
	•	Precondizioni: il tavolo è acceso e in modalità free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	l’utente trascina la finestra del modulo sull’apposita finestra di visualizzazione;
	•	sul navigatore degli utenti moderatori compare il messaggio: “L’utente X vuole inviare Y a tutto schermo: ATTENDI, OK”
	•	se tutti gli altri utenti hanno dato l’ok l’area di lavoro dell’utente si apre a tutto schermo e la finestra di collaborazione o il file da visualizzare a tutto schermo nella modalità collaborativa apposita.
	•	A tutti gli utenti permane in alpha il navigatore, ma non è utilizzabile.
	•	all’utente che ha proposto la modalità di visualizzazione a tutto schermo è attivo sul navigatore il tasto di chiusura di tale modalità.
	•	Nello scenario team è l’unico che può chiudere la modalità a tutto schermo è il moderatore. Ed è l’unico utente cui rimane in alpha il navigatore con il tasto di chiusura della visualizzazione a schermo pieno
	•	Scenari alternativi: 
	•	Alcuni utenti cliccano su “ATTENDI”
	•	la finestra di alert si minifica in basso con il solo messaggio e l’OK in attesa che l’utente finisca quello che sta facendo;
	•	Per l’utente che vuole visualizzare un suo file a tutto schermo si attiva un alert di attesa.
	•	Requisiti speciali: 
	•	Questioni aperte: 



(#10) STAND-BY UTENTE

	•	Attore principale: l’utente che toglie il cellulare dal tavolo ha la possibilità di impostare la sua area di lavoro in modalità stand-by.
	•	Precondizioni: il tavolo è acceso e in modalità free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	I’utente togliere il cellulare dal tavolo;
	•	Compare un cerchio di alert con scritto: “Vuoi effetturare il logout? SI , NO in pausa, Annulla”.
	•	Scenari alternativi: 
	•	
	•	Requisiti speciali: 
	•	Questioni aperte: 



(#11) LOGOUT UTENTE

	•	Attore principale: l’utente che toglie il cellulare dal tavolo ha la possibilità di effettuare il logout.
	•	Precondizioni: il tavolo è acceso e in modalità free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	I’utente togliere il cellulare dal tavolo;
	•	ha cliccato l’apposito pulsante di logout;
	•	Compare un cerchio di alert con scritto: “Vuoi terminare la riunione? SI , NO in pausa, Annulla”.
	•	Scenari alternativi: 
	•	
	•	Requisiti speciali: 
	•	Questioni aperte: 



(#12) LOGOUT UTENTE MODERATORE

	•	Attore principale: l’utente moderatore ha la possibilità di riportare il tavolo nella modalità di stand-by.
	•	Precondizioni: il tavolo è acceso e in modalità team o free, l’utente ha attivato l’app T1 sul suo mobile, l’utente è loggato al tavolo, il suo cellulare è sincronizzato con il tavolo e T2 ha associato correttamente i file con T1.
	•	Lo scenario principale di successo: 
	•	Il moderatore è l’ultimo a togliere il cellulare dal tavolo oppure ci sono altri moderatori loggati.
	•	Il moderatore ha cliccato l’apposito pulsante di chiudi la riunione nel menù di moderazione sul navigatore;
	•	Compare un cerchio di alert con scritto: “Vuoi terminare la riunione? SI , NO in pausa, Annulla”.
	•	Scenari alternativi: 
	•	Il moderatore non è l’ultimo a togliere il cellulare dal tavolo e non ci sono altri moderatori.
	•	Il moderatore ha cliccato l’apposito pulsante di chiudi la riunione nel menù di moderazione sul navigatore;
	•	Compare un cerchio di alert con scritto: “Vuoi terminare la riunione? SI , NO in pausa, Annulla”.
	•	Se “SI”, compare una finestra nella quale selezionare il nuovo moderatore.
	•	Requisiti speciali: il cellulare deve disporre di accelerometro, la wifi del cellulare deve essere attiva e la app sincronizzata con il tavolo.
	•	Questioni aperte: 
