# Nested form con stimulus

#TODO -> invece di todo_list->tasks facciamo esempio con annidamento a tre livelli:
  * Surveys->Questions->Answers
  * Libraries->Shelves->Books
  * Books->Chapters->Paragraphs
  * Dossiers->Offers->Products

Scelgo: Books->Chapters->Paragraphs


Risorse web:

* https://www.driftingruby.com/episodes/nested-forms-from-scratch-with-stimulusjs
* https://stackoverflow.com/questions/58205387/rails-nesteds-forms-with-dynamic-fields
* https://gorails.com/episodes?q=stimulus
* https://github.com/gorails-screencasts/dynamic-nested-forms-with-stimulusjs



## Branch

continuiamo con il branch aperto precedentemente




## Creiamo nested-form todo_list -> tasks

Adesso che abbiamo verificato che stimulus è correttamente installato attiviamo un nested-form todo_list->tasks.

[seguiamo driftingruby e poi lo rivediamo in chiave di railscast con Survey->Questions->Answers in modo da avere un doppio livello annidato]

Creiamo varie todo lists e ci annidiamo i vari tasks. Per la todo_list usiamo "generate scaffold" perché utilizzeremo le views.
Per i tasks usiamo "generate model" perché ci interessa la tabella; per le views usiamo quelle della todo_list in cui annidiamo i tasks.


{title="terminal", lang=bash, line-numbers=off}
```
$ rails g scaffold todo_list name:string
$ rails g model task todo_list:belongs_to description:string
$ rails db:migrate
```

Nota: "todo_list:belongs_to" crea la chiave esterna todo_list_id, mette l'indice ed imposta la relazione 1-a-molti nei models.




## Aggiorniamo i models


{id: "01-03-01_01", caption: ".../models/todo_list.rb -- codice 01", format: ruby, line-numbers: true, number-from: 2}
```
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc{ |attr| attr['description'].blank? }
```

