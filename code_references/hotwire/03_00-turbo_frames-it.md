# <a name="top"></a> Cap hotwire.3 - Turbo Frame examples

In questo capitolo vediamo Turbo Frame.
Qui inizia a vedersi il potere di Turbo per rendere Rails simile alle Single Page App, perché ci permette di passare solo piccole parti di codice ed aggiornare punti specifici. Questo rende estremamente veloce e prestazionale l'applicazione, dando un'eccellente "user experience".



## Risorse esterne

- [L3: Hotwire - Turbo Drive](https://school.mixandgo.com/targets/257)
- [L3: Hotwire - Turbo Frame](https://school.mixandgo.com/targets/258)
- [L3: Hotwire - Turbo Streams](https://school.mixandgo.com/targets/259)

- [hotwire calculator](bit.ly/hotwire-calc)



## Vediamo come funziona Turbo Frame

Dobbiamo racchiudere la parte di codice che vogliamo cambiare in una "cornice" (frame).

Abbiamo il Turbo Frame tag con un id che deve essere univoco nella pagina: `<turbo-frame id="frame-id">`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig01-turbo_frame_code.png)

In questo esempio abbiamo il link con titolo "Click" `<a href="/something">Click</a>` e quando clicchiamo sul link abbiamo la fetch/request che va al server.

Il server render un *template* (*view*) e quel template viene reinviato come fetch/response al browser e sostituisce il frame presente. Tutto il resto della pagina resta uguale.



## Vediamo un esempio con un login form

Prepariamo un login form e sul submit cambiamo solo la parte interna del form lasciando tutto il resto inalterato.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig02-turbo_frame_schema1.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig03-turbo_frame_schema2.png)

Per farlo funzionare dobbiamo avere un'identificativo del frame, come un **id**, così Rails sa quale frame aggiornare, in caso ci siano più di un frame nella pagina (multiple frames).

Vediamo all'opera. Prendiamo la pagina "first" del capitolo precedente e mettiamoci un frame.

***code 01 - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "someid" do %>
  <%= link_to "Second page", site_second_path %>
<% end %>
```

Se andiamo in preview e clicchiamo sul link vediamo che il link sparisce e sembra non succedere nientaltro. Questo perché manca un frame con lo stesso id nella pagina chiamata dal link (nel nostro caso site/second).
Quindi inseriamo il frame con lo stesso id nella "Second page"

***code 02 - .../app/views/site/second.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "someid" do %>
  Hello!
<% end %>
```

Se adesso andiamo in preview e clicchiamo sul link vediamo che il link sparisce ed è rimpiazzato con il il contenuto del frame della seconda pagina; nel nostro caso "Hello!"

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig04-turbo_frame_example1.png)


> ATTENZIONE! </br>
> L' **id** del turbo_frame deve essere lo stesso altrimenti è ignorato.



## Aggiungiamo un secondo frame

Vediamo come i frames sono indipendenti uno dall'altro. Aggiungiamo un secondo turbo_frame e questa volta mettiamo un form al suo interno.


***code 03 - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "formid" do %>
  <%= form_with url: site_second_path do |f| %>
    <%= f.text_field :name %>
    <%= f.submit %>
  <% end %>
<% end %>
```

Il submit esegue un POST quindi cambiamo nel routes il percorso all'azione `second` da GET a POST

***code n/a - .../config/routes.rb - line:3***

```ruby
  get "site/first"
  post "site/second"
```

ed impostiamo il relativo turbo_frame con id "formid" anche nella view "second".

***code 04 - .../app/views/site/second.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "formid" do %>
  Something else
<% end %>
```

Il submit del form (che usa POST) funziona ma ha smesso di funzionare il link_to (che usa GET).


![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig05-turbo_frame_get_post1.png)


![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig06-turbo_frame_get_post2.png)


![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig07-turbo_frame_get_post3.png)


Per far si che funzionino entrambi, rimettiamo il percorso di `second` su GET ed aggiungiamo il nuovo percorso `third` che usa POST. Dalla nuova azione `third` facciamo il redirect all'azione `second`.

***code 05 - .../config/routes.rb - line:3***

```ruby
  get "site/first"
  get "site/second"
  post "site/third"
```

Agiorniamo il reinstradamento sul form in view/first

***code n/a - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "formid" do %>
  <%= form_with url: site_third_path do |f| %>
