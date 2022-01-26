# Heroku

L'ambiente scelto per mandare in produzione le nostre applicazioni Rails.


Risorse interne:

* 01-base/04-heroku/02-inizializiamo_heroku


Risorse web:

* https://devcenter.heroku.com/articles/getting-started-with-rails6
* https://devcenter.heroku.com/articles/getting-started-with-rails5
* https://devcenter.heroku.com/articles/heroku-cli#download-and-install

* [Heroku - deplowing rails with puma](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server)
* https://devcenter.heroku.com/articles/git

* https://www.railstutorial.org/book/_single-page
* https://www.railstutorial.org/book/_single-page#sec-deploying
* [Michael Hartl - Rails Tutorial 7.5.2 Production webserver](https://www.railstutorial.org/book/_single-page#sec-production_webserver)







## Installazione Heroku CLI (former Heroku-toolbelt)

vedi 01-base/04-heroku/02-inizializiamo_heroku

Come abbiamo già fatto per PostgreSQL, anche Heroku lo installiamo sulla cartella principale di aws Cloud9: "/environment".
Assicuriamoci di essere sulla cartella principale

{caption: "terminal", format: bash, line-numbers: false}
```
$ cd ~/environment


user_fb:~/environment/bl6_0 (pp) $ cd ~/environment
user_fb:~/environment $ 
```

Per installare Heroku dobbiamo scaricare ed installare la "heroku CLI" (ex heroku-toolbelt).
Seguendo le indicazioni di [Heroku](https://devcenter.heroku.com/articles/heroku-cli) il comando che dobbiamo usare da aws cloud9, che è un "docker container" è questo:

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo su -
-> curl https://cli-assets.heroku.com/install.sh | sh
-> exit


user_fb:~/environment $ sudo su -
root@ip-172-31-87-229:~# curl https://cli-assets.heroku.com/install.sh | sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1892  100  1892    0     0  21022      0 --:--:-- --:--:-- --:--:-- 21258
Installing CLI from https://cli-assets.heroku.com/heroku-linux-x64.tar.xz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 16.9M  100 16.9M    0     0  6208k      0  0:00:02  0:00:02 --:--:-- 6206k
v11.14.0
heroku installed to /usr/local/bin/heroku
heroku/7.33.3 linux-x64 node-v11.14.0
root@ip-172-31-87-229:~# exit
logout
user_fb:~/environment $ 
```


Verifichiamo che l'installazione è andata a buon fine.

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku --version


user_fb:~/environment $ heroku --version
heroku/7.33.3 linux-x64 node-v11.14.0
```




### Alternativa tramite stringa Michael Hartl

Un'alternativa è eseguire la stringa di comando preparata da Michael Hartl del railstutorial.

{caption: "terminal", format: bash, line-numbers: false}
```
$ source <(curl -sL https://cdn.learnenough.com/heroku_install)
```

Questo comando esegue uno script fatto da Michael che esegue i seguenti passi:
* Scarica il pacchetto per linux dal sito di heroku (https://cli-assets.heroku.com/heroku-linux-x64.tar.gz) tramite curl. 
* Scompatta e rimuove il pacchetto.
* Sposta i files scompattati su /usr/local. 
* Poi attiva il puntamento su $HOME/.profile per permettere di eseguire il comando "heroku" da qualsiasi path ci troviamo.  

Ne possiamo vedere il contenuto qui:

[cod. b](beginning-heroku-02b-learnenogh-heroku_install)

I> Questa alternativa funziona ma tutte le volte che riapro l'istanza di cloud9 sono costretto a rilanciare il comando altrimenti non mi riconosce il comando "heroku ..."

proviamo a lanciarla come super user

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo -s
$ source <(curl -sL https://cdn.learnenough.com/heroku_install)
$ exit
```




## Alternativa tramite npm

Visualizza la versione di nvm

{caption: "terminal", format: bash, line-numbers: false}
```
$ nvm

$ nvm ls

$ nvm ls-remote
```

Update npm

{caption: "terminal", format: bash, line-numbers: false}
```
$ nvm i v8         # Any version > 8 will do e.g. nvm i v9 
```

Install heroku cli

{caption: "terminal", format: bash, line-numbers: false}
```
$ npm install -g heroku

$ npm install -g npm
```

Done!

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku --version

heroku/7.0.15 linux-x64 node-v8.11.1
```

