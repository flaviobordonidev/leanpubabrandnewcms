# <a name="top"></a> Cap git-github.2 - Implementiamo Git

Implementiamo git per OBSIDIAN

> Per Rails possiamo **saltare** questo capitolo.



## Risorse interne

-[]()



## Risorse esterne

- [How I Put My Mind Under Version Control](https://medium.com/analytics-vidhya/how-i-put-my-mind-under-version-control-24caea37b8a5)
- [Obsidian git plugin](https://github.com/denolehov/obsidian-git)

> Ho scelto di non usare il plugin perché è pensato per una sincronizzazione quindi oltre ai push fa anche un pull ogni volta che apro Obsidian. Io invece voglio fare solo dei backup e quindi fare solo dei push.</br>
> Per la sincronizzazione uso Dropbox. </br>
> Attenzione: su Dropbox deviniamo che la cartella Obsidian deve lavorare **"offline"** in modo da avere tutti i files disponibili per git.


## Git init

Per obsidian dobbiamo creare un repository locale.
Il comando per farlo è `$ git init`.
Questo comando in pratica crea la cartella nascosta `.git` all'interno della cartella in cui siamo.

Se per caso ci sbagliamo e vogliamo tornare indietro, non esiste un comando *"git undo init"*, ma basta semplicemente eliminare la cartella nascosta `.git`.

```bash
$ rm -rf .git
```

> L'opzione `-rf` vuol dire *recursivelly* *folders*, quindi rimuovi tutte le cartelle ricorsivamente, quindi anche le sotto-cartelle.

Can you reverse a git init?
While there is no undo git init command, you can undo its effects by removing the . git/ folder from a project. You should only do this if you are confident in erasing the history of your repository that you have on your local machine.

How do I delete a git repository init?
Steps to delete a local Git repo
- Open the the local Git repo's root folder.
- Delete all of the files and folder in the Git repo's root folder.
- Delete the hidden . git folder with File Explorer or through the command line.
- Run a git status command. A fatal: not a git repository error verifies that the Git repo is deleted.


## Inizializziamo per Obsidian

Siccome ho fatto un backup anche dei miei files di testo Obsidian, ho implementato github per avere il mio backup. In questo caso devo inizializare git.

> NON SERVE PER RAILS

***ENTRIAMO NELLA cartella del nostro VAULT di Obsidian***

> Non lo facciaomo dalla cartella principale dove sono i vari VAULTS, anche se spesso è solo uno.
> Questo perché è più pulito fare ogni singolo Vault ed il file *.gitignore* è più semplice.

```bash
$ git init
```

Esempio:

```bash
MacBook-Pro-di-Flavio:Obsidian FB$ pwd
/Users/FB/Dropbox/Obsidian
MacBook-Pro-di-Flavio:Obsidian FB$ ls
obs-ubuntudream
MacBook-Pro-di-Flavio:Obsidian FB$ cd obs-ubuntudream/
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ ls
Attachments	Journal		Notes		Templates
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ ls -a
.		..		.obsidian	Attachments	Journal		Notes		Templates
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git init
Initialized empty Git repository in /Users/FB/Dropbox/Obsidian/obs-ubuntudream/.git/
```



## Vediamo la nuova repository locale di git

Vediamo la cartella nascosta del *repository locale* creato da git.

```bash
$ ls -a
```

Esempio:

```bash
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ ls -a
.		..		.git		.obsidian	Attachments	Journal		Notes		Templates
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
```

Se facciamo un `git status` vediamo i files che git è pronto ad archiviare.
Alcuni di questi files però è meglio escluderli e questo lo facciamo nel prossimo paragrafo inserendo il file *.gitignore*.



## Implementiamo gitignore

Creiamo il file per indicare a git quali files ignorare.

***Codice 01 - .../.gitignore - linea:07***

```bash
# Ignore files that could cause issues across different workspaces.
.obsidian/cache
.trash/
.DS_Store
```

Per creare il file possiamo usare il comando `$ touch .gitignore`.

Per scrivere nel file possiamo aprirlo da interfaccia grafica.
See hidden files on Mac via Finder
- In Finder, open up your Macintosh HD folder.
- Press Command+Shift+Dot.
- Your hidden files will become visible. Repeat step 2 to hide them again!

Altrimenti possiamo usare il comando `echo` per infilargli dentro il testo in questo modo

```bash
$ echo "# Ignore files that could cause issues across different workspaces.
.obsidian/cache
.trash/
.DS_Store" > .gitignore
```

> Questo metodo non mi piace perché preferisco vedere il file aperto e poter tornare indietro nelle varie righe. Però è comodo perché non devo aprire il file su un editor di testo.

Se adesso facciamo un `git status` vediamo che quei files non sono inclusi.

> nota: If you work on a ZettelKasten with a team excluding the `.obsidian/workspace` file could also be a good idea as well as the `custom CSS` in the root directory if you have one.



## Implementiamo readme

Specialmente per Github è utile inserire un file readme che spiega la nostra applicazione

Creiamo il file *readme* e aggiungiamo una breve descrizione.

```
$ touch README.md
$ echo "# obs-ubuntudream
Backup dei files di ubuntudream su obsidian" > README.md
```




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
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git branch
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ ls
Attachments	Journal		Notes		Templates
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git branch
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git branch
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git add -A
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git commit -m "Prima archiviazione nel repository locale"
[master (root-commit) 50165f7] Prima archiviazione nel repository locale
 105 files changed, 17559 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 .obsidian/app.json
 create mode 100644 .obsidian/appearance.json
 create mode 100644 .obsidian/community-plugins.json
 create mode 100644 .obsidian/core-plugins-migration.json
 create mode 100644 .obsidian/core-plugins.json
 create mode 100644 .obsidian/graph.json
 create mode 100644 .obsidian/hotkeys.json
 create mode 100644 .obsidian/plugins/calendar/data.json
 create mode 100644 .obsidian/plugins/calendar/main.js
 create mode 100644 .obsidian/plugins/calendar/manifest.json
 create mode 100644 .obsidian/plugins/obsidian-admonition/main.js
 create mode 100644 .obsidian/plugins/obsidian-admonition/manifest.json
 create mode 100644 .obsidian/plugins/obsidian-admonition/styles.css
 create mode 100644 .obsidian/plugins/periodic-notes/data.json
 create mode 100644 .obsidian/plugins/periodic-notes/main.js
 create mode 100644 .obsidian/plugins/periodic-notes/manifest.json
 create mode 100644 .obsidian/plugins/periodic-notes/styles.css
 create mode 100644 .obsidian/plugins/recent-files-obsidian/data.json
 create mode 100644 .obsidian/plugins/recent-files-obsidian/main.js
 create mode 100644 .obsidian/plugins/recent-files-obsidian/manifest.json
 create mode 100644 .obsidian/plugins/recent-files-obsidian/styles.css
 create mode 100644 .obsidian/templates.json
 create mode 100644 .obsidian/themes/Minimal/manifest.json
 create mode 100644 .obsidian/themes/Minimal/theme.css
 create mode 100644 .obsidian/workspace.json
 create mode 100644 Attachments/Metodo Cornell potenziato - Sitema ADC.png
 create mode 100644 Journal/2023-01-01.md
 create mode 100644 Journal/2023-01-02.md
 create mode 100644 Notes/12 Abitudini che drenano le tue energie.md
 create mode 100644 Notes/3 uomini per un cannone.md
 create mode 100644 "Notes/Abbi l\342\200\231umilt\303\240 di chiedere consigli e farne tesoro.md"
 create mode 100644 Notes/Aereo caduto nella giungla.md
 create mode 100644 Notes/Affronta il mostro del tuo livello.md
 create mode 100644 Notes/Ambizione Saggia.md
 create mode 100644 Notes/Anna non so dire di no.md
 create mode 100644 Notes/Bravi si nasce o si diventa.md
 create mode 100644 Notes/Cavallo di Troia.md
 create mode 100644 Notes/Che cosa cambia le cose.md
 create mode 100644 Notes/Colori.md
 create mode 100644 Notes/Confini (Boundaries).md
 create mode 100644 Notes/Dissociazione - Vedersi fuori da se stessi.md
 create mode 100644 Notes/Guadagnare bene non sempre vuol dire spendere bene.md
 create mode 100644 Notes/I mostri Paura e Rabbia che spaventano ma sono di aiuto.md
 create mode 100644 Notes/I punti neri nella nostra vita.md
 create mode 100644 Notes/INTERESSANTE - Nelle carte delle emozioni.md
 create mode 100644 Notes/Il desiderio - Prof. universitaria Artista.md
 create mode 100644 Notes/Il giocatore di Hockey.md
 create mode 100644 "Notes/Il paradiso e l\342\200\231inferno sono dentro di te.md"
 create mode 100644 Notes/Il silicone bianco.md
 create mode 100644 "Notes/Il vantaggio dell\342\200\231emozione della Noia.md"
 create mode 100644 Notes/Incubi dopo Guerra Irak - figlio risolve con smartwatch.md
 create mode 100644 Notes/Inseguire il nostro sogno.md
 create mode 100644 Notes/Introspezione per riempire il vuoto.md
 create mode 100644 "Notes/La Giraffa del safari - L\342\200\231importanza dell\342\200\231emozione.md"
 create mode 100644 "Notes/La corruzione \303\250 creata dalla societ\303\240 - Cesto frutta marcia.md"
 create mode 100644 Notes/La cucina evolve.md
 create mode 100644 Notes/La dicotomia del controllo.md
 create mode 100644 Notes/La mia vita fra 10 anni.md
 create mode 100644 Notes/La paura bussa alla nostra porta.md
 create mode 100644 "Notes/La seconda volta sar\303\240 migliore.md"
 create mode 100644 Notes/La terra lavorata dal carcere.md
 create mode 100644 Notes/La vendetta non toglie il vuoto che hai dentro.md
 create mode 100644 Notes/Lamentarsi non aiuta.md
 create mode 100644 Notes/Le basi di una comunicazione efficace.md
 create mode 100644 "Notes/Nessun uomo \303\250 un isola - La storia della tartaruga.md"
 create mode 100644 Notes/Nessuno mi credeva - raccogliere lattine.md
 create mode 100644 Notes/Non si sentiva adulta - gli mancava qualcosa.md
 create mode 100644 Notes/Obsidian.md
 create mode 100644 Notes/Ognuno di noi ha la sua concezione delle emozioni.md
 create mode 100644 "Notes/PAURA dell\342\200\231ISOLAMENTO e maschera sociale.md"
 create mode 100644 Notes/Passione.md
 create mode 100644 "Notes/Perch\303\251 a volte non finiamo.md"
 create mode 100644 Notes/Post Traumatic Growth e vasi riparati con oro.md
 create mode 100644 "Notes/Quanto vale una moneta d\342\200\231oro in fondo all\342\200\231oceano.md"
 create mode 100644 Notes/Salasso e sigaretta - Rilassarsi facendosi del male.md
 create mode 100644 Notes/Sapere ascoltare.md
 create mode 100644 Notes/Sapere cosa vuoi.md
 create mode 100644 Notes/Scavare per loro.md
 create mode 100644 Notes/Se potessi dare un consiglio al tuo io del passato.md
 create mode 100644 Notes/Seguiamo gli impegni e non pensiamo a noi.md
 create mode 100644 Notes/Sono le esperienze che ci fanno felici e non tanto le cose materiali.md
 create mode 100644 "Notes/Storia dell\342\200\231autostada con le curve.md"
 create mode 100644 Notes/Trovare un piano alternativo.md
 create mode 100644 Notes/Una noiosa riunione di lavoro.md
 create mode 100644 Notes/Visualization - The life school coach.md
 create mode 100644 Notes/Visualizzazione sulle emozioni.md
 create mode 100644 Notes/YT-UD-003 - Le catene invisibili.md
 create mode 100644 Notes/YT-UD.md
 create mode 100644 Notes/Zettle-teoria.md
 create mode 100644 Notes/catena invisibile - rabbia.md
 create mode 100644 Notes/contribuire.md
 create mode 100644 Notes/dissociarsi.md
 create mode 100644 Notes/guadagni illeggitimi.md
 create mode 100644 Notes/il patto di ulisse.md
 create mode 100644 Notes/marrone.md
 create mode 100644 Notes/recently open files.md
 create mode 100644 Notes/visualizzazione.md
 create mode 100644 Templates/(default).md
 create mode 100644 Templates/daily_note.md
 create mode 100644 Templates/new_article.md
 create mode 100644 Templates/new_book.md
 create mode 100644 Templates/weekly_note.md
 create mode 100644 Templates/zettle_idea_template.md
 create mode 100644 Templates/zettle_moc_template.md
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ git branch
* master
MacBook-Pro-di-Flavio:obs-ubuntudream FB$ 
```




## Interfacciamoci con Github

Per parlare con Guthub, dove metteremo la *repository remota*, dobbiamo indicargli il nostro utente e la password.
queste info le possiamo archiviare localmente in modo che le usa in automatico.

***To permanently cache the credentials***

```bash
$ git config --global credential.helper osxkeychain
```

> Nota: se sei su linux al posto di `osxkeychain` usa `store`.





## Creiamo la repository remota su Github

Facciamo login su github.com e creiamo una nuova repository

…or push an existing repository from the command line

```bash
$ git remote add origin git@github.com:flaviobordonidev/obs-ubuntudream.git
$ git branch -M main
$ git push -u origin main
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
