# <a name="top"></a> Cap hotwire.4 - Turbo Streams examples

Turbo Stream è più potente di Turbo Frame perché ti permette di aggiornare più parti della pagina allo stesso tempo. Inoltre permette di inviare aggiornamenti via server side events quali model updates. Quest'ultima parte ci permette di creare una comunicazione broadcast che aggiorna contemporaneamente più browser aperti.

>AVVISO: </br>
> Ad oggi 08/08/2022 Turbo Strems **non** supporta GET.
> Stanno lavorando per farlo supportare in futuro: ( https://github.com/hotwired/turbo/pull/612 )



## Risorse esterne

- [hotwire inline crud table](bit.ly/inline-crud)



## Turbo Streams le basi

Ecco come appare un tag Turbo Stream:

```html
  <turbo-stream action="update" target="someid">
    <template>
      <div>New content for the target</div>
    </template>
  </turbo-stream>
```

Le "actions" possibili con turbo-stream sono:

- append
- prepend
- replace
- update
- remove
- before
- after



## Vediamo Turbo Stream in azione

Lavoriamo sulla stessa applicazione usata in turbo_frame sostituendo buona parte del codice precedente.

Nella view `first` inseriamo una tabella ed un form per aggiungere una nuova riga.

***code 01 - .../app/views/site/first.html.erb - line:3***

```html+erb
<table width="400">
  <thead>
    <tr>
      <th>Name</th>
      <th>Email</th>
      <th>Age</th>
    </tr>
  </thead>
  <tbody id="people">
    <tr>
      <td>John</td>
      <td>jdoe@email.com</td>
      <td>25</td>
    </tr>
    <tr>
      <td>Emily</td>
      <td>emily@email.com</td>
      <td>43</td>
    </tr>
    <tr>
      <td>Dan</td>
      <td>dan@email.com</td>
      <td>78</td>
    </tr>
  </tbody>
</table>

<%= form_with url: site_third_path, scope: "person" do |f| %>
  <%= f.text_field :name, placeholder: "Name" %>
  <%= f.text_field :email, placeholder: "Email" %>
  <%= f.text_field :age, placeholder: "Age" %>
  <%= f.submit :save %>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_01-views-site-first.html.erb)


> Nel form inseriamo l'attributo `scope: "person"` per avere una struttura simile a quella che si ha quando il form è legato ad un Model (in questo caso sarebbe il model Person).
> Nello specifico tutti i campi che dichiariamo nel form saranno annidati dentro la variabile dello `scope`, quindi nel nostro caso nella variabile `person`.<br/>
> Esempio di annidamento:<br/>
> `"person"=>{"name"=>"", "email"=>"", "age"=>""}`


Nell'azione `third` assegniamo i valori alle variabili di istanza (instance variables) @name, @email e @age, che useremo nella view. E prendiamo i valori dall'attributo "params[]".


***code 02 - .../app/controllers/site_controller.rb - line:3***

```ruby
  def third 
    @name, @email, @age = params[:person].values_at(:name, :email, :age)
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_02-controllers-site_controller.rb)

Attenzione!
Da notare che la risposta POST al submit del form è di tipo **TURBO_STREAM**.
Mentre invece la prima risposta della pagina `first` era di tipo **HTML**

```ruby
Started GET "/site/first" for 192.168.64.1 at 2022-08-08 12:22:39 +0200
Cannot render console from 192.168.64.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
Processing by SiteController#first as HTML
  Rendering layout layouts/application.html.erb
  Rendering site/first.html.erb within layouts/application
  Rendered site/first.html.erb within layouts/application (Duration: 1.6ms | Allocations: 857)
  Rendered layout layouts/application.html.erb (Duration: 21.7ms | Allocations: 14542)
Completed 200 OK in 25ms (Views: 24.6ms | Allocations: 15189)


Started POST "/site/third" for 192.168.64.1 at 2022-08-08 12:22:44 +0200
Cannot render console from 192.168.64.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
Processing by SiteController#third as TURBO_STREAM
  Parameters: {"authenticity_token"=>"[FILTERED]", "person"=>{"name"=>"", "email"=>"", "age"=>""}, "commit"=>"save"}
No template found for SiteController#third, rendering head :no_content
Completed 204 No Content in 43ms (Allocations: 650)
```

> Da Rails 7.0 (che integra hot wire), tutte le risposte ai submit dei forms sono di tipo **TURBO_STREAM**.
>
> O più precisamente, questo avviene automaticamente ogni volta che inviamo un modulo (un form) che utilizza uno dei seguenti metodi: POST, PUT, PATCH o DELETE.
>
> The way it happens is, Turbo injects `text/vnd.turbo-stream.html` in the request's `Accept` header.


Quindi la view che dobbiamo utilizzare avrà un'estensione, o meglio un *formato file (file format)*, di tipo `turbo_stream`.
In altre parole il nome del file della view sarà `third.tubo_stream.erb` e non `third.html.erb`.

***code 03 - .../app/views/site/third.tubo_stream.erb - line:3***

