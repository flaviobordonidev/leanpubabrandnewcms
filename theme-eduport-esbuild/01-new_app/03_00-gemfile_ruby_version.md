# <a name="top"></a> Cap 1.8 - Versione Ruby sul Gemfile



## Verifichiamo la versione di Ruby sul Gemfile

Verifichiamo che la versione di ruby scritta in automatico sul Gemfile coincida con quella che stiamo usando.
Questo è usato sia dal bundler che dal repository esterno in produzione (Heroku, render.com, ...).

verifichiamo la versione di ruby che stiamo usando

```bash
$ ruby -v
```

Esempio:

```bash
ubuntu@ubuntufla:~/eduport_esbuild $ruby -v
ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x86_64-linux]
ubuntu@ubuntufla:~/eduport_esbuild $
```

Verifichiamo la versione di ruby **scritta sul gemfile**.

***Code 01 - .../Gemfile - line:4***

```ruby
ruby "3.1.1"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_01-gemfile.rb)

> La versione viene riportata senza il numero di patch ('3.1.1' e non '3.1.1p18').

> Anche l'ambiente di produzione (Render o Heroku) da un warning se non trova la versione di ruby scritta nel Gemfile.

Ed una volta usato il *bundle install* l'installato viene registrato sul file: ***Gemfile.lock***.

```bash
$ cd ~/ubuntudream
$ bundle install

$ bundle update
$ bundle install
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
