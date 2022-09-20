# <a name="top"></a> Cap new_rails_app.1 - Nuova app Rails

Abbiamo preparato tutto l'ambiente e adesso creaimo una nuova app Rails.


## Risorse interne:

- [01-base/01-new_app_with_ubuntu_multipass/06_00-new_app]()
- [ubuntudream/01-new_app]()



## Risorse esterne:

- [Getting Started with Ruby on Rails on Render](https://render.com/docs/deploy-rails)
- [Heroku devcenter - Getting Started on Heroku with Rails 7.x](https://devcenter.heroku.com/articles/getting-started-with-rails7)



## Rails new

In produzione sia su Heroku (heroku.com) che su Render (render.com) si utilizza postgreSQL quindi lo installiamo anche localmente.
Un'alternativa era quella di caricare la gemma "pg" solo per l'ambiente di produzione. Ma è preferibile usare nell'ambiente di sviluppo le stesse risorse usate in produzione.

```bash
$ cd ~/
$ rails --version
$ rails new my_app_name --database=postgresql
```

> Possiamo anche indicare una specifica versione di rails ad esempio `rails _7.0.1_ new bl7_0 --database=postgresql` ma può essere utile solo in casi particolari. Normalmente è preferibile non forzarla e lasciare quella di default che è la più attuale che trova installata.
