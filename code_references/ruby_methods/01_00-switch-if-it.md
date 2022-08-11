# Switch if...else



## Ruby if...else Statement

Syntax

```ruby
  if conditional [then]
     code...
  [elsif conditional [then]
     code...]...
  [else
     code...]
  end
```

Esempio su view:

```html+erb
  <% if current_user.role_admin? %>
    <%= current_user.name %> è un amministratore.
  <% else %>
    <%= current_user.name %> è un utente normale.
  <% end %>
```


## Ruby unless...else Statement

‘unless … else’ is a terrible Ruby construct. Meglio non usarlo.
