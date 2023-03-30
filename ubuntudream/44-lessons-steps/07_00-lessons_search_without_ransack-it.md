# <a name="top"></a> Cap 10.1 - Implementiamo il search

Inseriamo un form per la ricerca delle lezioni composto da un campo di imput ed un pulsante di search.

> QUESTA PARTE È SOLO DIDATTICA!!</br>
> Mostra come avremmo impostato la ricerca se non avessimo avuto la gemma "ransack"



## Risorse interne

- [99-rails_references/views/pagination]()



## Apriamo il branch "Lessons Index Search"

```bash
$ git checkout -b lis
```



## Inseriamo il form di ricerca sul view lessons/index

Non essendo il form direttamente legato ad una tabella usiamo `form_with` con `url: ""`.

***Codice 01 - .../views/companies/index.html.erb - linea:112***

```html+erb
  <%= form_with(url: "", method: "get", local:true) do %>
    <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "cerca..." %>
    <%= submit_tag "Cerca" %>
  <% end %>
```

> Da rails 7 è impostato di default come "local" ossia ha "local:true" quindi si può omettere. [DAVERIFICARE]



## Aggiorniamo il controller

Intercettiamo la variabile "search", che è passata nell'url dal metodo "get" di invio del form, e la usiamo per effettuare la nostra ricerca.

Nell'azione "index"

***Codice 02 - .../app/controllers/lessons_controller.rb - linea:01***

```ruby
  def index
    #@lessons = Lesson.all
    #@pagy, @lessons = pagy(Lesson.all, items: 6)
    params[:search] = "" if params[:search].blank?
    @pagy, @lessons = pagy(Lesson.search(params[:search]), items: 6)
```

> Attenzione:</br> 
> "search()" non è un metodo di Rails. La definiamo **noi** nel model.



## Aggiorniamo il model

Definiamo il filtro "search()" che abbiamo deciso di usare sul controller. 

Nella sezione "# == Scopes"

***Codice 03 - .../app/models/lesson.rb - linea:36***

```ruby
  scope :search, -> (query) {where("name ILIKE ?", "%#{query.strip}%")}
```



## Implementiamo lo style

Adesso adattiamo il campo per fare le ricerche, allo stile di eduport.

```html+erb
            <%= form_with(url: "", method: "get", local:true, class: "border rounded p-2") do %>
              <div class="input-group input-borderless">
                <%= text_field_tag :search, params[:search], class: "form-control me-1", placeholder: "Find..." %>
                <%= button_tag type: 'submit', class: "btn btn-primary mb-0 rounded z-index-1" do %>
                  <i class="fas fa-search"></i>
                <% end %>
              </div>
            <% end %>
```


