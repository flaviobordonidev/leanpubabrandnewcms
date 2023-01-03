# <a name="top"></a> Cap 10.1 - Implementiamo il search

Inseriamo un form per la ricerca delle aziende composto da un campo di imput ed un pulsante di search.



## Risorse interne

- [99-rails_references/views/pagination]()



## Apriamo il branch "Users Index Search"

```bash
$ git checkout -b uis
```



## Inseriamo il form di ricerca sul view users/index

Non essendo il form direttamente legato ad una tabella usiamo `form_with` con `url: ""`.

> In passato avremmo usato "form_tag" ma oggi c'è "form_with" che funziona per tutte le situazioni.

***Codice 01 - .../views/companies/index.html.erb - linea:112***

```html+erb
  <%= form_with(url: "", method: "get", local:true) do %>
    <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "cerca..." %>
    <%= submit_tag "Cerca" %>
  <% end %>
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

***Codice 02 - .../app/controllers/users_controller.rb - linea:01***

```ruby
  def index
    params[:search] = "" if params[:search].blank?
    #@users = User.search(params[:search])
    @pagy, @users = pagy(User.search(params[:search]), items: 6)
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

Nella sezione "# == Scopes"

***Codice 03 - .../app/models/user.rb - linea:36***

```ruby
  scope :search, -> (query) {where("first_name ILIKE ?", "%#{query.strip}%")}
```

> La freccia `->` è un modo compatto di usare la chiamata `lambda`.</br>
> Invece di `..., -> (query){...`  abbiamo `..., lambda {|query|...`.

Usando `lambda` il codice può essere riscritto così:

***Codice n/a - .../app/models/user.rb - linea:36***

```ruby
  scope :search, lambda {|query| where("first_name ILIKE ?", "%#{query.strip}%")}
```



## Implementiamo lo style

I got the following to work:

```html+erb
  <%= form_with(url: "", method: "get", local:true, class: "rounded position-relative") do %>
    <%= text_field_tag :search, params[:search], class: "form-control bg-transparent", placeholder: "cerca..." %>
    <%#= submit_tag "Cerca" %>
    <%= button_tag type: 'submit', class: "btn bg-transparent px-2 py-0 position-absolute top-50 end-0 translate-middle-y" do %>
      <i class="fas fa-search fs-6 "></i>
    <% end %>
  <% end %>
```

> `submit_tag` doesn't seem to take a block, so the way to do it is with `button_tag`.</br>
> In this case the "block" is:</br>
> `<%= ... do %>` </br>
>   `...` </br>
> `<% end %>` </br>



## Cerchiamo per first_name, last_name, user_name

Ampliamo la ricerca anche ad altri campi.

***Codice n/a - .../app/models/user.rb - linea:36***

```ruby
  scope :search, -> (query) {where("first_name ILIKE ? OR last_name ILIKE ? OR username ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
```