```html+erb
<%= turbo_stream.prepend "people" do %>
  <tr>
    <td><%= @name %></td>
    <td><%= @email %></td>
    <td><%= @age %></td>
  </tr>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_03-views-site-third.tubo_stream.erb)



## Verifichiamo preview

Vediamo come si comporta il codice nel browser.

***code n/a - Terminal -line:n/a***

```ruby
$ rails s -b 192.168.64.3
```

Riempiamo il form e facciamo submit. Come si vede dalla seconda immagine siamo rimasti nella stessa pagina ed è stato aggiunto una nuova riga alla tabella. Nella prima riga della tabella (prepend).

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig01-example1_1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig02-example1_2.png)


The request from the form goes to the controller which picks up the params, initializes some instance variables and sends them to the view. And the view creates a new creates a new table's row and prepends it to the table's body.

In the network tab of the "browser inspect" (response tab) you see there is a turbo stream tag with an action of prepend: `<turbo-stream action="prepend" target="people">...</turbo-stream>`.
Inoltre il `target` è impostato a "people" che è il *DOM ID* del *table's body*.

E dentro il `<turbo-stream...` tag c'è il `<template>` tag che contiene la *table's row* to prepend.

> Come si vede Turbo-Stream è molto più "granulare" rispetto a Turbo-Frame; contiene solo ra riga che vogliamo aggiungere e non l'intera tabella, come avresti in turbo-frame.



## Aggiungiamo un "contatore (counter)" con Turbo-Stream

Aggiungiamo un elemento in fondo alla pagina per mostrare il counter.


***code 04 - .../app/views/site/first.html.erb - line:38***

```html+erb
  Total: <span id="counter"><%= @count %></span>
```

aggiungiamo anche un campo nascosto al form per passare il valore del counter.

***code 04 - ...continua - line:31***

```html+erb
  <%= hidden_field_tag :count, nil, id: "hidden-counter", value: @count %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_04-views-site-first.html.erb)


Aggiorniamo il controller inserendo la variabile d'istanza `@count`.

***code 05 - .../app/controllers/site_controller.rb - line:3***

```ruby
  def first 
    @count = 3
  end

  def third
    ...
    @count = params[:count].to_i + 1
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_05-controllers-site_controller.rb)


***code 06 - .../app/views/site/third.tubo_stream.erb - line:3***

```html+erb
<%= turbo_stream.replace "hidden-counter" do %>
  <%= hidden_field_tag :count, nil, id: "hidden-counter", value: @count %>
<% end %>


<%= turbo_stream.update "counter" do %>
  <%= @count %>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_06-views-site-third.tubo_stream.erb)



## Verifichiamo preview

Vediamo come si comporta il codice nel browser.

***code n/a - Terminal -line:n/a***

```ruby
$ rails s -b 192.168.64.3
```

Adesso il counter in basso è aggiornato insieme al prepend della riga nella tabella.



## Reference to multiple elements by Tag names

You can also target multiple elements with one message by using the class name instead of an id.
And the `_all` suffix for the action. 

Let's say we want to display the total counter at the top of the page as well. 
Aggiungiamo anche li uno span tag e cambiamo da id a class name.

***code 07 - .../app/views/site/first.html.erb - line:3***

```html+erb
  Total: <span class="counter"><%= @count %></span>
```

Mettiamo *class* anche nel total counter in fondo alla pagina.

***code 07 - ...continua - line:40***

```html+erb
  Total: <span class="counter"><%= @count %></span>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_07-views-site-first.html.erb)

Per far riferimento alla "class" (to target the class name) usiamo `.update_all` invece di `.update` e ci riferiamo alla classe mettendo il "." come prefisso; quindi `.counter` invece di `counter`.

***code 08 - .../app/views/site/third.tubo_stream.erb - line:3***

```html+erb
<%= turbo_stream.update_all ".counter" do %>
  <%= @count %>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_08-views-site-third.tubo_stream.erb)



## Verifichiamo preview

Vediamo come si comporta il codice nel browser.

***code n/a - Terminal -line:n/a***

```ruby
$ rails s -b 192.168.64.3
```

Adesso entrambi i counters, in alto e in basso, sono aggiornati insieme al prepend della riga nella tabella.

> Nell'inspector del browser, nel tab "Network" adesso il "Response" della pagina "third" ha come attributo di turbo-stream il parametro `targets` (al plurale).</br>
> `<turbo-stream action="update" targets=".counter"><template>...`




## Rivediamo come funziona Turbo Streams

Adesso che lo abbiamo usato rivediamo un esempio di funzionamento di Turbo Streams usando solo codice <html>.

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig04-turbo_streams_code.png)

Abbiamo un div con un id univoco che sarà usato da Turbo Streams:`<div id="some-id">`.
Questo div contiene un form `<form action="/create" method="POST">` che sarà il *target* per Turbo Streams.

Quando facciamo il submit del form andiamo sull'azione `create` del controller.
Il controller crea il div `<div>This is new content for the "some-id" node.</div>` ed effettua il render di Turbo Stream dicendo di appendere il div creato al div con id="some-id":

```ruby
render turbo_stream: [
  turbo_stream.append("some-id", html)
]
```

> Anche se in questo esempio abbiamo una sola azione, essendo il `render` un *array* possiamo eseguire più azioni.


Il controller genera il seguente codice <html> che manda come response:

```html
<turbo-stream action="append" target="some-id">
  <template>
    <div>
      This is new content for the "some-id" node.
    </div>
  </template>
</turbo-stream>
```



## Esempio inline crud table with Turbo Streams

In questo esempio c'è una tabella con i record ed interagiamo creando, modificando o eliminando i records senza refresh della pagina. (in modo molto *responsive*)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig05-turbo_streams_code_example.png)

Il codice per il controller non è molto complesso. Vediamo le tre azioni coinvolte.

```ruby
def create
  @user = User.new(user_params)

  if @user.save
    render turbo_stream: [
      turbo_stream.prepend("users", @user),
      turbo_stream.replace(
        "form_user",
        partial: "form",
        locals: { user: User.new }
      )
    ]
  else
    render :new, status: :unprocessable_entity
  end
end
```


```ruby
def update
  if @user.update(user_params)
    render turbo_stream: [
      turbo_stream.replace(@user, @user)
    ]
  else
    render :edit, status: :unprocessable_entity
  end
end
```


```ruby
def destroy
  @user.destroy
  render turbo_stream: [
    turbo_stream.remove(@user)
  ]
end
```




