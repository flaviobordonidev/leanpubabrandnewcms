# <a name="top"></a> Cap ajax_asynchronous_javascript - Stimulus su form_with

Utilizziamo stimulus con form_with


## Risorse esterne

- [GoRails: How to Use Stimulus JS 2.0: Values and CSS Classes API](https://www.youtube.com/watch?v=AEPIotNWFOM)
- [GoRails: How to Use Stimulus JS 2.0: Values and CSS Classes API](https://gorails.com/episodes/stimulus-js-2?autoplay=1)


## creiamo uno scaffold per i post

Per lavorare sul form_with applicato ad un model usiamo lo *scaffold* e creiamo dei *posts di esempio*.

```bash
$ rails g scaffold EgPost headline:string incipit:string
```

e migriamo

```bash
$ rails db:migrate
```



## Vediamo il form

Andiamo a vedere il partial "_form" ed aggiungiamo i *data attributes* per stimulus:

- il `data-controller` al *form_with* -> `, data: { controller: "tweer"}`.
- il `data-target` dentro al *form_with* -> `data-tweet-target="output"`.

> il valore del data-target è cammelCase; ad esempio "myOutput"

***codice 01 - .../app/views/eg_posts/_form.html.erb - line: 2***

```html+erb
<%= form_with(model: eg_post, data: { controller: "tweet"}) do |form| %>
  <% if eg_post.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(eg_post.errors.count, "error") %> prohibited this eg_post from being saved:</h2>

      <ul>
        <% eg_post.errors.each do |error| %>
          <li><%= error.full_message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div>
    <%= form.label :headline, style: "display: block" %>
    <%= form.text_field :headline %>

    <div data-tweet-target="output"></div>
  </div>

  <div>
    <%= form.label :incipit, style: "display: block" %>
    <%= form.text_field :incipit %>
  </div>

  <div>
    <%= form.submit %>
  </div>
<% end %>
```

> `data: { controller: "tweer"}` è uguale a `'data-controller': "tweer"`.


Creiamo il corrispondente *stimulus controller*.

***codice 02 - .../app/javascript/controllers/tweet_controller.js - line: 1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "output" ]

  connect() {
    this.outputTarget.textContent = "Hello, Stimulus!"
  }
}
```



## Gli *static values*

Gli *static values* vanno nella riga del `data-controller`.

***codice 03 - .../app/views/eg_posts/_form.html.erb - line: 2***

```html+erb
<%= form_with(model: eg_post, data: { controller: "tweet", tweet_character_count_value: 140}) do |form| %>
```

***codice 04 - .../app/javascript/controllers/tweet_controller.js - line: 1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "output" ]

  static values = {
    characterCount: Number,
  }

  connect() {
    this.outputTarget.textContent = "Hello, Stimulus!"
    console.log(this.characterCountValue)
  }
}
```

Vediamo anche nel browser che il valore 140 nella console log è un numero e non una stringa perché è di colore azzurro e non nero. 



## Limitiamo il testo nel campo di input a 140 caratteri


***codice 05 - .../app/views/eg_posts/_form.html.erb - line: 2***

```html+erb
    <%= form.text_field :headline, data: {tweet_target: "field"} %>

```

***codice 06 - .../app/javascript/controllers/tweet_controller.js - line: 1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "output", "field" ]

  static values = {
    characterCount: Number,
  }

  connect() {
    let length = this.fieldTarget.value.length
    this.outputTarget.textContent = `${length} characters`
    console.log(this.characterCountValue)
  }
}
```

In questo modo abbiamo l'informazione ma non è aggiornata mentre scriviamo. Dobbiamo aggiornare tutta la pagina del browser per vedere dei cambiamenti.

Aggiungiamo un azione al campo di input.

***codice 07 - .../app/views/eg_posts/_form.html.erb - line: 2***

```html+erb
    <%= form.text_field :headline, data: {tweet_target: "field"}, action: "keyup->tweet#change" %>
```

***codice 08 - .../app/javascript/controllers/tweet_controller.js - line: 1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "output", "field" ]

  static values = {
    characterCount: Number,
  }

  connect() {
    this.change()
  }

  change(){
    let length = this.fieldTarget.value.length
    this.outputTarget.textContent = `${length} characters`
    console.log(this.characterCountValue)
  }
}
```









**Versione GoRails**

***codice 01 - .../app/views/eg_posts/_form.html.erb - line: 2***

```html+erb
<%= form_with(model: post, local: true, data: { controller: "tweet", tweet_character_count_value: 140, tweet_over_limit_class: "text-danger" }) do |form| %>
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

  <div class="form-group">
    <%= form.label :body %>
    <%= form.text_area :body, class: 'form-control', data: { tweet_target: "field", action: "keyup->tweet#change" } %>

    <div data-tweet-target="output"></div>
  </div>

  <div class="form-group">
    <% if post.persisted? %>
      <div class="float-right">
        <%= link_to 'Destroy', post, method: :delete, class: "text-danger", data: { confirm: 'Are you sure?' } %>
      </div>
    <% end %>

    <%= form.submit class: 'btn btn-primary' %>

    <% if post.persisted? %>
      <%= link_to "Cancel", post, class: "btn btn-link" %>
    <% else %>
      <%= link_to "Cancel", posts_path, class: "btn btn-link" %>
    <% end %>
  </div>
<% end %>
```