# <a name="top"></a> Cap 2.3 - In produzione con Render

Invece di usare heroku usiamo Render in produzione perché heroku da Novembre/2022 toglierà l'opzione gratuita e sarà solo a pagamento.
Render invece ha un'opzione gratuita e si può direttamente scalare a pagamento da quella.

Facciamo un primo deploy in produzione senza ottimizzazione del codice.
Questo è solo per vedere che su Render funziona tutto:
- la creazione del database PostgreSQL
- la creazione del Web Service e relativo collegamento a GitHub e al database PostgreSQL

> per fare i collegamenti ci servirà:
> - l'`Internal Database URL` del nostro database PostgreSQL su Render.
> - la `masterkey` della nostra applicazione.

Più avanti questo webservice lo cancelliamo e ne creiamo un'altro basato sulle ottimizzazioni fatte nel codice. (Eventualmente applichiamo la modifiche senza cancellarlo)



## Risorse esterne

- [Update Your App For Render](https://render.com/docs/deploy-rails#update-your-app-for-render)
- [Creating a Database](https://render.com/docs/databases)




## Creiamo il database PostgreSQL su render.com

Create a new PostgreSQL database on Render. Note your database internal database URL; you will need it later. You can give your database a memorable name (which you can change at any time).

> Attenzione: The `database name` and `user name` **cannot** be changed after creation. <br/>
> We generate random values for them if you omit them.

Che nome diamo al database?

Usiamo quello che abbiamo già usato nella nostra app.
Abbiamo già i database PostgreSQL per lo sviluppo (`ubuntudream_development`) e per i test (`ubuntudream_test`).

Adesso creiamo su Render il database di produzione (`ubuntudream_production`).


New PostgreSQL

- `Name`: ubuntudream_production
- `Database`: ubuntudream_production
- `user`: ubuntu
- `Region`: Frankfurt EU Central
- `PostgreSQL Version`: 14

Creiamo il database.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig01-render_postgresql_new.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig02-render_postgresql_info1.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig03-render_postgresql_info2.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig04-render_postgresql_info3.png)


Prendiamo l'`Internal Database URL`: `postgres://ubuntu:03...f-k/ubuntudream_production`.




## Prendiamo la masterkey

Il file `master.key` ha una semplice stringa usata come chiave principale di crittatura. Di default Rails crea una stringa esadecimale di 32bytes.

***code 01 - .../config/master.key - line:01***

```bash
f458b1a6862a56b7474b9e734d7b01c4
```

> Siccome questa è la chiave per decifrare tutte le secrets questa è inclusa di default in `.gitignore` e quindi non è passata ai repositories remoti (es: GitHub).
>
> la possiamo anche visualizzare con `$ cat config/master.key`



## Creiamo il Web Service su render.com

Create a new Web Service, pointing it to your application repository (make sure Render has a permission to access it).