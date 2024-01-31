# <a name="top"></a> Cap git-github.2 - Implementiamo Git

Implementiamo git.



## Risorse interne

-[01-base-02-git-02-inizializziamo_git]()


## Risorse esterne

- [Gitignore - ignoring files](https://help.github.com/articles/ignoring-files)


## Il primo comando git su mac

Nel sistema operativo mac "git" è "preinstallato" di default. Per "preinstallato" intendo che al primo comando che diamo, ad esempio `git status`, ci apparirà una finestra chiedendoci di installare il `command line development tool`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/02_fig01-git_command_requires_the_command_line_development_tool.png)



## Inizializziamo per tt-odoo-manual

La cartella la metto nei miei files dropbox così se cambio computer mi basta installare dropbox e mi ritrovo la cartella pronta. (senza doverla riprendere da Github)

  Creo la cartella `FlaMac/Users/FB/Dropbox/FB_projects/tt-odoo-manual`

Apro la cartella su terminale:
(Scorciatoia: scrivo `cd ` e poi trascino sul terminale la cartella)

```bash
$ cd /Users/FB/Dropbox/FB_projects/tt-odoo-manual
```

Apro una nuova finestra di Visual Studio Code (VS code) [`File -> New Windows`]
Apro la cartella su VS Code [`File -> Open Folder...`]
Da VS Code creo il nuovo file `README.md` dentro la cartella.

Vado su GitHub (https://github.com). Faccio login con l'utente "tt-fb".
Apro il nuovo repository "tt-odoo-manual"

Torno al terminale e seguo le indicazioni per inizializzare Git ed agganciarlo al repository su GitHub.

```bash
$ cd /Users/FB/Dropbox/FB_projects/tt-odoo-manual
$ ls -a
$ git init

$ git add -A
$ git commit -m "first commit"

# Impostiamo utente tt-fb come flavio.bordoni@tt-group.it
$ git config --global user.name "tt-fb"
$ git config --global user.email flavio.bordoni@tt-group.it
$ git commit --amend --reset-author
# Se si visualizza editor stile Vim uscire con ":q"
$ git status

# Continuiamo ad agganciare repository remoto GitHub
$ git branch -M main
$ git remote add origin https://github.com/tt-fb/tt-odoo-manual.git
$ git push -u origin main

# Implementare autorizzazione su GitHub
"immagine tt-fb" -> "Settings" -> 
```

Esempio:
```bash
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ cd /Users/FB/Dropbox/FB_projects/tt-odoo-manual
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ ls -a
.		..		README.md
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git init
Initialized empty Git repository in /Users/FB/Dropbox/FB_projects/tt-odoo-manual/.git/
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git add -A
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git commit -m "first commit"
[master (root-commit) 67cbea5] first commit
 Committer: Flavio Bordoni <FB@MacBook-Pro-di-Flavio.local>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 README.md
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git config --global user.name "tt-fb"
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git config --global user.email flavio.bordoni@tt-group.it
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git commit --amend --reset-author
[master 7d78dae] first commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 README.md
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git status
On branch master
nothing to commit, working tree clean
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git branch -M main
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git remote add origin https://github.com/tt-fb/tt-odoo-manual.git
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git push -u origin main
Username for 'https://github.com': tt-fb
Password for 'https://tt-fb@github.com': 
remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for 'https://github.com/tt-fb/tt-odoo-manual.git/'
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ 
```


https://github.com/tt-fb/tt-odoo-manual




## Inizializziamo per Obsidian

> vedi prossimo paragrafo: *git_obsidian*



## Inizializziamo per Rails

Se non è stato fatto, inizializiamo *git*.

> Attenzione: <br/>
> con ***Rails*** **non** serve inizializzare. Quando creaimo una nuova app è automaticamente inizializzato anche un *git* al suo interno.

Per vedere se è inizializzato vediamo se ci sono le cartelle nascoste di git, ed il file *.gitignore*

```bash
$ ls -a
```

> per rendere visibili i files nascosti su aws cloud9 dalla ruota dentata al lato del nome del workspace scegliendo dal menu a discesa la voce "show hidden files"

Un'altro modo per verificare se git è inizializzato è vedere se abbiamo i branches.

```bash
$ git branch
```

Esempio:

```bash
ubuntu@ubuntufla:~/instaclone (main)$git branch
* main
ubuntu@ubuntufla:~/instaclone (main)$
```

> Normalmente il nome del branch è anche visibile nel *prompt*. <br/>
> Nel nostro esempio siamo nel branch *main* che è anche l'unico presente.


Se effettivamente git **non è inizializzato** lo possiamo attivare con il seguente comando:

```bash
$ git init
```



## Verifichiamo configurazione globale 

Verifichiamo la configurazione globale di git che è utilizzata per i repository esterni quali Github, Heroku, Gitbuchet, ...

Per verificare le impostazioni di git eseguiamo

```bash
$ git config -l
```

Se serve modificarle

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "your@email.com"
$ git config --global push.default matching
```



## gitignore

Escludiamo da git quei files che non fanno parte del codice. Ad esempio i files temporanei o quelli di log o file di configurazione di 
pacchetti accessori [Gitignore - ignoring files](https://help.github.com/articles/ignoring-files).
Altri files che è importante escludere sono quelli riguardanti password/secrets. Ma questi ultimi li trattiamo nel prossimo capitolo che si 
intitola Figaro.

Cloud9 nel workspace rails inserisce un gitignore di default che al momento lasciamo così ma che modificheremo in seguito

***code 01 - .gitignore - line:01***

```bash
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
