# Github

Github rende disponibile a livello web i progetti gestiti da git.
Github è un repository remoto di git.
Noi lo utilizziamo per avere un backup del nostro applicativo e per predisporre la possibilità di uno sviluppo multiutenti.




## Apriamo il branch

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b gh
~~~~~~~~




## L'importanza del README.md

Quando ci colleghiamo su github la pagina che ci presenta l'applicazione è quella scritta sul file README.md ed è quindi importante tenere aggiornato il file readme con quello che fa l'applicazione. Spieghiamo cos'è il nostro progetto e quali sono i benefici per chi lo userà. Spieghiamo il perché e scriviamo le varie storie che sono state prese in fase di idealizzazione.

[codice: 01](#code-beginning-github_readme-01)

{title="README.md",lang=markdown, line-numbers=on, starting-line-number=1}
~~~~~~~~
# Rebiworld v0.1.0
==
~~~~~~~~

{title="README.md",lang=markdown, line-numbers=on, starting-line-number=34}
~~~~~~~~
history:

* v0.1.0  21.03.18  creazione dell'applicazione su rails 5.1.4
~~~~~~~~

Mano a mano che sviluppiamo l'applicazione aggiorniamo anche il readme. Nello specifico la versione e l'history delle versioni.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "add readme"
~~~~~~~~




## Github

Iniziamo portando la nostra applicazionie su Github. Per prima cosa creiamoci un account su www.github.com

![account su github](images/beginning/github_readme/github_signup.png)

Se lo abbiamo già logghiamoci.

![account su github](images/beginning/github_readme/github_signin.png)

Una volta loggati creiamo un nuovo repository:

* nome        : rebisworld3
* descrizione : sito web con template Canvas

![account su github](beginning/09img-github_new_repository.png)

Appena creato il nuovo repository ci viene presentato un "Quick setup"

![account su github](beginning/09img-github_quick_setup.png)

Aggiungiamo sul nostro git il repository remoto "rebisworld1.git" creato sul nostro account github "flaviobordonidev" usando SSH.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git remote add origin git@github.com:flaviobordonidev/rebisworld3.git
~~~~~~~~

Se avessimo voluto usare HTTPS avremmo usato "git remote add origin https://github.com/flaviobordonidev/elisinfo6.git"

Il comando "git remote" è per attivare il repository remoto su un server esterno (nel nostro caso github.com).
con "add origin" si dichiara che il nome di riferimento del repositroy remoto è "origin" (potevamo chiamarlo github ma per convenzione storica la stessa Github ha scelto di chiamarlo "origin").  

Prima di spostare il nostro git locale sul repository remoto Github dobbiamo chiudere il branch locale, tornare sul branch master ed effettuare il merge. 




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge gh
$ git branch -d gh
~~~~~~~~

aggiorniamo github

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push origin master
~~~~~~~~

il comando "git push" sposta sul branch remoto "origin" il branch locale "master".

Spostiamo in remoto anche la parte dei tag in cui abbiamo messo la versione v.0.1.0

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push origin master --tag
~~~~~~~~

![github overview](beginning/09img-github_repository_overview.png)


