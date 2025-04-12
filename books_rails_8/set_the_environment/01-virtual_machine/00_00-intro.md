# <a name="top"></a> Cap 1.1 - L'ambiente di sviluppo per Ruby on Rails

L'ambiente di sviluppo che mi piace di più usa una Virtual Machine (VM) perché installo programmi e configurazioni di sviluppo su una macchina dedicata e confinata; ma va benissimo installare anche tutto direttamente sul sistema operativo macOS principale.



## multipass e il vantaggio di usare una Virtual Machine

Io prima avevo un macbook pro con chip Intel e mi trovavo benissimo ad usare una macchina virtuale (VM) su cui era installato Ubuntu Server, senza interfaccia grafica. Questo mi permetteva di fare sviluppo in una sitazione molto vicina a quella che era poi la realtà in produzione dove avevo un sistema Ubuntu linux in cloud e ci accedevo solo da terminale tramite ssh.

Quindi la mia configurazione di sviluppo era:
- VM con Ubuntu server con installato Ruby on Rails ed il database postgresql (il gestore della VM era multipass)
- Visual Studio Code installato direttamente sul macbook pro ed interfacciato alla VM tramite ssh

Acquistato il nuovo macbook pro con chip M3 il gestore delle VM, multipass, ha iniziato a non funzionare più. Funzionava solo fino ad una vecchia versione ma comunque mi ha poi creato problemi e corrotto le varie VM. Questo mi ha fatto cercare un'alternativa.



# Virtual Machines alternative a multipass

Il nostro ambiente di sviluppo è su Ubuntu Server attivato con multipass e raggiunto tramite ssh con Visual Code.

Software di virtualizzazione compatibile con Apple Silicon. Hai due opzioni principali:
- UTM (gratuito, open-source, facile da usare)
- Parallels Desktop for Mac (Apple Silicon) – a pagamento, ma molto ottimizzato e quindi con performance elevate.

Ho provato UTM ma non ha funzionato con la versione Ubuntu Server 24 LTS scaricata dal sito ufficiale. Ho visto che sul sito UTM c'erano dei sistemi operativi preimpostati ma si fermavano a ubuntu 22 LTS, quindi ho desistito,

Non ho provato parallel perché non ho budget sufficiente ^_^



# Installiamo direttamente su mac OS

Alla fine ho deciso di installare Ruby on Rails e postgresql direttamente sul sistema operativo nativo del mio macbook pro, senza usare macchine virtuali.

