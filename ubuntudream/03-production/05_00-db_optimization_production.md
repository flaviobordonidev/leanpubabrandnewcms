# <a name="top"></a> Cap 3.4 - Continuiamo con le ottimizzazioni per l'ambiente di produzione

Continuiamo ad ottimizzare per l'ambiente di produzione.

Sembra che tutto questo capitolo non serva più da Rails 7.1
**Da Rails 7.1 FORSE possiamo SALTARE questo capitolo**


## Risorse interne

-[]()



## Risorse esterne

- [render: Deploying Ruby on Rails on Render](https://docs.render.com/deploy-rails#deploy-manually)



## Aggiorniamo il file `config/database.yml`

**Da Rails 7.1 FORSE possiamo SALTARE questo paragrafo**

> We’ll connect to your Render database by setting the `DATABASE_URL` environment variable, so you don’t need to make any other changes to your `config/database.yml` file.

Aggiorniamo il file per il deployment in produzione su render.

Open `config/database.yml` and find the *production section*. 

[Codice 01 - .../config/database.yml - linea: 18]()

```yaml
production:
  <<: *default
  database: ubuntudream_production
  username: ubuntudream
  password: <%= ENV["UBUNTUDREAM_DATABASE_PASSWORD"] %>
```


Modify it to gather the database configuration from the `DATABASE_URL` *environment variable*.

[Codice 02 - .../config/database.yml - linea: 82]()

```yaml
production:
  <<: *default
  #database: ubuntudream_production
  #username: ubuntudream
  #password: <%= ENV["UBUNTUDREAM_DATABASE_PASSWORD"] %>
  url: <%= ENV['DATABASE_URL'] %>
```



## Aggiorniamo la configurazione per l'ambiente di produzione 

**Da Rails 7.1 FORSE possiamo SALTARE questo paragrafo**

Open `config/environments/production.rb` and enable the *public file server* when the `RENDER` *environment variable* is present (which always is on Render).

[Codice 05 - .../config/environments/production.rb - linea: 23]()

```ruby
# Disable serving static files from the `/public` folder by default since
# Apache or NGINX already handles this.
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || ENV['RENDER'].present?
```

**ATTENZIONE!**
Su RAILS *7.1* questa riga è commentata ed il default è "disabled" (enabled = false).

```ruby
  # Disable serving static files from `public/`, relying on NGINX/Apache to do so instead.
  # config.public_file_server.enabled = false
```

**Sembra l'opposto di come ci servirebbe...**
**... ma la lascio così com'è e non la cambio.**




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
