# <a name="top"></a> Cap active_records.11 - Nuove Utente e modifica

Creazione Nuove Utente e modifica di utente esistente



## Aggiunta di un nuovo utente

L'inserimento di un nuovo utente va effettuato tramite rails console con i comandi che effettuarenno l'append del nuovo record direttamente sulla tabella users. Si possono usare entrambi i metodi portati ad esempio qui di seguito: 

***code n/a - "rails terminal" - line:n/a***

```ruby
$ sudo service postgresql start
$ rails c 
-> User.new({email: 'donazioni@duomomilano.it', password: 'D*****@2017', password_confirmation: 'D*****@2017'}).save
```

oppure


***code n/a - "rails terminal" - line:n/a***

```ruby
-> u = User.new({email: 'donazioni@duomomilano.it', password: 'D*****@2017', password_confirmation: 'D*****@2017'})
-> u.save
```

> Le parentesi graffe "{}" forse si possono anche togliere.




## Modifica di un utente inserito

Troviamo l'utente che vogliamo modificare con 

- User.find(1) 
- User.last 
- User.first
- User.were(email: 'donazioni@duomomilano.it')

e poi lo modifichiamo con il metodo "update"

***code n/a - "rails terminal" - line:n/a***

```ruby
$ sudo service postgresql start
$ rails c 
-> u = User.were(email: 'donazioni@duomomilano.it') 
-> u.user.update({password: 'D*****@2018', password_confirmation: 'D*****@2018'})
```

se non funziona prova con le parentesi graffe:

***code n/a - "rails terminal" - line:n/a***

```ruby
-> u.user.update({password: 'D*****@2018', password_confirmation: 'D*****@2018'})
```
