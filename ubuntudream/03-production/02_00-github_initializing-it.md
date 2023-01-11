# <a name="top"></a> Cap 2.2 - Inizializiamo Github

Creiamo il nostro repository remoto su GitHub.
Lo facciamo per due motivi:
- per avere un backup in cloud su GitHub
- per andare in produzione, perché l'app in produzione la ospitiamo su render.com e loro usano github come repository principale per prendere l'app e fare il "deployment" in prodozione.
Si può anche caricare da un'altra repository pubblica di Git ma con GitHub è più facile.



## Risorse interne

- [code_references/git_github/14_00-connect_github_to_ubuntu_multipass-it.md]()



## Logghiamoci su Github

Logghiamoci su Github.



## Github connessione con ubuntu multipass (Condividiamo la chiave pubblica)

Per far comunicare Github con la nostra VM *ubuntufla* dobbiamo fargli condividere la chiave pubblica.

Questo lo abbiamo già fatto per un'altra applicazione e siccome la macchina virtuale (VM) è la stessa non dobbiamo farlo di nuovo. 

> Vedi: [code_references/git_github/14_00-connect_github_to_ubuntu_multipass-it.md]()



## Github nuovo repository

Su Github creiamo un nuovo repository:

- nome        : ubuntudream
- descrizione : mia applicazione Rails

Aggiungiamo sul nostro git il repository remoto creato sul nostro account github "flaviobordonidev" usando SSH.

```bash
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

> Ricordiamoci che non è necessario avere un backup su Github per andare in produzione ma per andare in produzione con render.com, passare per GitHub ci semplifica la vita.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/01_00-git_main_branch-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
