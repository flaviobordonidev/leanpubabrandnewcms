# Blog - visualiziamo articolo

Iniziamo dalla pagina dell'articolo. 
rendiamo dinamica la pagina dell'articolo prendendo i dati dal database.




## Apriamo il branch "Posts Show"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b ps
```







## Adattiamo il layout 

abbiamo già creato il file layouts/pofo.html.erb ed indicato a controllers/posts_controller.rb di usare quel layout

{title=".../app/controllers/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class PostsController < ApplicationController
  layout 'pofo'
```






## Aggiungiamo campi alla tabella posts per mockups/blog_post_layout_05

Nel template pofo sono utilizzati più elementi rispetto a quelli che abbiamo finora nella nostra tabella. Ci sono cinque immagini con relativo testo.

I campi dinamici che ci si presentano sulla pagina posts/show di pofo sono i seguenti:

- main_image              : già inserita nel model via ActiveStorage
- title                   : già in tabella
- published_at            : già in tabella
- author_name             : già in tabella urers come colonna "name"
- tags                    : già inserito nel model via gem acts-as-taggable-on

- central_paraghraph_title          : string da aggiungere
- central_paraghraph_content        : text da aggiungere
- central_paragraph_image           : da aggiungere nel model via ActiveStorage
- central_paragraph_left_title      : string da aggiungere
- central_paraghraph_left_content   : text da aggiungere
- central_paragraph_right_title     : string da aggiungere
- central_paraghraph_right_content  : text da aggiungere

- parallax_paraghraph_title         : string da aggiungere
- parallax_paraghraph_content       : text da aggiungere
- parallax_paragraph_image          : da aggiungere nel model via ActiveStorage

- paragraph_one_title         : string da aggiungere
- paragraph_one_content       : text da aggiungere
- paragraph_one_image         : da aggiungere nel model via ActiveStorage
- paragraph_one_image_label   : string

- paragraph_two_title        : string da aggiungere
- paragraph_two_content      : text da aggiungere
- paragraph_two_image        : da aggiungere nel model via ActiveStorage
- paragraph_two_image_label  : string


Normalizzando la pagina potremmo gestire con una sottotabella collegata uno-a-molti ma al momento aggiungiamo delle colonne alla tabella lasciando lo stesso nome e differenziandole con un numero progressivo aggiunto alla fine.


- main_image              : già inserita nel model via ActiveStorage
- title                   : già in tabella
- published_at            : già in tabella
- author_name             : già in tabella urers come colonna "name"
- tags                    : già inserito nel model via gem acts-as-taggable-on

- paraghraph_title1       : string da aggiungere
- paraghraph_content1     : text da aggiungere
- paragraph_image1        : da aggiungere nel model via ActiveStorage

- paragraph_title2        : string da aggiungere
- paraghraph_content2     : text da aggiungere

- paragraph_title3        : string da aggiungere
- paraghraph_content3     : text da aggiungere

- paraghraph_title4       : string da aggiungere
- paraghraph_content4     : text da aggiungere
- paragraph_image4        : da aggiungere nel model via ActiveStorage

- paragraph_title5        : string da aggiungere
- paragraph_content5      : text da aggiungere
- paragraph_image5        : da aggiungere nel model via ActiveStorage
- paragraph_image_label5  : string

- paragraph_title6        : string da aggiungere
- paragraph_content6      : text da aggiungere
- paragraph_image6        : da aggiungere nel model via ActiveStorage
- paragraph_image_label6  : string


Questo ci permetterebbe di gestire il tutto con una tabella "paragraphs" collegata 1-a-molti. La tabella paragraph avrebbe i campi:

- paragraph_style        : boolean/enum da aggiungere
- paragraph_title        : string da aggiungere
- paragraph_content      : text da aggiungere
- paragraph_image        : da aggiungere nel model via ActiveStorage
- paragraph_image_label  : string


paragraph_style avrà {central, parallax, standard)



Quindi implementiamoli nella nostra tabella posts

{title="terminal", lang=bash, line-numbers=off}
```
$ rails g migration AddParagraphColumnsToPosts paragraph_title1:string paragraph_content1:text paragraph_title2:string paragraph_content2:text paragraph_title3:string paragraph_content3:text paragraph_title4:string paragraph_content4:text paragraph_title5:string paragraph_content5:text paragraph_image_label5:string paragraph_title6:string paragraph_content6:text paragraph_image_label6:string
```

questo crea il migrate

