# <a name="top"></a> Cap git_github.04 - Connettiamo GitHub alla VM di Ubuntu multipass

Connettiamo GitHub alla nostra VM locale di multipass: `ub22fla`.

- GitHub = gestore di repositories remoti
- Ubuntu multipass = gestore dei repositories locali (le nostre applicazioni Rails)



## Risorse esterne

- [GitHub checking-for-existing-ssh-keys](https://help.github.com/en/articles/checking-for-existing-ssh-keys)
- [GitHub generating-a-new-ssh-key](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [How to Use Multiple SSH Keys For Different Git Accounts](https://theboreddev.com/use-multiple-ssh-keys-different-git-accounts/#google_vignette)
- [Specify an SSH key for git push for a given domain](https://stackoverflow.com/questions/7927750/specify-an-ssh-key-for-git-push-for-a-given-domain)

- [How to use specific SSH keys for git push](https://medium.com/@michael.rhema/how-to-use-specific-ssh-keys-for-git-push-4ecf3b31eeb4)
- [How to specify different SSH keys for git push for a given domain](https://thucnc.medium.com/how-to-specify-different-ssh-keys-for-git-push-for-a-given-domain-bef56639dc02)



## Risorse interne

- [ubuntudream/03-production/02_00-github_initializing]()
- [base/05-github/03_00-github_initializing-it.md]()
- [13-theme-angle-01-new_app_github_clone_fork-03-git_clone]()



## Come chiamare le chiavi di crittatura

Le possiamo chiamare come vogliamo ^_^.
A me piace chiamarle con la seguente struttura: `<pc_DA_dove_mi_collego>_<pc_A_cui_mi_collego>_key_<tipo_di_crittatura>`.
Esempi:
- flamac_github_fladev_key_ed25519 : chiave usata per fare `git push` dal mio MacBook Pro verso github (account fladev)
- ub22fla_github_fladev_key_ed25519 : chiave usata per fare `git push` dalla VM di multipass **ub22fla** verso github (account fladev)
- flamac_ub22fla_key_ed25519 : chiave usata per collegare vscode dal mio MacBook Pro verso la VM di multipass **ub22fla**



## Creiamo la coppia di chiavi di crittatura per collegarci

Se ci colleghiamo a Gihub dal mac le creiamo sul mac (ad esempio per obsidian).
Se ci colleghiamo a Gihub dalla VM multipass allora la creiaamo sulla VM multipass (ad esempio i progetti Rails).

Creiamo una nuova coppia di chiavi di crittatura (privata e pubblica).

> Le chiavi di crittatura sono mentenute per convenzione nella cartella nascosta `~/.ssh`

```shell
$ cd ~/.ssh
$ ssh-keygen -t ed25519 -f flamac_github_fladev_key_ed25519 -C "fb"
# la "passphrase" la lascio vuota per evitare di metterla ogni volta che mi collego con vscode
```

Se vogliamo successivamente inserire, cambiare o togliere la passfrase su una chiave usiamo `ssh-keygen -p ...`.

```shell
❯ cd ~/.ssh
❯ ssh-keygen -p -f flamac_github_fladev_key_ed25519
```

> per togliere la passphrase non inseriamo nulla e premiamo enter



## Il file ~/.ssh/config

Prepariamo il file `config` per assegnare la chiave creata.

Se il file `~/.ssh/config` non esiste lo creiamo con il comando:

```shell
$ touch ~/.ssh/config
```

Prepariamo la voce che usiamo per indicare a git di usare la chiave per il `git push` a github.

*** Codice 01 - ~/.ssh/config - linea: 1 ***

```shell
Host github-as-flamac
  HostName github.com
  User git
  IdentityFile ~/.ssh/flamac_github_fladev_key_ed25519
  IdentitiesOnly yes
```

---
ALTERNATIVA DA VERIFICARE:

```shell
Host github.com
  Hostname github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/flamac_github_fladev_key_ed25519
```
---



## Github sign_up sign_in

Creiamoci un account su Github. Andiamo su www.github.com e clicchiamo "Sign up"

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig01-github_signup.png)

Se lo abbiamo già logghiamoci.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig02-github_signin.png)



## Condividiamo la chiave pubblica con Github

Per far comunicare Github con la nostra VM *ubuntufla* dobbiamo fargli condividere la chiave pubblica.
Andiamo sul terminale della VM, visualizziamo e copiamo la chiave pubblica (public key).

```bash
$ cat ~/.ssh/flamac_github_fladev_key_ed25519.pub
```

Esempio:
  
```bash
ubuntu@ubuntufla:~/bl7_0 (gh)$cat ~/.ssh/flamac_github_fladev_key_ed25519.pub
ssh-rsa AAAAB3...[...]...MmDRyKWg55 ubuntu@ip-172-56-27-218
ubuntu@ubuntufla:~/bl7_0 (gh)$
```

Copiare tutta la chiave pubblica, compreso **ssh-ed25519** iniziale e **fb** finale, e passarla su **Github -> Settings -> SSH and GPG keys -> button "New SSH key"**.

- Title : ub22fla
- Key   : ssh-ed25519 AAAAC3...PExGh9R fb

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig03-github_ssh_public_key.png)

> Vecchio esempio di chiave con crittatura RSA: `ssh-rsa AAAAB3...[...]...MmDRyKWg5 ec2-user@ip-172-56-27-218`



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/02_00-github_readme-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04_00-github-multi-users-it.md)
