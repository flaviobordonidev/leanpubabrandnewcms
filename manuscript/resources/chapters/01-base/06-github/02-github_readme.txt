{id: 01-base-06-github-02-github_readme}
# Cap 6.2 -- Github readme

Facciamo un backup della nostra applicazione su Github.



## Apriamo il branch "GitHub"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b gh
```




## L'importanza del README.md

Quando ci colleghiamo su github la pagina che ci presenta l'applicazione è quella scritta sul file README.md ed è quindi importante tenere aggiornato il file readme con quello che fa l'applicazione. Spieghiamo cos'è il nostro progetto e quali sono i benefici per chi lo userà. Spieghiamo il perché e scriviamo le varie storie che sono state prese in fase di idealizzazione.

Il file README che ci interessa è quello dentro la cartella della nostra applicazione Rails.

{id: "01-06-02_01", caption: ".../README.md -- codice 01", format: markdown, line-numbers: true, number-from: 1}
```
# bl6_0
==
Questa applicazione Rails è una base comune per poter poi sviluppare varie altre applicazioni.
E' sufficiente fare un fork su github ed effettuare un git clone su una nuova applicazione.
```

dopo tutta la descrizione del progetto mettiamo la storia delle varie releases

{caption: ".../README.md -- codice 01", format: markdown, line-numbers: true, number-from: 1}
```
history:

* v0.1.0  04.09.19  creazione dell'applicazione su rails 6.0.0
==
```

[tutto il codice](#01-06-01_01all)

Mano a mano che sviluppiamo l'applicazione aggiorniamo anche il readme. Nello specifico la versione e l'history delle versioni.




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Update readme for github"
```




## pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku gh:master
```




## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo




## Il codice del capitolo





{id: "01-06-02_01all", caption: ".../README.md -- codice 01", format: markdown, line-numbers: true, number-from: 1}
```
# bl6_0
==
Questa applicazione Rails è una base comune per poter poi sviluppare varie altre applicazioni.
E' sufficiente fare un fork su github ed effettuare un git clone su una nuova applicazione.

Come instllare
lorem ipsum dolet amen.

Riempire il database
lorem ipsum dolet amen.

Usare i mockups
lorem ipsum dolet amen.

Esempi di utilizzo
lorem ipsum dolet amen.

history:

* v0.1.0  04.09.19  creazione dell'applicazione su rails 6.0.0
==
```

[indietro](#01-06-01_01)
