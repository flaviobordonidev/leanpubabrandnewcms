# <a name="top"></a> Cap 2.4 - Routine giornaliera

Come normalmente viene utilizzato Git.

> Per quanto riguarda il nostro tutorial questo capitolo lo possiamo saltare.



## Branch

Il nome del ramo principale in Git è " master ". Quando si inzia a fare dei commit, li stai dando al ramo master che punterà all'ultimo commit che hai eseguito. 
Creando un nuovo ramo o branch il puntatore si sposterà su quest'ultimo lasciando inalterato il ramo master.

Nei prossimi capitoli utlizzeremo SEMPRE il Branch per fare le modifiche e poi lo eliminiamo dopo aver passato le modifiche sul master (operazione di merge). 

Ogni volta che facciamo una modifica "anche piccola" apriamo un branch.
Il branch ci permette di tornare indietro se abbiamo fatto casini.



## Creiamo un nuovo ramo e ci spostiamo su di esso.

```bash
$ git checkout -b nomebranch
```

> Non è indispensabile creare e spostarsi sul nuovo branch prima di fare le modifiche perché le modifiche vengono passate su git solo quando si fa il " git add ". 
> E' comunque buona prassi iniziare creando il branch prima di modificare il codice.



## Lavoriamo sul codice e aggiorniamo il ramo

Mano a mano che continuiamo con lo sviluppo del codice facciamo delle aggiunte su git mettendo l'indicazione delle *modifiche fatte*.
Nella descrizione delle modifiche, **non** usiamo il passato; usiamo invece l'imperativo presente. Questo perché ogni commitment visto da git sono dei *punti di ripristino* del codice a quella versione.
Quindi la descrizione ci dice che tipo di situazione di codice ripristineremo se eseguissimo quel ripristino su git.

```bash
$ git add -A
$ git commit -m "modifiche fatte"


$ git add -A
$ git commit -m "modifiche fatte2"


$ git add -A
$ git commit -m "modifiche fatte3"
```



## Chiudiamo il ramo

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge nomebranch
$ git branch -d nomebranch
```


Se abbiamo fatto casino e vogliamo tornare indietro abortando il branch:

```bash
$ git checkout master
$ git branch -D nomebranch
```

> Attenzione: eventuali modifiche sul database non sono legate al branch e quindi restano inalterate anche se abortiamo il branch.


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/02_00-inizializziamo_git.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/03-mockups/01_00-mockups.md)
