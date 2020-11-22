# Pundit - Autorizzazione

Installazione ed uso di Pundit

Risorse interne

* 01-base/15-authorization/02-authorization-pundit
* 01-base/15-authorization/03-authorization-users


Risorse web

* [gems pundit](https://rubygems.org/gems/pundit)
* [varvet pundit](https://github.com/varvet/pundit)
* [rails authorization](http://railsapps.github.io/rails-authorization.html)
* [rails authorization freecodecamp](https://medium.freecodecamp.org/rails-authorization-with-pundit-a3d1afcb8fd2)
* [authorization with pundit tutplus](https://code.tutsplus.com/tutorials/authorization-with-pundit--cms-28202)
* [authorization with pundit medium](https://medium.com/@stacietaylorcima/implement-user-authorization-with-pundit-rails-80d921cdbf28)
* [Episode #047 - Authorization with Pundit](https://www.youtube.com/watch?v=PWizyTjCAdg)
* [Rails Authorization With Pundit - parte da zero ed installa anche devise ed usa anche spec tests](https://www.youtube.com/watch?v=qruGD_8ry7k)

* [Devise authentication 48:50](https://www.youtube.com/watch?v=qruGD_8ry7k
* [current_user present? and signed_in](https://stackoverflow.com/questions/45398702/what-is-the-difference-between-current-user-present-and-if-user-signed-in)
* [Differenza fra public e private](https://www.codementor.io/anuraag.jpr/the-difference-between-public-private-and-protected-methods-in-ruby-6zsvkeeqr)
* [Rails Authorization With Pundit - parte da zero ed installa anche devise ed usa anche spec tests](https://www.youtube.com/watch?v=qruGD_8ry7k)



## Identifichiamo il problema di autorizzazione

Impostiamo che autorizzazioni ha l'utente, una volta autenticato attraverso il login.
Attiviamo pundit per autorizzare le modifiche degli utenti solo se la persona è loggata (autenticata) ed ha il ruolo di amministratore (autorizzata).
In altre parole solo l'amministratore può modificare gli utenti.




### altri esempi di richieste di autorizzazione

Ma prima di approfondire Pundit identifichiamo il nostro problema che richiede autenticazione:

Nel sistema di gestione delle aziende abbiamo 2 ruoli, quello del manager e quello del dipendente. 
Il Manager può visualizzare tutte le schermate del sistema. 
Il dipendente non può creare, modificare o cancellare alcuna azienda.

