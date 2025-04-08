# <a name="top"></a> Cap 10.1 - Implementiamo il search

Inseriamo un form per la ricerca delle lezioni composto da un campo di imput ed un pulsante di search.

> nota: per la ricerca abbiamo utilizzato la gemma `ransack`.</br>
> Avendo già installato anche la gemma `mobility-ransack` implementiamo la ricerca che gestisce anche l'internazionalizzazione "In18".



## Risorse interne

- [ubuntudream/35-users_search_ransack/01_00-user_search-it.md]()
- [99-rails_references/views/pagination]()



## Apriamo il branch "Lessons Index Search"

```bash
$ git checkout -b lis
```



## Inseriamo il form di ricerca sul view lessons/index

Non essendo il form direttamente legato ad una tabella usiamo `form_with` con `url: ""`.


***Codice 01 - .../views/lessons/index.html.erb - linea:77***

```html+erb
<%= search_form_for @q do |f| %>
		<%= hidden_field_tag :locale, params[:locale] %>
    <%= f.search_field :name_cont, placeholder: "Search..." %>
    <%= f.submit "Search!" %>
<% end %>
```

> Da rails 7 `local:true` è impostato di default, quindi si può omettere. [DAVERIFICARE]
>
> Per far sì che mantenga la lingua dobbiamo passargli anche il parametro "locale" e questo lo facciamo attraverso un campo nascosto che chiamiamo `:locale` a cui passiamo il valore attuale del locale `params[:locale]`.
>
> la parte "ransack" è nel nome del campo "search_field" ossia: `:name_cont`.</br>
> Più specificamente il suffisso `_cont` che verifica i campi della tabella che "contengono" la stringa messa nell'input field "search".
> [Ransack: search-matches](https://activerecord-hackery.github.io/ransack/getting-started/search-matches/)



## Aggiorniamo il controller per effettuare le ricerca tramite `title`

Intercettiamo la variabile "search", che è passata nell'url dal metodo "get" di invio del form, e la usiamo per effettuare la nostra ricerca.

Nell'azione "index"

***Codice 02 - .../app/controllers/lessons_controller.rb - linea:01***

```ruby
  def index
    #@lessons = Lesson.all
    #@pagy, @lessons = pagy(Lesson.all, items: 3)
    @q = Lesson.ransack(params[:q])
    @pagy, @lessons = pagy(@q.result(distinct: true), items: 6)
```

> Per la ricerca sfruttiamo la gemma `ransak`.



## Implementiamo lo style del tema "eduport"

Adesso adattiamo il campo per fare le ricerche, allo stile di eduport.

***Codice 03 - .../views/lessons/index.html.erb - linea:77***

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



## Come avremmo fatto senza Ransak

A scopo puramente didattico vediamo come avremmo impostato la ricerca senza usare Ransak.

> In questo caso **senza** la gestione dell'internazionalizzazione "In18".

Avremmo **aggiornato la view** in questo modo.

Nella view `lessons/index` avremmo insertio il form di ricerca così:

***Codice n/a - .../views/lessons/index.html.erb - linea:88***

```html+erb
  <%= form_with(url: "", method: "get", local:true) do %>
    <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "cerca..." %>
    <%= submit_tag "Cerca" %>
  <% end %>
```

> Non essendo il form direttamente legato ad una tabella usiamo `form_with` con `url: ""`.

Avremmo **aggiornato il controller** in questo modo.

Nell'azione "index"

***Codice n/a - .../app/controllers/lessons_controller.rb - linea:01***

```ruby
  def index
    #@lessons = Lesson.all
    #@pagy, @lessons = pagy(Lesson.all, items: 6)
    params[:search] = "" if params[:search].blank?
    @pagy, @lessons = pagy(Lesson.search(params[:search]), items: 6)
```

> Attenzione:</br> 
> "search()" non è un metodo di Rails. La definiamo **noi** nel model.

Avremmo quindi dovuto **aggiornare anche il model**

Nella sezione "# == Scopes"

***Codice n/a - .../app/models/lesson.rb - linea:36***

```ruby
  scope :search, -> (query) {where("name ILIKE ?", "%#{query.strip}%")}
```

Avremmo poi aggiornato lo stile della view per adattarla al tema "eduport" in questo modo:

***Codice n/a - .../views/lessons/index.html.erb - linea:88***

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



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_00-users_form_i18n-it.md)
