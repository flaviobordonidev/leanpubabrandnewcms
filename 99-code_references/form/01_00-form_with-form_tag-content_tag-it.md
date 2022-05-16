# <a name="top"></a> Cap form_with.2 - Forms
Uno per controllarli tutti...
Il nuovo helper "form_with" sostituisce entrambe le vecchie versioni "form_tag" e "form_for".



## Risorse esterne

Rivediamo i vecchi codici con content_tag, form_tag, ... con i nuovi metodi di Rails

- https://www.justinweiss.com/articles/the-lesser-known-features-in-rails-5-dot-1/
- https://blog.engineyard.com/using_form_with-vs-form_for-vs-form_tag

- https://medium.com/@michellekwong2/form-tag-vs-form-for-vs-form-with-fa6e0ac73aac
- https://gorails.com/episodes/upgrade-from-turbolinks-to-hotwire-and-turbo?autoplay=1



## *local: true* non serve più

Su *form_with* l'opzione *local: true* è stata messa di default e quindi è superfluo riportarla.

Le due linee di codice seguenti sono in pratica identiche:

***codice n/a - .../app/views/posts/_form.rb - line:1***

```html+erb
<%= form_with(model: post, local: true) do |form| %>
```

***codice n/a - .../app/views/posts/_form.rb - line:1***

```html+erb
<%= form_with(model: post) do |form| %>
```

> è per questo che quando facciamo `rails g scaffold ...` non ci sarà l'opzione *, local: true*.



## Esempio preso dal manuale di Rails:

* https://guides.rubyonrails.org/form_helpers.html

```
<%= form_with(url: "", method: "get") do %>
  <%= label_tag(:search, "Search for:") %>
  <%= text_field_tag(:search) %>
  <%= submit_tag("Search") %>
<% end %>
```




## Forms non legati ad un model

L'esempio classico è il form di "search" per inviare una query di ricerca.

Il vecchio metodo è usare form_tag e content_tag come in questo esempio:

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <%= form_tag "", method: "get", role: "search", class: 'bottom-pad' do %>
      <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "cerca..." %>
      <%= content_tag :button, type: "submit", class: "btn btn-primary" do %>
          <span class= "glyphicon glyphicon-search"></span>CERCAME
        <% end %>      
  <% end %>
```


If you don't pass a model, form_with behaves like form_tag.

<%= form_with url: messages_path do |form| %>
  <%= form.text_field :subject %>
<% end %>
would generate

<form action="/messages" method="post" data-remote="true">
  <input type="text" name="subject">
</form>




## Esempio di "form search" su Companies index

Il vecchio codice usato fino ad elisinfo 6 era:

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
              <%= form_tag "", method: "get", role: "search", class: 'bottom-pad' do %>
              
                <div class="input-group left-pad">
                  <%= text_field_tag :search, params[:search], class: "form-control", placeholder: t(".form_search_placeholder") %>
                  <div class="input-group-btn right-pad">
                    <%= content_tag :button, type: "submit", class: "btn btn-primary" do %>
                      <span class= "glyphicon glyphicon-search"></span>CERCAME
                    <% end %>      
                  </div><!-- /input-group-btn -->
                </div><!-- /input-group -->
              
              <% end %>
```

La sua versione con form_with è:

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
              <%= form_with url: "", method: "get", local:true, role: "search", class: 'bottom-pad' do %>
              
                <div class="input-group left-pad">
                  <%= text_field_tag :search, params[:search], class: "form-control", placeholder: t(".form_search_placeholder") %>
                  <div class="input-group-btn right-pad">
                    <%= content_tag :button, type: "submit", class: "btn btn-primary" do %>
                      <span class= "glyphicon glyphicon-search"></span>CERCAME
                    <% end %>      
                  </div><!-- /input-group-btn -->
                </div><!-- /input-group -->
              
              <% end %>
```

Abbiamo cambiato SOLO 1 RIGA. Tutto il resto è rimasto uguale.
   - invece di 'form_tag ""' abbiamo usato 'form_with url: ""'
   - inoltre dobbiamo usare l'opzione ', local:true' altrimenti non esegue il submit.


Una versione semplificata è:

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
              <%= form_with(url: "", method: "get", local:true) do %>
                  <%= text_field_tag :search, params[:search], class: "form-control", placeholder: "cerca...") %>
                  <%= submit_tag "Cerca" %>
              <% end %>
```



## Tag label

* https://stackoverflow.com/questions/12534857/including-form-elements-in-a-label-tag-in-rails

You can use the block syntax of label_tag. Something like this:

<%= label_tag 'answer' do %>
  Give it to me: <%= text_field_tag 'answer', @prev_answer %>
<% end %>

More info:

* https://openmonkey.com/writing/2010/03/30/rails-label-helpers-with-blocks/
* https://stackoverflow.com/questions/6088348/passing-block-to-label-helper-in-rails3

