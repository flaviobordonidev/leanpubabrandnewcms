# <a name="top"></a> Cap 1.8 - Versione Ruby sul Gemfile



## Verifichiamo la versione di Ruby sul Gemfile

Verifichiamo che la versione di ruby scritta in automatico sul Gemfile coincida con quella che stiamo usando.
Questo è usato sia dal bundler che da Heroku.

verifichiamo la versione di ruby che stiamo usando

```bash
$ ruby -v
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream $ruby -v
ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x86_64-linux]
```

Verifichiamo la versione di ruby **scritta sul gemfile**.

***Code 01 - .../Gemfile - line:4***

```ruby
ruby "3.1.1"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_01-gemfile.rb)

> La versione viene riportata senza il numero di patch ('3.1.1' e non '3.1.1p18').

Ed una volta usato il *bundle install* l'installato viene registrato sul file: ***Gemfile.lock***.

```bash
$ cd ~/ubuntudream
$ bundle install

$ bundle update
$ bundle install
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream $bundle install
Using rake 13.0.6
Using concurrent-ruby 1.1.10
Using i18n 1.12.0
Using minitest 5.16.3
Using tzinfo 2.0.5
Using activesupport 7.0.4
Using builder 3.2.4
Using erubi 1.11.0
Using racc 1.6.0
Using nokogiri 1.13.8 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.19.0
Using rails-html-sanitizer 1.4.3
Using actionview 7.0.4
Using rack 2.2.4
Using rack-test 2.0.2
Using actionpack 7.0.4
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.4
Using globalid 1.0.0
Using activejob 7.0.4
Using activemodel 7.0.4
Using activerecord 7.0.4
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.4
Using mail 2.7.1
Using digest 3.1.0
Using timeout 0.3.0
Using net-protocol 0.1.3
Using strscan 3.0.4
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.4
Using actionmailer 7.0.4
Using actiontext 7.0.4
Using public_suffix 5.0.0
Using addressable 2.8.1
Using bindex 0.8.1
Using msgpack 1.5.6
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.5.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.6.2
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.0
Using railties 7.0.4
Using importmap-rails 1.1.5
Using jbuilder 2.11.5
Using pg 1.4.3
Using puma 5.6.5
Using rails 7.0.4
Using redis 4.8.0
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.4.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using stimulus-rails 1.1.0
Using turbo-rails 1.1.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 16 Gemfile dependencies, 75 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/ubuntudream $
```

> Anche l'ambiente di produzione (Render o Heroku) da un warning se non trova la versione di ruby scritta nel Gemfile.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
