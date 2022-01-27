# link_to


Risorse web:

* [](https://www.rubyguides.com/2019/06/rails-params/)
* [Articolo simpatico per LINK_TO](https://mixandgo.com/blog/how-to-use-link_to-in-rails)
* [GoRails Link to Current Page in Rails with Params](https://www.youtube.com/watch?v=FT-yVFiq9ZQ)

il comando link_to per creare dei link è uno dei più usati su rails. Ci sono molti esempi sugli usi ma in questo capitolo scopriremo degli usi meno noti nei forum ma molto usati nella vita reale.



* request.params.
  prende l'url attuale e tutti i parametri ed i loro valori.

* .merge()
  aggiunge o modifica i valori dei parametri dell'url.

* params.permit()
  prende l'url attuale ed aggiunge i soli parametri dichiarati in permit()




## Esempio nel cambio della lingua

Nel seguente codice il pulsante per Italiano ha "request.params" invece il pulsante per Inglese ha "params.permit"

```
  <%= link_to request.params.merge(locale: 'it'), class: "btn btn-medium #{(params[:locale] == 'it' or params[:locale] == nil) ? 'btn-dark-gray disabled' : 'btn-transparent-dark-gray'} margin-10px-bottom" do %>
    <%= image_tag "elis/icons/language_it.png", alt: "italian" %> <%= t("pages.home.italian") %> &nbsp&nbsp&nbsp&nbsp
  <% end %>
  <%= link_to params.permit(:locale).merge(locale: 'en'), class: "btn btn-medium #{params[:locale] == 'en' ? 'btn-dark-gray disabled' : 'btn-transparent-dark-gray'} margin-10px-bottom" do %>
    <%= image_tag "elis/icons/language_us.png", alt: "english" %>  <%= t("pages.home.english") %> &nbsp&nbsp&nbsp&nbsp
  <% end %>
```

Se clicco su inglese tutti gli altri parametri nell'url sono persi. (ad esempio se sono nella seconda pagina del pagination torno alla prima perché mi toglie "page=2")

Se clicco su italiano mi mantiene anche tutti gli altri parametri. (ad esempio torno correttamente alla seconda pagina del pagination perché mi mantiene "page=2")




## Link_to con "anchor"

link_to can also produce links with anchors:

```
link_to "Comment wall", profile_path(@profile, :anchor => "wall")
#=> <a href="/profiles/1#wall">Comment wall</a>
```

Se anchor della stessa pagina:

```
<%= link_to "#pane_list", "data-toggle" => "tab" do %>
```

oppure

```
<%= link_to request.params.merge(anchor: "pane_list"), "data-toggle" => "tab" do %>
```




## When we need to have a hyper link to an id in the same page (anchor)

given that your html id is #my_id

<%= link_to('Click here to do to my_id', :anchor => 'my_id') %>
<div id="my_id"></div>

https://mixandgo.com/blog/how-to-use-link_to-in-rails

Anchors with link_to
You might need to point to a specific section (anchor) in the page which you can identify by it’s dom ID. So let’s say on the target page we have a section that has the id="interesting-section". In order to point our link to that section, we’ll need to add the anchor to the generated link.

<%= link_to "Section", root_path(:anchor => "interesting-section") %>
# => <a href="/#interesting-section">Section</a>


## Esempio di anchor nell'elenco delle persone

Da views/people/show ho il link di chiusura che torna a views/people/index e scende fino alla persona che avevamo visualizzato.
Per fare questo mettiamo in "index" uno specifico "id" al "div". <div id="anchor_id"></div>

---
          <% @people.each do |person| %>
            <li>
              <div class="display-table width-100" id="anchor_<%= person.id %>">
---

e nel link in "show" mettiamo

---
<%= link_to 'Go Back To People Index', people_path(page: params[:previous][:page], anchor: "anchor_#{@person.id}") %> |
---

Non mi viene passato l'id della persona come params[:previous] perché nella pagina index non è nell'url. Potrei aggiungere al link che mi porta su show di passare anche un params[:person_id] ma è superfluo. Ho già "@person.id".



## Links che puntano a azione specifica

  questo paragrafo è interessante per creare dei links che puntano ad un'azione specifica da far fare al controller. Potrebbe essere anche non legata alla view.
  Ad esempio si può mettere un link per fare un aggiornamento dei dati " get 'data_sync' => 'transactions#sync_db_via_ftp' (vedi Donamat Dashboard)
  
  ## Verifichiamo gli instradamenti dei links
  
  Giochiamo un po' con le routes. Aggiungiamo i percorsi "sections" e "signatures" ma al momento li leghiamo alle pagine di examples
    
  {id="02-03-02_03", title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=9}
  ```
    get 'sections' => 'mockups#page_a'
    get 'signatures' => 'mockups#page_b'
    get 'mockups/page_a'
    get 'mockups/page_b'
  ```
  
  [Codice 03](#02-03-02_03all)
  
  Così possiamo andare nella stessa pagina sia con il percorso di default mydomain.com/example_pages/page_c sia con mydomain.com/signatures



## Esempio 1 - Stack Overflow

* https://stackoverflow.com/questions/28099203/link-to-post-edit-view-in-rails

Really basic question about link_to that I'm having trouble finding a straight answer to.

So I have an index view that simply lists posts according to user email address.

```
<% @post.each do |post| %>
  <tr>
    <td class="email"><%= link_to post.user.email, post %></td>
  </tr>
<% end %>
```

As it stands, this links to the show view for the given post. How might I make it link to the edit view instead?

Pretty simple:

<%= link_to post.user.email, edit_post_path(post) %>




## Esempio 2 - del remove uploaded image


{id: "99-08-01_02", caption: ".../app/controllers/companies_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 13}
```
  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    #redirect_back(fallback_location: request.referer)
    redirect_back(fallback_location: root_path)
  end
```





## Altri esempi da sistemare



https://github.com/flaviobordonidev/yesnormalis/blob/master/app/views/company_person_maps/edit/_tab_edit.html.erb

<%#= link_to company_person_maps_select_path(id: params[:id], company_person_maps: {person_id: @company_person_map.person_id, company_id: @company_person_map.company_id}, related: "companies", page: 1, search: ""), :class => "list-group-item" do %>
<%#= link_to [@company_person_map.company, related: "companies", page: 1, search: ""], :class => "list-group-item" do %>
<%= link_to companies_path(related: "companies", page: 1, search: ""), :class => "list-group-item" do %>



---

se passo i parametri con session[] sul controller uso ** after_action :set_session_last_front ** (vedi yesnormalis)


Quindi sul controller togliamo index dall'after_action.
Iniziamo dal lato people

{title="controllers/people_controller.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
after_action :set_session_last_front, only: [:show]
~~~~~~~~





# Link_to con params

Risorse web:

* [Go Rail link_to current page with params](https://gorails.com/episodes/rails-link-to-current-page-with-params)
* [Go Rail link_to current page with params - link alternativo](https://www.youtube.com/watch?v=FT-yVFiq9ZQ)


## Esempio sul cambio lingua

<%= link_to params.permit(:locale).merge(locale: 'en') %>



## Esempio hard coded

<%= link_to "Customers", root_path %>

<%= link_to "Paid Customers", root_path(paid: true) %>

<%= link_to "Customers Date Range", root_path(start: params[:start], end: params[:end]) %>

<%= link_to "Customers Date Range", request.params.except(:paid) %>

<%= link_to "Paid Customers Data Range", root_path(paid: true) %>




## Esempio passando un hash

Non indicando il "path" viene utilizzato lo stesso path/URL e vengono passati i parametri

<%= link_to "Customers Date Range", { start: params[:start], end: params[:end] } %>




## Prendiamo tutti i parametri

<%= link_to "Customers Date Range", request.params %>




### Escludiamo qualche parametro


<%= link_to "Customers Date Range", request.params.except(:paid) %>



### Includiamo qualche parametro

<%= link_to "Customers Date Range", request.params.merge(paid: true) %>



## Link to multiple params

<%= link_to "game " + g.game_number.to_s, :action => "gametemplate", :id => 1, :season => 'winter', :year => 2007 %>

These will be accessible from the controller as 
  params[:id], params[:year] etc...



## Pass custom variables to the link_to

I basically want to pass my own custom variables to the link_to function
so I don't need to set up a bunch of actions within my controller.

So here's more of the details:

link_to example:

Code:

<% for g in @games %>
   <%= link_to "game " + g.game_number.to_s, :action => "gametemplate"%>
<% end %>


controller example code:
Code:

  def gametemplate
    b = Batter.new()
    @batter_stats = b.find_game_stats 1, 2007, "winter"
  end


I can then pass the @batter_stats to my view. However, how do I get the:
Code:
 1, 2007, "winter"
arguments from my link_to function?

I can't find an answer anywhere I feel this would be something easy to
do in rails. I got around this by setting up a separate action and
resulting view rhtml file to for each game. This is obviously not a very
good solution especially if I have 50 games. I'm a newbie @ rails and
any help would be appreciated.

Thanks.

---
On 9 Oct 2007, at 16:25, Jonathon Eastman wrote:

>
> I can then pass the @batter_stats to my view. However, how do I get  
> the:
> Code:
>  1, 2007, "winter"
> arguments from my link_to function?
>
You can pass as many arguments as you want:
<%= link_to "game " + g.game_number.to_s, :action =>
"gametemplate", :id => 1, :season => 'winter', :year => 2007 %>
These will be accessible from the controller as params[:id], params
[:year] etc...

Fred
