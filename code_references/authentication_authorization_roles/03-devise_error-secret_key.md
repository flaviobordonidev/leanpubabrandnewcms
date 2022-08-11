# Devise.secret_key was not set.


Risorse interne:

* 01-base/07-authentication/03-devise-users-seeds




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ldi:master
```



### ERRORE su Heroku - Manca la secret_key

Questo errore non si dovrebbe presentare, ma...

...se il " git push heroku ... " si fermarsse con il seguente errore nella log

{caption: "terminal", format: bash, line-numbers: false}
```
remote:        rake aborted!
remote:        Devise.secret_key was not set. Please add the following to your Devise initializer:
remote:        
remote:          config.secret_key = '496bf68dc3...5e3'
remote:        
remote:        Please ensure you restarted your application after installing Devise or setting the key.
```

Dovremmo attivare questo secrets. 

Non editiamo il file config/credentials.yml.enc perché usiamo la secret_key_base che è già impostata.

{caption: ".../config/initializers/devise.rb -- codice 02", format: ruby, line-numbers: true, number-from: 11}
```
  config.secret_key = Rails.application.credentials.secret_key_base
```

Per far si che heroku riesca a decrittare il file config/credentials.yml.enc dobbiamo passargli la variabile d'ambiente con la master key. (RAILS_MASTER_KEY env variable)

Quindi apriamo heroku andiamo nella nostra app "bl6-0.herokuapp.com"

-> nel tab "settings"
-> nella sezione "Config Vars" facciamo click su "Reveal Config Vars"
-> aggiungiamo RAILS_MASTER_KEY   f458b1a...c4

![Fig. 02](chapters/01-base/07-authentication/03_fig02-heroku_config_vars.png)

adesso siamo pronti per poter andare in produzione.




## Cambio della secret_key

Paragrafo didattico. Possiamo saltarlo
Se avessimo voluto cambiare il file credentials.yml.enc per impostare la secret di devise allora

Come abbiamo visto nel precedente capitolo sui "secrets" è bene non passare la chiave in chiaro nel file devise.rb ma invece usiamo config/credentials.yml.enc

{caption: "terminal", format: bash, line-numbers: false}
```
$ EDITOR=vim rails credentials:edit
```

si apre vim sempre nel terminale. inseriamo la secret per devise ("i", "CTRL+c", "CTRL+v", "ESC")

```
# aws:
#   access_key_id: 123
#   secret_access_key: 345

devise:
  secret_key: 496bf68dc3...5e3

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: 845ade...0847
~
```

salviamo ed usciamo da vim (":w", ":q") e riceviamo il messaggio che il file è stato aggiornato.
Attenzione il file è tipo yml quindi si deve indentare. Non usare il "TAB" ma gli spazi della barra spaziatrice. Diamo 2 spazi per restare in standard Rails.

```
$ EDITOR=vim rails credentials:edit
# New credentials encrypted and saved.
```

verifichiamo che funziona

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
> Rails.application.credentials.devise[:secret_key]     # => "845ade..."
```

Adesso possiamo passare il secret nel file di inizializzazione di devise

{title=".../config/initializers/devise.rb", lang=ruby, line-numbers=on, starting-line-number=11}
```
  config.secret_key = Rails.application.credentials.devise[:secret_key]
```

Solo che al momento questa non funziona. Funziona solo con il segret di default e quindi al momento non possiamo fare un secret personalizzato per devise.




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement Devise on heroku"
```




### Riproviamo a Pubblicare su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ldi:master
$ heroku run rails db:migrate
```
