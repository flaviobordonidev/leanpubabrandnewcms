# <a name="top"></a> Cap git_github.3 - Connettiamo una repository

Connettiamo un'applicazione clonata da GitHub su un nuovo repository di GitHub.

L'applicazione clonata subirà delle variazioni e delle modifiche di cui vogliamo fare il backup in una differente repository di GitHub.



## Risorse interne

- []()



## Risorse esterne

- [Difference between Git Clone and Git Fork](https://www.toolsqa.com/git/difference-between-git-clone-and-git-fork/)

- [Forking in GitHub](https://www.toolsqa.com/git/git-fork/)

- [Cloning in GitHub](https://www.toolsqa.com/git/git-clone/)



## Difference between Git Clone and Git Fork

Since first you need to fork before cloning, although forking does not come as a strict pre-step for cloning. People of an organization working on a repository do not generally fork the repository. We have created this tutorial just to focus on the difference and make you clear about these two concepts viz. Git Cloning and Git Forking. This tutorial will help you understand:

- Difference between cloning and forking
- Workflow of forking and cloning on GitHub
- Why cloning and forking are used interchangeably?



## What are the major differences between Forking and Cloning?

To clear out the air from your mind, if you have any, let see how these two terms differ:

Forking is done on the GitHub Account while Cloning is done using Git. **When you fork a repository, you create a copy of the original repository (upstream repository) but the repository remains on your GitHub account. Whereas, when you clone a repository, the repository is copied on to your local machine with the help of Git.**

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig01-clone_or_fork.png)

Changes made to the forked repository can be merged with the original repository via a `pull request`. Pull request knocks the repository owner and tells that **"I have made some changes, please merge these changes to your repository if you like it".** On the other hand, changes made on the local machine (cloned repository) can be pushed to the upstream repository directly. For this, the user must have the write access to the repository otherwise this is not possible. If the user does not have write access, the only way to go is through the forked request. So in that case, the changes made in the cloned repository are first pushed to the forked repository and then a pull request is created. It is a better option to fork before clone if the user is not declared as a contributor and it is a third-party repository (not of the organization).

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig02-clone_push_or_fork_pull.png)

Forking is a concept while cloning is a process. Forking is just containing a separate copy of the repository and there is no command involved. Cloning is done through the command 'git clone' and it is a process of receiving all the code files to the local machine.



## Cloning a Git Repo without Fork


Cloning is a three steps process:

Step 1: Clone a Repository: The user starts from the upstream repository on GitHub. Since the user navigated to the repository because he/she is interested in the concept and they like to contribute. This process starts from cloning when they clone the repository it into their local machine. Now they have the exact copy of the project files on their system to make the changes.

Step 2: Make the desired changes: After cloning, contributors provide their contribution to the repository. Contribution in the form of editing the source files resulting in either a bug fix or adding functionality or maybe optimizing the code. In this step, a contributor can apply a single commit or multiple commits to the repository. But the bottom line is, everything happens on their local system.

Step 3: Pushing the Changes: Once the changes or commits are done and now the modifications can be pushed to the upstream repository. *

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig03-only_clone.png)



## Cloning a Git Repo after Forking

Forking a Repository is a five steps process but three steps are exactly the same as cloning. Only the first and the last forking step differs from cloning.

Step 1: Fork a Repository: Again the user starts from the upstream repository on GitHub but this process starts from forking when they fork a repository to their own GitHub account.

Step 2: Clone a Repository: Same as cloning.

Step 3: Make the desired changes: Same as cloning.

Step 4: Pushing the Changes: Same as cloning.

Step 5: Send changes to Original Repository: This process is called Pull Request in Git. At this step, the user sends the changes to the owner of the repository as a request to merge the changes to the main central repository.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig04-clone_and_fork.png)



## Is Cloning a part of Forking?

Now when you have an idea on the Difference between Git Clone and Git Fork, a good question if you are wondering about is cloning a part of forking?

Fork in the pre-git era was cloning the software or anything that the user wants a personal copy of. If I fork a document, let say this post only, I will have the same document on my account i.e. I will have a copy of this document. I can now use it, edit it modify it and if I want, I can send it back to the owner with some modification.

Then came GitHub. GitHub, like every other open-source, had a concept of the fork. Now, focus on the word concept that I have used to describe fork in GitHub. Forking in GitHub would create the same effect as other open-source platforms but the user was not able to edit the code. For this, they explicitly defined a command called git clone to clone the repository to work on it.

So, forking is a concept while cloning is a command in Git. Forking just acts as a middleman between the user and the upstream repository. Therefore, if you visit any other open-source community, you would find forking and cloning as the same concept, and people using that in an interchangeable way in the community.



## Fork the Render example

Per vedere come andare in produzione con render iniziamo usando il loro esempio.

Facendo un fork lo cloniamo dal loro repository su github al nostro repository su github.


![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig05-create_a_new_fork.png)


![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig06-new_fork_name.png)



## Clone the Render example

Adesso che è nel nostro repository facciamo un clone.
Avremmo potuto anche fare subito il clone ma per mantenere un backup su github avremmo dovuto creare un nuovo repository su github e poi aggangiarlo. Facendo il fork abbiamo già pronto il nostro repository su github.

Prendiamo il percorso del nostro repository (quello creato con il fork).

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/git_github/13_fig07-github_ssh_path.png)


Mettiamoci sulla root della nostra macchina virtuale e Cloniamo il nostro repository localmente sul nostro pc.

```bash
$ cd ..
$ git clone git@github.com:flaviobordonidev/render-eg.git
```

Then, change into the project's directory, by typing:

```bash
$ cd render-eg
```

Indichiamo l'uso di ruby 3.1

***code 01 - .../Gemfile - line:3***

```ruby
  ruby '3.1.1'
```

And set up the project.

```bash
$ bundle install
$ rails db:setup
```

You should now have everything set up to be able to run queries in the Rails console.




