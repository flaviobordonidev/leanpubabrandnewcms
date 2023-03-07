# <a name="top"></a> Cap 10.1 - Implementiamo il search

Inseriamo un form per la ricerca delle aziende composto da un campo di imput ed un pulsante di search.



## Risorse interne

- [99-rails_references/views/pagination]()



## Apriamo il branch "Users Index Search"

```bash
$ git checkout -b uis
```




## Inseriamo il form di ricerca sul view companies/index

Non essendo il form direttamente legato ad una tabella in passato avremmo usato "form_tag" ma oggi c'è "form_with".

***Codice 01 - .../views/companies/index.html.erb - linea:01***

```html+erb
  <%= form_with(url: "", method: "get", local:true) do %>
    <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "cerca..." %>
    <%= submit_tag "Cerca" %>
  <% end %>
```

La nuova sintassi "form_with" a confronto con la vecchia sintassi "form_tag": cambia solo la riga iniziale:

***Codice n/a - form_with vs form_tag - linea:01***

```html+erb
  <%= form_with(url: "", method: "get", local:true) do %>
  <%= form_tag "", method: "get" do %>
```

> Nota: Su rails 6 "form_with" di default è impostato come "remote" ossia ha "local:false", al contrario di "form_tag". Quindi per rimpiazzare "form_tag" con "form_with" dobbiamo esplicitare l'opzione ", local:true" altrimenti non funziona il submit.</br>
> Da rails 7 è impostato di default come "local" ossia ha "local:true" quindi si può omettere. [DAVERIFICARE]

Analizziamo il codice:

codice                    | descrizione
|:-                       |:-
`url: ""`                 | ricarica la stessa pagina. Ha bisogno di ", local:true" per funzionare.
`method: "get"`           | passa i parametri delle variabili direttamente nell'url
`text_field_tag :search`  | definisce un campo testo con nome "search"
`, params[:search]`       | opzione per il valore del campo. Ricaricando la pagina rimette nel campo text il valore che era stato digitato. (questo lo posso fare perché il form è inviato via "get")
`, placeholder: "cerca..."` | opzione per un segnaposto visibile quando non c'è nessun valore nel campo.


## Aggiorniamo il controller

Intercettiamo la variabile "search", che è passata nell'url dal metodo "get" di invio del form, e la usiamo per effettuare la nostra ricerca.

Nell'azione "index"

***Codice 02 - .../app/controllers/companies_controller.rb - linea:01***

```ruby
  def index
    params[:search] = "" if params[:search].blank?
    @companies = Company.search(params[:search])
```

Analizziamo il codice:

codice               | descrizione
|:-                  |:-
`params[:search] = "" if params[:search].blank?`  | se non è presente nell'url nessuna variabile "search" ne inizializziamo una con valore vuoto "". Altrimenti avremo errore nella query di ricerca.
`@companies = Company.search(params[:search])` | popoliamo la variabile di istanza @companies con tutte le aziende filtrate con il nostro scope "search()" a cui passiamo il valore di "params[:search]".

> Attenzione:</br> 
> "search()" non è un metodo di Rails. La definiamo **noi** nel model.



## Aggiorniamo il model

Definiamo il filtro "search()" che abbiamo deciso di usare sul controller. 

Nella sezione `# == Scopes`

***Codice 03 - .../app/models/company.rb - linea:01***

```ruby
  scope :search, -> (query) {where("name ILIKE ?", "%#{query.strip}%")}
```

Analizziamo il codice:

codice               | descrizione
|:-                  |:-
`->`                 | la freccia "->" è un modo compatto di usare la chiamata "lambda".

- 
  invece di "..., -> (query){..."  abbiamo "..., lambda {|query|...".

Il codice in alto può essere riscritto così:

***Codice n/a - .../app/models/company.rb - linea:01***

```ruby
  scope :search, lambda {|query| where("name ILIKE ?", "%#{query.strip}%")}
```


## I18n mel caso di gem `globalize`

Se avessimo usato la gemma `globalize` avremmo avuto il metodo `with_translations.`

***Codice 03 - .../app/models/company.rb - linea:01***

```ruby
  scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
```

 Invece noi usiamo `mobility` e c'è un suo metodo che vediamo più avanti.


Nota: Il "with_translations.where" effettua la ricerca anche nei campi tradotti nelle varie lingue. Se volessi limitare alla sola lingua scelta dovrei usare "with_translations(I18n.locale).where" ma questo ha un "bug" e mi crea dei records duplicati.

