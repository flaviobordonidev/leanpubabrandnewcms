# <a name="top"></a> Cap link_to.4 - Il link con chiamata destroy



## Risorse interne

- []()



## Risorse esterne

- [Adding sign in / sign out links](https://school.mixandgo.com/targets/263)



## Signout o Logout

Abbiamo installato **devise** ed adesso vediamo il path per il signout

```bash
$ rails routes | grep sign_out
```

esempio:

```bash
$ rails routes | grep sign_out
    destroy_user_session DELETE /users/sign_out(.:format) devise/sessions#destroy
```

Quindi il link per il signout è

***code n/a - views/n/a - line:x***

```html+erb
<%= link_to "Sign out", destroy_user_session_path, data: {turbo_method: :delete} %>
```

Questo mi evita di usare il `button_to`



## Login

Adesso vediamo il path per il signin

```bash
$ rails routes | grep sign_in
```

esempio:

```bash
$ rails routes | grep sign_in
    new_user_session GET /users/sign_in(.:format) devise/sessions#new
    user_session POST /users/sign_in(.:format) devise/sessions#create
```

Quindi il link per il signin è

***code n/a - views/n/a - line:x***

```html+erb
    <%= link_to "Sign in", new_user_session_path %>  
```

> Non serve `data: {turbo_method: :get}` perché GET è l'ozione di default.

Vediamoli entrambi

***code n/a - views/n/a - line:x***

```html+erb
  <% if user_signed_in? %>
    <%= link_to "Sign out", destroy_user_session_path, data: {turbo_method: :delete} %>
  <% else %>
    <%= link_to "Sign in", new_user_session_path %>  
  <% end %>
```