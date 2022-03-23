# <a name="top"></a> Cap 19.3 - Cambiamo lo style di Action Text



## Risorse esterne

- https://blog.saeloun.com/2019/10/01/rails-6-action-text.html
- https://blog.saeloun.com/2019/11/12/attachments-in-action-text-rails-6
- https://stackoverflow.com/questions/51494407/trix-editor-rails-customizing



## Apriamo il branch "Style Action Text"

```bash
$ git checkout -b sat
```




## Personalizziamo lo stile di Action Text


- https://stackoverflow.com/questions/51494407/trix-editor-rails-customizing

nascondiamo tutto il gruppo di gestione dei files che include il pulsante di inserimento attachment.

***codice 01 - .../app/assets/stylesheets/actiontext.scss - line: 2***

```scss
trix-toolbar .trix-button-group--file-tools {
 display: none;
 //background-color: green;
}
```

nascondiamo il bottone dei titoli.

***codice 01 - ...continua - line: 2***

```scss
trix-toolbar button.trix-button--icon-heading-1 {
  display: none;
}
```

nascondiamo la sola immagine nel bottone di inserimento attachment. (ovviamente devo commentare il "display: none;" nel gruppo di gestione dei files.

***codice 01 - ...continua - line: 2***

```scss
trix-toolbar .trix-button-group button.trix-button--icon-attach::before {
 background-image: none;
}
```



## ALTRE IDEE DA SVILUPPARE


Custom styling
We can modify app/assets/stylesheets/actiontext.scss, to change styling of Trix editor and the content.

To modify how the attachments are rendered we can update app/views/active_storage/blobs/_blob.html.erb. For example you can add a download link to each rendered attachment. The code would look something like below:

***codice n/a - .../app/views/active_storage/blobs/_blob.html.erb - line 1***

```html+erb
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



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_00-action_text-install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_00-organizing-our-models-it.md)
