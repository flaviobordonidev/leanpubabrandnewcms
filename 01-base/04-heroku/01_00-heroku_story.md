# <a name="top"></a> Cap 4.1 - La storia di Heroku

In questo capitolo descriviamo cosa è Heroku, la sua storia ed il perché lo abbiamo scelto.



## Che cosa è Heroku

Heroku è una storica piattaforma per la produzione con il vantaggio di presentarsi come un repository remoto (tipo GitHub) che semplifica enormemente la pubblicazione in produzione della nostra app.

Heroku è stata una delle prime piattaforme a comparire sul web a permettere ai propri utenti di sviluppare, distribuire e gestire app direttamente online. Nonostante inizialmente fornisse supporto solo per progetti compatibili con l'interfaccia di programmazione web Rack, con il tempo Heroku ha ampliato la propria offerta aggiungendo centinaia di servizi e il supporto per sei linguaggi di programmazione (Java, Ruby, Node.js, Scala, Clojure, Python e PHP).

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/01_fig01-heroku-homepage.png)

Grazie all'integrazione con Git, ad esempio, gli utenti potranno sviluppare la loro app su una piattaforma esterna per poi importare il progetto all'interno del proprio account Heroku, lasciando che la piattaforma PaaS faccia il resto del “lavoro sporco” per renderla operativa e funzionante.

Nel 2011 si unisce al team Yukihiro Matsumoto, chief designer di Ruby; in quello stesso anno la piattaforma si arricchirà del supporto ai linguaggi Node.js e Clojure. Nel settembre 2011 nasce, dalla collaborazione tra Heroku e Facebook, Heroku for Facebook, piattaforma di servizi ottimizzata per ospitare app sviluppate per il social network di Mark Zuckerberg.



## Heroku piattaforma cloud PaaS

Heroku è una piattaforma cloud di programmazione progettata per aiutare a realizzare e distribuire applicazioni online. 
Nata nel 2007, è oggi una delle più grandi piattaforme PaaS esistenti, con centinaia di migliaia di clienti sparsi in tutto il mondo. 
Supporta sei linguaggi di programmazione (grazie ai quali sviluppare le app da distribuire sul web) ed è basata sul sistema operativo Debian o, più recentemente, su Ubuntu (due distribuzioni Linux).



## Che cosa è una piattaforma cloud PaaS

Anche se la gran parte degli internauti crede che il cloud si risolva esclusivamente nel cloud storage, la realtà è ben altra. 
Il cloud computing si compone di tante branche (e il cloud storage è una di questa), raggruppate in tre macro-gruppi: Infrastructure as a Service (IaaS), Platform as a Service (PaaS) e Software as a Service (SaaS).




## La storia di Heroku

Nata da un'idea di James Lindenbaum, Adam Wiggins e Orion Henry, Heroku fa la sua comparsa sul web nella seconda parte del 2007, mettendo a disposizione degli utenti una piattaforma sulla quale far girare applicazioni compatibili con Rack.
La crescita della piattaforma è molto veloce e porta con sé molte novità: nell'ottobre 2009 al gruppo dei fondatori si aggiunge Byron Sebastian, che va a ricoprire il ruolo di CEO; l'anno successivo la piattaforma è acquistata da Salesforce.com e implementata come sussidiaria dell'azienda.



## A cosa serve e come funziona Heroku
Lo scopo della piattaforma è quello di fornire agli utenti le risorse informatiche (sia hardware sia software) necessarie a distribuire e far “girare” app web-based su svariate piattaforme (ad esempio la già citata Facebook). In questo modo gli sviluppatori non dovranno preoccuparsi di avere un'adeguata infrastruttura informatica a supporto della loro creatura, ma potranno affittarla da Heroku. Non solo: la piattaforma ideata da James Lindenbaum, Adam Wiggins e Orion Henry si occupa anche del “lavoro sporco”, compilando ed eseguendo automaticamente l'app non appena il codice sorgente sarà caricato nell'ambiente operativo. I programmatori potranno così concentrarsi sullo sviluppo di un codice il più possibile “pulito” e privo di bug, demandando alla piattaforma PaaS il resto dei compiti.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/01_fig02-heroku_metrics.png)

Alla base dei servizi di Heroku troviamo i dyno, container di funzioni capace di eseguire un solo comando che può essere
un processo web, un processo worker (batch) o un altro tipo di processo la cui sintassi è consentita nel file Procfile.
A seconda delle esigenze e della potenza di calcolo richiesta, lo sviluppatore può decidere di affittare uno o più dyno,
così da assicurare ai propri utenti la miglior esperienza possibile. Affinché ciò sia possibile, Heroku offre una
piattaforma completamente scalabile e automatizzata: sarà il sistema centrale a gestire l'allocazione delle risorse per
ogni dyno e per ogni servizio offerto tramite l'app, sgravando il programmatore di compiti di questo genere.



## Heroku come repository remoto

Heroku è quindi l'ambiente di produzione in cui viene pubblicata la nostra applicazione rails. 
Per caricarsi, l'applicazione, come descritto in precedenza, sfrutta git.
Heroku è infatti un repository remoto di git.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_00-mockups.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/02_00-inizializiamo_heroku.md)
