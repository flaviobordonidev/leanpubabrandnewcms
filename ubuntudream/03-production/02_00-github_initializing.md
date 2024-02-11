# <a name="top"></a> Cap 2.2 - Inizializiamo Github

Creiamo il nostro repository remoto su GitHub.
Lo facciamo per due motivi:
- per avere un backup in cloud su GitHub
- per andare in produzione, perché l'app in produzione la ospitiamo su *render.com* e loro usano github come repository principale per prendere l'app e fare il "deployment" in prodozione.
Si può anche caricare da un'altra repository pubblica di Git ma con GitHub è più facile.



## Risorse esterne

- [How to use specific SSH keys for git push](https://medium.com/@michael.rhema/how-to-use-specific-ssh-keys-for-git-push-4ecf3b31eeb4)
- [How to specify different SSH keys for git push for a given domain](https://thucnc.medium.com/how-to-specify-different-ssh-keys-for-git-push-for-a-given-domain-bef56639dc02)



## Risorse interne

- [code_references/git_github/04_00-connect_github_to_ubuntu_multipass-it.md]()



## Capitolo di riferimento

I paragrafi seguenti si basano sui seguenti capitoloi:

1. [code_references/git_github/04_00-connect_github_to_ubuntu_multipass-it.md]()

> Le informazioni più aggiornate sono nei capitoli indicati qui sopra.
> I seguenti capitoli servono solo ad applicare le info generiche al caso specifico "ubuntudreams".



## Github connessione con ubuntu multipass (Condividiamo la chiave pubblica)

Per far comunicare Github con la nostra VM dobbiamo fargli condividere la chiave pubblica.

1. Creiamo la coppia di chiavi di crittatura sulla VM.
2. Associamo la chiave pubblica a Github.
3. Prepariamo il file `config` per assegnare la chiave creata

> Basta farlo una volta per ogni VM.
> Quindi se creiamo più applicazioni rails sulla stessa VM, serve solo la prima volta.


### 1. Creiamo la coppia di chiavi

```shell
$ cd ~/.ssh
$ ssh-keygen -t ed25519 -f ub22fla_github_fladev_key_ed25519 -C "fb"
# la "passphrase" la lascio vuota per evitare di metterla ogni volta che mando il "git push" verso github
```

### 2. Associamo la chiave pubblica

Facciamo login su Github.
**Github -> Settings -> SSH and GPG keys -> button "New SSH key"** e ci copiamo la chiave pubblica.

```bash
$ cat ~/.ssh/ub22fla_github_fladev_key_ed25519.pub
```

> Copiamo tutta la chiave pubblica, compreso **ssh-ed25519** iniziale e **fb** finale.


### 3. Il file ~/.ssh/config

Se il file `~/.ssh/config` non esiste lo creiamo con il comando:

```shell
$ touch ~/.ssh/config
```

Prepariamo la voce che usiamo per indicare a git di usare la chiave per il `git push` a github.

[Codice 01 - ~/.ssh/config - linea: 1](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/05_01-mockups-test_a.html.erb)

```shell
Host github-as-ub22fla
  HostName github.com
  User git
  IdentityFile ~/.ssh/ub22fla_github_fladev_key_ed25519
  IdentitiesOnly yes
```



## Github nuovo repository

Su Github creiamo un nuovo repository:

- nome        : ubuntudream
- descrizione : mia applicazione Rails

Aggiungiamo sul nostro git il repository remoto creato sul nostro account github "flaviobordonidev" usando SSH.

```shell
$ cd ~/ubuntudrean
$ git remote add origin git@github.com:flaviobordonidev/ubuntudream.git
$ git branch -M main
# il seguente comando è opzionale ed io non lo uso:
$ git push -u origin main
```

> Il comando `git remote` è per attivare il repository remoto su un server esterno (nel nostro caso github.com). Con `add origin` si dichiara che il nome di riferimento del repositroy remoto è `origin`.<br/>
> Il comando `branch -M main` imposta il branch principale con il nome `main`. <br/>
> (In passato era chiamata *master* ma è stato cambiato perché non era una parola "politically correct".)

L'ultimo comando `push -u origin main` imposta di default "*origin main*" e ci permette di eseguire successivamente anche il solo: `git push`.
Personalmente preferisco digitare il comando completo `git push origin main`.

ATTENZIONE!
Il `git remote add origin ...` che abbiamo impostato non usa la chiave di crittografia che abbiamo creato e quindi ci prende errore. (tende ad usare la chiave di default che normalmente è id_rsa)
Quindi adesso lo rimuoviamo e lo sostituiamo con quello che punta alla voce che abbiamo inserito in `~/.ssh/config`.

```shell
$ git remote rm origin
$ git remote add origin git@github-as-ub22fla:flaviobordonidev/ubuntudream.git
# il seguente comando è opzionale ed io non lo uso:
$ git push -u origin main
```

> Nel nuovo `git remote add ...` abbiamo sostituito l'host di github `github.com` con `github-as-ub22fla` che è la voce che abbiamo aggiunto nel file `~/.ssh/config`.



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
-> yes
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (main) $ git push origin main
The authenticity of host 'github.com (140.82.113.3)' can't be established.
ECDSA key fingerprint is SHA256:p2QBTSJIC4TMYWsIOttpUc79/T18VZWa6/GiwKbV8QN.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,140.82.113.3' (ECDSA) to the list of known hosts.
Counting objects: 112, done.
Compressing objects: 100% (95/95), done.
Writing objects: 100% (112/112), 25.64 KiB | 1009.00 KiB/s, done.
Total 112 (delta 10), reused 0 (delta 0)
remote: Resolving deltas: 100% (10/10), done.
To github.com:flaviobordonidev/bl7_0.git
 * [new branch]      main -> main
user_fb:~/environment/bl7_0 (main) $ 
```

> il comando *git push* sposta sul branch remoto *origin* il branch locale *main*.

Se adesso facciamo un refresh alla pagina di Github vedremo il nostro nuovo repository popolato con il codice della nostra app.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/02_fig01-github_ubuntudream_repository.png)


Possiamo usare questo backup con render.com per fare il deploy in produzione.

> Ricordiamoci che non è necessario avere un backup su Github per andare in produzione.
> Ma per andare in produzione con render.com, passare per GitHub ci semplifica la vita.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/01_00-git_main_branch-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