[tutto il codice](#01-03-01_01all)

L'opzione "dependent: :destroy" fa in modo che quando eliminiamo una todo_list in automatico vengono cancellati anche tutti i suoi tasks.


Nel model Task verifichiamo solo che il "belongs_to" è già stato impostato.

{id: "01-03-01_01", caption: ".../app/models/task.rb -- codice 02", format: ruby, line-numbers: true, number-from: 2}
```
  belongs_to :todo_list
```

[tutto il codice](#01-03-01_02all)




## Aggiorniamo il controller

Permettiamo che siano passati i parametri relativi a task

{id: "01-03-01_03", caption: ".../app/controllers/todo_list_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 70}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:name, tasks_attributes: [:_destroy, :id, :description])
    end
```


Indichiamo a tutte le azioni di fare il render con il layout "mockup" perché al momento stimulus è impostato solo lì.

{caption: ".../app/controllers/todo_list_controller.rb -- continua", format: ruby, line-numbers: true, number-from: 3}
```
  layout 'mockup'
```

[tutto il codice](#01-03-01_03all)

Lato server / back-end abbiamo terminato.



## Aggiorniamo la view

Adesso lavoriamo lato front-end. La view su cui operiamo è il partial "_form" in cui abbiamo le views edit e new delle varie todo_lists.
Prima del pulsante di submit del form inseriremo la possibilità di aggiungere vari tasks.
Ma prima di fare questo verifichiamo che stimulus sta funzionando correttamente. Per far questo usiamo il codice già usato nella view "mockups/page_b"

{id: "01-03-01_04", caption: ".../views/todo_list/_form.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <h1>Tasks</h1>

  <div data-controller="hello">
    <input data-target="hello.name" type="text">
    <button data-action="click->hello#log">Log</button>
  </div>
```

[tutto il codice](#01-03-01_04all)




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/todo_lists

Apriamo nel browser google chrome "view->developer->JavaScript Console".
Clicchiamo su "new todo_list" ci appare il partial "_form". 
Scriviamo qualcosa nel nuovo campo input e premiamo il pulsante "Log".
Questa volta il testo nella "JavaScript Console" appare e scompare rapidamente perché il click sul pulsante esegue anche il sumbit del form.
Vogliamo evitar questo.




## Evitiamo sumbit del form su click del pulsante "Log"

Per far questo dobbiamo intercettare l'evento click sul nostro codice javascript in Stimulus.
Torniamo al nostro stimulus controller "hello_controller.js" ed aggiungiamo la gestione dell'evento nell'azione "log".

{id: "01-03-01_02", caption: ".../javascript/packs/controllers/hello_controller.js -- codice 05", format: JavaScript, line-numbers: true, number-from: 1}
```
import { Controller } from "stimulus"

export default class extends Controller {
  log(event){
    event.preventDefault()
    console.log(this.targets.find("name").value)
  }
}
```

Analizziamo il codice:

* log(event){             -> Passiamo l'evento all'azione log. Nel nostro caso l'evento "click"
* event.preventDefault()  -> Preveniamo che sia eseguita l'azione di default. Interrompiamo la normale azione su click del button.

Adesso se riandiamo in preview vediamo che non ci sarà più il submit del form ed il testo rimarrà nella "Java Console".
Verificato che Stimulus sta funzionando correttamente andiamo avanti con il "form annidato".




## Implementiamo l'html con convenzione stimulus nel view

Continuiamo a lavorare nel partial "_form" per inserire il codice html in convenzione stimulus per inserire i form annidati.

{id: "01-03-01_06", caption: ".../views/todo_list/_form.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <div data-controller="nested-form">
    <!-- Creiamo nuovo Record -->
    <template data-target="nested-form.template">
      <%= form.fields_for :tasks, Task.new, child_index: "TEMPLATE_RECORD" do |task| %>
        <%= render "task_fields", form: task %>
      <% end %>
    </template>

    <!-- Visualizziamo i Records esistenti -->
    <%= form.fields_for :tasks do |task| %>
      <%= render "task_fields", form: task %>
    <% end %>
    
    <!-- Il pulsante per aggiungere i tasks -->
    <div data-target="nested-form.add_item">
        <%= link_to "Add Task", "#", data: { action: "nested-form#add_association" } %>
        <%#= link_to "Add Task", "#", 'data-action': "nested-form#add_association" %>
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


Vediamo adesso il partial "task_fields".

{id: "01-03-01_07", caption: ".../views/todo_list/_task_fields.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="nested-fields">
  <div class="form-group">
    <%= form.hidden_field :_destroy %>
    <%= form.text_field :description, placeholder: "Description", class: "form-control" %>
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



## Creiamo lo stimulus controller per nested-forms

Nella cartella javascript/packs/controllers/ creiamo il nuovo file nested_form_controller.js in cui inseriamo il codice javascript per gestire le form annidate.

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




## Javascript differenza tra var e let

The let statement declares a block-scoped local variable. A block statement is used to group statements. 
Example:

```
{
   console.log("I am inside a block");
}
```

Difference 1 : Scope
The major difference between var and let is , the scope of var is either global or local to the function it is declared, whereas the scope of let is the block in which it is declared.
Example:

```
{
   var x = 10; // create variable in global scope
   let y = 20; // create variable in local scope
}
console.log(x); // 10
console.log(y); // ReferenceError: y is not defined
```


Difference 2 : Accessing value
When we create a variable with var statement, we can access the value(undefined by default) before it’s variable declaration.

```
console.log(x); // undefined
```

But we can’t do the same in let

```
console.log(y); // ReferenceError: y is not defined
```

Difference 3 : Binding
When we declare variable with var ,it creates a property on the global object.

```
var a = 10;
console.log(this.a); // 10
console.log(window.a); // 10
console.log(a); //10
console.log(globalThis.a); // 10
```

But in let we can’t do the same, because let does not create a property on the global object.

```
let z= 10;
console.log(z); //10
console.log(this.z); // undefined
console.log(window.z); // undefined
console.log(globalThis.z); // undefined
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ep:master
$ heroku run rails db:migrate
```












## 51b --> gorails-screencasts/dynamic-nested-forms-with-stimulusjs

Il video è privato ma il codice su github è pubblico.

L'esempio che fa è su Project -> Task

{id: "01-03-01_01", caption: ".../views/projects/_form.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= form_with(model: project, local: true) do |form| %>
  .
  .
  .
  <div class="form-group">
    <%= form.label :name %>
    <%= form.text_field :name, class: 'form-control' %>
  </div>

  <div class="form-group">
    <%= form.label :description %>
    <%= form.text_field :description, class: 'form-control' %>
  </div>

  <h4>Tasks</h4>
  <div data-controller="nested-form">
    <template data-target="nested-form.template">
      <%= form.fields_for :tasks, Task.new, child_index: 'NEW_RECORD' do |task| %>
        <%= render "task_fields", form: task %>
      <% end %>
    </template>

    <%= form.fields_for :tasks do |task| %>
      <%= render "task_fields", form: task %>
    <% end %>

    <div class="mb-3" data-target="nested-form.links">
      <%= link_to "Add Task", "#", class: "btn btn-outline-primary", data: { action: "click->nested-form#add_association" } %>
    </div>
  </div>
```

[tutto il codice](#01-03-01_01all)




{id: "01-03-01_01", caption: ".../views/projects/_task_fields.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= content_tag :div, class: "nested-fields", data: { new_record: form.object.new_record? } do %>
  <div class="form-group">
    <%= form.label :description %>
    <%= form.text_field :description, class: 'form-control' %>
    <small><%= link_to "Remove", "#", data: { action: "click->nested-form#remove_association" } %></small>
  </div>

  <%= form.hidden_field :_destroy %>
<% end %>
```

[tutto il codice](#01-03-01_02all)






---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
