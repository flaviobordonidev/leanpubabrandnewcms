# <a name="top"></a> Cap 4.2 - Andiamo in produzione su Heroku

Pubblichiamo la nostra applicazionie sull'ambiente di produzione Heroku.

Andiamo subito in produzione così risolviamo di volta in volta gli eventuali problemi che si presentano senza essere costretti a fare un troubleshooting su tutto l'applicativo.



## Risorse interne:

- 99-rails_references/Heroku/



## Risorse esterne:

- [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
- [Heroku MFA - Multi Factor Access](https://help.heroku.com/AVOHZTFH/heroku-cli-login-interactive-option-no-longer-supported-with-salesforce-mfa)
- [Heroku API_KEY](https://help.heroku.com/PBGP6IDE/how-should-i-generate-an-api-key-that-allows-me-to-use-the-heroku-platform-api)
- [Solve ip-address-mismatch on signing](https://stackoverflow.com/questions/63363085/ip-address-mismatch-on-signing-into-heroku-cli)

 

## Verifichiamo dove eravamo rimasti

Vediamo dove eravamo rimasti con la programmazione.

```bash
$ git status
$ git log
```

Esempio:

```bash
user_fb:~/environment $ cd bl7_0/
user_fb:~/environment/bl7_0 (main) $ git status
On branch main
nothing to commit, working tree clean
user_fb:~/environment/bl7_0 (main) $ git log
commit 92f76c76c69a9ffd3381c34bdca46ba184b3c802 (HEAD -> main)
Author: Flavio Bordoni Dev <flavio.bordoni.dev@gmail.com>
Date:   Thu Jan 20 22:43:39 2022 +0000

    implement mockups

commit d64bcf1dfc29ecacc5652754eae6a40b1ad5b579 (tag: v0.1.0)
Author: Flavio Bordoni Dev <flavio.bordoni.dev@gmail.com>
Date:   Tue Jan 18 14:37:49 2022 +0000

    new rails app
user_fb:~/environment/bl7_0 (main) $ 
```

Siamo sul branch principale ed abbiamo già inviato tutto il codice su git con il commit *implement mockups*.



## Apriamo il branch "Pubblichiamo in Produzione"

Siamo pronti ad inserire nuovo codice e lo facciamo su un nuovo ramo (branch) di git.

```bash
$ git checkout -b pp
```



## Verifichiamo se abbiamo Heroku installato su aws Cloud9  

```bash
$ heroku --version
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (pp)$heroku --version

Command 'heroku' not found, but can be installed with:

sudo snap install heroku

ubuntu@ubuntufla:~/bl7_0 (pp)$
```

Nel nostro caso non è installato.



## Creiamoci un account Heroku  

Per prima cosa creiamoci un account su **www.heroku.com**.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/02_fig01-heroku_signup.png)



## Installiamo Heroku CLI

Come abbiamo già fatto per PostgreSQL, anche Heroku lo installiamo sulla cartella principale di aws Cloud9: **/environment**.

Assicuriamoci di essere sulla cartella principale

```bash
$ cd ~/
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (pp)$cd ~/
ubuntu@ubuntufla:~ $
```

Per installare Heroku dobbiamo scaricare ed installare la "heroku CLI" (ex heroku-toolbelt).
Seguendo le indicazioni di [Heroku](https://devcenter.heroku.com/articles/heroku-cli) il comando che dobbiamo usare da aws cloud9, che è un "docker container" è questo:

```bash
$ sudo su -
-> curl https://cli-assets.heroku.com/install.sh | sh
-> exit
```

Esempio:

```bash
ubuntu@ubuntufla:~ $sudo su -
root@ubuntufla:~# curl https://cli-assets.heroku.com/install.sh | sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1894  100  1894    0     0   7576      0 --:--:-- --:--:-- --:--:--  7576
Installing CLI from https://cli-assets.heroku.com/heroku-linux-x64.tar.xz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 18.7M  100 18.7M    0     0  4867k      0  0:00:03  0:00:03 --:--:-- 4866k
v12.21.0
heroku installed to /usr/local/bin/heroku
 ›   Warning: Our terms of service have changed: https://dashboard.heroku.com/terms-of-service
heroku/7.59.2 linux-x64 node-v12.21.0
root@ubuntufla:~# exit
logout
ubuntu@ubuntufla:~ $
```

Verifichiamo che l'installazione è andata a buon fine.

```bash
$ heroku --version
```

Esempio:

```bash
ubuntu@ubuntufla:~ $heroku --version
 ›   Warning: Our terms of service have changed: https://dashboard.heroku.com/terms-of-service
heroku/7.59.2 linux-x64 node-v12.21.0
ubuntu@ubuntufla:~ $
```



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT /dev/vda1
```

Esempio:

```bash
ubuntu@ubuntufla:~ $df -hT /dev/vda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/vda1      ext4   20G  3.8G   16G  20% /
ubuntu@ubuntufla:~ $
```

Abbiamo ancora **16GB** disponibili.



## Creiamo l'app su heroku

Torniamo nella cartella della nostra applicazione Rails

```bash
$ cd bl7_0
```

Loghiamoci con le credenziali usate nella creazione dell'account heroku (sign_up).

```bash
$ heroku login
```

Esempio:
 
```bash

user_fb:~/environment/bl7_0 (pp) $ heroku login
heroku: Press any key to open up the browser to login or q to exit: 
Opening browser to https://cli-auth.heroku.com/auth/browser/fbca295d-9ffd-46ba-9bf5-2b13698871c1
 ›   Warning: Cannot open browser.

[lo apro cliccando sul link ma appare una pagina web con: ip-address-mismatch]
```

Questa procedura ti fa fare il login sulla pagina web. Basta cliccare sul link, scegliere "open" ed eseguire il login.

Funziona





## IP address mismatch

In alcune situazioni potrebbe non funzionare e dare errore di *ip-address-mismatch*.

> Ad esempio su aws cloud9 non funziona per qualche errore di autorizzazione o di reinstradamanento.
Appare una pagina web con l'errore: ip-address-mismatch

Risolviamo il problema dell'IP address mismatch.

* https://stackoverflow.com/questions/63363085/ip-address-mismatch-on-signing-into-heroku-cli

Cercando di fare login mi presenta errore di "IP address mismatch"

Risolto con 

```bash
$ heroku login -i
```

L'opzione "-i" ci fa fare login direttamente da terminale senza passare per l'interfaccia grafica web.

Esempio:

```bash
user_fb:~/environment $ cd bl7_0/
user_fb:~/environment/bl7_0 (pp) $ heroku login -i
heroku: Enter your login credentials
Email: mymail@gmail.com
Password: ********
 ›   Error: Your account has MFA enabled; API requests using basic authentication with email and password are not supported. Please generate an authorization token for API 
 ›   access. 
 ›
 ›   Error ID: vaas_enrolled
user_fb:~/environment/bl7_0 (pp) $
```

Purtroppo avendo attivato l'autenticazione MFA non è più sufficiente solo email e password.

Riusciamo a risolvere usando come password una chiave creata sulla piattaforma Heroku.

> If you are using Multi-Factor Authentication you could generate an Authorization token in settings page: https://dashboard.heroku.com/account/applications
> Run heroku login -i and use the generated token as password.


![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/02_fig02-heroku_MFA_authorization.png)


```bash
user_fb:~/environment/bl7_0 (pp) $ heroku login -i
heroku: Enter your login credentials
Email: flavio.bordoni.dev@gmail.com
Password: ************************************
Logged in as flavio.bordoni.dev@gmail.com
user_fb:~/environment/bl7_0 (pp) $ 
```

Una soluzione alternativa da provare è questa:
The accepted answer (run heroku login -i) doesn't work for accounts with MFA enabled. 
What I did instead was to reveal my account's API key and put it into ~/.netrc like so:

```bash
machine api.heroku.com
  login <MY_EMAIL>
  password <API_KEY>
machine git.heroku.com
  login <MY_EMAIL>
  password <API_KEY>
```

And voila! I can now use the CLI. This worked for me with Google CloudShell.
P.S. -- I added my machine's SSH key but could not understand how to use that to configure the CLI's access. 
It seems hard-coded to look for API keys in ~/.netrc.



## La chiave di criptatura

Aggiungiamo la nostra chiave di criptatura in modo da stabilire un canale sicuro tra aws Cloud9 ed Heroku.

```bash
$ heroku keys:add
-> y
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (pp) $ heroku keys:add
Could not find an existing SSH key at ~/.ssh/id_rsa.pub
? Would you like to generate a new one? Yes
Generating public/private rsa key pair.
Your identification has been saved in /home/ubuntu/.ssh/id_rsa.
Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:SP7SsFoqsp4k+nkqb5VJO/E7/Sh1vX4D5/Ro+9ETYHs ec2-user@ip-191-27-45-214
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|                 |
|      .   o      |
|     o . . o     |
|      + S . E    |
|     + =  .. . oo|
|..  o O o...  ooo|
|+oo..B +.+ .+  =o|
|***+..+ o.oo.+*o=|
+----[SHA256]-----+
Uploading /home/ubuntu/.ssh/id_rsa.pub SSH key... done
user_fb:~/environment/bl7_0 (pp) $ 
```


Creiamo una nuova app su heroku.

{caption: "terminal", format: bash, line-numbers: false}
```bash
$ heroku create
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (pp) $ heroku create
Creating app... done, ⬢ desolate-plains-35326
https://desolate-plains-35326.herokuapp.com/ | https://git.heroku.com/desolate-plains-35326.git
user_fb:~/environment/bl7_0 (pp) $ 
```

l'app viene creata dinamnicamente. In questo caso è stato creato **desolate-plains-35326** ma può essere qualsiasi nome.


Per verficarlo si può usare il comando

```bash
$ heroku domains
```

Esempio:
 
```bash
user_fb:~/environment/bl7_0 (pp) $ heroku domains
=== desolate-plains-35326 Heroku Domain
desolate-plains-35326.herokuapp.com
user_fb:~/environment/bl7_0 (pp) $ 
```

oppure

```bash
$ heroku apps:info
```

Esempio:
 
```bash
user_fb:~/environment/bl7_0 (pp) $ heroku apps:info
=== desolate-plains-35326
Auto Cert Mgmt: false
Dynos:          
Git URL:        https://git.heroku.com/desolate-plains-35326.git
Owner:          myemail@gmail.com
Region:         us
Repo Size:      0 B
Slug Size:      0 B
Stack:          heroku-20
Web URL:        https://desolate-plains-35326.herokuapp.com/
user_fb:~/environment/bl7_0 (pp) $
```


Possiamo verificare che abbiamo la configurazione git corretta con

```bash
$ git config --list | grep heroku
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (pp) $ git config --list | grep heroku
remote.heroku.url=https://git.heroku.com/desolate-plains-35326.git
remote.heroku.fetch=+refs/heads/*:refs/remotes/heroku/*
user_fb:~/environment/bl7_0 (pp) $
```

Se ci appare "fatal: not in a git directory" allora probabilmente non siamo nella directory corretta. Altrimenti possiamo mandare in produzione il nostro codice.


## Ricolleghiamo l'app

> [couldnt find the app in heroku](https://stackoverflow.com/questions/53551717/couldnt-find-that-app-when-running-heroku-commands-in-console)

Mi è successo di cancellare l'app dall'interfaccia web di heroku e quindi di doverla ricreare.
Creata di nuovo ho perso il collegamento.

```bash
ubuntu@ubuntufla:~/bl7_0 (pp)$heroku domains
 ›   Error: Couldn't find that app.
 ›
 ›   Error ID: not_found
```

Per riprenderlo ho dovuto reinserire nel *git:remote* il nome della nuova *app*.

```bash
heroku apps
heroku git:remote -a YOUR_APP
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (pp)$heroku domains
 ›   Warning: heroku update available from 7.59.2 to 7.59.3.
 ›   Error: Couldnt find that app.
 ›
 ›   Error ID: not_found
ubuntu@ubuntufla:~/bl7_0 (pp)$heroku apps
 ›   Warning: heroku update available from 7.59.2 to 7.59.3.
=== flavio.bordoni.dev@gmail.com Apps
agile-everglades-47263
elisinfo

=== Collaborated Apps
integram-agency-blog  r.desantis@integram-system.com
rebisworld4           r.desantis@integram-system.com
ubuntu@ubuntufla:~/bl7_0 (pp)$heroku git:remote -a agile-everglades-47263
 ›   Warning: heroku update available from 7.59.2 to 7.59.3.
set git remote heroku to https://git.heroku.com/agile-everglades-47263.git
ubuntu@ubuntufla:~/bl7_0 (pp)$heroku domains
 ›   Warning: heroku update available from 7.59.2 to 7.59.3.
=== agile-everglades-47263 Heroku Domain
agile-everglades-47263.herokuapp.com
ubuntu@ubuntufla:~/bl7_0 (pp)$
```



## Rinominiamo l'app

Diamo all'app di heroku un nome simile a quello del nostro ambiente di aws cloud9 che è anche simile al nome della nostra applicazione Rails. Così è più facile associarli.

```bash
$ heroku rename bl7-0
```

Esempio:
 
```bash
user_fb:~/environment/bl7_0 (pp) $ heroku rename bl7-0
Renaming desolate-plains-35326 to bl7-0... done
https://bl7-0.herokuapp.com/ | https://git.heroku.com/bl7-0.git
 ▸    Don't forget to update git remotes for all other local checkouts of the app.
Git remote heroku updated
user_fb:~/environment/bl7_0 (pp) $
```

Attenzione:
Il nome deve essere unico in tutto l'ambiente Heroku. Se il nome fosse già utilizzato potremmo aggiungere il prefisso *-mese* per renderlo univoco.


verifichiamo di nuovo le informazione della nostra app

```bash
$ heroku apps:info
```

Esempio:
 
```bash
user_fb:~/environment/bl7_0 (pp) $ heroku apps:info
=== bl7-0
Auto Cert Mgmt: false
Dynos:          
Git URL:        https://git.heroku.com/bl7-0.git
Owner:          myemail@gmail.com
Region:         us
Repo Size:      0 B
Slug Size:      0 B
Stack:          heroku-20
Web URL:        https://bl7-0.herokuapp.com/
user_fb:~/environment/bl7_0 (pp) $ 
```

e la configurazione di git


```bash
$ git config --list | grep heroku
```

Esempio:
 
```bash
user_fb:~/environment/bl7_0 (pp) $ git config --list | grep heroku
remote.heroku.url=https://git.heroku.com/bl7-0.git
remote.heroku.fetch=+refs/heads/*:refs/remotes/heroku/*
user_fb:~/environment/bl7_0 (pp) $
```

Adesso è tutto pronto. Possiamo fare il commit finale in locale e uploadare tutto in remoto.



## archiviamo su git


```bash
$ git add -A
$ git commit -m "ready to public in production on heroku"
```



## Pubblichiamo su heroku

Attenzione! per pubblicare su heroku da un branch si usa il comando " git push heroku yourbranch:master ". [per approfondimenti](https://devcenter.heroku.com/articles/git)

```bash
$ git push heroku pp:master
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (pp) $ git push heroku pp:master
Counting objects: 106, done.
Compressing objects: 100% (89/89), done.
Writing objects: 100% (106/106), 24.81 KiB | 1.03 MiB/s, done.
Total 106 (delta 8), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Building on the Heroku-20 stack
remote: -----> Determining which buildpack to use for this app
remote: -----> Ruby app detected
remote: -----> Installing bundler 2.2.33
remote: -----> Removing BUNDLED WITH version in the Gemfile.lock
remote: -----> Compiling Ruby/Rails
remote: -----> Using Ruby version: ruby-3.1.0
remote: -----> Installing dependencies using bundler 2.2.33
remote:        Running: BUNDLE_WITHOUT='development:test' BUNDLE_PATH=vendor/bundle BUNDLE_BIN=vendor/bundle/bin BUNDLE_DEPLOYMENT=1 bundle install -j4
remote:        Fetching gem metadata from https://rubygems.org/..........
remote:        Fetching rake 13.0.6
remote:        Installing rake 13.0.6
remote:        Fetching concurrent-ruby 1.1.9
remote:        Fetching minitest 5.15.0
remote:        Fetching erubi 1.10.0
remote:        Fetching builder 3.2.4
remote:        Installing minitest 5.15.0
remote:        Installing builder 3.2.4
remote:        Using racc 1.6.0
remote:        Installing erubi 1.10.0
remote:        Fetching crass 1.0.6
remote:        Fetching rack 2.2.3
remote:        Fetching nio4r 2.5.8
remote:        Installing concurrent-ruby 1.1.9
remote:        Installing crass 1.0.6
remote:        Installing rack 2.2.3
remote:        Fetching websocket-extensions 0.1.5
remote:        Installing nio4r 2.5.8 with native extensions
remote:        Installing websocket-extensions 0.1.5
remote:        Fetching marcel 1.0.2
remote:        Fetching mini_mime 1.1.2
remote:        Installing marcel 1.0.2
remote:        Installing mini_mime 1.1.2
remote:        Using digest 3.1.0
remote:        Using io-wait 0.2.1
remote:        Using timeout 0.2.0
remote:        Using strscan 3.0.1
remote:        Fetching msgpack 1.4.2
remote:        Using bundler 2.3.3
remote:        Fetching method_source 1.0.0
remote:        Fetching thor 1.2.1
remote:        Installing msgpack 1.4.2 with native extensions
remote:        Installing method_source 1.0.0
remote:        Installing thor 1.2.1
remote:        Fetching zeitwerk 2.5.3
remote:        Fetching pg 1.2.3
remote:        Installing zeitwerk 2.5.3
remote:        Installing pg 1.2.3 with native extensions
remote:        Fetching nokogiri 1.13.1 (x86_64-linux)
remote:        Installing nokogiri 1.13.1 (x86_64-linux)
remote:        Fetching websocket-driver 0.7.5
remote:        Installing websocket-driver 0.7.5 with native extensions
remote:        Fetching rack-test 1.1.0
remote:        Installing rack-test 1.1.0
remote:        Fetching i18n 1.8.11
remote:        Installing i18n 1.8.11
remote:        Fetching tzinfo 2.0.4
remote:        Installing tzinfo 2.0.4
remote:        Using net-protocol 0.1.2
remote:        Fetching sprockets 4.0.2
remote:        Installing sprockets 4.0.2
remote:        Fetching mail 2.7.1
remote:        Installing mail 2.7.1
remote:        Fetching loofah 2.13.0
remote:        Installing loofah 2.13.0
remote:        Fetching activesupport 7.0.1
remote:        Installing activesupport 7.0.1
remote:        Fetching net-imap 0.2.3
remote:        Installing net-imap 0.2.3
remote:        Fetching net-pop 0.1.1
remote:        Installing net-pop 0.1.1
remote:        Fetching net-smtp 0.3.1
remote:        Installing net-smtp 0.3.1
remote:        Fetching rails-html-sanitizer 1.4.2
remote:        Installing rails-html-sanitizer 1.4.2
remote:        Fetching rails-dom-testing 2.0.3
remote:        Installing rails-dom-testing 2.0.3
remote:        Fetching globalid 1.0.0
remote:        Installing globalid 1.0.0
remote:        Fetching activemodel 7.0.1
remote:        Installing activemodel 7.0.1
remote:        Fetching actionview 7.0.1
remote:        Installing actionview 7.0.1
remote:        Fetching activejob 7.0.1
remote:        Installing activejob 7.0.1
remote:        Fetching activerecord 7.0.1
remote:        Installing activerecord 7.0.1
remote:        Fetching actionpack 7.0.1
remote:        Installing actionpack 7.0.1
remote:        Fetching jbuilder 2.11.5
remote:        Installing jbuilder 2.11.5
remote:        Fetching activestorage 7.0.1
remote:        Installing activestorage 7.0.1
remote:        Fetching actionmailer 7.0.1
remote:        Installing actionmailer 7.0.1
remote:        Fetching railties 7.0.1
remote:        Installing railties 7.0.1
remote:        Fetching sprockets-rails 3.4.2
remote:        Installing sprockets-rails 3.4.2
remote:        Fetching actionmailbox 7.0.1
remote:        Installing actionmailbox 7.0.1
remote:        Fetching actiontext 7.0.1
remote:        Installing actiontext 7.0.1
remote:        Fetching importmap-rails 1.0.2
remote:        Installing importmap-rails 1.0.2
remote:        Fetching stimulus-rails 1.0.2
remote:        Installing stimulus-rails 1.0.2
remote:        Fetching turbo-rails 1.0.1
remote:        Installing turbo-rails 1.0.1
remote:        Fetching actioncable 7.0.1
remote:        Fetching puma 5.5.2
remote:        Installing actioncable 7.0.1
remote:        Installing puma 5.5.2 with native extensions
remote:        Fetching rails 7.0.1
remote:        Installing rails 7.0.1
remote:        Fetching bootsnap 1.10.1
remote:        Installing bootsnap 1.10.1 with native extensions
remote:        Bundle complete! 15 Gemfile dependencies, 57 gems now installed.
remote:        Gems in the groups 'development' and 'test' were not installed.
remote:        Bundled gems are installed into `./vendor/bundle`
remote:        Bundle completed (18.81s)
remote:        Cleaning up the bundler cache.
remote:        Removing bundler (2.2.33)
remote: -----> Detecting rake tasks
remote: -----> Preparing app for Rails asset pipeline
remote:        Running: rake assets:precompile
remote:        I, [2022-01-21T15:06:48.011558 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/manifest-b84bfa46a33d7f0dc4d2e7b8889486c9a957a5e40713d58f54be71b66954a1ff.js
remote:        I, [2022-01-21T15:06:48.011926 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/manifest-b84bfa46a33d7f0dc4d2e7b8889486c9a957a5e40713d58f54be71b66954a1ff.js.gz
remote:        I, [2022-01-21T15:06:48.012080 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/application-e0cf9d8fcb18bf7f909d8d91a5e78499f82ac29523d475bf3a9ab265d5e2b451.css
remote:        I, [2022-01-21T15:06:48.012174 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/application-e0cf9d8fcb18bf7f909d8d91a5e78499f82ac29523d475bf3a9ab265d5e2b451.css.gz
remote:        I, [2022-01-21T15:06:48.012386 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/application-37f365cbecf1fa2810a8303f4b6571676fa1f9c56c248528bc14ddb857531b95.js
remote:        I, [2022-01-21T15:06:48.012494 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/application-37f365cbecf1fa2810a8303f4b6571676fa1f9c56c248528bc14ddb857531b95.js.gz
remote:        I, [2022-01-21T15:06:48.012645 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/controllers/application-368d98631bccbf2349e0d4f8269afb3fe9625118341966de054759d96ea86c7e.js
remote:        I, [2022-01-21T15:06:48.012740 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/controllers/application-368d98631bccbf2349e0d4f8269afb3fe9625118341966de054759d96ea86c7e.js.gz
remote:        I, [2022-01-21T15:06:48.012859 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/controllers/hello_controller-549135e8e7c683a538c3d6d517339ba470fcfb79d62f738a0a089ba41851a554.js
remote:        I, [2022-01-21T15:06:48.012972 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/controllers/hello_controller-549135e8e7c683a538c3d6d517339ba470fcfb79d62f738a0a089ba41851a554.js.gz
remote:        I, [2022-01-21T15:06:48.013115 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/controllers/index-2db729dddcc5b979110e98de4b6720f83f91a123172e87281d5a58410fc43806.js
remote:        I, [2022-01-21T15:06:48.013255 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/controllers/index-2db729dddcc5b979110e98de4b6720f83f91a123172e87281d5a58410fc43806.js.gz
remote:        I, [2022-01-21T15:06:48.013414 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/turbo-7b0aa11f61631e9e535944fe9c3eaa4186c9df9d6c9d8b1d16a1ed3d85064cf0.js
remote:        I, [2022-01-21T15:06:48.013505 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/turbo-7b0aa11f61631e9e535944fe9c3eaa4186c9df9d6c9d8b1d16a1ed3d85064cf0.js.gz
remote:        I, [2022-01-21T15:06:48.013624 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/turbo.min.js-2e71e75cec6429b11d9575a009df6f148e9c52fbae30baf2292ec44620163b6f.map
remote:        I, [2022-01-21T15:06:48.013966 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/turbo.min-96cbf52c71021ba210235aaeec4720012d2c1df7d2dab3770cfa49eea3bb09da.js
remote:        I, [2022-01-21T15:06:48.014071 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/turbo.min-96cbf52c71021ba210235aaeec4720012d2c1df7d2dab3770cfa49eea3bb09da.js.gz
remote:        I, [2022-01-21T15:06:48.014230 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/activestorage-66f58884eeef2512d26d68339169134e187ee30b7c9a8bf787d54ba426f87f7b.js
remote:        I, [2022-01-21T15:06:48.014333 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/activestorage-66f58884eeef2512d26d68339169134e187ee30b7c9a8bf787d54ba426f87f7b.js.gz
remote:        I, [2022-01-21T15:06:48.014457 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/activestorage.esm-e6f556def16438cabebcb3b9e9fe903c4a78333331dc4bd9860f98ee6d050ba3.js
remote:        I, [2022-01-21T15:06:48.014548 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/activestorage.esm-e6f556def16438cabebcb3b9e9fe903c4a78333331dc4bd9860f98ee6d050ba3.js.gz
remote:        I, [2022-01-21T15:06:48.014669 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/actiontext-2cbe83c53ac55751766b846f03c0f117d6f2a1b58bec8c45d05510b6d8d2ba13.js
remote:        I, [2022-01-21T15:06:48.014765 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/actiontext-2cbe83c53ac55751766b846f03c0f117d6f2a1b58bec8c45d05510b6d8d2ba13.js.gz
remote:        I, [2022-01-21T15:06:48.014887 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/trix-ac629f94e04ee467ab73298a3496a4dfa33ca26a132f624dd5475381bc27bdc8.css
remote:        I, [2022-01-21T15:06:48.015209 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/trix-ac629f94e04ee467ab73298a3496a4dfa33ca26a132f624dd5475381bc27bdc8.css.gz
remote:        I, [2022-01-21T15:06:48.015347 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/es-module-shims-9e0c70685497a549ab07a74fc9ec13c2f0cd4952ccf7570d08f29f43473ecb7d.js
remote:        I, [2022-01-21T15:06:48.015441 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/es-module-shims-9e0c70685497a549ab07a74fc9ec13c2f0cd4952ccf7570d08f29f43473ecb7d.js.gz
remote:        I, [2022-01-21T15:06:48.015563 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/es-module-shims.min-6982885c6ce151b17d1d2841985042ce58e1b94af5dc14ab8268b3d02e7de3d6.js
remote:        I, [2022-01-21T15:06:48.015653 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/es-module-shims.min-6982885c6ce151b17d1d2841985042ce58e1b94af5dc14ab8268b3d02e7de3d6.js.gz
remote:        I, [2022-01-21T15:06:48.015780 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/es-module-shims.js-363f5d8dbcfc8948923497b4b8e3ce188d1704534aabd480a3c8a69700b7c983.map
remote:        I, [2022-01-21T15:06:48.016029 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/trix-1563ff9c10f74e143b3ded40a8458497eaf2f87a648a5cbbfebdb7dec3447a5e.js
remote:        I, [2022-01-21T15:06:48.016131 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/trix-1563ff9c10f74e143b3ded40a8458497eaf2f87a648a5cbbfebdb7dec3447a5e.js.gz
remote:        I, [2022-01-21T15:06:48.016254 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus.min-900648768bd96f3faeba359cf33c1bd01ca424ca4d2d05f36a5d8345112ae93c.js
remote:        I, [2022-01-21T15:06:48.016342 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus.min-900648768bd96f3faeba359cf33c1bd01ca424ca4d2d05f36a5d8345112ae93c.js.gz
remote:        I, [2022-01-21T15:06:48.016468 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-autoloader-2c31fda20cec0bdbfa933e7f149712e27af6e6ac829d23f81975f6ebd4d830cf.js
remote:        I, [2022-01-21T15:06:48.016559 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-autoloader-2c31fda20cec0bdbfa933e7f149712e27af6e6ac829d23f81975f6ebd4d830cf.js.gz
remote:        I, [2022-01-21T15:06:48.016674 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-importmap-autoloader-b10ce93483412df368cf597e99e0d924a712f36e0910e674236239f6028ed0a8.js
remote:        I, [2022-01-21T15:06:48.016764 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-importmap-autoloader-b10ce93483412df368cf597e99e0d924a712f36e0910e674236239f6028ed0a8.js.gz
remote:        I, [2022-01-21T15:06:48.016888 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-loading-685d40a0b68f785d3cdbab1c0f3575320497462e335c4a63b8de40a355d883c0.js
remote:        I, [2022-01-21T15:06:48.016971 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-loading-685d40a0b68f785d3cdbab1c0f3575320497462e335c4a63b8de40a355d883c0.js.gz
remote:        I, [2022-01-21T15:06:48.017096 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus.min.js-5cdf38f474c7d64a568a43e5de78b4313515aa0e4bd3d13fac297fffeba809f0.map
remote:        I, [2022-01-21T15:06:48.017367 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-0ce1b26664523b4ad005eb6a6358abf11890dad17c46d207e5b61a04056d7b26.js
remote:        I, [2022-01-21T15:06:48.017484 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-0ce1b26664523b4ad005eb6a6358abf11890dad17c46d207e5b61a04056d7b26.js.gz
remote:        I, [2022-01-21T15:06:48.017610 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-autoloader-2c31fda20cec0bdbfa933e7f149712e27af6e6ac829d23f81975f6ebd4d830cf.js
remote:        I, [2022-01-21T15:06:48.017705 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-autoloader-2c31fda20cec0bdbfa933e7f149712e27af6e6ac829d23f81975f6ebd4d830cf.js.gz
remote:        I, [2022-01-21T15:06:48.017828 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-importmap-autoloader-b10ce93483412df368cf597e99e0d924a712f36e0910e674236239f6028ed0a8.js
remote:        I, [2022-01-21T15:06:48.017951 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-importmap-autoloader-b10ce93483412df368cf597e99e0d924a712f36e0910e674236239f6028ed0a8.js.gz
remote:        I, [2022-01-21T15:06:48.018092 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-loading-685d40a0b68f785d3cdbab1c0f3575320497462e335c4a63b8de40a355d883c0.js
remote:        I, [2022-01-21T15:06:48.018372 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/stimulus-loading-685d40a0b68f785d3cdbab1c0f3575320497462e335c4a63b8de40a355d883c0.js.gz
remote:        I, [2022-01-21T15:06:48.018512 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/actioncable-da745289dc396d1588ddfd149d68bb8e519d9e7059903aa2bb98cfc57be6d66e.js
remote:        I, [2022-01-21T15:06:48.018608 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/actioncable-da745289dc396d1588ddfd149d68bb8e519d9e7059903aa2bb98cfc57be6d66e.js.gz
remote:        I, [2022-01-21T15:06:48.018731 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/actioncable.esm-3d92de0486af7257cac807acf379cea45baf450c201e71e3e84884c0e1b5ee15.js
remote:        I, [2022-01-21T15:06:48.018820 #812]  INFO -- : Writing /tmp/build_03e21824/public/assets/actioncable.esm-3d92de0486af7257cac807acf379cea45baf450c201e71e3e84884c0e1b5ee15.js.gz
remote:        Asset precompilation completed (1.14s)
remote:        Cleaning assets
remote:        Running: rake assets:clean
remote: -----> Detecting rails configuration
remote: 
remote: ###### WARNING:
remote: 
remote:        No Procfile detected, using the default web server.
remote:        We recommend explicitly declaring how to boot your server process via a Procfile.
remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
remote: 
remote: 
remote: -----> Discovering process types
remote:        Procfile declares types     -> (none)
remote:        Default types for buildpack -> console, rake, web
remote: 
remote: -----> Compressing...
remote:        Done: 38.9M
remote: -----> Launching...
remote:        Released v6
remote:        https://bl7-0.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/bl7-0.git
 * [new branch]      pp -> master
user_fb:~/environment/bl7_0 (pp) $ 
```



## Verifichiamo production

La nostra applicazione è ora in produzione su heroku. La possiamo vedere sul broser all'URL

https://bl7-0.herokuapp.com/

> siccome non abbiamo ancora tabelle di database è stato sufficiente fare il "git push" ma quando avremo tabelle di database dobbiamo ricordarci di eseguire il "migrate" anche su heroku.

```bash
$ heroku run rake db:migrate
```



## Impostiamo i dynos

Per visualizzare la nostra app sul web stiamo usando un dyno di tipo web.
Vediamo quanti dynos abbiamo associato alla nostra app in produzione su heroku 

```bash
$ heroku ps
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (pp) $ heroku ps
Free dyno hours quota remaining this month: 995h 11m (99%)
Free dyno usage for this app: 0h 36m (0%)
For more information on dyno sleeping and how to upgrade, see:
https://devcenter.heroku.com/articles/dyno-sleeping

=== web (Free): bin/rails server -p ${PORT:-5000} -e $RAILS_ENV (1)
web.1: idle 2022/01/21 15:43:03 +0000

user_fb:~/environment/bl7_0 (pp) $ 
```

abbiamo 1 dyno assegnato ed in attesa *web.1: idle* pronto a diventare attivo *web.1: up*.

Se vogliamo assegnare più dynos usiamo il comando **ps:scale**. Ad esempio assicuriamoci di avere 1 dyno attivo per il web.

```bash
$ heroku ps:scale web=1
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (pp) $ heroku ps:scale web=1
Scaling dynos... done, now running web at 1:Free
user_fb:~/environment/bl7_0 (pp) $ 
```

Possiamo verificare che non è cambiato nulla perché era già attivo di default 1 dyno.

```bash
user_fb:~/environment/bl7_0 (pp) $ heroku ps
Free dyno hours quota remaining this month: 995h 11m (99%)
Free dyno usage for this app: 0h 36m (0%)
For more information on dyno sleeping and how to upgrade, see:
https://devcenter.heroku.com/articles/dyno-sleeping

=== web (Free): bin/rails server -p ${PORT:-5000} -e $RAILS_ENV (1)
web.1: idle 2022/01/21 15:43:03 +0000

user_fb:~/environment/bl7_0 (pp) $ 
```

Se proviamo a scalare a 2 dynos riceviamo un messaggio di errore perché possiamo avere solo 1 dyno gratuito ogni applicazione. 

```bash
user_fb:~/environment/bl7_0 (pp) $ heroku ps:scale web=2
Scaling dynos... !
 ▸    Cannot update to more than 1 Free size dynos per process type.
user_fb:~/environment/bl7_0 (pp) $ 
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/01-heroku_story.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/03-heroku_finish.md)
