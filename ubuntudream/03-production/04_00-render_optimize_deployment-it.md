# <a name="top"></a> Cap 2.4 - Ottimizziamo l'app per andare in produzione su Render

Before deploying any serious application in production, some minor tweaks are required.



## Risorse interne

-[]()



## Risorse esterne

- [render: deploy manually](https://docs.render.com/deploy-rails#deploy-manually)
- [render: Update Your App For Render](https://render.com/docs/deploy-rails#update-your-app-for-render)

- [Use bundle exec rake or just rake?](https://stackoverflow.com/questions/8275885/use-bundle-exec-rake-or-just-rake#answer-8275912)
- [What is the difference between bin/rake and bundle exec rake](https://stackoverflow.com/questions/29192130/what-is-the-difference-between-bin-rake-and-bundle-exec-rake)



## Update your app for Render

Let’s prepare your Rails project for production on Render. We’ll create a build script for Render to run with each deploy.
You will need to run a series of commands to build your app. This can be done using a build script. Create a script called `bin/render-build.sh` at the root of your repository.



## Creiamo un build script

Render crea il tuo progetto, prima di ogni messa in produzione (deploy), eseguendo uno specifico comando di compilazione (build command). 
Creiamo lo script da utilizzare per questo comando.
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



## Aggiorniamo il Web Service render.com

Riseguiamo i passi che abbiamo già fatto nei capitoli precedenti aggiungendo qualche modifica.

- Abbiamo già creato un nuovo database PostgreSQL su Render 
  e ci siamo appuntati l'`internal database URL`.
- Aggiorniamo il Web Service creato precedentemente.

Andiamo nel nostro Web Service su `Settings -> Build & Deploy` ed aggiorniamo le seguenti proprietà:

PROPERTY    : VALUE
- `Build Command` :	`./bin/render-build.sh`
- `Start Command` :	`bundle exec puma -C config/puma.rb`

alternativa

PROPERTY        | VALUE
| :---          | :--- 
`Build Command` | `./bin/render-build.sh`
`Start Command` | `bundle exec puma -C config/puma.rb`

That’s it! You can now finalize your service deployment. It will be live on your .onrender.com URL as soon as the build finishes.





## Aggiorniamo il file `config/database.yml`

Aggiorniamo il file per il deployment in produzione su render.

Open `config/database.yml` and find the `production section`. 

[Codice 02 - .../config/database.yml - linea: 18]()

```yaml
production:
  <<: *default
  database: ubuntudream_production
  username: ubuntudream
  password: <%= ENV["UBUNTUDREAM_DATABASE_PASSWORD"] %>
```


Modify it to gather the database configuration from the `DATABASE_URL` **environment variable**.

[Codice 03 - .../config/database.yml - linea: 82]()

```yaml
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
```





## Aggiorniamo il webserver Puma

Open `config/puma.rb` and uncomment the following lines:

[Codice 04 - .../config/puma.rb - linea: 27]()

```ruby
# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch("WEB_CONCURRENCY") { 4 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!
```




## I settaggi di produzione (public_file_server)

Open `config/environments/production.rb` and enable the public file server when the `RENDER` **environment variable** is present (which always is on Render).

[Codice 05 - .../config/environments/production.rb - linea: 1]()

```ruby
# Disable serving static files from the `/public` folder by default since
# Apache or NGINX already handles this.
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || ENV['RENDER'].present?
```







## Modifica sul view

Adesso facciamo una piccola modifica e la riportiamo in produzione.

Modifichiamo la nostra homepage aggiungendo semplicemente un paragrafo.

***Code 01 - .../app/mockups/index.html.erb - line:3***

```html+erb
<p>this is a change</p>
```



## Archiviamo su Git e su GitHub

Commit all changes and push them to your GitHub repository. 

```bash
$ git add -A
$ git commit -m "App ready for production"
$ git push origin main
```

Now your application is ready to be deployed on Render!



## Pubblichiamo su render.com

Di default il processo di pubbliacazione parte in automatico ogni volta che facciamo il `git push` su Github perché abbiamo collegato render.com a Github.

Se per qualche strano motivo non partisse in automatico possiamo farlo manualmente:
Dal nostro Web Service su render.com selezioniamo Manual Deploy -> `Deploy latest commit`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/04_fig01-deploy_latest_commit.png)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/05_00-production_with_render-it.md)
