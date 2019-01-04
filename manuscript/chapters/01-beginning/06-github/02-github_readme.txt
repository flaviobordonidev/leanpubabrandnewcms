# Github

Facciamo un backup della nostra applicazione su Github.



## Apriamo il branch "GitHub"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b gh
~~~~~~~~




## L'importanza del README.md

Quando ci colleghiamo su github la pagina che ci presenta l'applicazione è quella scritta sul file README.md ed è quindi importante tenere aggiornato il file readme con quello che fa l'applicazione. Spieghiamo cos'è il nostro progetto e quali sono i benefici per chi lo userà. Spieghiamo il perché e scriviamo le varie storie che sono state prese in fase di idealizzazione.

Il file README che ci interessa è quello dentro la cartella della nostra applicazione Rails.

{id="01-06-02_01", title=".../README.md",lang=markdown, line-numbers=on, starting-line-number=1}
~~~~~~~~
# Myapp v0.1.0
==
~~~~~~~~

{title=".../README.md",lang=markdown, line-numbers=on, starting-line-number=34}
~~~~~~~~
history:

* v0.1.0  01.01.19  creazione dell'applicazione su rails 5.2.0
~~~~~~~~

[Codice 01](#01-06-02_01all)

Mano a mano che sviluppiamo l'applicazione aggiorniamo anche il readme. Nello specifico la versione e l'history delle versioni.




## Salviamo su git

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add readme"
~~~~~~~~




## pubblichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push heroku gh:master
~~~~~~~~




## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo




## Il codice del capitolo



[Codice 01](#01-06-02_01)

{id="01-06-02_01all", title=".../README.md",lang=markdown, line-numbers=on, starting-line-number=1}
~~~~~~~~
# Myapp v0.1.0
==
Questa app è stata fatta da me e serve a fare quello che voglio io.
Segue una lunga spiegazione del perché e del percome.
tutta la parte di installazione.
tutta la parte di utilizzo.
Vari esempi dimostrativi.
Altre considerazioni
Altre informazioni
BlaBlaBla

history:

* v0.1.0  18.06.18  creazione dell'applicazione su rails 5.2.0
~~~~~~~~