{id="02-06-01_01", title=".../db/migrate/xxx_add_paragraph_columns_to_posts.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class AddParagraphColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :paraghraph_title1, :string
    add_column :posts, :paragraph_content1, :text
    add_column :posts, :paragraph_title2, :string
    add_column :posts, :paragraph_content2, :text
    add_column :posts, :paragraph_title3, :string
    add_column :posts, :paragraph_content3, :text
    add_column :posts, :paragraph_title4, :string
    add_column :posts, :paragraph_content4, :text
    add_column :posts, :paragraph_title5, :string
    add_column :posts, :paragraph_content5, :text
    add_column :posts, :paragraph_image_label5, :string
    add_column :posts, :paragraph_title6, :string
    add_column :posts, :paragraph_content6, :text
    add_column :posts, :paragraph_image_label6, :string
  end
end
```

[Codice 01](#02-06-01_01all)


eseguiamo il migrate

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails db:migrate
```




### Aggiungiamo le colonne paragraph_image via ActiveStorage nel model

aggiungiamoli nella sezione "# == Attributes =", sottosezione "## ActiveStorage"

{id="02-06-01_01", title=".../app/models/post.rb", lang=ruby, line-numbers=on, starting-line-number=8}
```
  ## ActiveStorage
  has_one_attached :main_image
  has_one_attached :paragraph_image1
  has_one_attached :paragraph_image4
  has_one_attached :paragraph_image5
  has_one_attached :paragraph_image6
```

[Codice 02](#02-06-01_01all)




### aggiorniamo il controller

aggiungiamo i campi nella withelist di authors/posts

{id="02-06-01_01", title=".../db/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=79}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :incipit, :content, :type_of_content, :video_youtube, :video_vimeo, :seocontent, :date_chosen, :user_id, :main_image, :published, :published_at, :paragraph_title1, :paragraph_content1, :paragraph_image1, :paragraph_title2, :paragraph_content2, :paragraph_title3, :paragraph_content3, :paragraph_title4, :paragraph_content4, :paragraph_image4, :paragraph_title5, :paragraph_content5, :paragraph_image5, :paragraph_image_label5, :paragraph_title6, :paragraph_content6, :paragraph_image6, :paragraph_image_label6)
    end
```

[Codice 03](#02-06-01_01all)

Abbiamo finito con l'inserimento dei nuovi campi. Passiamo adesso alle views




## Aggiorniamo la view authors/posts/_form

aggiungiamo le nuove colonne nel partial "form" della cartella authors/posts

Note: Cercando la differenza tra "content" e "description" nei tags HTML uno è usato per "plain text" l'altro per testo formattato.
Quindi usiamo:

* description : quando ho un campo di testo semplice
* content     : quando ho un campo in cui uso trix


inseriamo "central_paraghraph"

{id="02-06-01_01", title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=102}
```
      <div class="field"><br/><h6>---Central paragraph---</h6></div>

      <div class="field">
        <%= form.label :paraghraph_title1 %>
        <%= form.text_area :paraghraph_title1, rows: "3", class: "form-control" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_content1 %>
        <%= form.trix_editor :paragraph_content1, required: true, autofocus: true %>
      </div>
      <div class="field">
        <%= form.label :paragraph_image1 %>
        <% if post.paragraph_image1.attached? %>
          <p><%= image_tag post.paragraph_image1.variant(resize: "100x100") %></p>
        <% else %>
          <p>Nessuna immagine presente</p>
        <% end %>
        <%= form.file_field :paragraph_image1, class: "form-control-file" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_title2 %>
        <%= form.text_area :paragraph_title2, rows: "3", class: "form-control" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_content2 %>
        <%= form.trix_editor :paragraph_content2, required: true, autofocus: true %>
      </div>
      <div class="field">
        <%= form.label :paragraph_title3 %>
        <%= form.text_area :paragraph_title3, rows: "3", class: "form-control" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_content3 %>
        <%= form.trix_editor :paragraph_content3, required: true, autofocus: true %>
      </div>
```


inseriamo "Parallax paragraph"

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=140}
```
      <div class="field"><br/><h6>---Parallax paragraph---</h6></div>

      <div class="field">
        <%= form.label :paragraph_title4 %>
        <%= form.text_area :paragraph_title4, rows: "3", class: "form-control" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_content4 %>
        <%= form.trix_editor :paragraph_content4, required: true, autofocus: true %>
      </div>
      <div class="field">
        <%= form.label :paragraph_image4 %>
        <% if post.paragraph_image4.attached? %>
          <p><%= image_tag post.paragraph_image4.variant(resize: "100x100") %></p>
        <% else %>
          <p>Nessuna immagine presente</p>
        <% end %>
        <%= form.file_field :paragraph_image4, class: "form-control-file" %>
      </div>
```


inseriamo "Default paragraph 1"

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=161}
```
      <div class="field"><br/><h6>---Default paragraph 1---</h6></div>

      <div class="field">
        <%= form.label :paragraph_title5 %>
        <%= form.text_area :paragraph_title5, rows: "3", class: "form-control" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_content5 %>
        <%= form.trix_editor :paragraph_content5, required: true, autofocus: true %>
      </div>
      <div class="field">
        <%= form.label :paragraph_image5 %>
        <% if post.paragraph_image5.attached? %>
          <p><%= image_tag post.paragraph_image5.variant(resize: "100x100") %></p>
        <% else %>
          <p>Nessuna immagine presente</p>
        <% end %>
        <%= form.file_field :paragraph_image5, class: "form-control-file" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_image_label5 %>
        <%= form.text_area :paragraph_image_label5, class: "form-control" %>
      </div>
```


inseriamo "Default paragraph 2"

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=185}
```
      <div class="field"><br/><h6>---Default paragraph 2---</h6></div>

      <div class="field">
        <%= form.label :paragraph_title6 %>
        <%= form.text_area :paragraph_title6, rows: "3", class: "form-control" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_content6 %>
        <%= form.trix_editor :paragraph_content6, required: true, autofocus: true %>
      </div>
      <div class="field">
        <%= form.label :paragraph_image6 %>
        <% if post.paragraph_image6.attached? %>
          <p><%= image_tag post.paragraph_image6.variant(resize: "100x100") %></p>
        <% else %>
          <p>Nessuna immagine presente</p>
        <% end %>
        <%= form.file_field :paragraph_image6, class: "form-control-file" %>
      </div>
      <div class="field">
        <%= form.label :paragraph_image_label6 %>
        <%= form.text_area :paragraph_image_label6, class: "form-control" %>
      </div>
```

[Codice 04](#02-06-01_01all)


