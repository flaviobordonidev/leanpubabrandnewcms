# <a name="top"></a> Cap 2.5 - Prepariamo l'app per la produzione

Before deploying any serious application in production, some minor tweaks are required.



## Risorse interne

-[]()



## Risorse esterne

- [Update Your App For Render](https://render.com/docs/deploy-rails#update-your-app-for-render)



## App with PostgreSql

In order for your Rails project to be ready for production, you will need to make a few adjustments. 
You will be required update your project to use a Render PostgreSQL database instead of a SQLite database.

Lo abbiamo già fatto. Possiamo solo verificare che sia tutto apposto su config/database.yml.

***code 01 - .../config/database.yml - line:18***

```yaml
  adapter: postgresql
...
  #username: ubuntudream
...
  #password:
...
  #host: localhost
...
  #port: 5432
...
production:
  <<: *default
  database: ubuntudream_production
  username: ubuntudream
  password: <%= ENV["UBUNTUDREAM_DATABASE_PASSWORD"] %>
```


Aggiorniamo il file per il deployment in produzione su render.

Open `config/database.yml` and find the `production section`. Modify it to gather the database configuration from the `DATABASE_URL` **environment variable**.

***code 02 - .../config/database.yml - line:82***

```yaml
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
```



## Aggiorniamo il webserver Puma

Open `config/puma.rb` and uncomment the following lines:

***code 03 - .../config/puma.rb - line:27***

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

***code 04 - .../config/environments/production.rb - line:01***

```ruby
# Disable serving static files from the `/public` folder by default since
# Apache or NGINX already handles this.
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || ENV['RENDER'].present?
```



## Create a Build Script

You will need to run a series of commands to build your app. This can be done using a build script. Create a script called `bin/render-build.sh` at the root of your repository.

***code 05 - .../bin/render-build.sh - line:01***

```bash
#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
```

Make sure the script is executable before checking it into Git:

```bash
$ chmod a+x bin/render-build.sh
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (main)$ls -l bin/render-build.sh
-rw-rw-r-- 1 ubuntu ubuntu 159 Sep 21 01:46 bin/render-build.sh
ubuntu@ubuntufla:~/ubuntudream (main)$chmod a+x bin/render-build.sh
ubuntu@ubuntufla:~/ubuntudream (main)$ls -l bin/render-build.sh
-rwxrwxr-x 1 ubuntu ubuntu 159 Sep 21 01:46 bin/render-build.sh
ubuntu@ubuntufla:~/ubuntudream (main)$
```

We will configure Render to call this script on every push to the Git repository.

Commit all changes and push them to your GitHub repository. Now your application is ready to be deployed on Render!



## Deploy Manually to Render

Riseguiamo i passi che abbiamo già fatto nei capitoli precedenti aggiungendo qualche modifica.

- Abbiamo già creato un nuovo database PostgreSQL su Render 
  (e ci siamo appuntati l'`internal database URL`).

- Aggiorniamo il Web Service creato precedentemente.



### Aggiorniamo il Web Service

Andiamo nel nostro Web Service su `Settings -> Build & Deploy` ed aggiorniamo le seguenti proprietà:

PROPERTY        |	VALUE
-----------------------------------------------------
`Build Command` |	`./bin/render-build.sh`
`Start Command` |	`bundle exec puma -C config/puma.rb`

That’s it! You can now finalize your service deployment. It will be live on your .onrender.com URL as soon as the build finishes.


## Archiviamo su Git e su GitHub

```bash
$ git add -A
$ git commit -m "App ready for production"
$ git push origin main
```



## Pubblichiamo su render.com

Dal nostro Web Service su render.com selezioniamo Manual Deploy -> `Deploy latest commit`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/04_fig01-deploy_latest_commit.png)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_00-render_first_deployment-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/05_00-production_with_render-it.md)

