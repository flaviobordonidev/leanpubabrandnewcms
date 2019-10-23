{id: 01-base-02-git-03-daily_routine}
# Cap 2.3 -- Routine giornaliera

Come normalmente viene utilizzato Git.
Per quanto riguarda il nostro tutorial questo capitolo lo possiamo saltare.



## Branch

Il nome del ramo principale in Git è " master ". Quando si inzia a fare dei commit, li stai dando al ramo master che punterà all'ultimo commit che hai eseguito. Creando un nuovo ramo o branch il puntatore si sposterà su quest'ultimo lasciando inalterato il ramo master.

Nei prossimi capitoli utlizzeremo SEMPRE il Branch per fare le modifiche e poi lo eliminiamo dopo aver passato le modifiche sul master (operazione di merge). 

Ogni volta che facciamo una modifica "anche piccola" apriamo un branch.
Il branch ci permette di tornare indietro se abbiamo fatto casini.




## Creiamo un nuovo ramo e ci spostiamo su di esso.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b nomebranch
```

I> Non è indispensabile creare e spostarsi sul nuovo branch prima di fare le modifiche perché le modifiche vengono passate su git solo quando si fa il " git add ". E' comunque buona prassi iniziare creando il branch prima di modificare il codice.




## Lavoriamo sul codice e aggiorniamo il ramo

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "modifiche fatte"


$ git add -A
$ git commit -m "modifiche fatte2"


$ git add -A
$ git commit -m "modifiche fatte3"

...
```




## Chiudiamo il ramo

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge nomebranch
$ git branch -d nomebranch
```


se abbiamo fatto casino e vogliamo tornare indietro abortando il branch:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git branch -D nomebranch
```
