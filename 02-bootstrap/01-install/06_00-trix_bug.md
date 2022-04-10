# Bug on Rails action text rich text area after installing bootstrap

## Risorse esterne

- https://github.com/rails/rails/issues/43441


## Solved

Il problema

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/21-bootstrap/06_fig01-trix_bug.png)


Adding in app/views/layouts/application.html.erb this line:

<%= stylesheet_link_tag "actiontext", "data-turbo-track": "reload" %>
