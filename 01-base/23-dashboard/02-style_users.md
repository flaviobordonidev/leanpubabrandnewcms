{id: 01-base-23-dashboard_style_users-02-style_users}
# Cap 23.2 -- Implementiamo lo stile sugli Users

La gestione degli utenti è tutta fatta nel dashboard quindi impostiamogli lo stile "dashboard".
Applichiamo uno stile alla gestione degli utenti. Rendiamo più piacevole l'interfaccia grafica usando Bootstrap.

* formattiamo la tabella degli utenti ed i links con i pulsantini colorati.
* formattiamo la _form degli utenti abbellendola come faremo per authors/posts.

Senza passare per delle pagine statiche di mockups attiviamo bootstrap ed implementiamo direttamente sulle pagine users uno stile semplice.




## Apriamo il branch "Style Users"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b su
```




## Assegnamo il layout dashboard al controller degli utenti

{id: "01-23-02_01", caption: ".../app/controllers/users_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 4}
```
  layout 'dashboard'
```

[tutto il codice](#01-23-02_01all)




## Formattiamo users/index

Usiamo le classi html di Bootsrap per rendere la tabella "a strisce" in modo da evidenziare le varie righe.

{id: "01-23-02_02", caption: ".../app/views/users/index.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 12}
```
<table class="table table-striped">
```

per formattare il link edit facendolo sembrare un pulsante

{caption: ".../app/views/users/index.html.erb -- codice continua", format: HTML+Mako, line-numbers: true, number-from: 43}
```
        <td><%= link_to 'Edit', edit_user_path(user), class: 'btn btn-sm btn-warning' %></td>
```

per formattare il link destroy facendolo sembrare un pulsante

{caption: ".../app/views/users/index.html.erb -- codice continua", format: HTML+Mako, line-numbers: true, number-from: 44}
```
        <td><%= link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-sm btn-danger' unless user == current_user %></td>
```

lasciamo "show" come link 

Mettiamo il link per creazione di nuovo utente in alto a destra e lo facciamo sembrare un pulsante


{caption: ".../app/views/users/index.html.erb -- codice continua", format: HTML+Mako, line-numbers: true, number-from: 44}
```
<%= link_to 'New User', new_user_path, class: "btn btn-sm btn-success float-right" %>
<br/><br/>
```

infine incapsuliamo il tutto dentro la griglia di bootstrap

{caption: ".../app/views/users/index.html.erb -- codice continua", format: HTML+Mako, line-numbers: true, number-from: 7}
```
<div class="container-fluid">
  <div class="row no-gutter">
    <div class="col-md-12 col-lg-12">
```

[tutto il codice](#01-23-02_02all)




## Mettiamo l'elenco utenti in ordine alfabetico per nome

{id: "01-23-02_03", caption: ".../app/controllers/users_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 4}
```
    @pagy, @users = pagy(User.all.order(name: "ASC"), items: 6)
```

[tutto il codice](#01-23-02_03all)





## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users




## Formattiamo users/_form

Inseriamo innanzitutto il container bootstrap in users/edit e users/new ed impostiamo il valore della "scatola" yield(:page_title) sia su "new" che su "edit".

{id: "01-23-02_04", caption: ".../app/views/users/edit.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 7}
```
<%# == Meta_data ============================================================ %>

<% provide(:page_title, "Modifica Utente: #{@user.name}") %>

<%# == Meta_data - end ====================================================== %>

<div class="container-fluid">
```

[tutto il codice](#01-23-02_04all)


{id: "01-23-02_05", caption: ".../app/views/users/new.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 7}
```
<%# == Meta_data ============================================================ %>

<% provide(:page_title, "Nuovo Utente") %>

<%# == Meta_data - end ====================================================== %>

<div class="container-fluid">
```

[tutto il codice](#01-23-02_05all)


Dedichiamoci adesso alla formattazione del form di aggiunta/modifica utente. Implementiamo la griglia di bootstrap ed il componente cards.
Prepariamo un blocco di codice "mockup" da inserire dento il form; lo inseriamo subito dopo il "form_with".

{id: "01-23-02_06", caption: ".../app/views/users/_form.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= form_with(model: user, local: true) do |form| %>

  <div class="row">
    <!-- Basic info section -->
    <div class="col-md-6">
      <div class="card">
```

