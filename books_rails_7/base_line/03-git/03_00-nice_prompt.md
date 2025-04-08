# <a name="top"></a> Cap 2.3 - Abbelliamo il prompt

Visualizziamo il branch direttamente nel nostro prompt del terminale.



## Risorse esterne

- [How to add git branch name to shell prompt in Ubuntu](https://dev.to/sonyarianto/how-to-add-git-branch-name-to-shell-prompt-in-ubuntu-1gdj)


When I work in a git repository directory that has many branches, I want to know which branch I am currently in on my shell prompt. Below is the sample output result.

Before my shell prompt is like this. Note suppose I am on folder `~/general/repos/playground` with the following prompt: `sony@ubuntu:~/general/repos/playground$`.

We will create like this.

```bash
sony@ubuntu:~/general/repos/playground (master)$
```

On above example, I am on my playground git repository directory and it display the branch name *master*. It means I am on master branch now.

Today I will share how to create it.

Scenario
I want to add git branch name to my shell prompt when I am in a project repository directory. I am using Ubuntu, so the default shell is bash.

Step-by-step to go there

Step 1. Go to your shell prompt first.

Step 2. We have to know the current prompt setting, type like below.

```bash
echo $PS1
```

$PS1 is the enviroment variable that store the default prompt setting we see every time when we log in the console.

On mine, the setting is like below.

```bash
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$
```

Step 3. Open file ~/.bashrc

```bash
vi ~/.bashrc
```

Step 4. Add this function on the bottom of your `~/.bashrc` file.

```bash
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
```

Step 5. Add this on the bottom of your `~/.bashrc` file. Add the git_branch function on the shell prompt, by adding it on PS1 variable. Sample like below (that based on my $PS1 output above).

```bash
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$(git_branch)\$ "
```

> Attenzione! la prima parte dopo `PS1="` è quella che hai visualizzato con `echo $PS1`.

Step 6. You are done. Now save the file `~/.bashrc` and run this command to reflect the changes.

```bash
source ~/.bashrc
```

Or you can close the terminal and re-open again to reflect the changes.

Now on my shell prompt will display like below.

```bash
sony@ubuntu:~/general/repos/playground (master)$
```

Add color to make it better

This is just additional cosmetics things. I will make the branch indicator (master) to green for foreground color. Add this `\[\033[00;32m\]\$(git_branch)\[\033[00m\]` to **your** PS1 variable. 
On **mine** is like below.

```bash
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "
```

> Attenzione! la prima parte dopo `PS1="` è quella che hai visualizzato con `echo $PS1`.

That's it.


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/02_00-inizializziamo_git.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/04_00-daily_routine.md)
