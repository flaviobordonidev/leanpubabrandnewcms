# <a name="top"></a> Cap 5.3 - Inizializzazione di Github

Creiamo il nostro repository remoto su GitHub.


## Risorse interne

- [99-rails_references/git_github/github]



## Apriamo il branch

non serve perché è rimasto aperto dal capitolo precedente



## Github sign_up sign_in

Per prima cosa creiamoci un account su Github. Andiamo su www.github.com e clicchiamo "Sign up"

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig01-github_signup.png)

Se lo abbiamo già logghiamoci.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig02-github_signin.png)



## Github connessione con aws Cloud9

Inizializziamo GitHub che useremo principalmente come repositroy remoto di backup del codice.



## Condividiamo la chiave pubblica

Per far comunicare Github con aws Cloud9 dobbiamo fargli condividere la chiave pubblica.
Andiamo sul terminale di aws Cloud9 e visualizziamo e copiamoci la chiave pubblica (public key) di aws Cloud9.

```bash
$ cat ~/.ssh/id_rsa.pub
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (gh) $ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3...[...]...MmDRyKWg55 ubuntu@ip-172-56-27-218
user_fb:~/environment/bl7_0 (gh) $
```

Copiare tutta la chiave pubblica, compreso ***ssh-rsa***, e passarla su ***Github -> Settings -> SSH and GPG keys -> button "New SSH key"***

- Title : awsC9-bl7_0
- Key   : ssh-rsa AAAAB3...[...]...MmDRyKWg5 ec2-user@ip-172-56-27-218

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig03-github_ssh_public_key.png)



## Github nuovo repository

Su Github creiamo un nuovo repository:

- nome        : bl7_0
- descrizione : mia applicazione Rails

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig04-github_new_repository.png)

Appena creato il nuovo repository ci viene presentato un "Quick setup"

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig05-github_quick_setup.png)

Aggiungiamo sul nostro git il repository remoto "bl7_0.git" creato sul nostro account github "flaviobordonidev" usando SSH.

```bash
$ git remote add origin git@github.com:flaviobordonidev/bl7_0.git
$ git branch -M main
$ git push -u origin main
```

Se avessimo voluto usare HTTPS avremmo usato ***git remote add origin https://github.com/flaviobordonidev/bl7_0.git***

Il comando *git remote* è per attivare il repository remoto su un server esterno (nel nostro caso github.com).
con *add origin* si dichiara che il nome di riferimento del repositroy remoto è *origin* (potevamo chiamarlo github ma per convenzione storica la stessa Github ha scelto di chiamarlo *origin*).  

Il comando *branch -M main* imposta il branch principale con il nome ***main***. In passato era chiamata *master* ma è stato cambiato perché non era una parola "politically correct".

L'ultimo comando *push -u origin main* imposta di default "*origin main*" e ci permette di eseguire successivamente anche il solo: *git push*. Ma io preferisco lasciarlo esplicito, quindi l'ultima riga non la uso.

Prima di spostare il nostro git locale sul repository remoto Github dobbiamo chiudere il branch locale, tornare sul branch master ed effettuare il merge. 




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge gh
$ git branch -d gh
```




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

il comando *git push* sposta sul branch remoto *origin* il branch locale *main*.

Spostiamo in remoto anche la parte dei tag in cui abbiamo messo la versione v.0.1.0

```bash
$ git push origin main --tag
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (main) $ git push origin main --tag
Warning: Permanently added the ECDSA host key for IP address '140.82.114.3' to the list of known hosts.
Total 0 (delta 0), reused 0 (delta 0)
To github.com:flaviobordonidev/bl7_0.git
 * [new tag]         v0.1.0 -> v0.1.0
user_fb:~/environment/bl7_0 (main) $ 
```

Se adesso facciamo un refresh alla pagina di Github vedremo il nostro nuovo repository con la nostra myapp-01

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig06-github_repository_overview.png)

possiamo vedere tutti i nostri commits

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig07-github_commits.png)

ed i tags delle varie versioni

![fig08](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig08-github_tags.png)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/02-github_readme-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04-github-multi-users-it.md)
