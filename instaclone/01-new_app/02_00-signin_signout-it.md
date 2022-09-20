# <a name="top"></a> Cap 1.2 - Login Logout

Tratto da mix_and_go. Un clone di instagram



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Adding sign in / sign out links](https://school.mixandgo.com/targets/263)



## Devise -> current_user

Devise ci mette a disposizione il seguente helper che ritorna lo status dell'utente attivo (current_user)

***code 01 - .../app/views/site/index.html.erb - line:1***

```html+erb
<% if user_signed_in? %>
  SIGNED IN
<% else %>
  SIGNED OUT
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/02_01-views-site-index.html.erb)



## Inseriamo links

Inseriamo il link per il log-out. Innanzitutto verifichiamo il path.

```bash
$ rails routes | grep sign_out
```

Esempio:

```bash
ubuntu@ubuntufla:~/instaclone $rails routes | grep sign_out
                    destroy_user_session DELETE /users/sign_out(.:format)
```

Con queste informazioni prepariamo il nostro link


***code 02 - .../app/views/site/index.html.erb - line:1***

```html+erb
<% if user_signed_in? %>
  <%= link_to "Sign out", destroy_user_session_path, data: { turbo_method: :delete }>
<% else %>
  SIGNED OUT
<% end %>
```

Adesso vediamo il path per il login.

```bash
$ rails routes | grep sign_in
```

Esempio:

```bash
ubuntu@ubuntufla:~/instaclone $rails routes | grep sign_in
    new_user_session GET    /users/sign_in(.:format)     devise/sessions#new
       user_session POST   /users/sign_in(.:format)      devise/sessions#create
ubuntu@ubuntufla:~/instaclone $
```

Con queste informazioni prepariamo il nostro link

***code 02 - ...continua - line:1***

```html+erb
  <%= link_to "Sign in", new_user_session_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/02_02-views-site-index.html.erb)

> in questo caso non serve `turbo_method` perché usiamo il metodo di default di `link_to` che è `GET`.



## Diamo un po' di stile

Spostiamo i links di login/logout in un "navigation menu" su layout.

***code 03 - .../app/views/layout/application.html.erb - line:15***

```html+erb
    <div class="nav">
      <% if user_signed_in? %>
        <%= link_to "Sign out", destroy_user_session_path, data: { turbo_method: :delete } %>
      <% else %>
        <%= link_to "Sign in", new_user_session_path %>
      <% end %>
    </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/02_03-views-layout-application.html.erb)

E creiamo un po' di css.

***code 03 - .../app/assets/stylesheets/application.css - line:17***

```css
body {
  width: 960px;
  margin: 10px auto;
}

.nav {
  text-align: right;
}
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/02_04-assets-stylesheets-application.css)

