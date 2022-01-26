# <a name="top"></a> Cap 5.2 - Github readme

Facciamo un backup della nostra applicazione su Github.



## Apriamo il branch "GitHub"

```bash
$ git checkout -b gh
```



## L'importanza del README.md

Quando ci colleghiamo su github la pagina che ci presenta l'applicazione è quella scritta sul file *README.md* ed è quindi importante tenere aggiornato il file readme con quello che fa l'applicazione. 
Spieghiamo cos'è il nostro progetto e quali sono i benefici per chi lo userà. 
Spieghiamo il perché e scriviamo le varie storie che sono state prese in fase di idealizzazione.

Il file README che ci interessa è quello dentro la cartella della nostra applicazione Rails.

***codice 01 - .../README.md - line: 1***

```Markdown
# bl7_0
==
Questa applicazione Rails è una base comune per poter poi sviluppare varie altre applicazioni.
E' sufficiente fare un fork su github ed effettuare un git clone su una nuova applicazione.
```

dopo tutta la descrizione del progetto mettiamo la storia delle varie releases

***codice 01 - .../README.md - line: 22***

```Markdown
history:

- v0.1.0  26.01.22  creazione dell'applicazione su rails 7.0.1
==
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/02_01-readme.md)


Mano a mano che sviluppiamo l'applicazione aggiorniamo anche il *README.md*. Nello specifico la versione e l'history delle versioni.



## Salviamo su git

```bash
$ git add -A
$ git commit -m "Update readme for github"
```



## pubblichiamo su heroku

```bash
$ git push heroku gh:master
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/01-github_story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03-github_initializing-it.md)
