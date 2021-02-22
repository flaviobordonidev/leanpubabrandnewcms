{id: 99-rails_references-502-link_to-02-link_to-pre_params}
# Ref 502.1 -- Passiamo alla nuova pagina i parametri della pagina in cui siamo


Risorse interne:

* views/company_person_map/_parent_company.html.erb 
  line 43:  <%= link_to person_path(company_person_map.person, h_prev_params.merge(key1: "valore1")), class: "btn image-button btn-rounded btn-transparent-dark-gray margin-10px-bottom" do %>



Risorse web:

* [how to add new item to hash](https://stackoverflow.com/questions/9571768/how-to-add-new-item-to-hash)
* [pass and read url parameters](https://www.developer.com/lang/rubyrails/article.php/3804081/techniques-to-pass-and-read-url-parameters-using-rails.htm)
* [nested params via link_to](https://stackoverflow.com/questions/19308459/merge-nested-params-via-link-to)



## Come passare i parametri su un link_to

I parametri sono passati sotto forma di "hash" in questo modo:

views/page1
```
<%= link_to page2_path(parm1: "valore1", param2: "valore2") %>
```

Vediamo che sull'url avremo:

* https://dominiomyapp.com/page2?param1=valore1&param2=valore2




## Esempio 1- un helper che passa un hash

Creiamo un hash su un helper

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_params()
    #passiamo subito tutto un hash di 2 coppie key: "value"
    my_params = {cane: "zoppo", capra: "campa"}
  end
```

E lo usiamo nella pagina. Sia come riga di testo, per vedere com'è formato, sia associato ad un link.

views/page1
```
<%= h_params %>
<br>
<%= link_to page2_path(h_params) %>
```

Sulla pagina otteniamo:

* {cane: "zoppo", capra: "campa"}

E nell'url del link otteniamo:

* https://dominiomyapp.com/page2?cane=zoppo&capra=campa




## Esempio 2 - un helper che passa un hash creato in più passi

Creiamo un hash su un helper

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_params()
    #creiamo l'hash in più passaggi
    my_params = {}
    my_params[:cane] = "zoppo"
    my_params[:capra] = "campa"
  end
```

In questo esempio usiamo il modo base di aggiungere un elemento ad un hash:

```
  hash = {:item1 => 1}
  #Add a new item to it:
  hash[:item2] = 2
```


Il risultato nella pagina è lo stesso:

* {cane: "zoppo", capra: "campa"}

E nell'url del link otteniamo:

* https://dominiomyapp.com/page2?cane=zoppo&capra=campa




## Esempio 3 - un helper che passa un hash creato in più passi con ".merge"

Creiamo un hash su un helper usando merge

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_params()
    #creiamo l'hash in più passaggi usando .merge
    params = {}
    params = params.merge(cane: "zoppo")
    params = params.merge(capra: "campa")
  end
```


Il risultato nella pagina è lo stesso:

* {cane: "zoppo", capra: "campa"}

E nell'url del link otteniamo:

* https://dominiomyapp.com/page2?cane=zoppo&capra=campa




## Esempio 4 - un helper che passa un hash dei parametri attualmente usati

Creiamo un hash su un helper usando merge e raccogliendo tutti i parametri attualmente presenti nell'url.
I parametri attuali li marchiamo come "pre_" perché una volta cliccato il link andremo su una nuova pagina e quindi i parametri che stiamo raccogliendo si riferiscono alla "pagina precedente".

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_pre_params()
    pre_params = {}
    params.each do |key,value|
      pre_params = pre_params.merge("pre_"+key => value)
    end
    return pre_params
  end
```

Questo esempio lo vediamo usato su companies/index -- <%= link_to companies_path(h_pre_params) ...


Se la nostra pagina attuale è https://dominiomyapp.com/page1?locale=it&page=2&palazzo=grattacielo

Il risultato sarà:

* {pre_locale: "it", pre_page: "2", pre_palazzo: "grattacielo"}

E nell'url del link otteniamo:

* https://dominiomyapp.com/page2?pre_locale=it&pre_page=2&pre_palazzo=grattacielo




## Esempio 5 - url con "nested" params

Predisponiamo un url in modo da avere la seguente struttura

* parentA
  * child1 = Mario
  * child2 = Maria
* parentB
  * child1 = Luca
  * child2 = Lucia

Questo è fatto con il seguente url:

* https://dominiomyapp.com/page1?parenA[child1]=Mario&parentA[child2]=Maria&parentB[child1]=Luca&parentB[child2]=Lucia

E possiamo richiamare i parametri in questo modo:

* params[:parentA][:child1] --> # Mario
* params[:parentA][:child2] --> # Maria
* params[:parentB][:child1] --> # Luca
* params[:parentB][:child2] --> # Lucia


Creiamolo sull'helper

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_params()
    my_params = {parentA: {child1: "Mario", child2: "Maria"}, parentB: {child1: "Luca", child2: "Lucia"}}
  end
```

E lo usiamo nella pagina. Sia come riga di testo, per vedere com'è formato, sia associato ad un link.

views/page1
```
<%= h_params %>
<br>
<%= link_to page2_path(h_params) %>
```

Sulla pagina otteniamo:

* {:parentA=>{:child1=>"Mario", :child2=>"Maria"}, :parentB=>{:child1=>"Luca", :child2=>"Lucia"}}

E nell'url del link otteniamo:

* https://domainmyapp.com/page2?parentA%5Bchild1%5D=Mario&parentA%5Bchild2%5D=Maria&parentB%5Bchild1%5D=Luca&parentB%5Bchild2%5D=Lucia

Che in realtà è uguale a questo:

* https://domainmyapp.com/page2?parentA[child1]=Mario&parentA[child2]=Maria&parentB[child1]=Luca&parentB[Bchild2]=Lucia

Solo che i caratteri "[" e "]" non sono permessi nell'url ed allora sono ricodificati in "%5B" e "%5D". (i browser attuali fanno in automatico questa conversione)


Note:

https://edgeguides.rubyonrails.org/action_controller_overview.html

The params hash is not limited to one-dimensional keys and values. It can contain nested arrays and hashes. To send an array of values, append an empty pair of square brackets "[]" to the key name:

* GET /clients?ids[]=1&ids[]=2&ids[]=3

The actual URL in this example will be encoded as:

* "/clients?ids%5b%5d=1&ids%5b%5d=2&ids%5b%5d=3" 

as the "[" and "]" characters are not allowed in URLs. Most of the time you don't have to worry about this because the browser will encode it for you, and Rails will decode it automatically, but if you ever find yourself having to send those requests to the server manually you should keep this in mind.

The value of params[:ids] will now be

* ["1", "2", "3"]. 

Note that parameter values are always strings; Rails makes no attempt to guess or cast the type.


Nella page2 mettiamo il seguente codice per avere la prova del nove, ossia la conferma:

views/page2
```
<h5>Debug</h5>
<p> params = <%= params  %> </p>
<br>
<p> params[:parentA][:child1] = <%= params[:parentA][:child1] %> </p>
<p> params[:parentA][:child2] = <%= params[:parentA][:child2] %> </p>
<p> params[:parentB][:child1] = <%= params[:parentB][:child1] %> </p>
<p> params[:parentB][:child2] = <%= params[:parentB][:child2] %> </p>
```

ed otteniamo il seguente risultato:

params = {"parentA"=>{"child1"=>"Mario", "child2"=>"Maria"}, "parentB"=>{"child1"=>"Luca", "child2"=>"Lucia"}, "controller"=>"pages", "action"=>"page2"}

params[:parentA][:child1] = Mario
params[:parentA][:child2] = Maria
params[:parentB][:child1] = Luca
params[:parentB][:child2] = Lucia




## Esempio 6 - un helper che passa un hash "annidato"

Riprendendo l'esempio 4, invece di marcare ogni parametro con "pre_" vogliamo creare un parmetro padre "previous" che dentro ha un hash con parametri figli.

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_prev_params()
    prev_params = {previous: {}}
    request.params.except(:previous).each do |key,value|
      prev_params[:previous] = prev_params[:previous].merge(key => value)
    end
    return prev_params
  end
```

Analizziamo il codice:

* request.params.except(:previous)  --> evita di avere previous annidati uno dentro l'altro. (non si annidano all'infinito ma solo una volta perché la seconda volta sovrascrive i valori del "previous" annidato)
* request.params --> se uso solo "params" ottengo un messaggio di errore per alcuni parametri non autorizzati.

  Esempio su views/page1 (url: https://domainmyapp.com/people?locale=en&page=2&previous[controller]=home) 
  
  usando solo "params.each" ottengo:
    
    * h_prev_params: {:previous=>{"locale"=>"en", "page"=>"2", "previous"=><ActionController::Parameters {"controller"=>"home"} permitted: false>, "controller"=>"people", "action"=>"index", "search"=>""}}

  usando "request.params.each" ottengo:
    
    * h_prev_params: {:previous=>{"locale"=>"en", "page"=>"2", "previous"=>{"controller"=>"home"}, "controller"=>"people", "action"=>"index"}}

  usando "request.params.except(:previous).each" ottengo:

    * h_prev_params: {:previous=>{"locale"=>"en", "page"=>"2", "controller"=>"people", "action"=>"index"}}






## Esempio 7 - oltre previous passiamo previous-previous

Oltre il previous già visto che ci permette di tornare indietro di un view creaiamo l'helper previous-previous che ci permette di tornare indietro di 2 views.

{id: "50-04-09_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  def h_prevprev_params()
    prevprev_params = {preprevious: {}}
    request.params.except(:preprevious).each do |key,value|
      if key == :previous
        prevprev_params = prevprev_params.merge(key => value)
      else
        prevprev_params[:preprevious] = prevprev_params[:preprevious].merge(key => value)
      end
    end
    return prev_params
  end
```

NOTA: CODICE DA VERIFICARE.

L'idea è avere "previous" e "preprevious" come sibiling di params. Quindi:
params[:previous][:controller] = people
params[:preprevious][:controller] = companies

Se non usavo il controllo "if key == :previous" avrei avuto un doppio annidamento:
params[:previous][:controller] = people
params[:previous][:preprevious][:controller] = companies




---
## Esempio su company_person_map che torna a person

Su company_person_map ho il link che mi richiama lo show della persona.
Sul views/people/show ho il partial _navbar_show che ha il pulsante di chiusura.
Il pulsante di chiusura di default mi rimanda su people/index, ma, vedendo nel params[:previous] il controller company_person_maps mi fa tornare a company_person_maps.

---
        <%#= link_to new_person_path, class: "btn btn-small btn-transparent-white lg-margin-15px-bottom d-table d-lg-inline-block md-margin-lr-auto" do %>
          <%#= image_tag "elis/icons/close.png", class: "img-circle width-85 xs-width-100", alt: "" %>
        <%# end %>
        <% if params[:previous].present? %>
          <% if params[:previous][:controller] == "company_person_maps" %>
            <%= link_to company_person_maps_path(page: params[:previous][:page], anchor: "anchor_#{@person.id}"), class: "btn btn-medium btn-transparent-dark-gray margin-10px-bottom wow fadeInUp", 'data-wow-delay': "0.6s" do %>
              <%= image_tag "elis/icons/close.png", class: "img-circle width-85 xs-width-100", alt: "" %>
            <% end %>
          <% elsif params[:previous][:controller] == "people" %>
            <%= link_to people_path(page: params[:previous][:page], anchor: "anchor_#{@person.id}"), class: "btn btn-medium btn-transparent-dark-gray margin-10px-bottom wow fadeInUp", 'data-wow-delay': "0.6s" do %>
              <%= image_tag "elis/icons/close.png", class: "img-circle width-85 xs-width-100", alt: "" %>
            <% end %>
          <% else %>
            <%= raise "errore" %>
          <% end %>
        <% end %>
---

Questo blocco di codice lo dovrei pulire con un presenter o con un helper ma questo lo faremo più avanti.




