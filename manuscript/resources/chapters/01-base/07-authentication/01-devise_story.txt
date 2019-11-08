{id: 01-base-07-authentication-01-devise_story}
# Cap 7.1 -- Storia di devise

Questo capitolo è solo teorico. Non andiamo avanti con il codice.

Questa sezione è una parte importante per la gestione dell'applicazione in quanto permette l'accesso ed identifica chi può fare cosa a seconda del suo ruolo.


Risorse interne:

* 99-rails_references/authentication/01-story




## Distinguiamo

Il processo di autorizzazione è distinto da quello di autenticazione. Mentre l'autenticazione è il processo di verificare che "tu sei chi tu dici di essere", l'autorizzazione è il processo di verificare che "tu hai il permesso di fare quello che stai cercando di fare". La verifica del permesso è fatta in funzione del ruolo o dei ruoli che hai.
L'autenticazione sono porte di ingresso che si aprono tutte con la chiave chiamata login. Una volta entrato l'utente può fare tutto. Per limitarne l'azione gli si assegnano uno o più ruoli e per ogni ruolo si abilitano delle autorizzazioni a fare certe azioni.

Autenticazione è essere in grado di verificare l'identità dell'utente. E' fare accesso/login --> Devise, Authlogic, Clearance
Autorizzazione è chi può fare cosa una volta autenticato. (è dare livelli di accesso differente) --> CanCanCan, Pundit, Authority
Ruolificazione è dare un ruolo ad ogni utente. Questo ci permette di dare autorizzazioni in funzione del ruolo. --> rolify

Per l'Autenticazione scelgo Devise.
Per l'autorizzazione scelgo Pundit.
Per la ruolificazione scelgo Rolify.




## Un po' di storia per i nostalgici - Figaro

Un problema di sicurezza.
Le password e le chiavi di criptatura non sono state escluse da git e vengono quindi passate sui repositories esterni. Questo non è cosa buona e giusta. Implementiamo la sicurezza con la gemma Figaro.



## Perché usavamo figaro?

Figaro è una gemma vecchiotta che però anche per Rails 5 fa egregiamente il suo lavoro.
Da rails 4.1 è stato introdotto il file secrets.yml che è un'alternativa a figaro.
Però figaro vale ancora la pena...

Rails 4.1 ha introdotto il file secrets.yml che potrebbe sostituire figaro ma non al 100%. Il problema è che secrets.yml non setta le variabili d'ambiente (environment variables). Lo stesso secrets.yml di default ne usa una per l'ambiente di produzione.

{title="config/secrets.yml", lang=ruby, line-numbers=on, starting-line-number=47}
~~~~~~~~
# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
~~~~~~~~

Quindi dove raccolgo tutte le password per la mia applicazione per poi passarle come variabili d'ambiente?
Al momento conviene ancora usare figaro e raccoglierle sul file a lui dedicato config/application.yml
All'avvio di rails la gemma figaro carica in variabili d'ambiente tutte le password scritte su config/application.yml

A> Evita di usare .bashrc o .bash-profile per le passwords/secrets
A>
A> Quando immagazzini passwords/secrets in file come .bashrc, queste sono mandate come variabili d'ambiente ad ogni singolo programma che stai eseguendo come utente. La maggior parte di questi programmi non ha bisogno di conoscere le tue passwords/secrets. Quindi perché passarglieli?
A> Rivela le tue passwords/secrets solo ai processi che ne hanno bisogno.
A> Gemme come figaro o detenv ti permettono di aggiungere variabili d'ambiente ai tuoi files che sono caricati all'avvio di Rails. Quest variabili d'ambiente saranno disponibili solo al processo Rails e ai suoi processi figli.

I> ATTENZIONE!
I>
I> ricordiamoci di mettere config/application.yml su .gitignore per non passare il file delle password su git-hub.




## Come erano messe al sicuro le password

Avendo installato figaro spostiamo tutte le password sul file /config/application.yml
Iniziamo con il secret_key_base che è usato per verificare l'integrità dei signed cookies e che si trova da rails 4.1 sul file config/secrets.yml. (Nelle precedenti versioni di rails era in config/initializers/secret_token.rb)

