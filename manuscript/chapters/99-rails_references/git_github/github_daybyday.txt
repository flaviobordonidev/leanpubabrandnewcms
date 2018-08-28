# Github giorno per giorno

nella normale operatività quotidiana i comandi git+github più usati sono i seguenti:


## Creo un branch 

Prima di creare il branch verifico/scarico aggiornamenti fatti dai collaboratori su github con un push. Creo il branch in locale e lo carico anche sul repository remoto github.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git pull origin master
$ git checkout -b nomebranch
$ git push origin nomebranch
~~~~~~~~




## Lavoro sul codice

Faccio modifiche al codice sul branch e le salvo di volta in volta sia in locale che sul repository remoto github.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git add -A
$ git commit -m "modifiche 1"
$ git push origin nomebranch


$ git add -A
$ git commit -m "modifiche 2"
$ git push origin nomebranch


$ git add -A
$ git commit -m "modifiche 3"
$ git push origin nomebranch

...
~~~~~~~~




## Chiudo il branch

Finito e va tutto bene chiudo il branch faccio merge ed elimino il branch.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git merge nomebranch
$ git push origin master

$ git branch -d nomebranch
$ git push origin :nomebranch
~~~~~~~~




## In alternativa Github solo come backup

Se uso Github solo come backup non ho bisogno di fare push in remoto anche dei branches ma lo faccio solo del branch master.

Quindi seguo la normale operatività del solo Git e dopo aver fatto il merge ed eliminato il branch posso fare un backup sul repository remoto Github.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git push origin master
~~~~~~~~

