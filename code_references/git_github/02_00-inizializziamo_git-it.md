# <a name="top"></a> Cap git-github.2 - Implementiamo Git

Implementiamo git.



## Risorse interne

-[01-base-02-git-02-inizializziamo_git]()



## Risorse esterne

- [Gitignore - ignoring files](https://help.github.com/articles/ignoring-files)



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