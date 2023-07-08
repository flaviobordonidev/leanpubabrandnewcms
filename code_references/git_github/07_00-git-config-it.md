# Git config

I FILES DI CONFIGURAZIONE DI GIT.

Ci sono divesi files di configurazione e **non** uno solo!!!!


## Risorse interne

- []()



## Risorse esterne

- [How to disable osxkeychain as credential helper in git config?](https://stackoverflow.com/questions/16052602/how-to-disable-osxkeychain-as-credential-helper-in-git-config)


## I vari files di configurazione di git

Ci sono 3 files più usati... 

```bash
$ git config --local --edit
$ git config --global --edit
$ sudo git config --system --edit
```

> The last one may not work if you don't have proper permissions. So you may need to run the last one under sudo for it to work correctly. 

...ma ci possono essere anche dei parametri che sono impostati su altri files "gitconfig".

Ad esempio con:

```bash
$ git config -l
```

possiamo visualizzare un parametro che non troviamo nei 3 files di default. Se dovesse succedere possiamo andare alla caccia del file "gitconfig" che lo contiene con il comando:

`$ git config --show-origin --get <nome_parametro>`

Nel prossimo parametro vediamo questa ricerca messa in atto per trovare dove era configurato il parametro "credential.helper".


## TROVIAMO e TOGLIAMO il credential.helper

Questa impostazione è utile se hai un solo utente/email che si collega a github perché prende le impostazioni dal file di archiviazione delle password del tuo sistema operativo. Nel nostro caso da Mac OSX:

```bash
credential.helper=osxkeychain
```

Però diventa un problema se vogliamo aggiungere un utente differente perché viene sempre preso il primo.
Per gestire l'altro utente ho dovuto cancellare questa opzione e non è stato facile trovarla perché era su un file di configurazione di git particolarmente nascosto. 

Inizialmente ho provato con i 3 files più usati:

```bash
$ git config --local credential.helper
$ git config --global credential.helper
$ git config --system credential.helper
```

> Se non trovano nulla il comando non da nessuna risposta. Se invece lo trova allora è mostrato.

The first one checks the local repo config, the second is your ~/.gitconfig, and the third is based on where git is installed. Depending on which one comes back showing the credential helper, you can try using the equivalent --unset option:

```bash
git config --local --unset credential.helper
git config --global --unset credential.helper
git config --system --unset credential.helper
```

> The last one may not work if you don't have proper permissions. So you may need to run the last one under sudo for it to work correctly. 


Infine, l'ho trovato con il comando:

```bash
$ git config --show-origin --get credential.helper
```

E poi l'ho editato direttamente usando le autorizzazioni di super user (sudo):

```bash
$ sudo nano /Library/Developer/CommandLineTools/usr/share/git-core/gitconfig
```

Ho cancellato le righe che lo chiamavano e finalmente me ne sono liberato ^_^.


```bash
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git config -l
credential.helper=osxkeychain  <--- ECCO IL PARAMETRO CHE VOGLIO TOGLIERE
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/tt-fb/tt-odoo-manual.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
user.email=flavio.bordoni@tt-group.it
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git push origin main
remote: Permission to tt-fb/tt-odoo-manual.git denied to flaviobordonidev.
fatal: unable to access 'https://github.com/tt-fb/tt-odoo-manual.git/': The requested URL returned error: 403
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git config --show-origin --get credential.helper
file:/Library/Developer/CommandLineTools/usr/share/git-core/gitconfig	osxkeychain
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ sudo nano /Library/Developer/CommandLineTools/usr/share/git-core/gitconfig
Password:
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git config -l
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/tt-fb/tt-odoo-manual.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
user.email=flavio.bordoni@tt-group.it
```


### Un altro modo

In my case it was easier to run:

```bash
$ git config --get-all --show-origin credential.helper
```

Which outputs the full list including config file paths:

```bash
file:/Library/Developer/CommandLineTools/usr/share/git-core/gitconfig   osxkeychain
file:/Users/yourname/.gitconfig !aws codecommit credential-helper $@
```

Then open the config file:

```bash
sudo vim /Library/Developer/CommandLineTools/usr/share/git-core/gitconfig
```

And comment out the line `credential.helper=osxkeychain`
