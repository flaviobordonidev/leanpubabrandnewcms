





















## Verifichiamo preview

Attiviamo il webserver

```bash
$ rails s -b 192.168.64.3
```

Per verificarlo dobbiamo andare alla pagina **/users/sign_in** quindi all'URL:

- http://192.168.64.3:3000/users/sign_in




## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Popolate users table"
```



## Chiudiamo il branch

Se va tutto bene chiudiamo il branch e facciamo il merge.

```bash
$ git checkout main
$ git merge ldi
$ git branch -d ldi
```



## Facciamo un backup su Github

Mettiamo tutto su Github. Questo ci serve sia come backup sia come punto di appoggio per andare in produzione più facilmente con `render.com`.

```bash
$ git push origin main
```



## Pubblichiamo in produzione

In realtà la pubblicazione la fa in automatico ogni volta che facciamo il backup su Github.

Possiamo forzare la pubblicazione andando nel sito `render.com`.

`Dashboard -> ubuntudream -> Manual Deploy -> Deploy latest commit`



## Popoliamo da terminale il database su render.com

Se abbiamo una versione a pagamento abbiamo disponibile la console remota tramite SSL e quindi possiamo ridare semplicemente gli stessi comandi.

Se invece siamo sulla versione gratuita dobbiamo collegarci direttamente al database PostgreSQL di render.com ed inserire i dati lì.

La difficoltà è l'inserimento della password perché dobbiamo mettere quella già criptata. Quindi ci colleghiamo prima al PostgreSQL locale e ce la copiamo e poi la usiamo nel database remoto di postgresql.

```sql
$ psql postgres
> \c ubuntudream_development
> SELECT * FROM users;
```

Ci copiamo i dati (ad esempio):

- id                 : 1
- username           : 'Ann'
- email              : 'ann@test.abc'
- encrypted_password : '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO'
- created_at         : '2022-10-08 23:30:28.257872'
- updated_at         : '2022-10-08 23:30:28.257872'

Usciamo con `\q` oppure su un nuovo terminale:

```sql
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
> INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

> Per approfondimenti vedi: [code_reference/postgresql]() 


> Un'altra possibilità per ovviare al fatto che sulla versione gratuita non c'è il collegamento SSL e quindi no possiamo creare l'utente da terminale, è quello di inserirlo direttamente tramite web gui.
La web gui la creiamo nei prossimi capitoli.



## Verifichiamo produzione

Verifichiamo la nostra applicazione in produzione.
Andiamo all'URL:

- https://ubuntudream.onrender.com//users/sign_in

Usiamo le credenziali di login create su development e ricopiate nel database di produzione.

```
email     : ann@test.abc
password  : passworda
```

> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati se proviamo di nuovo veniamo riportati sulla pagina di *root* con l'avviso: "You are already signed in."

> Se non abbiamo fatto il copia/incolla della password tra i due database PostgreSQL di sviluppo e di produzione, possiamo aspettare i prossimi capitoli in cui la inseriremo tramite web gui.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_00-authentication-devise_install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_00-users_table-it.md)
