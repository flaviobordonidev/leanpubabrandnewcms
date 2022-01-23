# <a name="top"></a> Cap 1.8 - Più spazio disco su sessione c9

Lo spazio disco allocato inizialmente è poco per avere un ambiente di sviluppo locale Rails.
Quindi lo aumentiamo.



## Risorse interne

- [99-rails_references / 015-aws_cloud9 / 03-running_out_of_space]()
- [99-rails_references / 015-aws_cloud9 / 04-disk_resize](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-rails_references/0-Generic/015-aws_cloud9/04-disk_resize.md)



## Risorse esterne

- [Amazon: environment size](https://docs.aws.amazon.com/cloud9/latest/user-guide/move-environment.html#move-environment-resize)



## Errore di spazio disco

Dall'interfaccia aws cloud9 riceviamo il messaggio di avviso che stiamo per terminare lo spazio disponibile.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/09_fig01-aws_c9_running_out_of_space.png)








```bash
$ ruby -v
```

Esempio:

```bash
user_fb:~/environment $ ruby -v
ruby 3.1.0p0 (2021-12-25 revision fb4df44d16) [x86_64-linux]
user_fb:~/environment $ 
```

Verifichiamo la versione di ruby **scritta sul gemfile**.

***Codice 01 - .../Gemfile - line: 4***

```ruby
ruby "3.1.0"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08_01-gemfile.rb)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08-gemfile_ruby_version)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/01-git_story.md)
