# Upload del logo

Implementiamo active storage per caricare le immagini del logo aziendale.

Abbiamo già impostato tutto in 01-base/18-activestorage-filesupload. 
Quindi abbiamo già:

* installato activestorage
* predisposto i buckets su aws S3
* effettuato il puntamento usando i secrests criptati
* impostato l'eventuale remove dei file uploadati




## Apriamo il branch




## Attiviamo upload immagine nel model

Implementiamo il campo per l'upload delle immagini dei loghi aziendali.

Nella sessione "# == Attributes":

{id: "50-04-12_01", caption: ".../app/models/company.rb -- codice 01", format: ruby, line-numbers: true, number-from: 4}
```
  ## Active Storage
  has_one_attached :logo_image
```

[tutto il codice](#50-04-12_01all)




## Aggiorniamo il controller

Inseriamo il nostro nuovo campo nella whitelist.

Nel metodo privato "company_params":

{id: "50-04-12_02", caption: ".../app/controllers/companies_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 77}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :building, :address, :client_type, :client_rate, :supplier_type, :supplier_rate, :note, :sector, :tax_number_1, :tax_number_2, :logo_image, telephones_attributes: [:_destroy, :id, :name, :prefix, :number], emails_attributes: [:_destroy, :id, :name, :address])
    end
```

[tutto il codice](#50-04-12_02all)




## Implementiamo la view

{id: "50-04-12_03", caption: ".../app/views/companies/_form.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 45}
```
  <div class="field">
    <%= form.label :logo_image %>
    <%= form.file_field :logo_image %>
  </div>
```

[tutto il codice](#50-04-12_03all)


Per visualizzare l'immagine usiamo "image_tag ..."

{id: "50-04-12_04", caption: ".../app/views/companies/index.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 62}
```
      <% if company.logo_image.attached? %>
        <%= image_tag company.logo_image.variant(resize: "100x100") %>
      <% else %>
        <%= image_tag "pofo/logo_default.png", class: "img-circle width-85 xs-width-100", alt: "" %>
      <% end %>
```

[tutto il codice](#50-04-12_04all)

Le tre principali forme di resize sono:

* resize_to_fit: Will downsize the image if it's larger than the specified dimensions or upsize if it's smaller.
* resize_to_limit: Will only resize the image if it's larger than the specified dimensions
* resize_to_fill: Will crop the image in the larger dimension if it's larger than the specified dimensions




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

andiamo alla pagina con l'elenco degli articoli ossia sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts

Creaiamo un nuovo articolo ed aggiungiamo un'immagine. Verremo portati su show e vedremo l'immagine nella pagina.




## DA SPOSTARE SULLO STILE

Per fare l'immagine con il pulsante rotondo si può usare la clase di Pofo "image-button"

```
  <%= link_to edit_company_path(company), class: "btn image-button btn-rounded btn-transparent-dark-gray margin-10px-bottom" do %>
    <%= image_tag company.logo_image.variant(resize: "100x100") %> &nbsp&nbsp&nbsp&nbsp
  <% end %>
```

I 4 "&nbsp" dopo l'immagine sono un workaround per visualizzare l'immagine più grande. Questo perché sembra che la formattazione css sia pensata per la presenza di "testo" nei pulsanti.
Usando "&nbsp" forziamo la presenza di "testo" come spazzi bianchi " ".




## Visualizziamo il logo in edit se è presente

Anche nel partial "_form" visualizziamo l'immagine del logo se è presente.

```
        <div class="col-12">
          <%= form.label :logo_image %>
          <% if company.logo_image.attached? %>
            <%= image_tag company.logo_image.variant(resize_to_fit: [100, 100]) %>
            <%= link_to 'Remove', delete_image_attachment_company_path(company.logo_image.id), method: :delete, data: { confirm: 'Are you sure?' } %>
          <% else %>
                <p>Nessuna immagine presente</p>
          <% end %>
          <p><%= form.file_field :logo_image %></p>
        </div>
```



## Aggiungiamo pulsante per rimuovere immagine logo in edit se è presente

Per rimuovere l'immagine aggiungiamo un link, un instradamento ed un metodo nel controller.

views/companies/_form
```
        <div class="col-12">
          <%= form.label :logo_image %>
          <% if company.logo_image.attached? %>
            <%= image_tag company.logo_image.variant(resize_to_fit: [100, 100]) %>
            <%= link_to 'Remove', delete_image_attachment_company_path(company.logo_image.id), method: :delete, data: { confirm: 'Are you sure?' } %>
          <% else %>
                <p>Nessuna immagine presente</p>
          <% end %>
          <p><%= form.file_field :logo_image %></p>
        </div>
```


routes
```
  resources :companies do
    member do
      delete :delete_image_attachment
    end
  end
```


companies_controller
```
  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end
```