[tutto il codice](#01-23-02_06all)





## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users/1/edit




## Rendiamo dinamico

adesso iniziamo a sostituire un pezzo alla volta il codice del "mockup" in basso con la parte dinamica che interagisce con il database

Inseriamo tutto il codice del "mockup" all'interno del form, ossia spostiamo l' " <% end %> " in fondo ed indentiamo tutto il codice del "mockup". 
Nel card-body inseriamo il campo :title e visualizziamo nel titoletto il contenuto della "scatola vuota" yield(:page_title) che è impostato nella view "edit" o nella view "new".


Il titolo.

{id: "01-23-02_07", caption: ".../app/views/users/_form.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 7}
```
        <div class="card-body">
          <h5 class="card-title"><%= yield(:page_title) %></h5>
        </div>
```

questo ci evita di dover usare una chiamata if..else..end del tipo:

{caption: ".../app/views/users/_form.html.erb -- alternativa", format: HTML+Mako, line-numbers: true, number-from: 7}
```
        <div class="card-body">
          <% if user.new_record? %>
            <h5 class="card-title">Nuovo utente</h5>
          <% else %>
            <h5 class="card-title">Modifica: <%= user.name %></h5>
          <% end %>
```


Il menu a cascata

Aggiungiamo lo stile "class: "form-control"" al nostro menu a cascata

{caption: ".../app/views/users/_form.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 40}
```
                <%= form.select(:role, User.roles.keys.map {|role| [role.titleize,role]}, {}, {class: "form-control"}) %>
```

L'helper ".select" accetta due hash di opzioni, uno per select e il secondo per le opzioni html. Quindi diamo un hash vuoto di default come primo parametro dopo la lista degli elementi, ed aggiungiamo la nostra classe al secondo hash, ossia all'hash di html_options. ( https://stackoverflow.com/questions/4081907/ruby-on-rails-form-for-select-field-with-class )
Una volta aggiunto lo stile portiamo il menu a cascata nella nostra grid.


Il resto dei campi

Aggiungiamo lo stile al resto dei campi e portiamoli nel grid.

{caption: ".../app/views/users/_form.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 111}
```
            <div class="field">
              <%= form.label :name %>
              <%= form.text_field :name, class: "form-control" %>
            </div>
```

{caption: ".../app/views/users/_form.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 72}
```
            <div class="field">
              <%= form.label :video_vimeo, class: "control-label" %>
              <%= form.text_field :video_vimeo, class: "form-control" %><!-- parte di URL vimeo che identifica il video -->
            </div>
```


pulsante "submit". (Se non passo un nome al pulsante di submit -> non devo mettere la virgola per passare la "class:")

{caption: ".../app/views/users/_form.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 40}
```
            <div class="actions">
              <%#= form.submit %>
              <%#= form.submit "Aggiorna/Modifica", class: "btn btn-success btn-lg btn-block"%>
              <%= form.submit class: "btn btn-success btn-lg btn-block"%>
            </div>
```


[tutto il codice](#01-23-02_07all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users
* https://mycloud9path.amazonaws.com/users/1/edit
* https://mycloud9path.amazonaws.com/users/new




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Style users/_form"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku su:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge su
$ git branch -d su
```


aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#02-04-03_01)

{id="02-04-03_01all", title=".../app/views/layouts/dashboard.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<!DOCTYPE html>
<html>
  <head>
    <title><%= yield(:page_title) %> | MyApp</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <div class="container">
      
      <% if user_signed_in? %> <%= render 'layouts/dashboard_navbar' %><% end %>
  
      <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
      <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>
      
      <%= yield %>
      <p class="alert alert-info text-center">Solo per Autori</p>
    </div>
  </body>
</html>
```




[Codice 02](#02-04-03_02)

{id="02-04-03_02all", title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class Authors::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  layout 'dashboard'

  # GET /authors/posts
  # GET /authors/posts.json
  def index
    @posts = current_user.posts unless current_user.admin?
    @posts = Post.all if current_user.admin?
    authorize @posts
  end

  # GET /authors/posts/new
  def new
    #@post = Post.new
    @post = current_user.posts.new
    authorize @post
  end

  # GET /authors/posts/1/edit
  def edit
  end

  # POST /authors/posts
  # POST /authors/posts.json
  def create
    @post = Post.new(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/posts/1
  # PATCH/PUT /authors/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/posts/1
  # DELETE /authors/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
      authorize @post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :incipit, :content, :type, :video_youtube, :video_vimeo, :seocontent, :date_chosen, :user_id)
    end
end
```




[Codice 03](#02-04-03_03all)

{id="02-04-03_03", title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<%= form_with(model: post, local: true, url: authors_url) do |form| %>
  <% if post.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(post.errors.count, "error") %> prohibited this post from being saved:</h2>

      <ul>
      <% post.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :seocontent %>
    <%= form.text_area :seocontent %>
  </div>

  <div class="field">
    <%= form.label :date_chosen %>
    <%#= form.date_select :date_chosen %>
    <%= form.text_field :date_chosen %>
  </div>

  <div class="field">
    <%= form.label :user_id %>
    <%= form.text_field :user_id %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>



  <div class="row">
    <div class="col-md-4">
      <!--<div class="card" style="width: 18rem;">-->
      <div class="card">
        <div class="card-body">
            <h5 class="card-title">Nuovo Articolo o Modifica Articolo: Pincopallo della felice scelta che si ripropone con costanza</h5>
          <div class="field">
            <label>Title</label> 
            <input type="text" class="form-control">
          </div>
        </div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">
            <div class="field">
              <label>select_media</label> 
              <select name="select_media"><!-- menu a cascata (drop-down list) -->
                <option value="a">Immagine</option>
                <option value="b">Video youtube</option>
                <option value="c">Video vimeo</option>
                <option value="d">Audio</option>
              </select>
            </div>
          </li>
          <li class="list-group-item">
            <div class="field">
              <label class="control-label">Immagine</label>
              <br><img src="https://images.pexels.com/photos/634843/pexels-photo-634843.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=200" alt="Immagine demo presa da pexels.com" width="200" height="200"><br>
              <input type="file" name="myFile">
            </div>
          </li>
          <li class="list-group-item">
            <div class="field">
              <label class="control-label">Video YouTube</label>
              <input type="text" class="form-control" value="https://youtu.be/Ma_i0JvdNN0"><!-- parte di URL youtube o vimeo che identifica il video -->
            </div>
          </li>
          <li class="list-group-item">
            <div class="field">
              <label class="control-label">Video Vimeo</label>
              <input type="text" class="form-control" value="https://vimeo.com/user94273470/review/313142032/1326689190"><!-- parte di URL youtube o vimeo che identifica il video -->
            </div>
          </li>

          <li class="list-group-item">
            <div class="field">
              <label class="control-label">Immagine per i social. (476x249px)</label>
              <br><img src="https://images.pexels.com/photos/634843/pexels-photo-634843.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=476&w=249" alt="Immagine demo presa da pexels.com" width="200" height="200"><br>
              <input type="file" name="myFile"><!-- image 476x249 px -->
            </div>
          </li>
          <li class="list-group-item">
            <div class="field">
              <label class="control-label">Descrizione per i social.</label>
              <textarea name="incipit" rows="3" class='form-control'>Cari amici, guardate questo. E' una ficata!</textarea><!-- max 160 caratteri -->
            </div>
          </li>
          <li class="list-group-item">
            <div class="field">
              <label class="control-label">Tags (separati da virgola)</label>
              <textarea name="incipit" rows="2" class='form-control'>salute, sport, cucina mediterranea, mantenersi in forma</textarea>
            </div>
          </li>

          <li class="list-group-item">
            <div class="actions">
              <input type="submit" value="Salva l'articolo" class="btn btn-success btn-lg btn-block">
            </div>
          </li>
        </ul>
      </div>

    </div>
    
    <div class="col-md-8">
      <div class="field">
        <label class="control-label">Incipit</label>
        <textarea name="incipit" rows="3" class='form-control'>Descrizione che viene vista nell'elenco degli articoli. E' una parte introduttiva che termina nel [leggi tutto].</textarea>
      </div>

      <div class="field"><h6>---Read More---</h6></div>

      <div class="field">
        <label class="control-label">Corpo</label>
        <textarea name="incipit" rows="8" class='form-control'>Descrizione Dettagliata.</textarea>
      </div>
    </div>
  </div>
  
  
  
<% end %>
```
