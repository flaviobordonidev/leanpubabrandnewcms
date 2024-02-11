# <a name="top"></a> Cap 2.3 - In produzione con Render

Facciamo un primo deploy in produzione senza ottimizzazione del codice. Questo per vedere che funziona tutto:
- la creazione del database PostgreSQL
- la creazione del Web Service e relativo collegamento a GitHub e al database PostgreSQL

> Usiamo Render perché heroku da Novembre/2022 ha tolto l'opzione gratuita ed è solo a pagamento.
> Render invece ha un'opzione gratuita e si può direttamente scalare a pagamento.



## Risorse esterne

- [render: Update Your App For Render](https://render.com/docs/deploy-rails#update-your-app-for-render)
- [render: Creating a Database](https://render.com/docs/databases)
- [render: Docker vs. native runtimes](https://docs.render.com/docker)



## Creiamo il database PostgreSQL su render.com

Create a new PostgreSQL database on Render. Note your database internal database URL; you will need it later. You can give your database a memorable name (which you can change at any time).

> Attenzione: The `database name` and `user name` **cannot** be changed after creation. <br/>
> We generate random values for them if you omit them.

Che nome diamo al database?

Usiamo quello che abbiamo già nella nostra app su (`config/database.yml`).
Abbiamo già i database PostgreSQL per lo sviluppo (`ubuntudream_development`) e per i test (`ubuntudream_test`).

Adesso creiamo su Render il database di produzione (`ubuntudream_production`).


New PostgreSQL

- `Name`: ubuntudream_production
- `Database`: ubuntudream_production
- `user`: ubuntudream
- `Region`: Frankfurt EU Central
- `PostgreSQL Version`: 14

Creiamo il database.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig01-render_postgresql_new.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig02-render_postgresql_info1.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig03-render_postgresql_info2.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig04-render_postgresql_info3.png)


IMPORTANTE
> Su render.com per collegare il database appena creato al "Web Service" che creiamo più avanti, ci servirà:
> - l'`Internal Database URL` del nostro database PostgreSQL su Render.
> - la `masterkey` della nostra applicazione.

Prendiamo l'`Internal Database URL`: `postgres://ubuntudream:FE7...glyz2-d/ubuntudream_production_64p3`.



## Prendiamo la masterkey

Il file `master.key` ha una semplice stringa usata come chiave principale di crittatura. Di default Rails crea una stringa esadecimale di 32bytes.

*** Codice 01 - .../config/master.key - linea: 1 ***

```bash
seb666...4bh17
```

> Siccome questa è la chiave per decifrare tutte le secrets questa è inclusa di default in `.gitignore` e quindi non è passata ai repositories remoti (es: GitHub).
>
> la possiamo anche visualizzare con `$ cat config/master.key`



## Creiamo il Web Service su render.com

Create a new Web Service, pointing it to your application repository (make sure Render has a permission to access it).

Scegli il repository GitHub da cui prendere i files. Nel nostro caso "ubuntudream".

- Name : ubndudream3
- Region : Frankfurt (EU Central)
- Branch : main
- Runtime : Ruby

> ATTENZIONE!
> Select `Ruby` for the `environment`.</br>
> Di default l'`environment` è impostato su `docker` e dobbiamo cambiamolo su `Ruby`.
> Render has native support for many popular languages, including Node.js, Python, Ruby, Go, Rust, and Elixir. *You don’t need to use Docker on Render* if your service can be deployed with a native runtime and a build and start command.

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig05-render_deploy1.png)

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig06-render_deploy2.png)

> Le variabili `Build Command` e `Start Command` nei prossimi capitoli le cambieremo inserendo i files della nostra applicazione Rails con le ottimizzazioni per la produzione.


Selezioniamo il piano gratuito

- Free plan


Add the following `Environment Variables` under the `Advanced section`:
KEY	VALUE of `Environment Variables`

- DATABASE_URL      :	the internal database URL for the database you created above
                        postgres://ubuntudream:FE7...glyz2-d/ubuntudream_production_64p3
- RAILS_MASTER_KEY  :	the content of the config/master.key file
                        seb666...4bh17

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig07-render_deploy3.png)

That’s it! 
Facciamo click sul bottone *Create Web Service*.
You can now finalize your service deployment. It will be live on your .onrender.com URL as soon as the build finishes.

- https://ubuntudream.onrender.com/



## Verifichiamo

A volte ci può volere qualche minuto prima che le modifiche siano visibili.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/02_00-github_initializing-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/04_00-render_second_deployment-it.md)