```

Aggiungiamo l'azione nel controller, e siccome fa un redirect non serve avere la "views/third".

***code 05 - .../controllers/site_controller.rb - line:3***

```ruby
  def third 
    redirect_to site_second_path
  end
```

In questo modo riusciamo a far funzionare sia il link_to che il submit del form.


![fig08](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/03_fig08-turbo_frame_get_post4.png)

Nel preview abbiamo cliccato prima il link e poi il submit del form. Nell'immagine vediamo la prima richiesta GET completata con successo con Status 304. Poi la richiesta POST completata con successo con redirect e relativo Status 302. Ed infine il GET dal redirect concluso con successo con Status 304.



## Aggiorniamo un frame differente

Da dentro un frame possiamo anche aggiornare il contenuto di un altro frame indicandolo esplicitamente.
Ad esempio facciamo in modo che il link, che è nel turbo_frame con id="someid", una volta cliccato invece di essere rimpiazzato con la scritta "Hello!" attivi il turbo_frame con id="formid" sostituendo quindi il form con la scritta "Something else".


***code n/a - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "someid" do %>
  <%= link_to "Second page", site_second_path, data: { turbo_frame: "formid"} %>
<% end %>
```

Funziona ^_^



## Andiamo su una nuova pagina

I link all'interno di un turbo_frame non ci portano su una nuova pagina ma ci lasciano sulla pagina in cui siamo ed aggiornano il solo contenuto del frame.
Se invece vogliamo effettivamente andare su un'altra pagina possiamo farlo inserendo il seguente attributo: `target: "_top"`


***code n/a - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "someid" do %>
  <%= link_to "Second page", site_second_path, target: "_top" %>
<% end %>
```

Funziona ^_^
Facendo clic sul link siamo andati alla view `second`



## Carichiamo il contenuto di un turbo_frame usando un path

Questo ci permette di caricare il contenuto come se fosse un "view partial" ma in questo caso viene fatta una vera e propria chiamata dal browser che è intercettatata da turbo_frame e gestita come fetch.

Il risultato finale è che il contenuto html è aggiunto al frame come se fosse stato scritto in locale ma in realtà viene da un'altra view. Inoltre è possibile gestire questo caricamento in modalità "lazy" che ritarda il caricamento del turbo_frame fino a quando quella sezione della pagina non diventa visibile nel browser.

Per fare un esempio aggiungiamo il nuovo instradamento `fourth` a routes.

***code n/a - .../config/routes.rb - line:3***

```ruby
  get "site/first"
  get "site/second"
  post "site/third"
  get "site/fourth"
```

Aggiorniamo il controller aggiungendo la nuova azione `fourth`.

***code n/a - .../controllers/site_controller.rb - line:3***

```ruby
  def fourth;  end
```

Il modo in cui facciamo riferimento a questo percorso è aggiungendo un attributo `src` al tag turbo_frame con un percorso da cui vogliamo recuperare il contenuto.
(The way we reference this path is by adding a `src` attribute to the turbo_frame tag with a path you want to fetch the content from.)

***code n/a - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "fourthid", src: "/site/fourth" %>
```

Creiamo quindi la view `fourth` da dove vogliamo prendere il contenuto. 


***code n/a - .../app/views/site/fourth.html.erb - line:1***

```html+erb
<%= turbo_frame_tag "fourthid" do %>
  <hr />
  This content was loaded from a different template/view.
<% end %>
```

Possiamo ritardare il caricamento del turbo_frame fino a quando quella sezione della pagina non diventa visibile nel browser. Per far questo utilizziamo l'attributo "loading" con il valore "lazy".

***code n/a - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= turbo_frame_tag "fourthid", src: "/site/fourth", loading: "lazy" %>
```

Questo permette alla tua pagina di caricare molto più velocemente, specialmente se la tua pagina ha molto contenuto.



## Come gestire componenti correlati

Finora abbiamo visto che Turbo Frames cambia un solo componente alla volta (per componente intendiamo del codice html dentro il turbo frame). Ma ci sono molti casi in cui dobbiamo cambiare anche in un altra parte della pagina. 

Ad esempio abbiamo un contatore (counter) da una parte della pagina ed interagiamo con un turbo frame in un'altra parte della pagina. Se vogliamo che al request del turbo frame il server ci dia un response che aggiorni anche il contatore... questo Turbo Frame **non** riesce a farlo. 

Ed è per questo che esiste Turbo Stream.