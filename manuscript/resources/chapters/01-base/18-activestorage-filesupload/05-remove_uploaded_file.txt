{id: 01-base-18-activestorage-filesupload-05-remove_uploaded_file}
# Cap 18.5 -- Eliminiamo il file caricato

Questo codice noi lo usiamo per rimuovere la singola immagine "has_one_attached :main_image" ma è pensato anche per caricamenti multipli di immagini "has_many_attached :main_image".


Risorse interne:

* 99-rails_references/active_storage/aws_s3




## Apriamo il branch "ActiveRecord Remove Upload"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b arru
```




## Nel model EgPost

Nel model abbiamo già attivato la variabile "mmain_image" per ActionStorage in modo da poter caricare le immagini.

{id: "01-18-05_01", caption: ".../app//models/post.rb -- codice 01", format: ruby, line-numbers: true, number-from: 2}
```
  has_one_attached :main_image
```

[tutto il codice](#01-18-05_01all)





## Implementiamo sul controller

Creiamo la nuova azione "delete_image_attachment" sul controller

{id: "01-18-05_02", caption: ".../app/controllers/posts_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 70}
```
  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end
```

[tutto il codice](#01-18-05_02all)

Come possiamo vedere questo codice è molto generico e può essere usato così com'è su qualsiasi controller.




## Implementiamo sugli instradamenti (routes)

Prepariamo un instradamento per puntare alla nuova azione "delete_image_attachment". 

{id: "01-18-05_03", caption: ".../app/config/routes.rb -- codice 03", format: ruby, line-numbers: true, number-from: 4}
```
  resources :eg_posts do
    member do
      delete :delete_image_attachment
    end
  end
```

[tutto il codice](#01-18-05_03all)



vediamo il path

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "delete_image_attachment"

user_fb:~/environment/bl6_0 (arru) $ rails routes | egrep "delete_image_attachment"
      delete_image_attachment_eg_post DELETE /eg_posts/:id/delete_image_attachment(.:format)                                          eg_posts#delete_image_attachment
```

Possiamo vedere che esiste l'instradamento / il percorso "delete_image_attachment_eg_post_path" che punta all'azione "delete_image_attachment" del controller "eg_posts" (eg_posts#delete_image_attachment).




## Inseriamo il link nella view eg_posts/_form

Usiamo il nuovo instradamento sul link per eliminare l'immagine

{id: "01-18-05_04", caption: ".../app/views/authors/posts/_form.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 70}
```
      <%= link_to 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :delete, data: { confirm: 'Are you sure?' } if eg_post.header_image.attached? %>
```

[tutto il codice](#01-18-05_04all)

Mettiamo un "if..." perché se non c'è l'immagine ho un errore nel link non potendo avere l'"id".




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/eg_posts

facciamo uploads ed eliminiamo gli uploads fatti.
Se su aws S3, entriamo nel bucket "bl6-0-dev" possiamo vedere i files caricati e rimossi.



## Aumentiamo l'usabilità

Nel form, se è presente l'immagine, mettiamo una miniatura (thumbnail) con il link di remove.

{id: "01-18-05_05", caption: ".../app/views/authors/posts/_form.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 45}
```
  <div class="field">
    <%= form.label :header_image %>
    <% if eg_post.header_image.attached? %>
      <%= image_tag eg_post.header_image.variant(resize_to_fit: [100, 100]) %>
      <%= link_to 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :delete, data: { confirm: 'Are you sure?' } %>
    <% else %>
          <p>Nessuna immagine presente</p>
    <% end %>
    <p><%= form.file_field :header_image %></p>
  </div>
```

[tutto il codice](#01-18-05_05all)




## aggiorniamo git 

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add link to remove uploaded file"
```




## Publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku arru:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge arru
$ git branch -d arru
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-11-04_01)

{id="01-11-04_01all", title=".../Gemfile", lang=ruby, line-numbers=on, starting-line-number=1}
```
```
