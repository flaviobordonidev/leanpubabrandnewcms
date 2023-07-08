# restart db

[ATTENZIONE-guarda:]
- [Vedi code_references/postgresql/04_00-backup_and_recover_database_render-it]()
  nel capitolo qui sopra facciamo la stessa cosa di questo capitolo ma la facciamo meglio!!!

[TODO: INTEGRARE CAPITOLO NEL LINK IN ALTO CON QUESTO CAPITOLO]



--
In questo capitolo rimettiamo in piedi il database partendo da zero.

Lo scenario è quello di un database su render.com di cui non è stato fatto backup e che è stato cancellato. Ad esempio il database free che dopo 3 mesi è cancellato.

I passaggi sono:
1. ricreiamo un nuovo database

2. lo colleghiamo alla nostra applicazione
  > per fare i collegamenti ci servirà:
  > - l'`Internal Database URL` del nostro database PostgreSQL su Render.
  > - la `masterkey` della nostra applicazione.

3. lo popoliamo di dati tramite seeds



## Risorse esterne

- [Update Your App For Render](https://render.com/docs/deploy-rails#update-your-app-for-render)
- [Creating a Database](https://render.com/docs/databases)



## Creiamo il nuovo database PostgreSQL su render.com

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
- `PostgreSQL Version`: 15

Creiamo il database.


![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig01-render_postgresql_new.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig02-render_postgresql_info1.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig03-render_postgresql_info2.png)


Prendiamo l'`Internal Database URL`: `postgres://ubuntu:06...f-k/ubuntudream_production`.



## Colleghiamo il Web Service *ubuntudream*

Su render.com -> Dashboard -> web service "ubuntudream" (i web service hanno l'icona del mondo).
Andiamo su "Environment" e modifichiamo l'`Environment Variable` DATABASE_URL.

KEY	VALUE of `Environment Variables`
- DATABASE_URL      :	the internal database URL for the database you created above
- RAILS_MASTER_KEY  :	lasciamo il valore che c'è (the content of the config/master.key file)

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/03_fig07-render_deploy3.png)

That’s it! You can now finalize your service deployment. It will be live on your .onrender.com URL as soon as the build finishes.

- https://ubuntudream.onrender.com/



## Verifichiamo

Per farlo funzionare dobbiamo rilanciare un `Manual Deploy -> Deploy latest commit`
A volte ci può volere qualche minuto prima che le modifiche siano visibili.

nell'url: https://ubuntudream.onrender.com/
Ci appare il login.
Però il database è ancora vuoto



## Connettiamoci al databas PostgreSQL di produzione

Su *render.com* andiamo nel database di produzione `ubuntudream_production` e copiamoci il codice su `Connect -> External Connection -> PSQL Command`

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/postgresql/03_fig01-render_postgres_external_connection.png)

Usiamo quel codice sul nostro terminale.
Esempio:

```bash
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
```



## Verifichiamo che il database è vuoto

Una volta collegati al database possiamo usare i comandi SQL di postgresql.

```sql
\d users
SELECT * FROM users;
```

> per uscire dalle schermate premere il tasto "q"



## Aggiungiamo manualmente l'utente Ann

Aggiungiamo un record al nostro database remoto (production) su render.com.

```sql
INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

>l'encrypted_password l'abbiamo copiata dal postgresql db locale (development), in cui abbiamo già inserito l'utente Ann usando la password in chiaro e rails l'ha archiviata criptata nel database. Aggiungendola criptata possiamo fare il login in remoto con la stessa password in chiaro usata in locale. 


Verifichiamo che l'utente è stato inserito correttamente.

```sql
SELECT * FROM users;
```

Adesso se riandiamo sulla nostra app in produzione (il web service *ubuntudream*)...

- https://ubuntudream.onrender.com/

...Possiamo fare login.

