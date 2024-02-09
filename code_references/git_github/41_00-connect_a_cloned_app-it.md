# <a name="top"></a> Cap git_github.3 - Connettiamo una repository

Connettiamo un'applicazione clonata da GitHub su un nuovo repository di GitHub.

L'applicazione clonata subirà delle variazioni e delle modifiche di cui vogliamo fare il backup in una differente repository di GitHub.



## Risorse interne

- [13-theme-angle/01-new_app_github_clone_fork/03_00-git_clone-it.md]()



## Risorse esterne

- [connecting-to-github-with-ssh](https://help.github.com/articles/connecting-to-github-with-ssh/)



## Clone una repository nella nostra app locale

Clone the repository on your machine using the following command.

```bash
$ git clone git@github.com:mixandgo/prorb_db_queries.git
```

Then, change into the project's directory, by typing:

```bash
$ cd prorb_db_queries
```

And set up the project.

```bash
$ bundle install
$ rails db:setup
```

You should now have everything set up to be able to run queries in the Rails console.
