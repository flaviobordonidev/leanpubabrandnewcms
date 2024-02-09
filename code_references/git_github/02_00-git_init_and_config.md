# <a name="top"></a> Cap git-github.2 - Implementiamo Git

Implementiamo git.



## Risorse interne

-[01-base-02-git-02-inizializziamo_git]()



## Risorse esterne

- [Gitignore - ignoring files](https://help.github.com/articles/ignoring-files)
- [How to disable osxkeychain as credential helper in git config?](https://stackoverflow.com/questions/16052602/how-to-disable-osxkeychain-as-credential-helper-in-git-config)



## Il primo comando git su mac

Nel sistema operativo mac "git" è "preinstallato" di default. Per "preinstallato" intendo che al primo comando che diamo, ad esempio `git status`, ci apparirà una finestra chiedendoci di installare il `command line development tool`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/02_fig01-git_command_requires_the_command_line_development_tool.png)



## Inizializziamo git

Se non è stato fatto, inizializiamo *git*.

- [Rails: continua qui sotto]()
- [Obsidian: vai a 60_00-git_obsidian-it]()
- [tt-odoo-manual: vai a 61_00-git_tt-odoo-manual-it]()

> Attenzione: <br/>
> Per **Rails non** serve inizializzare. Quando creaimo una nuova app è automaticamente inizializzato anche un *git* al suo interno.

Per vedere se è inizializzato vediamo se ci sono le cartelle nascoste di git, ed il file *.gitignore*

```shell
$ ls -a
```

> per rendere visibili i files nascosti su mac usare *SHIFT+.*.

Un'altro modo per verificare se git è inizializzato è vedere se abbiamo i branches.

```shell
$ git branch
```

Esempio:

```shell
ubuntu@ubuntufla:~/instaclone (main)$git branch
* main
```

> Nel nostro esempio siamo nel branch *main* che è anche l'unico presente.


Se effettivamente git **non è inizializzato** lo possiamo attivare con il seguente comando:

```shell
$ git init
```



## Verifichiamo la configurazione globale 

Ci sono divesi files di configurazione e **non** uno solo!!!!
Verifichiamo la configurazione globale di git che è utilizzata per i repository esterni quali Github, Heroku, Gitbuchet, ...

Per verificare le impostazioni di git eseguiamo:

```shell
$ git config -l
```

Se serve modificarle

```shell
$ git config --global user.name "Your Name"
$ git config --global user.email "your@email.com"
$ git config --global push.default matching
```



## I vari files di configurazione di git

Ci sono 3 files più usati... 

```shell
$ git config --local --edit
$ git config --global --edit
$ sudo git config --system --edit
```

> The last one may not work if you don't have proper permissions. So you may need to run the last one under sudo for it to work correctly. 

...ma ci possono essere anche dei parametri che sono impostati su altri files "gitconfig".

Ad esempio con:

```shell
$ git config -l
```

possiamo visualizzare un parametro che non troviamo nei 3 files di default. Se dovesse succedere possiamo andare alla caccia del file "gitconfig" che lo contiene con il comando:

```shell
$ git config --show-origin --get <nome_parametro>
```

Nel prossimo paaragrafo vediamo questa ricerca messa in atto per trovare dove era configurato il parametro "credential.helper".



## TROVIAMO e TOGLIAMO il credential.helper

Questa impostazione è utile se hai un solo utente/email che si collega a github perché prende le impostazioni dal file di archiviazione delle password del tuo sistema operativo. Nel nostro caso da Mac OSX:

```shell
credential.helper=osxkeychain
```

Però diventa un problema se vogliamo aggiungere un utente differente perché viene sempre preso il primo.
Per gestire l'altro utente ho dovuto cancellare questa opzione e non è stato facile trovarla perché era su un file di configurazione di git particolarmente nascosto. 

Inizialmente ho provato con i 3 files più usati:

```shell
$ git config --local credential.helper
$ git config --global credential.helper
$ git config --system credential.helper
```

> Se non trovano nulla il comando non da nessuna risposta. Se invece lo trova allora è mostrato.

The first one checks the local repo config, the second is your ~/.gitconfig, and the third is based on where git is installed. Depending on which one comes back showing the credential helper, you can try using the equivalent --unset option:

```shell
git config --local --unset credential.helper
git config --global --unset credential.helper
git config --system --unset credential.helper
```

> The last one may not work if you don't have proper permissions. So you may need to run the last one under sudo for it to work correctly. 


Infine, l'ho trovato con il comando:

```shell
$ git config --show-origin --get credential.helper
```

E poi l'ho editato direttamente usando le autorizzazioni di super user (sudo):

```shell
$ sudo nano /Library/Developer/CommandLineTools/usr/share/git-core/gitconfig
```

Ho cancellato le righe che lo chiamavano e finalmente me ne sono liberato ^_^.


```shell
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

```shell
$ git config --get-all --show-origin credential.helper
```

Which outputs the full list including config file paths:

```shell
file:/Library/Developer/CommandLineTools/usr/share/git-core/gitconfig   osxkeychain
file:/Users/yourname/.gitconfig !aws codecommit credential-helper $@
```

Then open the config file:

```shell
sudo vim /Library/Developer/CommandLineTools/usr/share/git-core/gitconfig
```

And comment out the line `credential.helper=osxkeychain`







## gitignore

Escludiamo da git quei files che non fanno parte del codice. Ad esempio i files temporanei o quelli di log o file di configurazione di 
pacchetti accessori [Gitignore - ignoring files](https://help.github.com/articles/ignoring-files).
Altri files che è importante escludere sono quelli riguardanti password/secrets. Ma questi ultimi li trattiamo nel prossimo capitolo che si 
intitola Figaro.

Cloud9 nel workspace rails inserisce un gitignore di default che al momento lasciamo così ma che modificheremo in seguito

***code 01 - .gitignore - line:01***

```shell
# See https://help.github.com/articles/ignoring-files for more about ignoring files.
#
# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile '~/.gitignore_global'

# Ignore bundler config.
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-journal

# Ignore all logfiles and tempfiles.
/log/*
!/log/.keep
/tmp
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/01-overview-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/03_00-git-ssh-keys-it.md)
