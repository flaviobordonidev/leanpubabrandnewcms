# <a name="top"></a> Cap 4.3 - Perfezioniamo la configurazione di Heroku

Ottimizziamo la nostra app per l'ambiente di produzione Heroku.



## Risorse interne

- 99-rails_references/Heroku/



## Risorse esterne

Questo capitolo segue quanto riportato nella documentazione di Heroku:

- [Heroku: getting started with rails7](https://devcenter.heroku.com/articles/getting-started-with-rails7)


 
## Verifichiamo dove eravamo rimasti


```bash
$ git status
$ git log
```




## Continuiamo con il branch "Pubblichiamo in Produzione"

Continuiamo con il branch aperto nel capitolo precedente




## Vediamo i warnings

Pubblicando su heroku abbiamo ricevuto diversi avvisi di miglioramenti da fare. Molti di questi sono anche riportate le pagine web di tutorial di heroku.
Rivediamo qui i messaggi di miglioramenti.
In realtà è solo UNO ^_^:

```bash
remote: ###### WARNING:
remote: 
remote:        No Procfile detected, using the default web server.
remote:        We recommend explicitly declaring how to boot your server process via a Procfile.
remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
remote: 
```


Invece nell'installazione di Rails 6 ne avevamo ricevuti altri:

```bash
remote:        Ruby Sass is deprecated and will be unmaintained as of 26 March 2019.
remote:        
remote:        * If you use Sass as a command-line tool, we recommend using Dart Sass, the new
remote:          primary implementation: https://sass-lang.com/install
remote:        
remote:        * If you use Sass as a plug-in for a Ruby web framework, we recommend using the
remote:          sassc gem: https://github.com/sass/sassc-ruby#readme
remote:        
remote:        * For more details, please refer to the Sass blog:
remote:          http://sass.logdown.com/posts/7081811
```

```bash
remote:        Warning: the running version of Bundler (1.15.2) is older than the version that created the lockfile (1.17.1). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
remote:        The latest bundler is 2.0.0.pre.2, but you are currently running 1.15.2.
remote:        To update, run `gem install bundler --pre`
```

```bash
remote: -----> Detecting rails configuration
remote: 
remote: ###### WARNING:
remote: 
remote:        You set your `config.active_storage.service` to :local in production.
remote:        If you are uploading files to this app, they will not persist after the app
remote:        is restarted, on one-off dynos, or if the app has multiple dynos.
remote:        Heroku applications have an ephemeral file system. To
remote:        persist uploaded files, please use a service such as S3 and update your Rails
remote:        configuration.
remote:        
remote:        For more information can be found in this article:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku
remote:        
remote: 
remote: ###### WARNING:
remote: 
remote:        We detected that some binary dependencies required to
remote:        use all the preview features of Active Storage are not
remote:        present on this system.
remote:        
remote:        For more information please see:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku
remote:        
remote: 
remote: ###### WARNING:
remote: 
remote:        No Procfile detected, using the default web server.
remote:        We recommend explicitly declaring how to boot your server process via a Procfile.
remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
```


Di questi ultimi tre WARNING: 
Il primo ed il secondo relativi ad active_storage li risolviamo più avanti quando implementiamo l'upload dei files.
Ma su Rails 7. Non ci sono proprio arrivati questi messaggi d'errore perché è integrato meglio come ci accorgeremo più avanti.

Il terzo relativo al Procfile lo risolviamo fra poco in questo capitolo.
(E questo è effettivamente l'unico avviso che abbiamo avuto con Rails 7.)



## Vediamo la log

```bash
$ heroku logs
```

Se vogliamo più dettagli

```bash
$ heroku logs --tail
```

in realtà l'opzione *--tail* lascia la log attiva e mostra nuove voci in tempo reale.



## Il webserver puma

Ok, finalmente ci prendiamo cura del warning relativo al Procfile. Questo è il file con la configurazione per il webserver Puma.

Rails 7 ha di default nel Gemfile il webserver puma che quindi abbiamo già installato con il precedente ***$ bundle install***.

***codice 01 - .../Gemfile - line: 15***

```ruby
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/03_01-Gemfile.rb)


Non ci resta che creare il nuovo file **Procfile** nella cartella principale della nostra applicazione.
(Da notare che questo file non ha nessuna estenzione. Non ha alla fine il punto "***.***" con delle altre lettere dopo.)

Ed inseriamo la stringa suggerita dalla documentazione di Heroku.

***codice 02 - .../Procfile - line:1***

```ruby
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/03_02-Procfile)



## Alternativa per configurare il Procfile

Un metodo alternativo interessante è quello di puntare al file *config/puma.rb* che è creato in automatico da Rails.

***codice 03 - .../Procfile - line:1***

```ruby
web: bundle exec puma -C config/puma.rb
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/03_03-Procfile)


Questo Procfile rimanda la lettura della configurazione al file config/puma.rb che è già creato di default da Rails. Vediamolo senza i commenti.

***codice 04 - .../config/puma.rb - line:1***

```
# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/03_04-config-puma.rb)


Ma noi usiamo quest'altra configurazione che è suggerita da heroku 

***codice 05 - .../config/puma.rb - line:1***

```ruby
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/03_01-Gemfile.rb)


Entrambi i *workers* ed i *threads* forniscono più sessioni contemporanee (more concurrency) però:

- i *workers* consumano più RAM
- i *threads* consumano più CPU

Noi abbiamo impostato *5 Puma-threads* e *2 Puma-workers*.
Con un tipico footprint di memoria di Rails, possiamo aspettarci di eseguire 2-4 processi *Puma-workers* su un dyno free, hobby o standard 1x.



## Thread safe

If your app is not thread safe, you will only be able to use workers. Set your min and max threads to 1

```bash
$ heroku config:set MIN_THREADS=1 RAILS_MAX_THREADS=1


ec2-user:~/environment/myapp (master) $ heroku config:set MIN_THREADS=1 RAILS_MAX_THREADS=1
Setting MIN_THREADS, RAILS_MAX_THREADS and restarting ⬢ myapp-1-blabla... done, v7
MIN_THREADS:       1
RAILS_MAX_THREADS: 1
```

You can still gain concurrency by adding workers. Since a worker runs in a different process and does not share memory, code that is not thread safe can be run across multiple worker processes.
Once you have your application running on workers, you can try increasing the number of threads on staging and in development to 2

```bash
$ heroku config:set MIN_THREADS=2 RAILS_MAX_THREADS=2
```

You need to monitor exceptions and look for errors such as *deadlock detected (fatal), race conditions, and locations where you’re modifying global or shared variables.
Concurrency bugs can be difficult to detect and fix, so make sure to test your application thoroughly before deploying to production. If you can make your application thread safe, the benefit is greatly worth it, as scaling out with Puma threads and workers provide significantly more throughput than using workers alone.



## salviamo su git


```bash
$ git add -A
$ git commit -m "Add Puma webserver Procfile and config"
```




## Pubblichiamo su Heroku

```bash
$ git push heroku pp:master
$ heroku run rails db:migrate
```

Adesso non ho più il warning. Per il momento è tutto su Heroku

Inoltre il web dyno sta lavorando sul web server puma

```bash
user_fb:~/environment/bl7_0 (pp) $ heroku ps
Free dyno hours quota remaining this month: 993h 48m (99%)
Free dyno usage for this app: 0h 0m (0%)
For more information on dyno sleeping and how to upgrade, see:
https://devcenter.heroku.com/articles/dyno-sleeping

=== web (Free): bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development} (1)
web.1: up 2022/01/24 11:56:24 +0000 (~ 12s ago)

user_fb:~/environment/bl7_0 (pp) $ 
```

In questo caso abbiamo "=== web (Free): bundle exec puma -C config/puma.rb" mentre nel capitolo precedente, prima di creare il Procfile, avevamo "=== web (Free): bin/rails server -p $PORT -e $RAILS_ENV"




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pp
$ git branch -d pp
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/04-heroku/02-inizializiamo_heroku.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/01-github_story.md)
