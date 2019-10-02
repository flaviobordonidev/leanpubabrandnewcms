# form.select


Risorse web:

* [Dynamic Select Menus in Rails 5](https://rubyplus.com/articles/3691-Dynamic-Select-Menus-in-Rails-5)
* []()




## Esempi di uso interno

* vedi 01-base/c05-enum_with_i18n/01-enum_with_i18n

Mettiamo la possibilità per l'amministratore di selezionare un autore qualsiasi per l'articolo.

{id="03-03-01_03", title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
  <!-- Hidden fields -->
  <%= form.text_field :user_id, style: 'display:none' %><!-- :user_id è fondamentale per l'azione new -->
  <!-- Hidden fields end -->

  <% if current_user.admin? == true %>
    <!-- se amministratore -->
    <div class="form-group">
      <%= form.label :user_id %>
      <%= form.collection_select :user_id, User.order(:name), :id, :name, include_blank: true %>
      
      <%#= f.collection_select :provider_id, Provider.order(:name),:id,:name, include_blank: true %>
      <%#= f.collection_select :country_id, Country.order(:name), :id, :name, include_blank: true %>
      <%#= f.collection_select :state_id, State.order(:name), :id, :name, include_blank: true %>
  
      <%#= f.select(:project_id, Project.all.collect {|p| [p.name, p.id]},  {prompt: "Select"}, {class: 'form-control'}) %>
      <%#= f.select(:task_id, Tasks.all.collect {|t| [t.name, t.id]}, {}, {class: 'form-control'}) %>
    </div>
  <% end %>
~~~~~~~~

[Codice 03](#06-01-01_01all)
  
