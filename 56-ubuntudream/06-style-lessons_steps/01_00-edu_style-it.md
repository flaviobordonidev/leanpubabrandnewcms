# <a name="top"></a> Cap 6.1 - Inseriamo lo stile dal tema edu

Mettiamo lo style preso dal tema edu nelle views che abbiamo creato.



## Apriamo il branch "Edu Style"

```bash
$ git checkout -b es
```


## Lessons show

C'è la presentazione della visualizzazione a lato i vari video propedeutici ed altre info.

Sotto l'immagine ci sono i **3 pulsanti** principali da fare in sequenza:

1 - Preparazione
2 - Visualizzazione
3 - fine 

> sarebbe utile iniziare con solo il pulsante "1" abilitato ed una volta fatto l'esercizio si abilita il "2" ed una volta fatto il "2" si abilita il "3". (magari su quelli fatti si attiva un segno di spunta a lato. Segno di spunta che dura un'ora e poi si disattiva.)

> Invece a livello di lezione il segno di spunta lo lascerei permanente.

*****

NOOOO!
TOGLIAMO TUTTA QUESTA COMPLESSITA'
Il rasoio di Ockham: la spiegazione più semplice spesso è la migliore.

TOGLIAMO TUTTA QUESTA COMPLESSITA' e semplicemente aggiungiamo il video di preparazione al primo video della lezione. Ed il video di "fine" alla pagina di "Complimenti hai finito la lezione!".

Questo approccio, da un lato ci fa ripetere lo stesso video per ogni lezione, ma questo senza creare nessuna ripetizione a livello di codice. Dall'altro lato ci permette anche di creare delle variazioni sul video di preparazione per ogni lezione ed anche di creare delle versioni differenti per ogni istruttore differente.

*****



***code 01 - .../app/views/lessons/show.html.erb - line:1***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/01_01-db-migrate-xxx_create_answers.rb)


Cliccando sul pulsante *1 - Preparazione* abbiamo il filmato come su `lessons/steps/show` ma visualiziamo il video di preparazione (come possiamo cambiare gli istruttori?)

> forse la soluzione semplice è aprire su un nuovo tab la lezione specifica per la preparazione: `lessons/steps/1` e con il terzo pulsante apriamo `lessons/steps/2` (Queste prime due lezioni non possono essere cancellate e **non** hanno steps intermedi)

> 