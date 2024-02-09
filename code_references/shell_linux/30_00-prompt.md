# <a name="top"></a> Cap git-github.3b - Il prompt della shell



## Risorse interne

-[code_references/shell_linux/prompt]()



## Risorse esterne

- [How to add git branch name to shell prompt in Ubuntu](https://dev.to/sonyarianto/how-to-add-git-branch-name-to-shell-prompt-in-ubuntu-1gdj)
- [Add Git Branch Name to Terminal Prompt (Linux/Mac)](https://gist.github.com/joseluisq/1e96c54fa4e1e5647940)
- []()



## Spieghiamo cos'è il prompt

Il prompt è la parte iniziale della shell prima del puntatore. In genere è `nome_utente@nome_pc:path$`
Ad esempio: `ubuntu@ub22fla:~/ubuntudream$`.

Possiamo visualizzare come è costruita con il comando:

```shell
$ echo $PS1
```

> $PS1 is the enviroment variable that store the default prompt setting we see every time when we log in the console.


Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ echo $PS1
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$
```



## Vediamo come modificare il prompt

Per modificare il prompt si lavora sulla struttura presentata in `$PS1`.

Vediamo come è strutturata:
...
...
...



### Facciamo dei cambi non permanenti

Se vogliamo provare a fare dei cambi al prompt senza che siano memorizzati possiamo eseguire `export PS1=...` direttamente sul terminale.
Questo ci permette di resettare e ripartire se facciamo errori.

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$(git_branch)\$"
ubuntu@ub22fla:~/ubuntudream-main$
```



## Aggiungiamo il "branch" nel prompt

Aggiungiamo il "branch" nel prompt 

Apriamo il file `~/.bashrc`

```shell
$ nano ~/.bashrc
```

Aggiungiamo le seguenti linee di codice in fondo al file.

*** Codice 01 - ~/.bashrc - linea : 122 ***

```shell
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[00;32m\]\$(git_branch)\[\033[00m\]\$"
```

> Creiamo la funzione `git_branch()`
> E la sggiungiamo alla fine della variabile `$PS1`.

Now save the file ~/.bashrc and run this command to reflect the changes.

```shell
source ~/.bashrc
```

> Or you can close the terminal and re-open again to reflect the changes.

