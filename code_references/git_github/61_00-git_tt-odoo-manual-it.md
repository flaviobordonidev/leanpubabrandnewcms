# <a name="top"></a> Cap git-github.11 - Implementiamo Git per TT-ODOO

---
---

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


---
---



Implementiamo git per **tt-odoo**.

> Per Rails possiamo **saltare** questo capitolo.

Cosa facciamo:
- abbiamo creato un nuovo account su github come nomeutente: "tt-fb" e email: "flavio.bordoni@tt-group.it" 
  (potevamo creare utente "tt-group" legato a email "it@tt-group.it")
- Ogni persona avrà una sua cartella locale che apre con Visual Studio Code e su questa cartella installa git che sarà collegato a github.
- FB, che è il primo a creare il progetto, inizia a lavorare in locale o poi fa un push.
- Gli altri sviluppatori, apriranno una cartella locale, installeranno git e faranno un pull per prendersi il lavoro già presente su github.
- Ogni sviluppatore si crea un suo branch in modo da evitare che si creino troppi conflitti tra push e pull. Quando è pronto a fare l'upload manderà una pull request.
- FB, o LSP che è l'altro amministratore, verificheranno la pull request ed eventualmente l'accetteranno facendo il merge sul main branch.



## Risorse interne

-[]()



## Risorse esterne

