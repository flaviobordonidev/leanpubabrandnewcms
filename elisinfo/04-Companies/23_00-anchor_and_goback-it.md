{id: 50-elisinfo-04-Companies-23-anchor_and_goback}
# Cap 4.23 -- NavBar pulsante go-back

Implementiamo passo a passo il link per tornare indietro alla finestra precedente.




## Passo 1

Mettiamo dei semplici path assoluti alla view su cui dobbiamo tornare



## Passo 2

Aggiungiamo un anchor così quando torniamo indietro ci posizioniamo nel punto giusto dell'elenco.
L'aggiunta di un anchor si fa semplicemente dichiarando un "id" nel nostro caso nel <div>. Lo chiamiamo anchor_... semplicemente per farci capire che quell'id lo usiamo come anchor e deve essere univoco. Lo avremmo potuto chiamare pippo_... e mettere un progressivo o un random o un time.now ecc...

{id: "50-04-23_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 58}
```
          <% @companies.each do |company| %>
            <li>
              <div class="display-table width-100" id="anchor_<%= company.id %>">
```

Diciamo al nostro pulsante go_back sul nav_bar di tornare indietro e di usare l'anchor


{id: "50-04-23_01", caption: ".../views/companies/_navbar_show.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 58}
```
        <%= link_to companies_path(anchor: "anchor_#{@company.id}"), class: "btn btn-medium btn-transparent-dark-gray margin-10px-bottom wow" do %>
          <%= image_tag "elis/icons/go_back.png", class: "img-circle width-85 xs-width-100", alt: "" %>
        <% end %>
```



## Codice da spostare più avanti nei capitoli

Siamo su company_person_maps/index -> partial _parent_company ed inseriamo il pulsante "..." che va su companies/show.
Ma vogliamo che sul nav_bar di companies/show se clicco sul pulsante per tornare indietro torni su company_person_maps/index e non vada su companies/index.

A questo punto implemento il params[:previous] che mi passa tutti i parametri della pagina attuale così possiamo tornare indietro alla pagina chiamante esattamente nelle stesse condizioni da dove partivamo.

Prepariamo un helper per raccogliere tutti i parametri e metterli annidati dentro params[:previous]

{id: "50-04-23_01", caption: ".../helpers/application_helper.rb -- codice 02", format: ruby, line-numbers: true, number-from: 58}
```
  def h_prev_params()
    prev_params = {previous: {}}
    request.params.except(:previous).each do |key,value|
      prev_params[:previous] = prev_params[:previous].merge(key => value)
    end
    prev_params[:previous][:page] = 1 if prev_params[:previous][:page].blank?
    return prev_params
  end
```

Con questo helper passiamo annidati dentro params[:previous] tutti i parametri presenti nella pagina attuale, tranne eventuali params[:previous] già presenti.

Adesso creiamo il link che usa l'helper:


{id: "50-04-23_01", caption: ".../views/company_person_map/_parent_company.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 58}
```
  <%= link_to company_path(company, h_prev_params), class: "btn image-button btn-rounded btn-transparent-dark-gray margin-10px-bottom" do %>
```

Volendo oltre a tutti i parametri "previous" possiamo anche passargli degli altri parametri se ci fa comodo, ad esempio:

{id: "50-04-23_01", caption: ".../views/company_person_map/_parent_company.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 58}
```
  <%= link_to company_path(company, h_prev_params.merge(key1: "valore1", key2: "valore2")), class: "btn image-button btn-rounded btn-transparent-dark-gray margin-10px-bottom" do %>
```

Facciamo clic ed arriviamo a companies/show e sull'url abbiamo params[:previous] con tutti i parametri passati.
Adesso cambiamo il pulsante per tornare indietro di nav_bar in modo che sfrutti i params[:previous] e ci riporti su company_person_maps/index

{id: "50-04-23_01", caption: ".../views/companies/_navbar_show.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 58}
```
        <%= params[:previous] %>
        <% if params[:previous][:controller] == "company_person_maps" %>
          <%= link_to company_person_maps_path(anchor: "anchor_company_#{@company.id}", page: params[:previous][:page]), class: "btn btn-medium btn-transparent-dark-gray margin-10px-bottom wow" do %>
            <%= image_tag "elis/icons/go_back.png", class: "img-circle width-85 xs-width-100", alt: "" %>
          <% end %>
        <% else %>
          <%= link_to companies_path(anchor: "anchor_#{@company.id}"), class: "btn btn-medium btn-transparent-dark-gray margin-10px-bottom wow" do %>
            <%= image_tag "elis/icons/go_back.png", class: "img-circle width-85 xs-width-100", alt: "" %>
          <% end %>
        <% end %>
```


## REFACTORING

https://stackoverflow.com/questions/27995582/how-to-properly-refactor-a-simple-if-else-logic-in-views-for-ror

I'm a newbie at Rails and I'm having trouble wrapping my head around refactoring logic from views. Let's say I have a simple Post model. In the index view, I want specific content to be displayed if there are posts or not. Basically, if there are any posts, display this specific content or else this other content.

Here is my index.html.erb view for Posts:

<div class="content">
 <% if @posts.any? %>
 <table>
     <thead>
       <tr>
         <th>Title</th>
         <th>Content</th>
       </tr>
     </thead>
     <tbody>
       <% @posts.each do |post| %>
         <tr>
           <td><%= post.title %></td>
           <td><%= post.content %></td>              
         </tr>
       <% end %>
     </tbody>
   </table>
 <% else %>
 <p>There are no posts!</p>
 <% end %>
</div>
Now, the way I refactored this was by creating a couple of helpers and partials like so:

posts_helper.rb (which renders the partials according to the if logic):

module PostsHelper

 def posts_any
  if @posts.any?
    render 'this_content'
  else
    render 'this_other_content'
  end
 end

end
In the partials, I just used the exact content in the if else statement.

_this_content.html.erb partial:

<table>
   <thead>
     <tr>
       <th>Title</th>
       <th>Content</th>
     </tr>
   </thead>
   <tbody>
     <% @posts.each do |post| %>
       <tr>
         <td><%= post.title %></td>
         <td><%= post.content %></td>              
       </tr>
     <% end %>
   </tbody>
 </table>
_this_other_content.html.erb partial:

<p>There are no posts!</p>
Finally, the refactored index.html.erb (which would call the helper method):

<div class="content">
 <%= posts_any %>
</div>
The problem is, I'm just not convinced that this is the correct Rails way of refactoring. If any of you could shed some light on this, I would highly appreciate it! Thanks!

--

You're doing it right, and better than many people I know. :)

A few minor adjustments...

I would move the render from the helper to the erb, and just use the helper to return the right name of what to render.

Your erb code and helper code:

<%= posts_any %>

def posts_any
  if @posts.any?
    render 'this_content'
  else
    render 'this_other_content'
  end
end
I suggest:

<%= render posts_any %>

def posts_any
  @posts.any? ? 'this_content' : 'this_other_content'
end
Next, I personally like to render a collection using a partial.

Yours:

 <% @posts.each do |post| %>

I suggest:

<%= render partial: "post", collection: @posts %>

And in the comment below, user kyledecot suggests even terser:

<%= render @posts %>

Then create the file _post.html.erb like this:

<tr>
  <td><%= post.title %></td>
  <td><%= post.content %></td>              
</tr>

Some developers think that it's overkill to render a collection using a partial, in the case where the partial is not used anywhere else.

I personally think it's helpful, and especially useful when a project has multiple coders some of whom may be changing the table row data results.

