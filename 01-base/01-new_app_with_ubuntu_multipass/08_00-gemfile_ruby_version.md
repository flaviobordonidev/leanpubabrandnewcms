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
ubuntu@ubuntufla:~$ ruby -v
ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x86_64-linux]
ubuntu@ubuntufla:~$ 
```

Verifichiamo la versione di ruby **scritta sul gemfile**.

***Codice 01 - .../Gemfile - line:4***

```ruby
ruby "3.1.1"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/08_01-gemfile.rb)

> La versione viene riportata senza il numero di patch ('3.1.1' e non '3.1.1p18').

Ed una volta usato il *bundle install* l'installato viene registrato sul file: ***Gemfile.lock***.

```bash
$ cd ~/bl7_0
$ bundle install

$ bundle update
$ bundle install
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0$ bundle install
Using rake 13.0.6
Using concurrent-ruby 1.1.9
Using i18n 1.10.0
Using minitest 5.15.0
Using tzinfo 2.0.4
Using activesupport 7.0.2.2
Using builder 3.2.4
Using erubi 1.10.0
Using racc 1.6.0
Using nokogiri 1.13.3 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.14.0
Using rails-html-sanitizer 1.4.2
Using actionview 7.0.2.2
Using rack 2.2.3
Using rack-test 1.1.0
Using actionpack 7.0.2.2
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.2.2
Using globalid 1.0.0
Using activejob 7.0.2.2
Using activemodel 7.0.2.2
Using activerecord 7.0.2.2
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.2.2
Using mail 2.7.1
Using digest 3.1.0
Using io-wait 0.2.1
Using timeout 0.2.0
Using net-protocol 0.1.2
Using strscan 3.0.1
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.2.2
Using actionmailer 7.0.2.2
Using actiontext 7.0.2.2
Using public_suffix 4.0.6
Using addressable 2.8.0
Using bindex 0.8.1
Using msgpack 1.4.5
Using bootsnap 1.10.3
Using bundler 2.3.7
Using matrix 0.4.2
Using regexp_parser 2.2.1
Using xpath 3.2.0
Using capybara 3.36.0
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.4.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.5.4
Using railties 7.0.2.2
Using importmap-rails 1.0.3
Using jbuilder 2.11.5
Using pg 1.3.3
Using puma 5.6.2
Using rails 7.0.2.2
Using rexml 3.2.5
Using rubyzip 2.3.2
Using selenium-webdriver 4.1.0
Using sprockets 4.0.3
Using sprockets-rails 3.4.2
Using stimulus-rails 1.0.4
Using turbo-rails 1.0.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 15 Gemfile dependencies, 74 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/bl7_0$ 
```

> Lo stesso Heroku che tratteremo più avanti da un warning se non trova la versione di ruby scritta nel Gemfile.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/08-pg_app_databases.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/01_00-git_story.md)