Questo ci può creare dei bugs apparenti.
Ad esempio se filtro per "m" mi appare anche il "Sig. Rossi" perché in inglese è "Mr. Rossi".
Nel nostro caso delle Aziende il problema lo vedo quando includo nel filtro la colonna "building" con la traduzione dinamica tramite globalize / i18n.
La cosa diventa ancora più strana quando avremo il doppio filtro Aziende e Persone.

Quindi meglio usare "with_translations(I18n.locale).where".
Risolviamo il bug dei records duplicati nel prossimo paragrafo.




## Workaround per il Bug su with_translations(I18n.locale).where

Risolviamo il bug dei records duplicati.




### Teoria

Si potrebbe provare ad usare `.distinct.select(` per eliminare i duplicati di `with_translations(I18n.locale).where`

- https://guides.rubyonrails.org/active_record_querying.html#joining-tables

```ruby
Author.left_outer_joins(:posts).distinct.select('authors.*, COUNT(posts.*) AS posts_count').group('authors.id')
```

Which produces:

```sql
SELECT DISTINCT authors.*, COUNT(posts.*) AS posts_count FROM "authors"
LEFT OUTER JOIN posts ON posts.author_id = authors.id GROUP BY authors.id
```

Which means: "return all authors with their count of posts, whether or not they have any posts at all"

Oppure `.uniq` vedi:

- https://stackoverflow.com/questions/39575398/rails-uniq-vs-distinct

[...]
Rails queries acts like arrays, thus .uniq produces the same result as .distinct, but

- `.distinct` is *sql query* method
- `.uniq` is *array* method

> `uniq` won't spawn additional sql query. `distinct` will do. But both results will be the same

Example:

```ruby
users = User.includes(:posts)
puts users
# First sql query for includes

users.uniq
# No sql query! (here you speed up you app)
users.distinct
# Second distinct sql query! (here you slow down your app)
```

This can be useful to make performant application

> Hint:</br>
> Same works for:
> - .size     vs .count;
> - present?  vs .exists?
> - map       vs pluck

[...]




### Workaround applicato nel view 

Usiamo `.uniq` poco prima di fare `.each do ...` -> `@companies.uniq.each do ...`

> Yea! `.uniq` ha funzionato!!! </br>
> (Non è il massimo dal punto di vista teorico delle prestazioni perché sto filtrando i dati un'altra volta, ma al momento funziona egregiamente)

Per rimediare al problema dei records duplicati usiamo il metodo `.uniq`

- Siccome sconsiglia di usarlo nella catena delle chiamate per le query (nelle "relations") lo applichiamo direttamente nelle views.
Altrimenti nel controller dovremmo creare una nuova variabile di istanza del tipo: 
`@companies = @companieswithdupliceted.uniq`




### Workaround applicato nel controller

si può risalire ed applicare il workaround nel controller

```ruby
      companiesduplicated = Company.search(params[:search_master])
      @companies = companiesduplicated.uniq
```

ma guardando il codice sembra più pulito farlo su una riga

```ruby
      @companies = Company.search(params[:search_master]).uniq
```

ma in questo caso è evidente che siamo in un caso ***deprecato***:
In Rails 5+ `Relation#uniq` is deprecated and recommended to use `Relation#distinct` instead. 
See http://edgeguides.rubyonrails.org/5_0_release_notes.html#active-record-deprecations

Quindi meglio usare `.distinct`

```ruby
      @companies = Company.search(params[:search_master]).distinct
```



### Workaround applicato nel metodo

A questo punto torniamo da dove il bug è partito e risolviamolo direttamente nel metodo

```ruby
  scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%").distinct}
```

Ancora meglio mettiamolo subito dopo il metodo che ci genera i duplicati così è più evidente cosa stiamo risolvendo:

```ruby
  scope :search, -> (query) {with_translations(I18n.locale).distinct.where("name ILIKE ?", "%#{query.strip}%")}
```

Dopo questo lungo giro didattico abbiamo messo la patch direttamente dove serviva:

- `with_translations(I18n.locale)`          -> genera dei records duplicati 
- `with_translations(I18n.locale).distinct` -> non genera records duplicati 



## Verifichiamo preview

```bash
$ rails s
```

e vediamo sul nostro browser:

* https://mycloud9path.amazonaws.com/companies

Andiamo sul campo "cerca..." digitiamo "AB" e clicchiamo il bottone "search" per fare la ricerca.
vediamo che le aziende sono filtrate e l'url diventa:

* https://mycloud9path.amazonaws.com/companies?search=AB

Funziona tutto.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "Implement search form on companies"
```
