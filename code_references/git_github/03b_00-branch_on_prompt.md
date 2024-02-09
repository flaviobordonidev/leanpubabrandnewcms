# <a name="top"></a> Cap git-github.3b - Aggiungiamo il "branch" nel prompt

Facciamo in modo che il branch sia presente anche nel prompt.
Aggiungiamo il "branch" nel prompt che al momento è `nome_utente@nome_pc:path$`
Ad esempio: `ubuntu@ub22fla:~/ubuntudream$`.


## Risorse interne

-[code_references/shell_linux/prompt]()
-[ubuntudream/03-production/]


## Aggiungiamo il "branch" nel prompt

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

