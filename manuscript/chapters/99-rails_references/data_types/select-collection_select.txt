## Spiegazione didattica su **.select**

Per il selettore avremmo potuto usare form.collection_select al posto di form.select ?

~~~~~~~~
    <%= form.collection_select(:city_id, City.all, :id, :name) %>
~~~~~~~~

Nel nostro caso no perché form.collection_select lavora su una tabella; invece noi stiamo usando |enum| sulla colonna :role della tabella users.
  

Altri esempi di form.select per chiarire meglio come lavora:

~~~~~~~~
<%= form_for @post do |form| %>
  <%= form.select :person_id, Person.all.map { |p| [ p.name, p.id ] }, include_blank: true %>
  <%= form.submit %>
<% end %>
~~~~~~~~

~~~~~~~~
@users = User.all
<% form_for @user, :html => { :method => :post } do |form| %>
  <%= form.select :user_id, @users %>
~~~~~~~~

~~~~~~~~
<% form_for @user, :html => { :method => :post } do |form| %>
  <%= form.select :user_id, @users.collect { |user| [user.name, user.id] } %>
~~~~~~~~

~~~~~~~~
<%= form.select :estados, ['SP', 'PA', 'RJ'] %>
~~~~~~~~

~~~~~~~~
<%= form.select :estados, [['São Paulo', 'SP'], ['Pará', 'PA'], ['Rio de Janeiro', 'RJ']] %>
~~~~~~~~

