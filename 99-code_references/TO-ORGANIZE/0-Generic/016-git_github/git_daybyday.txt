# Git giorno per giorno

nella normale operatività quotidiana i comandi git più usati sono i seguenti:


## Creo un branch 

posso crearlo anche se ho già fatto alcune mofifiche al codice

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout -b nomebranch
~~~~~~~~




## Lavoro sul codice

Faccio modifiche al codice sul branch e salvo di volta in volta.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "modifiche 1"


$ git add -A
$ git commit -m "modifiche 2"


$ git add -A
$ git commit -m "modifiche 3"

...
~~~~~~~~




# Chiudo il branch

Finito e va tutto bene chiudo il branch faccio merge ed elimino il branch.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge nomebranch
$ git branch -d nomebranch
~~~~~~~~
