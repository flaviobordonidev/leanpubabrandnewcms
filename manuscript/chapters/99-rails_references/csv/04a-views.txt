# views




## kiosks




#### 01 {#code-csv-04-views-01}

{title="views/kiosks/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<%= form_for(kiosk) do |f| %>
  <% if kiosk.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(kiosk.errors.count, "error") %> prohibited this kiosk from being saved:</h2>

      <ul>
      <% kiosk.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :serial %>
    <%= f.text_field :serial %>
  </div>

  <div class="field">
    <%= f.label :csvfile %>
    <%= f.file_field :csvfile, class: 'form-control'%>
  </div>
  
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
~~~~~~~~




#### 02 {#code-csv-04-views-02}

{title="views/kiosks/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<p id="notice"><%= notice %></p>

<h1>Kiosks</h1>

<table>
  <thead>
    <tr>
      <th>Serial</th>
      <th>CSVfilename</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @kiosks.each do |kiosk| %>
      <tr>
        <td><%= kiosk.serial %></td>
        <td><%= kiosk.csvfile_file_name %></td>
        <td><%= link_to 'Show', kiosk %></td>
        <td><%= link_to 'Edit', edit_kiosk_path(kiosk) %></td>
        <td><%= link_to 'Destroy', kiosk, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New Kiosk', new_kiosk_path %>
~~~~~~~~