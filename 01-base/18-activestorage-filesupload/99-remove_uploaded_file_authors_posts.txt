

Vedi 05-remove_uploaded_file.txt

Poi qui abbiamo un cambio perché abbiamo incapsulato posts dentro authors:


## Implementiamo sugli instradamenti (routes)

Prepariamo un instradamento per puntare alla nuova azione "delete_image_attachment". 

{id: "01-18-05_03", caption: ".../app/config/routes.rb -- codice 03", format: ruby, line-numbers: true, number-from: 4}
```
  namespace :authors do
    resources :posts, :except => [:show] do
      member do
        delete :delete_image_attachment
      end
    end
  end
```

[tutto il codice](#01-18-05_03all)



vediamo il path

```
$ rails routes | egrep "delete_image_attachment"

ubuntu:~/environment/cmsbase (lmp) $ rails routes | egrep "delete_image_attachment"
delete_image_attachment_authors_post DELETE /authors/posts/:id/delete_image_attachment(.:format)                                     authors/posts#delete_image_attachment
```




## Su authors/posts/_form

Usiamo il nuovo instradamento sul link per eliminare l'immagine

{id="01-11-02_03", title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=70}
```
                <p><%= link_to 'Remove', delete_image_attachment_authors_post_path(post.main_image.id), method: :delete, data: { confirm: 'Are you sure?' } %></p>
```

[Codice 04](#01-11-02_01all)




## Vediamo i passi per upload di multiple immagini

Here is the model

```
class Space < ApplicationRecord
  belongs_to :user

  has_many_attached :space_image

end
```

The controller

```
class SpacesController < ApplicationController
  before_action :set_space, except: [:index, :new, :create, :delete_image_attachment]
  before_action :authenticate_user!, except: [:show]

  def delete_image_attachment
    @space_image = ActiveStorage::Attachment.find(params[:id])
    @space_image.purge
    redirect_back(fallback_location: request.referer)
  end

  private
    def set_space
      @space = Space.find(params[:id])
    end
end
```

The view

```
<div>
  <% if @space.space_image.attached? %>
    <% @space.space_image.each do |space_image| %>
    <%= image_tag space_image, class: "avatar-medium" %>
    <%= link_to 'Remove', delete_image_attachment_space_url(space_image.id),
                method: :delete,
                  data: { confirm: 'Are you sure?' } %>
    <% end %>
  <% end %>
</div>
```

