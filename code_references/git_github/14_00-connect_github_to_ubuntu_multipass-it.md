# <a name="top"></a> Cap git_github.14 - Connettiamo GitHub a Ubuntu multipass

Connettiamo GitHub alla nostra VM locale: ubuntu multipass.

- GitHub = gestore di repositories remoti
- Ubuntu multipass = gestore dei repositories locali (le nostre applicazioni Rails)



## Risorse interne

- [01-base/05-github/03_00-github_initializing-it.md]()
- [ubuntudream/01b-production/02_00-github_initializing]()



## Github sign_up sign_in

Per prima cosa creiamoci un account su Github. Andiamo su www.github.com e clicchiamo "Sign up"

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig01-github_signup.png)

Se lo abbiamo già logghiamoci.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig02-github_signin.png)



## Github connessione con ubuntu multipass (Condividiamo la chiave pubblica)

Per far comunicare Github con la nostra VM *ubuntufla* dobbiamo fargli condividere la chiave pubblica.
Andiamo sul terminale della VM, visualizziamo e copiamo la chiave pubblica (public key).

```bash
$ cat ~/.ssh/id_rsa.pub
```

Esempio:
  
```bash
ubuntu@ubuntufla:~/bl7_0 (gh)$cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3...[...]...MmDRyKWg55 ubuntu@ip-172-56-27-218
ubuntu@ubuntufla:~/bl7_0 (gh)$
```

Copiare tutta la chiave pubblica, compreso ***ssh-rsa***, e passarla su ***Github -> Settings -> SSH and GPG keys -> button "New SSH key"***

- Title : ubuntufla-bl7_0
- Key   : ssh-rsa AAAAB3...[...]...MmDRyKWg5 ec2-user@ip-172-56-27-218

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_fig03-github_ssh_public_key.png)


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/02_00-github_readme-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04_00-github-multi-users-it.md)
