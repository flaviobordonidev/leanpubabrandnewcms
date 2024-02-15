# <a name="top"></a> Cap 3.4 - Ottimizziamo l'app per andare in produzione su Render

Before deploying any serious application in production, some minor tweaks are required.



## Risorse interne

-[]()



## Risorse esterne

- [render: deploy manually](https://docs.render.com/deploy-rails#deploy-manually)
- [render: Update Your App For Render](https://render.com/docs/deploy-rails#update-your-app-for-render)

- [Use bundle exec rake or just rake?](https://stackoverflow.com/questions/8275885/use-bundle-exec-rake-or-just-rake#answer-8275912)
- [What is the difference between bin/rake and bundle exec rake](https://stackoverflow.com/questions/29192130/what-is-the-difference-between-bin-rake-and-bundle-exec-rake)

- [Deploying Rails Applications with the Puma Web Server](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server)
- [render: Paid plan doesn’t provide enough memory to run a Rails console](https://community.render.com/t/paid-plan-doesnt-provide-enough-memory-to-run-a-rails-console/16219/4)
- [github: Puma: A Ruby Web Server Built For Parallelism](https://github.com/puma/puma)



## Update your app for Render

Let’s prepare your Rails project for production on Render. We’ll create a build script for Render to run with each deploy.
You will need to run a series of commands to build your app. This can be done using a build script. Create a script called `bin/render-build.sh` at the root of your repository.



## Verifichiamo il Web Service render.com

Verifichiamo i valori che che abbiamo impostato e quelli di default che andremo ad ottimizzare.

### Environment Variables

Andiamo nel nostro Web Service su `Settings -> Environment`.
render.com -> Dashboard -> ubuntudream3 (Web Service) -> Environment
-> Environment Variables

Key                | Value
| :---             | :--- 
`DATABASE_URL`     | `postgres://ubuntudream:FE7...glyz2-d/ubuntudream_production_64p3`
`RAILS_MASTER_KEY` | `seb666...4bh17`


### Build & Deploy

Andiamo nel nostro Web Service su `Settings -> Build & Deploy`.
render.com -> Dashboard -> ubuntudream3 (Web Service) -> Settings 
-> Build & Deploy

Di default abbiamo:

Property        | Value
| :---          | :--- 
`Build Command` | `bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean;`
`Start Command` | `bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`



## Creiamo il build script per `Build Command`

Render crea il tuo progetto, prima di ogni messa in produzione (deploy), eseguendo uno specifico comando di compilazione (build command).

La cosa più facile sarebbe modificare il `Build Command` di default in:
`bundle install; bundle exec rails assets:precompile; bundle exec rails assets:clean; bundle exec rails db:migrate;`

Ma per maggiore flessibilità creiamo un file con lo script da utilizzare per questo comando.
Nella nostra applicazione rails, nella cartella `bin`, creiamo un nuovo file e lo chiamiamo `render-build.sh` e ci inseriamo il seguente script:

[Codice 01 - .../bin/render-build.sh - linea: 1]()

```sh
#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
```

> Il comando `... rails db:migrate` è necessario solo per i *piani gratuiti* su render.com.
> Per i *piani a pagamento* è meglio non usarlo ed usare invece la proprietà `Pre-deploy Command` nel *web service*.

> `bundle exec rails` è meglio di `./bin/rails`.  
> La maggior parte delle volte fanno la stessa cosa ma `bundle exec` executes a command in the context of your application. As each application can have different versions of gem used. Using `bundle exec` guarantees that you use the correct versions.


Assicuriamoci che lo script sia eseguibile prima di inviarlo a GitHub.

```shell
chmod a+x bin/render-build.sh
```

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream (is)$ls -l bin/render-build.sh
-rw-rw-r-- 1 ubuntu ubuntu 163 Feb 11 14:35 bin/render-build.sh

ubuntu@ub22fla:~/ubuntudream (is)$chmod a+x bin/render-build.sh
ubuntu@ub22fla:~/ubuntudream (is)$ls -l bin/render-build.sh
-rwxrwxr-x 1 ubuntu ubuntu 163 Feb 11 14:35 bin/render-build.sh
```

> We’ll configure Render to call this script each time your app is deployed.
> We will configure Render to call this script on every push to the Git repository.



## Creiamo il build script per `Start Command`

Questo script fa partire il webserver puma.
Lo script inline di default è: 
`bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`

> `-t 5:5` imposta `min_threads_count = 5` e `max_threads_count = 5`

Se invece vogliamo usare il file di configurazione `config/puma.rb` di Rails indichiamo allo script di usarlo con il comando:
`bundle exec puma -C config/puma.rb`

> l'opzione `-C ...` prende il resto dei comandi dal file indicato.
> You can  provide a configuration file with the -C (or --config) flag.

Il file `config/puma.rb` di default di rails 7.1 ha una configurazione che non va bene per *render.com*
vedi: [render: Paid plan doesn’t provide enough memory to run a Rails console](https://community.render.com/t/paid-plan-doesnt-provide-enough-memory-to-run-a-rails-console/16219/4)

Vediamo il file `config/puma.rb` di default di rails 7.1.
Evidenziamo la parte che da problema.

[Codice 02 - .../config/puma.rb - linea: 27]()

```ruby
# Specifies that the worker count should equal the number of processors in production.
if ENV["RAILS_ENV"] == "production"
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end
```

> Specifies the number of `workers` to boot in clustered mode.
> Workers are forked web server processes. If using threads and workers together
> the concurrency of the application would be max `threads` * `workers`.

This is setting the web concurrency based on the physical processor count, which will be incorrect when you’re running on a Cloud platform - you don’t have 16 cpus! (As `Concurrent.physical_processor_count` returns)
Setting WEB_CONCURRENCY to a much smaller number, eg 2 than the memory drops from 496Mb to 200Mb.


Modifichiamolo per andare bene con render.com.

[Codice 03 - .../config/puma.rb - linea: 27]()

```ruby
# Specifies that the worker count should equal the number of processors in production.
# noi li impostiamo a 4 altrimenti su render.com ne prende erroneamente 16 e satura la RAM
if ENV["RAILS_ENV"] == "production"
  require "concurrent-ruby"
  #worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 4 })
  workers worker_count if worker_count > 1
end
```


Su rails 7.0 era implementata anche `preload_app!` ma su rails 7.1 è stata tolta

```ruby
  # Use the `preload_app!` method when specifying a `workers` number.
  # This directive tells Puma to first boot the application and load code
  # before forking the application. This takes advantage of Copy On Write
  # process behavior so workers use less memory.
  #
  preload_app!
```




## Aggiorniamo il Web Service render.com

Andiamo nel nostro Web Service su `Settings -> Build & Deploy`.
render.com -> Dashboard -> ubuntudream3 (Web Service) -> Settings -> Build & Deploy

Di default abbiamo:
- `Build Command` = `bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean;`</br>
- `Start Command` = `bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`

Impostiamo alle proprietà `Build Command` e `Start Command` di eseguire gli script dei files che abbiamo creato nei paragrafi precedenti.

PROPERTY        | VALUE
| :---          | :--- 
`Build Command` | `./bin/render-build.sh`
`Start Command` | `bundle exec puma -C config/puma.rb`



That’s it! You can now finalize your service deployment. It will be live on your .onrender.com URL as soon as the build finishes.

Riseguiamo i passi che abbiamo già fatto nei capitoli precedenti aggiungendo qualche modifica.

- Abbiamo già creato un nuovo database PostgreSQL su Render 
  e ci siamo appuntati l'`internal database URL`.
- Aggiorniamo il Web Service creato precedentemente.



## Archiviamo su git e Github

```bash
$ git add -A
$ git commit -m "Optimization for render.com"
# Commit all changes and push them to your GitHub repository.
$ git push origin main
```

Now your application is ready to be deployed on Render!



## Chiudiamo eventuale branch e archiviamo su Github

Se avessimo avuto un branch aperto lo avremmo dovuto chiudere prima del `git push origin main`

```bash
$ git checkout main
$ git merge branch_name
$ git branch -d branch_name
```

Commit all changes and push them to your GitHub repository. 

```shell
$ git push origin main
```

Now your application is ready to be deployed on Render!

Possiamo riaprire l'eventuale branch

```shell
$ git checkout -b branch_name
```



## Pubblichiamo su render.com

Di default il processo di pubbliacazione parte in automatico ogni volta che facciamo il `git push` su Github perché abbiamo collegato render.com a Github.

Se per qualche strano motivo non partisse in automatico possiamo farlo manualmente:
Dal nostro Web Service su render.com selezioniamo Manual Deploy -> `Deploy latest commit`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/04_fig01-deploy_latest_commit.png)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/05_00-production_with_render-it.md)
