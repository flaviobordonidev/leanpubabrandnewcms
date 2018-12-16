# Github

Facciamo un backup della nostra applicazione su Github.



## Apriamo il branch

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b gh
~~~~~~~~




## L'importanza del README.md

Quando ci colleghiamo su github la pagina che ci presenta l'applicazione è quella scritta sul file README.md ed è quindi importante tenere aggiornato il file readme con quello che fa l'applicazione. Spieghiamo cos'è il nostro progetto e quali sono i benefici per chi lo userà. Spieghiamo il perché e scriviamo le varie storie che sono state prese in fase di idealizzazione.

{title=".../README.md",lang=markdown, line-numbers=on, starting-line-number=1}
~~~~~~~~
# Rigenerabatterie v0.1.0
==
~~~~~~~~

{title=".../README.md",lang=markdown, line-numbers=on, starting-line-number=34}
~~~~~~~~
history:

* v0.1.0  10.12.18  creazione dell'applicazione su rails 5.2.0
~~~~~~~~

Mano a mano che sviluppiamo l'applicazione aggiorniamo anche il readme. Nello specifico la versione e l'history delle versioni.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add readme"
~~~~~~~~


