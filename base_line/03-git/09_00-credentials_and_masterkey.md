{id: 01-base-01-new_app-08-credentials_and_masterkey}
# Cap 1.8 -- Rails Secrets

Fino a Rails 4.0 un'ottia gemma era Figaro. Adesso non la usiamo più perché è stata implementata una sicurezza nativa su Rails.




## Il problema di sicurezza.

Le password e le chiavi di criptatura non erano escluse da git e venivano quindi passate sui repositories esterni. Questo non accade più perché è stato implementato il file secrets.




## Perché si usava figaro?

Figaro è una gemma vecchiotta che ha fatto egregiamente il suo lavoro.
Da rails 4.1 è stato introdotto il file secrets.yml che è un'alternativa a figaro. Però figaro valeva ancora la pena...
Il problema è che secrets.yml non settava le variabili d'ambiente (environment variables).

All'avvio di rails la gemma figaro caricava in variabili d'ambiente tutte le password scritte su config/application.yml
Questo era molto meglio di usare le variabili di ambiente tramite .bashrc o .bash-profile per le passwords/secrets. Perché quando immagazzini passwords/secrets in file come .bashrc, queste sono mandate come variabili d'ambiente ad ogni singolo programma che stai eseguendo come utente. La maggior parte di questi programmi non ha bisogno di conoscere le tue passwords/secrets. Quindi perché passarglieli? Rivela le tue passwords/secrets solo ai processi che ne hanno bisogno. Gemme come figaro o detenv ti permettono di aggiungere variabili d'ambiente ai tuoi files che sono caricati all'avvio di Rails. Quest variabili d'ambiente saranno disponibili solo al processo Rails e ai suoi processi figli.

Per maggiori informazioni sulle variabili d'ambiente (ENV) usando la rails console vedi:
* (https://pragmaticstudio.com/blog/2014/3/11/console-shortcuts-tips-tricks)

Già da Rails 5.2 il problema è stato risolto in modo elegante usando la criptatura .




## Come gestire i secrets da Rails 5.2 in avanti

D'ora in poi, da Rails 5.2 utilizziamo solo questi due file:

* config/credentials.yml.enc
* config/master.key

il file in cui verranno archiviate tutte le credenziali private è " .../config/credentials.yml.enc ".

Come suggerisce l'estensione, questo file sarà crittografato, quindi non sarai in grado di leggere ciò che è al suo interno, a meno che tu non abbia la chiave master corretta per decrittografarlo. Ecco perché è sicuro lasciare questo file su git (il nostro control versioning system).

Il secondo file, " .../config/master.key ", è il file in cui è contenuta la RAILS_MASTER_KEY.

La RAILS_MASTER_KEY è la chiave che Rails utilizza per decrittografare " .../config/credentials.yml.enc ". NON dobbiamo inserire questo file nel git. Dobbiamo tenerlo segreto, e quindi dobbiamo assicuraci cha sia elencato nel nostro file " .../.gitignore ".



## Il file master.key

è una semplice stringa usata come chiave principale di crittatura. Di default Rails crea una stringa esadecimale di 32bytes.

{caption: ".../config/master.key -- codice 01", format: yaml, line-numbers: true, number-from: 1}
```
f458b1a6862a56b7474b9e734d7b01c4
```

Siccome questa è la chiave per decifrare tutte le secrets questa è automaticamente inclusa in .gitignore e quindi non è passata ai repositories remoti (es: GitHub)

{id: "01-01-08_01", caption: ".../.gitignore -- codice 01", format: yaml, line-numbers: true, number-from: 25}
```
# Ignore master key for decrypting credentials and more.
/config/master.key
```

[tutto il codice](#01-01-08_01all)

Il file " .gitignore " è un file nascosto di default. Per visualizzarlo dobbiamo selezionare il menu "Show Hidden Files" dal pulsante con la "ruota dentata" nell'angolo in alto a destra nel tab "environment" dove è presente l'elenco dei files e delle cartelle.

![Fig. 01](chapters/01-base/01-new_app/08_fig01-show_hidden_files.png)

![Fig. 02](chapters/01-base/01-new_app/08_fig02-gitignore.png)




## Editare le credenziali

Poiché è crittografato, Rails offre un modo per modificare il file " config/credentials.yml.enc ". Possiamo farlo eseguendo il seguente comando:

{caption: "terminal", format: bash, line-numbers: false}
```
$ EDITOR=vim rails credentials:edit
```

Questo apre il file decrittato sul terminale usando vim. Come possiamo vedere il file decrittato assomiglia ad un normale file .yml

Per fare delle modifiche con VIM:

* muoversi con le frecce sulla tastiera. 
* premere [i] per entrare in modalità modifica. 
* premere [canc] per cancellare.
* premere [ESC] per uscire dalla modalità modifica.
* Quando si è fuori dalla modalità modifica digitare " :w " e premere [ENTER] per salvare.
* Quando si è fuori dalla modalità modifica digitare " :q " e premere [ENTER] per uscire.
* Quando si è fuori dalla modalità modifica digitare " :wq " e premere [ENTER] per salvare ed uscire.

Quando salviamo, Rail automaticamente critta il file usando la master key.

Se quando eseguiamo il comando " credentials:edit " i due files " config/master.key " e " config/credentials.yml.enc " non esistono, verranno automaticamente creati.

La configurazione iniziale sarà qualcosa come

{caption: "terminal", format: bash, line-numbers: false}
```
# aws:
#   access_key_id: 123
#   secret_access_key: 345

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: da874abc33759d3c51aab38959d3c5db4...847
```




## Leggere le credenziali

Se ad esempio la versione decrittata del nostro " config/credentials.yml.enc " è questa:

{caption: "terminal", format: bash, line-numbers: false}
```
aws:
  access_key_id: 123
  secret_access_key: 345
secret_key_base: da874abc33759d3c51aab38959d3c5db4...847
```

Allora possiamo accedere alla configurazione in questo modo:

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
> Rails.application.credentials.aws[:access_key_id]         # => "123"
# oppure
> Rails.application.credentials.dig(:aws, :access_key_id)   # => "123"

> Rails.application.credentials.aws[:secret_access_key]         # => "345"
# oppure
> Rails.application.credentials.dig(:aws, :secret_access_key)   # => "345"

> Rails.application.credentials.secret_key_base     # => "da874abc3...
```







## Il codice del capitolo




{id: "01-01-08_01all", caption: ".../.gitignore -- codice 01", format: yaml, line-numbers: true, number-from: 1}
```
# See https://help.github.com/articles/ignoring-files for more about ignoring files.
#
# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile '~/.gitignore_global'

# Ignore bundler config.
/.bundle

# Ignore all logfiles and tempfiles.
/log/*
/tmp/*
!/log/.keep
!/tmp/.keep

# Ignore uploaded files in development.
/storage/*
!/storage/.keep

/public/assets
.byebug_history

# Ignore master key for decrypting credentials and more.
/config/master.key

/public/packs
/public/packs-test
/node_modules
/yarn-error.log
yarn-debug.log*
.yarn-integrity

```

[indietro](#01-01-08_01)
