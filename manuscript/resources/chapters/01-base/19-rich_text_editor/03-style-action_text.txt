{id: 01-base-19-rich_text_editor-03-style-action_text}
# Cap 19.3 -- Cambiamo lo style di Action Text


* https://blog.saeloun.com/2019/10/01/rails-6-action-text.html
* https://blog.saeloun.com/2019/11/12/attachments-in-action-text-rails-6




## Apriamo il branch "Style Action Text"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b sat
```





## Personalizziamo lo stile di Action Text


* https://stackoverflow.com/questions/51494407/trix-editor-rails-customizing

nascondiamo tutto il gruppo di gestione dei files che include il pulsante di inserimento attachment.

{id: "01-19-03_01", caption: ".../app/assets/stylesheets/actiontext.scss -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 2}
```
trix-toolbar .trix-button-group--file-tools {
 display: none;
 //background-color: green;
}
```

nascondiamo il bottone dei titoli.

{caption: ".../app/assets/stylesheets/actiontext.scss -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 2}
```
trix-toolbar button.trix-button--icon-heading-1 {
  display: none;
}
```

nascondiamo la sola immagine nel bottone di inserimento attachment. (ovviamente devo commentare il "display: none;" nel gruppo di gestione dei files.

{caption: ".../app/assets/stylesheets/actiontext.scss -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 2}
```
trix-toolbar .trix-button-group button.trix-button--icon-attach::before {
 background-image: none;
}
```




## ALTRE IDEE DA SVILUPPARE


Custom styling
We can modify app/assets/stylesheets/actiontext.scss, to change styling of Trix editor and the content.

To modify how the attachments are rendered we can update app/views/active_storage/blobs/_blob.html.erb. For example you can add a download link to each rendered attachment. The code would look something like below:

```
<%# app/views/active_storage/blobs/_blob.html.erb %>
<%
  figure_class = [
      "attachment",
      "attachment--#{blob.representable? ? 'preview' : 'file'}",
      "attachment--#{blob.filename.extension}",
  ].join(" ")
  resize_limit = local_assigns[:in_gallery] ? [ 800, 600 ] : [ 1024, 768 ]
  blob_representation = blob.representation(resize_to_limit: resize_limit )
%>
<figure class=<%=figure_class%>>
  <% if blob.representable? %>
    <%= image_tag blob_representation %>
  <% end %>

  <figcaption class="attachment__caption">
    <% if caption = blob.try(:caption) %>
      <%= caption %>
    <% else %>
      <span class="attachment__name"><%= blob.filename %></span>
    <% end %>
    |
    <%
      # This is the line we added.
      # Everthing else is was already present when the file was created during action text setup
    %>
    <%= link_to "Download", rails_blob_path(blob, disposition: "attachment") %>
  </figcaption>
</figure>
```
