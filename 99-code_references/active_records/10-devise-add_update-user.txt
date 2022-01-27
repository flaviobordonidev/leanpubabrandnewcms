# Creazione Nuove Utente e modifica di utente esistente




## Aggiunta di un nuovo utente

L'inserimento di un nuovo utente va effettuato tramite rails console con i comandi che effettuarenno l'append del nuovo record direttamente sulla tabella users. Si possono usare entrambi i metodi portati ad esempio qui di seguito: 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails c 
-> User.new({email: 'donazioni@duomomilano.it', password: 'D*****@2017', password_confirmation: 'D*****@2017'}).save
~~~~~~~~

oppure


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
-> u = User.new({email: 'donazioni@duomomilano.it', password: 'D*****@2017', password_confirmation: 'D*****@2017'})
-> u.save
~~~~~~~~

I> le parentesi graffe "{}" forse si possono anche togliere.




## Modifica di un utente inserito

Troviamo l'utente che vogliamo modificare con 

* User.find(1) 
* User.last 
* User.first
* User.were(email: 'donazioni@duomomilano.it')

e poi lo modifichiamo con il metodo "update"

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails c 
-> u = User.were(email: 'donazioni@duomomilano.it') 
-> u.user.update({password: 'D*****@2018', password_confirmation: 'D*****@2018'})
~~~~~~~~

se non funziona prova con le parentesi graffe:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
-> u.user.update({password: 'D*****@2018', password_confirmation: 'D*****@2018'})
~~~~~~~~
