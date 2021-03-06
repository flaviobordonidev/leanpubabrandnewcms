---
Facciamo un "pull request" su github per fare il merge e chiudere il branch.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ git checkout master
$ git pull origin master
$ git merge homepage
$ git push origin master
$ git branch -d homepage
$ git push origin :homepage
~~~~~~~~

