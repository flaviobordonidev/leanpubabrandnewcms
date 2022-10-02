# <a name="top"></a> Cap 2.2 - Inizializiamo Github

Creiamo il nostro repository remoto su GitHub.
Lo facciamo perché render.com ha github come repository principale per caricare la nostra app.
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
$ git remote add origin git@github.com:flaviobordonidev/instaclone.git
$ git branch -M main
$ git push origin main
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.


```bash
$ git push origin main
-> yes
```

Esempio:
 
```bash
ubuntu@ubuntufla:~/instaclone (main)$git branch
* main
ubuntu@ubuntufla:~/instaclone (main)$git remote add origin git@github.com:flaviobordonidev/instaclone.git
ubuntu@ubuntufla:~/instaclone (main)$git branch -M main
ubuntu@ubuntufla:~/instaclone (main)$git push origin main
Enumerating objects: 186, done.
Counting objects: 100% (186/186), done.
Compressing objects: 100% (170/170), done.
Writing objects: 100% (186/186), 842.69 KiB | 11.54 MiB/s, done.
Total 186 (delta 10), reused 0 (delta 0)
remote: Resolving deltas: 100% (10/10), done.
To github.com:flaviobordonidev/instaclone.git
 * [new branch]      main -> main
ubuntu@ubuntufla:~/instaclone (main)$
```

> il comando *git push* sposta sul branch remoto *origin* il branch locale *main*.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/01_00-git_main_branch-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
