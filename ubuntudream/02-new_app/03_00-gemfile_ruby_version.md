# <a name="top"></a> Cap 1.3 - Versione Ruby sul Gemfile



## Verifichiamo la versione di Ruby sul Gemfile

Verifichiamo che la versione di ruby scritta in automatico sul Gemfile coincida con quella che stiamo usando.
Questo è usato sia dal bundler che da Heroku.

verifichiamo la versione di ruby che stiamo usando

```shell
$ ruby -v
```

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ ruby -v
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [aarch64-linux]
```

Verifichiamo la versione di ruby *scritta sul gemfile*.

[Codice 01 - ..../Gemfile - linea: 3](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/03_01-gemfile.rb)

```ruby
ruby "3.3.0"
```

> Se ci fossero delle patches, la versione verrebbe riportata senza il numero di patch. Ad esempio: '3.1.1' e non '3.1.1p18'.

Ed una volta usato il *bundle install* l'installato viene registrato sul file: *Gemfile.lock*.

```shell
$ cd ~/ubuntudream
$ bundle install

$ bundle update
$ bundle install
```

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ pwd
/home/ubuntu/ubuntudream
ubuntu@ub22fla:~/ubuntudream$ bundle install
Bundle complete! 14 Gemfile dependencies, 82 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.

ubuntu@ub22fla:~/ubuntudream$ bundle update
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies...
Bundle updated!

ubuntu@ub22fla:~/ubuntudream$ bundle install
Bundle complete! 14 Gemfile dependencies, 82 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ub22fla:~/ubuntudream$ 
```

> Anche l'ambiente di produzione (Render o Heroku) da un warning se non trova la versione di ruby scritta nel Gemfile.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
