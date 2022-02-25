# From annidate di telefoni su aziende. 

Vedi anche: Nested form con stimulus

Nota: per essere più didattici e rendere facile l'apprendimento la creazione delle form annidate per i telefoni la facciamo con una prima tabella non polimorfica che renderemo polimorfica successivamente.
Per una creazione delle form annidate direttamente con tabella polimorfica vedere capitolo 08 "polimorphic_emailable".


Risorse web:

* https://www.driftingruby.com/episodes/nested-forms-from-scratch-with-stimulusjs
* https://stackoverflow.com/questions/58205387/rails-nesteds-forms-with-dynamic-fields
* https://gorails.com/episodes?q=stimulus
* https://github.com/gorails-screencasts/dynamic-nested-forms-with-stimulusjs

olds:
* [Molto interessante!](https://github.com/plataformatec/simple_form/wiki/Nested-Models)
* [non usa .erb](https://www.pluralsight.com/guides/ruby-on-rails-nested-attributes)




## Branch

continuiamo con il branch aperto precedentemente




## Inizializiamo stimulus per nostra applicazione

Inizializiamo stimulus per essere referenziato/collegato alle pagine principali della nostra applicazione. Quelle che, seguendo la convenzione rails, abbiamo messo sotto il layouts "application".

Assicuriamoci che sul "layouts" che vogliamo usare ci sia "javascript_pack_tag" e non "javascript_include_tag".

{id: "01-03-01_01", caption: ".../views/layouts/application.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 9}
```
    <%#= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```

Volendo possiamo lasciare entrambe le chiamate.

* javascript_include_tag -> richiama l'asset-pipeline (.../app/assets/javascripts/)
* javascript_pack_tag -> richiama webpack (.../app/javascript/packs)


Nel file "application" di webpack inizializiamo stimulus.

{id: "01-03-01_02", caption: ".../javascript/packs/application.js -- codice 02", format: JavaScript, line-numbers: true, number-from: 22}
```
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
```


## Verifichiamo che stimulus sta funzionando

Per la verifica usiamo il codice dello stimulus controller hello_controller.js.
Andiamo sul partial _form di companies e aggiungiamo un div che referenziamo/colleghiamo al nostro "hello_controller.js" attraverso "data-controller="hello"". Dentro mettiamo un input che referenziamo con "data-target="hello.name"". Da notare che non mettiamo solo "name" ma dobbiamo mettere il prefisso "hello." in modo da indicare che appartiene allo stimulus controller "hello_controller.js" (namespacing).
Infine creiamo il pulsante che su evento click mi esegue l'azione "log" del mio "hello_controller.js".

{id: "01-03-01_01", caption: ".../views/companies/_form.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div data-controller="hello" class="field">
  <input data-target="hello.name" type="text">
  <button data-action="click->hello#log">Log</button>
</div>
```




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/mockups/page_b

Apriamo nel browser google chrome "view->developer->JavaScript Console", scriviamo qualcosa nel nuovo campo input e premiamo il pulsante "Log". Vedremo apparire nella "JavaScript Console" il testo che abbiamo inserito nel campo input.
Funziona! ^_^




## Creiamo nested-form Company -> telephones

Adesso che abbiamo verificato che stimulus è correttamente installato attiviamo un nested-form company->telephones.
Per i telephones usiamo "generate model" perché ci interessa la tabella; per le views usiamo quelle di companies.

Definiamo la tabella:

* name:string     -> che numero è (centralino, casa, ufficio, cellulare, ...)
* prefix:string   -> prefisso internazionale (+39, +1, +44, ...)
* number:string   -> numero telefonico

{title="terminal", lang=bash, line-numbers=off}
```
$ rails g model telephone company:belongs_to name:string prefix:string number:string
```

Nota: "company:belongs_to" crea la chiave esterna company_id, mette l'indice ed imposta la relazione 1-a-molti nei models.

Nota: Questo campo lo elimineremo più avanti a favore di due cambi per la relazione polimorfica. Questo perché quando dovremo fare i telefoni per le persone, con questo modello dovremo aggiungere una nuova colonna con chiave esterna person_id ed ogni nuova tabella che aggiungiamo dobbiamo inserire una nuova colonna. Inoltre le colonne delle chiavi esterne saranno tutte riempite parzialmente. Questo lo evitiamo con la relazione polimorfica.

Aggiorniamo il migrate creato inserendo dei valori di default.

{id: "01-08-01_04", caption: ".../db/migrate/xxx_create_telephones.rb -- codice 04", format: ruby, line-numbers: true, number-from: 1}
```
class CreateTelephones < ActiveRecord::Migration[6.0]
  def change
    create_table :telephones do |t|
      t.belongs_to :company, null: false, foreign_key: true
      t.string :name, default: "Ufficio"
      t.string :prefix, default: "+39"
      t.string :number

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

Nel model Telephone verifichiamo solo che il "belongs_to" sia già stato impostato.

{id: "01-03-01_01", caption: ".../app/models/telephone.rb -- codice 05", format: ruby, line-numbers: true, number-from: 2}
```
  belongs_to :company
```

[tutto il codice](#01-03-01_02all)


Nel model Company aggiungiamo la relazione 1-a-molti per nested_form.

{id: "01-03-01_01", caption: ".../app/models/company.rb -- codice 06", format: ruby, line-numbers: true, number-from: 2}
```
  has_many :telephones, dependent: :destroy
  accepts_nested_attributes_for :telephones, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }
```

[tutto il codice](#01-03-01_01all)

Analizziamo il codice:

* dependent: :destroy -> questa opzione fa in modo che quando eliminiamo un'azienda in automatico vengono cancellati anche tutti i suoi numeri telefonici.
* allow_destroy: true -> permette di cancellare le form annidate
* reject_if: proc{ |attr| attr['number'].blank? } -> evita che vengano salvate form annidate in cui non è stato messo il numero di telefono



## Aggiorniamo il controller

Permettiamo che siano passati i parametri relativi ai telefoni

{id: "01-03-01_07", caption: ".../app/controllers/companies_controller.rb -- codice 07", format: ruby, line-numbers: true, number-from: 70}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :building, :address, :client_type, :client_rate, :supplier_type, :supplier_rate, :note, :sector, :tax_number_1, :tax_number_2, telephones_attributes: [:_destroy, :id, :name, :prefix, :number])
    end
```

[tutto il codice](#01-03-01_07all)

Lato server / back-end abbiamo terminato.



## Aggiorniamo la view

Adesso lavoriamo lato front-end. La view su cui operiamo è il partial "_form" in cui abbiamo le view edit ed new delle varie aziende.
Prima del pulsante di submit del form inseriremo la possibilità di aggiungere vari numeri di telefono.
Implementiamo l'html con convenzione stimulus nel view.
Continuiamo a lavorare nel partial "_form" per inserire il codice html in convenzione stimulus per inserire i form annidati.

{id: "01-03-01_08", caption: ".../views/companies/_form.html.erb -- codice 08", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <div data-controller="nested-form">
    <!-- Creiamo nuovo Record -->
    <template data-target="nested-form.template">
      <%= form.fields_for :telephones, Telephone.new, child_index: "TEMPLATE_RECORD" do |telephone| %>
        <%= render "telephone_fields", form: telephone %>
      <% end %>
    </template>

    <!-- Visualizziamo i Records esistenti -->
    <%= form.fields_for :telephones do |telephone| %>
      <%= render "telephone_fields", form: telephone %>
    <% end %>
    
    <!-- Il pulsante per aggiungere i tasks -->
    <div data-target="nested-form.add_item">
        <%= link_to "Add Telephone", "#", data: { action: "nested-form#add_association" } %>
        <%#= link_to "Add Telephone", "#", 'data-action': "nested-form#add_association" %>
    </div>
  </div>
```

[tutto il codice](#01-03-01_04all)

Analizziamo il codice:

* data-controller="nested-form"       -> Si collega a stimulus nested_form_controller. Nota: nel codice html uso "-" nel codice rails uso "_".
* <template>                          -> Questo tag contiene il codice HTML senza visualizzarlo.
* data-target="nested-form.template"  -> Passa a nested_form_controller la variabile "template".
* form.fields_for :tasks              -> fields_form cicla i vari forms annidati
* , Task.new                          -> questa opzione permette di creare un nuovo form annidato
* , child_index: "TEMPLATE_RECORD"    -> questa opzione passa un id ad ogni form annidato e deve essere univoco. In TEMPLATE_RECORD inseriremo il valore univoco. 
* data-target="nested-form.add_item"  -> Passa a nested_form_controller la variabile "add_item".
* data: { action: "..." }             -> codice rails per generare il seguente codice html : data-action = "..."
* 'data-action': "..."                -> Altro modo di chiamare l'attributo "data-action" da rails. Mi serve l'apice singola "'" altrimenti ho un errore.
* "click->nested-form#add_association" -> che si collega all'azione "add_association" di stimulus nested_form_controller.


Vediamo adesso il partial "telephone_fields".

{id: "01-03-01_07", caption: ".../views/companies/_telephone_fields.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="nested-fields">
  <div class="form-group">
    <%= form.hidden_field :_destroy %>
    <%= form.text_field :name, placeholder: "centralino", class: "form-control" %>
    <%= form.text_field :prefix, class: "form-control" %>
    <%= form.text_field :number, class: "form-control" %>
    <small>
      <%= link_to "Remove", "#", data: { action: "click->nested-form#remove_association" } %>
      <%#= link_to "Remove", "#", 'data-action': "click->nested-form#remove_association" %>
    </small>
  </div>
</div>
```

[tutto il codice](#01-03-01_07all)

Analizziamo il codice:

* form.hidden_field :_destroy       -> Passa il suo valore su submit del form e nel controller vediamo che se non è "nil" allora eliminiamo il record.
* data: { action: "..." }           -> Genera il codice html "data-action = "..."" 
* "click->nested-form#remove_association" -> che si collega all'azione "remove_association" di stimulus nested_form_controller.



## Verifichiamo lo stimulus controller per nested-forms

Nella cartella javascript/packs/controllers/ abbiamo già creato il file nested_form_controller.js in cui abbiamo inseriamo il codice javascript per gestire le form annidate.
Il codice è già sufficientemente generico e non dobbiamo fare nessun aggiornamento.

{id: "01-03-01_06", caption: ".../javascript/packs/controllers/nested_form_controller.js -- codice 06", format: JavaScript, line-numbers: true, number-from: 1}
```
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["add_item", "template"]
  
  add_association(event){
    event.preventDefault()
    var content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, Math.floor(Math.random() * 20))
    this.add_itemTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event){
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = "none"
  }
}
```

Analizziamo il codice:

* static targets = ["add_item", "template"]   -> Si collega a "data-target="nested-form.template"" e "data-target="nested-form.add_item""
* event.preventDefault()                      -> Quando clicchiamo il link non viene eseguita l'azione di default.
* var content                                 -> Definisce "content" una variabile globale
* this.templateTarget                         -> Attributo creato da Stimulus prendendo gli "static targets" e rinominandoli in stile "CammelCase"
* .innerHTML                                  -> Prende la seguente parte DOM del codice HTML:
  
    ```
    <%= form.fields_for :tasks, Task.new, child_index: "TEMPLATE_RECORD" do |task| %>
      ...
    <% end %>
    ```
    
    Che è quella che sta dentro il "templateTarget", ossia: 
    
    ```
    <template data-target="nested-form.template">
      ...
    </template>
    ```

* .replace(/TEMPLATE_RECORD/g, ...)       -> Trova la parte "TEMPLATE_RECORD" e la sostituisce con "..."
* Math.floor(Math.random() * 20)          -> Crea un numero random e lo rende adatto ad essere messo al posto di "TEMPLATE_RECORD" per il "child_index"
* this.add_itemTarget.                    -> Prende la seguente parte DOM del codice HTML:
    
    ```
    <div data-target="nested-form.add_item">
      ...
    </div>
    ```

* this.add_itemTarget.                        -> Prende la seguente parte DOM del codice HTML:
* insertAdjacentHTML('beforebegin', content)  -> Inserisce adiacente il codice html "content" posizionandolo sopra ("beforebegin")
                                                 il codice html "content" è quello che abbiamo visto prima ossia la seguente parte DOM:

    ```
    <%= form.fields_for :tasks, Task.new, child_index: "123...random...790" do |task| %>
      <%= render "task_fields", form: task %>
    <% end %>
    ```

    In pratica posiziona sopra il pulsante "add task" il nested form.

* let item                    -> Definisce "item" una variabile locale
* event.target                -> Prende la parte DOM del codice HTML che ha generato l'evento. Nel nostro caso la seguente:

    ```
    <%= link_to "Remove", "#", data: { action: "click->nested-form#remove_association" } %>
    ```

* .closest(".nested-fields")  -> Risale per i tags HTML papà, ossia risale nella DOM, fino ad incontrare il tag HTML con class="nested-fields".
    Nel nostro caso è tutta la parte interna del nested form. Tutto il codice del partial "_task_fields"

* item.querySelector("input[name*='_destroy']").value = 1   -> Trova il tag HTML <input> che ha il nome "_destroy".

    ```
    <%= form.hidden_field :_destroy %>
    ```

    E gli imposta il valore ad "1". Questo è usato da rails per marcare l'eliminazione del record. E questa la abbiamo definita nel model TodoList in "accepts_nested_attributes_for :tasks, allow_destroy: true ...".

    Nota: il codice rails <%= form.hidden_field :_destroy %> crea il seguente DOM HTML:
    
    ```
    <input type="hidden" value="false" name="todo_list[tasks_attributes][0][_destroy]" id="todo_list_tasks_attributes_0__destroy">
    ```
 
* item.style.display = "none"   -> Nasconde il DOM selezionato così non è più visibile nella view.




## Salviamo su Git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement nested_form telephone on companies"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku tei:master
$ heroku run rails db:migrate
```