- [](https://www.cybrosys.com/blog/odoo-15-development-environment-using-pycharm-in-ubuntu-20-04)
- [](https://www.cybrosys.com/blog/how-to-install-odoo-16-on-ubuntu-2004-lts)



## Git init

Creiamo un repository locale. Il comando per farlo è `$ git init`.
Questo comando in pratica crea la cartella nascosta `.git` all'interno della cartella in cui siamo.

- Creiamo la nuova cartella `tt-odoo`, nel mio caso è `/Users/FB/tt-odoo`
- Entriamo nella cartella da terminale con `$ cd /Users/FB/tt-odoo`
  Una scorciatoia è iniziare a scrivere `$ cd ` e poi trascinare nel terminale la cartella per completare in automatico il percorso.
- Vediamo che non c'è nessun repository *.git* con `$ ls -a`
- Creiamo un nuovo repository locale con `$ git init`
- Vediamo che è stato creato con `$ ls -a`

```bash
$ cd /Users/FB/tt-odoo
$ ls -a
$ git init
$ ls -a
```

Esempio:

```bash
MacBook-Pro-di-Flavio:~ FB$ cd /Users/FB/tt-odoo-manual
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ pwd
/Users/FB/tt-odoo-manual
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ ls -a
.	..
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git init
Initialized empty Git repository in /Users/FB/tt-odoo-manual/.git/
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ 
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ ls -a 
.		..	.git
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ 
```

Se per caso ci sbagliamo e vogliamo tornare indietro, non esiste un comando *"git undo init"*, ma basta semplicemente eliminare la cartella nascosta `.git`.

```bash
$ rm -rf .git
```

> L'opzione `-rf` vuol dire *recursivelly* *folders*, quindi rimuovi tutte le cartelle ricorsivamente, quindi anche le sotto-cartelle.

> Can you reverse a git init?
> While there is no undo git init command, you can undo its effects by removing the . git/ folder from a project. You should only do this if you are confident in erasing the history of your repository that you have on your local machine.



## Vediamo la nuova repository locale di git

Vediamo la cartella nascosta del *repository locale* creato da git.

```bash
$ ls -a
```

Esempio:

```bash
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ ls -a 
.		..	.git
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ 
```

Se facciamo un `git status` vediamo i files che git è pronto ad archiviare.


## Implementiamo gitignore

[Per il "manuale" NON SERVE perché USIAMO tutti i files presenti nella cartella -- Nella installazione di odoo invece c'è già il file gitignore con tutte le voci...]

Creiamo il file per indicare a git quali files ignorare.
Per creare il file da terminale usiamo il comando `$ touch .gitignore`.

Per scrivere nel file possiamo aprirlo da interfaccia grafica.
See hidden files on Mac via Finder
- In Finder, open up your Macintosh HD folder.
- Press Command+Shift+Dot.
- Your hidden files will become visible. Repeat step 2 to hide them again!

Per il contenuto vediamo il `.gitignore` di **odoo** su github:

- [Github odoo: .gitignore](https://github.com/odoo/odoo/blob/16.0/.gitignore)

```bash
# sphinx build directories
_build/

# dotfiles
.*
!.gitignore
!.github
!.mailmap
# compiled python files
*.py[co]
__pycache__/
# setup.py egg_info
*.egg-info
# emacs backup files
*~
# hg stuff
*.orig
status
# odoo filestore
odoo/filestore
# maintenance migration scripts
odoo/addons/base/maintenance

# generated for windows installer?
install/win32/*.bat
install/win32/meta.py

# needed only when building for win32
setup/win32/static/less/
setup/win32/static/wkhtmltopdf/
setup/win32/static/postgresql*.exe

# js tooling
node_modules
jsconfig.json
tsconfig.json
package-lock.json
package.json
.husky

# various virtualenv
/bin/
/build/
/dist/
/include/
/lib/
/man/
/share/
/src/
```

Se adesso facciamo un `git status` vediamo che quei files non sono inclusi.



## Implementiamo readme

Specialmente per Github è utile inserire un file readme che spiega la nostra applicazione

Creiamo il file *readme* e aggiungiamo una breve descrizione.

```
$ touch README.md
$ echo "# Odoo Dev Manual
manuale dello sviluppatore di Odoo" > README.md
```

> Questo è un primo inizio poi lo scriveremo meglio in seguito.



## La prima archiviazione locale

Facendo la prima archiviazione nel *repository locale* verrà creato automaticamente anche il "ramo principale" (*main branch*).

Col comando `$ git branch` vediamo che non abbiamo "rami".

Aggiungiamo tutti i files sullo *stack di git** col comando `add` e poi archiviamo nel *repository locale* (la cartella nascosta *.git*) con il comando `commit`.

**Archiviamo su git**

```bash
$ git add -A
$ git commit -m "Prima archiviazione nel repository locale"
```

Col comando `$ git branch` vediamo che adesso abbiamo il ramo principale.

Esempio:

```bash
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git branch
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git add -A
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git commit -m "Prima archiviazione nel repository locale"
[master (root-commit) 5e088d2] Prima archiviazione nel repository locale
 1 file changed, 2 insertions(+)
 create mode 100644 README.md
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ git branch
* master
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ 
```



## Interfacciamoci con Github

Per parlare con Github, dove metteremo la *repository remota*, dobbiamo indicargli il nostro utente e la password.
queste info le possiamo archiviare localmente in modo che le usa in automatico.

Verifichiamo la configurazione globale di git che è utilizzata per i repository esterni quali Github, Heroku, Gitbuchet, ...

Per verificare le impostazioni di git eseguiamo

```bash
$ git config -l
```

Se serve modificarle globalmente:

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "your@email.com"
$ git config --global push.default matching
```

Se serve modificarle localmente:

```bash
$ git config user.name "Your Name"
$ git config user.email "your@email.com"
$ git config push.default matching
```

***To permanently cache the credentials***

```bash
$ git config --global credential.helper osxkeychain
```

> Nota: se sei su linux al posto di `osxkeychain` usa `store`.



## Aggiungiamo la nostra email a Github

- [](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)

Se abbiamo inserito una nuova email dobbiamo aggiungerla a Github.

1. In the upper-right corner of any page, click your profile photo, then click Settings.
2. In the "Access" section of the sidebar, click  Emails.
3. In "Add email address", type your email address and click Add.
4. Verify your email address. --> click Resend verification email. GitHub will send you an email with a link in it. After you click that link, you'll be taken to your GitHub dashboard and see a confirmation banner.
5. In the "Primary email address" dropdown menu, select the email address you'd like to associate with your web-based Git operations.




## Creiamo la repository remota su Github

Facciamo login su github.com e creiamo una nuova repository

…or push an existing repository from the command line

```bash
git remote add origin https://github.com/tt-fb/tt-odoo-manual.git
git branch -M main
git push -u origin main
```

Esempio:

```bash
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git config --global credential.helper osxkeychain
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git remote add origin git@github.com:flaviobordonidev/obs-ubuntudream.git
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git branch -M main
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git push -u origin main
The authenticity of host 'github.com (140.82.121.4)' cant be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,140.82.121.4' (ECDSA) to the list of known hosts.
Enumerating objects: 117, done.
Counting objects: 100% (117/117), done.
Delta compression using up to 8 threads
Compressing objects: 100% (113/113), done.
Writing objects: 100% (117/117), 2.76 MiB | 1.09 MiB/s, done.
Total 117 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), done.
To github.com:flaviobordonidev/obs-ubuntudream.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
```

Se facciamo un refresh sulla pagina web del nostro repository remoto su Github vediamo che si è popolato con tutti i nostri files di obsidian.

> Il backup è fatto ^_^!!!



## Futuri backups

Per altri backups bastano le seguenti 3 righe di codice:

```bash
$ git add -A
$ git commit -m "Prima archiviazione nel repository locale"
$ git push origin main
```

> [DAFA] verifichiamo se serve aggiungere il "fingerprint SHA256" ossia la **public_key**. </br>
> Ho fatto un'altro backup e sembra non essere necessaria. Al momento, Funziona tutto!



## Password authentication REMOVED

remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for 'https://github.com/tt-fb/tt-odoo-manual.git/'
MacBook-Pro-di-Flavio:tt-odoo-manual FB$ 