Questo file ha una "convenzione" con heroku per quanto riguarda la produzione. Infatti heroku crea in automatico la ENV["SECRET_KEY_BASE"] come puoi verificare da terminale.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ heroku config
~~~~~~~~

Quindi questa possiamo lasciarla così com'è oppure possiamo prendere quella di heroku ed archiviarla sul file di figaro config/application.yml 
Comunque per le altre due Spostiamo i valori. 

Apriamo il file .../config/secrets e copiamoci i valori dei secret_key_base

[codice: beginning figaro 03](#code-beginning-figaro-03)

{title=".../config/secrets.yml", lang=yaml, line-numbers=on, starting-line-number=13}
~~~~~~~~
development:
  secret_key_base: 2d64e44d814e3fdf518fb7f830e0f656bfcd015c86dfc4c5686d2b671a6e05aeaf67e780beaaa82b5f3be2c58bd28d616ffef2845233ab5dba9fade5067e0c06

test:
  secret_key_base: 2de1ca50ad0877af447c1f414419e3eab1e0d09f612a6d24cd846bfcea38e3750d4965323aa35d39f945bb18b5f1592c1c590ffee3dbec39973ca299bbacb1ca
~~~~~~~~

Passiamoli sul file di Figaro 

{title=".../config/application.yml", lang=yaml, line-numbers=on, starting-line-number=1}
~~~~~~~~
development:
  SECRET_KEY_BASE: 2d64e44d814e3fdf518fb7f830e0f656bfcd015c86dfc4c5686d2b671a6e05aeaf67e780beaaa82b5f3be2c58bd28d616ffef2845233ab5dba9fade5067e0c06

test:
  SECRET_KEY_BASE: 2de1ca50ad0877af447c1f414419e3eab1e0d09f612a6d24cd846bfcea38e3750d4965323aa35d39f945bb18b5f1592c1c590ffee3dbec39973ca299bbacb1ca

production:
  #SECRET_KEY_BASE: already present on heroku. See $ heroku config
~~~~~~~~

I> ATTENZIONE!
I>
I> le variabili d'ambiente sono case-sensitive quindi ENV["secret_key_base"] è DIVERSO da ENV["SECRET_KEY_BASE"]
I> 
I> Per convenzione le variabili d'ambiente si scrivono tutte maiuscole.

I> DOPPIA ATTENZIONE!
I> 
I> dopo le modifiche al file config/application.yml può essere necessario chiudere TUTTO IL TERMNIALE e non solo uscire dalla rails console e rientrare.


quindi il file secret.yml risulta

[codice: beginning figaro 04](#code-beginning-figaro-04)

{title=".../config/secrets.yml", lang=yaml, line-numbers=on, starting-line-number=13}
~~~~~~~~
development:
  secret_key_base: ENV["SECRET_KEY_BASE"]

test:
  secret_key_base: ENV["SECRET_KEY_BASE"]

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
~~~~~~~~




## Giochiamo con le variabili d'ambiente (ENV)

Verifichiamo usando la rails console (https://pragmaticstudio.com/blog/2014/3/11/console-shortcuts-tips-tricks)

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails console
> puts ENV.keys # find out what ENV vars are set
=> (returns a long list of var names)
> puts ENV['SECRET_KEY_BASE']
=> "067d793e8781fa02aebd36e239c7878bdc1403d6bcb7c380beac53189ff6366be"
~~~~~~~~

Riproviamolo nell'ambiente di test

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails console test
> puts ENV.keys 
~~~~~~~~

Riproviamolo nell'ambiente di produzione (con sandbox per rollback delle modifiche)

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails console production --sandbox
> puts ENV.keys 
~~~~~~~~

I> ATTENZIONE!
I> l'ambiente di produzione coì chiamato fa riferimento ad un publicazione in locale e NON su Heroku. 
I>
I> Per heroku credo si debba usare un'altro comando. Ad esempio " heroku run bash "




## come si implementava Heroku

Per Heroku esisteva la script " figaro heroku:set " che passava i valori

Adesso passiamo le variabili di 'secrets' creato in figaro direttamente in produzione su Heroku.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ figaro heroku:set -e production
~~~~~~~~