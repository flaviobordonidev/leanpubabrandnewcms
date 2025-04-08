{id: 50-elisinfo-04-Companies-09-polymorphic_socialable}
# Cap 4.9 -- Polimorphic socials

Creiamo la tabella "socials" con relazione polimorfica.




## Apriamo il branch "Polimorphic Socials"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b ps
```




## Creiamo la tabella socials

Generiamo la tabella socials a cui associamo una relazione polimorfica e che useremo per le form annidate (nested-form).
Usiamo "generate model" perché ci interessa la tabella; per le views usiamo quelle delle tabelle collegate uno-a-molti, ossia quelle che hanno il form principale in cui annideremo le forms.

Definiamo la tabella:

* name:string     -> che social è (skype, linkedin, facebook, telegram, snapchat, ...)
* address:string  -> il nome "account" del social
* socialable_id:integer -> per la chiave esterna (lato molti della relazione uno-a-molti)
* socialable_type:string -> per identificare la tabella esterna 


{title="terminal", lang=bash, line-numbers=off}
```
$ rails g model social name:string address:string socialable_id:integer socialable_type:string
```


Vediamo il migrate creato

{id: "01-08-01_01", caption: ".../db/migrate/xxx_create_social.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class CreateSocials < ActiveRecord::Migration[6.0]
  def change
    create_table :socials do |t|
      t.string :name
      t.string :address
      t.integer :socialable_id
      t.string :socialable_type

      t.timestamps
    end
  end
end
```

[tutto il codice](#01-08-01_01all)


Effettuiamo il migrate

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```




## Aggiorniamo i models

Nel model Social su "# == Relationships", aggiungiamo la relazione polimorfica.

{id: "01-08-01_02", caption: ".../app/models/social.rb -- codice 02", format: ruby, line-numbers: true, number-from: 13}
```
  ## polymorphic
  belongs_to :socialable, polymorphic: true
```


Nel model Company su "# == Relationships", aggiungiamo la relazione per form annidate indicando anche la relazione polimorfica (", as: :emailable").

{id: "01-08-01_03", caption: ".../app/models/company.rb -- codice 03", format: ruby, line-numbers: true, number-from: 13}
```
  ## nested-form + polymorphic
  has_many :socials, dependent: :destroy, as: :socialable
  accepts_nested_attributes_for :socials, allow_destroy: true, reject_if: proc{ |attr| attr['address'].blank? }
```

Analizziamo il codice:

* dependent: :destroy -> questa opzione fa in modo che quando eliminiamo un'azienda in automatico vengono cancellati anche tutti i suoi accounts social.
* , as: :socialable -> questa opzione indica che è una relazione polimorfica
* allow_destroy: true -> permette di cancellare le form annidate
* reject_if: proc{ |attr| attr['address'].blank? } -> evita che vengano salvate form annidate in cui non è stato messo l'indirizzo social, ossia l'account.




## Aggiorniamo il controller

Permettiamo che siano passati i parametri del form annidato per i socials.

{id: "01-03-01_04", caption: ".../app/controllers/companies_controller.rb -- codice 04", format: ruby, line-numbers: true, number-from: 70}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :building, :address, :client_type, :client_rate, :supplier_type, :supplier_rate, :note, :sector, :tax_number_1, :tax_number_2, :logo_image, telephones_attributes: [:_destroy, :id, :name, :prefix, :number], emails_attributes: [:_destroy, :id, :name, :address], socials_attributes: [:_destroy, :id, :name, :address])
    end
```

[tutto il codice](#01-03-01_04all)


Analizziamo il codice:

- `, socials_attributes: [:_destroy, :id, :name, :address]` -> permette il passaggio dei parametri dei socials su form annidati.


Lato server / back-end abbiamo terminato.




## Aggiorniamo la view

Adesso lavoriamo lato front-end. 
La view su cui operiamo è il partial "_form" di companies (quello per le views edit e new).
Prima del pulsante di submit del form inseriremo la possibilità di aggiungere vari indirizzi socials.
Inseriamo il codice html con convenzione stimulus per i form annidati.

{id: "01-03-01_08", caption: ".../views/companies/_form.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 1}
```
         <div data-controller="nested-form" class="col-12"> <!-- Nested Form Socials start -->
          <%= form.label :socials %>

          <!-- Creiamo nuovo Record -->
          <template data-target="nested-form.template">
            <%= form.fields_for :socials, Email.new, child_index: "TEMPLATE_RECORD" do |social| %>
              <%= render "social_fields", form: social %>
            <% end %>
          </template>
      
          <!-- Visualizziamo i Records esistenti -->
          <%= form.fields_for :socials do |social| %>
            <%= render "social_fields", form: social %>
          <% end %>

          <!-- Il pulsante per aggiungere i tasks -->
          <div data-target="nested-form.add_item">
              <%= link_to "+ Aggiungi indirizzo web o social network", "#", data: { action: "nested-form#add_association" }, class: "btn btn-transparent-dark-gray btn-medium margin-20px-bottom" %>
              <%#= link_to "Add Telephone", "#", 'data-action': "nested-form#add_association" %>
          </div>
        </div> <!-- Nested Form Socials end -->
```

[tutto il codice](#01-03-01_04all)

Per l'analisi del codice vedi capitolo precedente "05-telephones_nested_forms"


Creiamo il partial "social_fields". (In pratica è il copia incolla di "email_fields")

{id: "01-03-01_07", caption: ".../views/companies/_email_fields.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="nested-fields">
  <div class="form-row">
    <%= form.hidden_field :_destroy %>
    <div class="form-group col-auto">
      <%= form.text_field :name, placeholder: "sito web", class: "medium-input" %>
    </div>
    <div class="form-group col">
      <%= form.text_field :address, placeholder: "", class: "medium-input" %>
    </div>
    <div class="form-group col-auto">
      <small>
        <%= link_to "X", "#", data: { action: "click->nested-form#remove_association" }, class: "btn btn-transparent-dark-gray btn-medium margin-20px-bottom" %>
      </small>
    </div>
  </div>
</div>
```

[tutto il codice](#01-03-01_06all)

Per l'analisi del codice vedi capitolo precedente "05-telephones_nested_forms"




## Verifichiamo lo stimulus controller per nested-forms

Nella cartella javascript/packs/controllers/ abbiamo già creato il file nested_form_controller.js in cui abbiamo inseriamo il codice javascript per gestire le form annidate.
Il codice è già sufficientemente generico e non dobbiamo fare nessun aggiornamento.
Per il codice e la relativa spiegazione fare riferimento al capitolo precedente "06-polymorfic_telephonable"




## Verifichiamo preview

Vediamo la nostra applicazione rails funzionante. Attiviamo il webserver

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

e vediamo sul nostro browser:

* https://mycloud9path.amazonaws.com/companies

Andiamo su edit di un'azienda ed inseriamo/modifichiamo/eliminiamo gli indirizzi emails. 
Funziona tutto.




## Salviamo su Git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement nested_form social on companies"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ps:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ps
$ git branch -d ps
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo



