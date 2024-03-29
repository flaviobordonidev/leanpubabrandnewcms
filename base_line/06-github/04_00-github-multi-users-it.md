# <a name="top"></a> Cap 5.4 - Git and GitHub in ambiente multiutente

Nella vita di tutti i giorni, collaborando con più sviluppatori sulla stessa applicazione, le attività di Git e Gihub richiedono anche dei "pull" oltre i "push".
In questo capitolo approfondiamo l'uso di Git e Git.
Ai fini di questo tutorial questo capitolo si può saltare.



## Risorse web

- https://git-scm.com/book/en/v2/Git-Basics-Tagging
- http://stackoverflow.com/questions/7813194/how-do-i-edit-an-existing-tag-message-in-git
- https://allenan.com/git-branch-naming-conventions/
- http://www.pivotaltracker.com/help/gettingstarted
- http://nvie.com/posts/a-successful-git-branching-model/
- [Github Tutorial For Beginners - Github Basics for Mac or Windows & Source Control Basics](https://www.youtube.com/watch?v=0fKg7e37bQE)
- [GITHUB PULL REQUEST, Branching, Merging & Team Workflow](https://www.youtube.com/watch?v=oFYyTZwMyAg&list=PLoYCgNOIyGAB_8_iq1cL8MVeun7cB6eNc&index=10&feature=iv&src_vid=0fKg7e37bQE&annotation_id=annotation_3593094967)
- [Are git forks actually git clones?](http://stackoverflow.com/questions/6286571/are-git-forks-actually-git-clones)
- [git - the simple guide](http://rogerdudler.github.io/git-guide/)
- http://www.gitguys.com/topics/adding-and-removing-remote-branches/



## La routine giornaliera

Ogni volta che voglio contribuire ad un progetto che ho già clonato: entro nella directory del progetto; prendo le ultime modifiche da github con un "pull"; mi apro un branch diverso dal master e ci entro; lavoro un poco; faccio il mio "snapshot" sul mio git locale; chiudo lo "snapshot" con un commento scritto all'imperativo PRESENTE; verifico che le modifiche funzionano anche su heroku (opzionale); invio le mie nuove modifiche su github con un "push".

> $ git pull origin master
>
> $ git checkout -b my_branch_name
>
> $ git push origin my_branch_name
>
> ... faccio questo e quello... (lavoro un poco)
>
> $ git add -A
>
> $ git commit -m "fai questo e quello"
>
> $ git push heroku my_branch_name:master
>
> $ git push origin my_branch_name

Se non ho finito di completare la "story" del mio nuovo branch continuo: prendo le ultime modifiche da github con un "pull" dal nuovo ramo (branch_name); lavoro un poco; faccio il mio "snapshot" sul mio git locale; chiudo lo "snapshot" con un commento scritto all'imperativo PRESENTE; verifico che le modifiche funzionano anche su heroku (opzionale); invio le mie nuove modifiche su github con un "push".

> $ git pull origin my_branch_name
>
> ... faccio questo e quello... (lavoro un poco)
>
> $ git add -A
>
> $ git commit -m "fai questo e quello"
>
> $ git push heroku my_branch_name:master
>
> $ git push origin my_branch_name

Una volta finito con la "story" esco dal branch e richiedo su github un merge (Faccio una "pull request"). Una volta accordata procedo a fare il merge (oppure lo fa chi ne ha i diritti):

> $ git checkout master
>
> $ git merge my_branch_name
>
> $ git push origin master

Poi elimino il branch sia in locale che in remoto (su github)

> $ git branch -d my_branch_name
>
> $ git push origin :my_branch_name

Fine della mia routine.



## Visualizzazioni

Per vedere l'elenco dei tag (in questo caso solo uno) e per vedere l'elenco dei commit

> $ git tag
> 
> $ git log

Visualizzo la lista dei branches 

> git branches



## Gestione del Tag

eliminiamo il tag sul git locale.

$ git tag -d beginning

eliminiamo da web il tag su github. (Click su canvas -> releases -> tag "beginning" -> delete)

creiamo un nuovo tag

$ git tag v0.0.1

aggiorniamo github

$ git push --tag




## Github Workflow


https://github.com/Kunena/Kunena-Forum/wiki/Create-a-new-branch-with-git-and-manage-branches


xxx

https://git-scm.com/book/en/v2/GitHub-Contributing-to-a-Project

The GitHub Flow
GitHub is designed around a particular collaboration workflow, centered on Pull Requests. This flow works whether you’re collaborating with a tightly-knit team in a single shared repository, or a globally-distributed company or network of strangers contributing to a project through dozens of forks. It is centered on the Topic Branches workflow covered in Git Branching.

Here’s how it generally works:

Create a topic branch from master.

Make some commits to improve the project.

Push this branch to your GitHub project.

Open a Pull Request on GitHub.

Discuss, and optionally continue committing.

The project owner merges or closes the Pull Request.

This is basically the Integration Manager workflow covered in Integration-Manager Workflow, but instead of using email to communicate and review changes, teams use GitHub’s web based tools.

Let’s walk through an example of proposing a change to an open source project hosted on GitHub using this flow.

xxxx


Github sul mio git locale si chiama "origin"
Github può avere vari rami "banches", ma deve avere per lo meno un ramo: il ramo di default.
Il ramo di default si chiama "master" 

La giornata lavorativa di Bob e Fla seguiva questi semplici rituali:

Bob è quello che ha aperto il programma su github ed ha invitato Fla. Quindi è Bob che può integrare le modifiche (merge).


1. Fla entra nella cartella dell'applicazione e scaricare gli ultimi aggiornamenti da github

A> $ cd ~/Sites/romasportface
A> $ git pull origin master


2. E' la v0.1.0. Apre una nuova "story" per la "feature" "climb a mountain" ed aggiorna github

A> $ git checkout -b ft-climb_a_mountain-001
A>
A> $ git push origin ft-climb_a_mountain-001


3. lavora sulla "story" ed aggiorna github

A> $ git add -A
A>
A> $ git commit -m "one more drop of sweat"
A>
A> $ git push origin ft-climb_a_mountain-001


A> $ git add -A
A>
A> $ git commit -m "we are almost there"
A>
A> $ git push origin ft-climb_a_mountain-001


A> $ git add -A
A>
A> $ git commit -m "this story is done"
A>
A> $ git push origin ft-climb_a_mountain-001


4. Finita la "story" chiede a Bob se può integrarla sul programma.

Su github clicca il pulsante "New pull request". Questo in automatico manda un'email a Bob che vede le modifiche e manda un messaggio su Github di Tutto ok! Integriamola sul programma.


5. Bob aggiorna il branch, fa il merge ed aggiorna github

A> $ git pull origin ft-climb_a_mountain-001
A> 
A> $ git checkout master
A>
A> $ git merge --no-ff ft-climb_a_mountain-001
A>
A> $ git push origin master
A>
A> $ git tag v0.2.0
A>
A> $ git push --tag 






## Recuperare da un errore

Se si fanno errori si può ripristinare tutto all'ultimo commit con

A> $ git checkout -f

[...]
Tratto da https://www.railstutorial.org/book/beginning

If you’ve never used version control before, it may not be entirely clear at this point what good it does you, so let me give just one example. Suppose you’ve made some accidental changes, such as (D’oh!) deleting the critical app/controllers/ directory.

A> $ ls app/controllers/
A>
A>    application_controller.rb  concerns/
A>
A> $ rm -rf app/controllers/
A>
A> $ ls app/controllers/
A>    ls: app/controllers/: No such file or directory

Here we’re using the Unix ls command to list the contents of the app/controllers/ directory and the rm command to remove it (Table 1.1). The -rf flag means “recursive force”, which recursively removes all files, directories, subdirectories, and so on, without asking for explicit confirmation of each deletion.

Let’s check the status to see what changed:

A> $ git status
A> 
A> On branch master
A> 
A> Changed but not updated:
A> 
A>   (use "git add/rm <file>..." to update what will be committed)
A> 
A>   (use "git checkout -- <file>..." to discard changes in working directory)
A> 
A>       deleted:    app/controllers/application_controller.rb

no changes added to commit (use "git add" and/or "git commit -a")
We see here that a file has been deleted, but the changes are only on the “working tree”; they haven’t been committed yet. This means we can still undo the changes using the checkout command with the -f flag to force overwriting the current changes:

A> $ git checkout -f
A> 
A> $ git status
A> 
A> # On branch master
A> 
A> nothing to commit (working directory clean)
A> 
A> $ ls app/controllers/
A> 
A> application_controller.rb  concerns/
A> 
A> The missing files and directories are back. That’s a relief!

[...]








## Revert to a previous commit

Voglio tornare al commit "add back all javascripts files" mi basta vedere il suo id con la log e poi usare "git revert..."" e "git commit" vuoto per forzare.

A> $ git log

```
.
.
.

commit fc7244b7d7bca02754b952a2e3736e891121b8eb
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Thu Jan 21 22:26:03 2016 +0100

    add back all javascripts files

commit 39bf910363c4ad0b2eddf6f1dc20a83658f10646
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Thu Jan 21 22:22:02 2016 +0100

    add back bootstrap.css

commit 57ed0ce119902eccbb85113ae9d44ba211e3f985
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Thu Jan 21 22:17:24 2016 +0100

    rename style.scss because heroku fails

commit f23617aedb9c5c180d494e9093465e437fa0b44b
Author: Flavio Bordoni <flavio.bordoni.dev@gmail.com>
Date:   Thu Jan 21 22:13:37 2016 +0100
```

A> $ git revert --no-commit fc7244b7d7bca02754b952a2e3736e891121b8eb..HEAD
A>
A> $ git commit -m "revert to fc7244b..."


///


## Taglia i rami

Tagliare i rami in git è anche detto potare (to prune). Basta tornare sul ramo principale con (git checkout master) e chiamare il branch con il parametro "-d"

A> git checkout master
A>
A> git branch -d my_branch_name

Le potature fatte localmente non sono riportate anche in remoto.
Se si vuole potare anche sul repository remoto, nel nostro caso Github, si può fare direttamente dall'interfaccia web oppure con il comando:

A> git push origin :my_branch_name

I due punti ":" messi prima del nome del ramo indicano che si vuole tagliare il ramo. Una versione più descrittiva dello stesso identico comando è:

A> git push origin --delete my_branch_name



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/03_00-github_initializing-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_00-mockups_i18n-it.md)
