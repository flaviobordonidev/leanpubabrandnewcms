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


> Nel form inseriamo l'attributo `scope: "person"` per avere una struttura simile a quella che si ha quando il form è legato ad un Model (in questo caso sarebbe il model Person).
> Nello specifico tutti i campi che dichiariamo nel form saranno annidati dentro la variabile dello `scope`, quindi nel nostro caso nella variabile `person`.


Nell'azione `third` assegniamo i valori alle variabili di istanza (instance variables) @name, @email e @age, che useremo nella view. E prendiamo i valori dall'attributo "params[]".


***code 02 - .../app/controllers/site_controller.rb - line:3***

```ruby
  def third 
    @name, @email, @age = params[:person].values_at(:name, :email, :age)
  end
```

Attenzione!
Da notare che la risposta POST al submit del form è di tipo **TURBO_STREAM**.
Mentre invece la prima risposta della pagina `first` era di tipo **HTML**

```
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

Quindi la view che dobbiamo utilizzare avrà un'estensione, o meglio un "file format", di tipo `turbo_stream`.
In altre parole il nome del file della view sarà `third.tubo_stream.erb` e non `third.html.erb`.

***code 01 - .../app/views/site/third.html.erb - line:3***

```html+erb

```















## Vediamo come funziona Turbo Streams

Facciamo un esempio di funzionamento usando solo codice <html>.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig01-turbo_streams_code.png)

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

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig02-turbo_streams_code_example.png)

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




## Turbo Streams Broadcast

