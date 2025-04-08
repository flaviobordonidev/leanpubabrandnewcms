{id: 50-elisinfo-04-Companies-10-companies_index_pagination}
# Cap 4.10 -- La paginazione per le aziende

Abbiamo già installato, implementato e usato la gemma "pagy" nella sezione 01-base/17-pagination.
Adesso usiamola per companies.




## Apriamo il branch "Companies Index Pagination"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b cip
```




## Implementiamo la paginazione per companies_controller

Abbiamo già inserito la chiamata a pagy in application_controller. Adesso che abbiamo incluso pagy possiamo chiamare la funzione "pagy()" nelle azioni dei nostri controllers. Implementiamo la paginazione nell'azione index di eg_posts_controller

{id: "50-04-10_01", caption: ".../app/controllers/companies_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
    @pagy, @companies = pagy(Company.search(params[:search]).order(created_at: "DESC"), items: 2)
```

[tutto il codice](#50-04-10_01all)

Analiziamo il codice:

* .order(created_at: "DESC")  : Di default l'ordinamento è crescente in base l'ultima modifica fatta, quindi ogni modifica l'utente va in fondo all'elenco. Per lasciare un elenco più "statico" inseriamo l'ordinamento decrescente in base alla creazione.
* , items: 2                  : Di default sono impostati 20 records ogni pagina; li riduciamo a 2 così avremo attivi i links per la paginazione.




## Implementiamo la pagina companies/index

Abbiamo già incluso il frontend di pagy a livello di "application_helper" con "include Pagy::Frontend"; adesso lo possiamo usare nelle views.

Usiamo l'helper "pagy_nav()" messo a disposizione da pagy.
Anche se pagy già evita query-injections, per essere esplicitamente prudenti usiamo "sanitize".

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= sanitize pagy_nav(@pagy) %>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/companies

E vediamo la paginazione. Al momento i link sono disattivati perché abbiamo pochi articoli.



