# Bootstrap 




#### 01 {#code-login_authentication-login_devise_views-01}

{title=".../app/views/homepage/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<div id="front_mode" class="container-fluid front_mode">

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%#= render 'breadcrumbs' %>
      <p>breadcrumbs</p>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%#= render 'button_global_settings' %>
      <ol class="breadcrumb top-pad pull-right right-pad">
        <li>
          <%#= link_to "Sign Out", destroy_user_session_path, method: :delete %>
          <%= link_to destroy_user_session_path, method: :delete do %>
             <em class="glyphiconmy ico_logout"></em>
          <% end %>
        </li>
      </ol>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <%#= render 'main_media_object' %>
      <p>main_media_object</p>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%#= render 'related_form_search' %>
      <p>related_form_search</p>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%#= render 'related_button_new' %>
      <p>related_button_new</p>
    </div> <!-- /col -->
  </div> <!-- /row -->


  <div class="row">
    <div class="col-xs-12">
      <%#= render 'related_list_group' %>
      <p>related_list_group</p>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <div class="text-center">
        <%#= render 'related_pagination' %>
        <p>related_pagination</p>
      </div>
    </div> <!-- /col -->
  </div> <!-- /row -->

</div> <!-- /front_mode -->
~~~~~~~~




#### 02 {#code-login_authentication-login_devise_views-02}

{title="/config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
Rails.application.routes.draw do

  root 'homepage#show'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users

  get 'homepage/show'
  get 'testpages/page_a'
  get 'testpages/page_b'
  get 'mockup_tests/bootstrap_grid'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
~~~~~~~~




#### 03 {#code-login_authentication-login_devise_views-03}

{title=".../app/views/homepage/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=25}
~~~~~~~~
<div id="front_mode" class="container-fluid front_mode">

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%#= render 'breadcrumbs' %>
      <p>breadcrumbs</p>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%#= render 'button_global_settings' %>
      <ol class="breadcrumb top-pad pull-right right-pad">
        <li>
          <%#= link_to "Sign Out", destroy_user_session_path, method: :delete %>
          <%= link_to destroy_user_session_path, method: :delete do %>
             <em class="glyphiconmy ico_logout"></em>
          <% end %>
        </li>
      </ol>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <%#= render 'main_media_object' %>
      <p>main_media_object</p>
      <p> utente attivo: <%= current_user.email if current_user.present? == true %> </p>
      <p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %> </p>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%#= render 'related_form_search' %>
      <p>related_form_search</p>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%#= render 'related_button_new' %>
      <p>related_button_new</p>
    </div> <!-- /col -->
  </div> <!-- /row -->


  <div class="row">
    <div class="col-xs-12">
      <%#= render 'related_list_group' %>
      <p>related_list_group</p>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <div class="text-center">
        <%#= render 'related_pagination' %>
        <p>related_pagination</p>
      </div>
    </div> <!-- /col -->
  </div> <!-- /row -->

</div> <!-- /front_mode -->
~~~~~~~~




# login_authentication login_devise_i18n


#### 02 {#code-login_authentication-login_devise_i18n-02}

{title=".../app/views/homepage/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<div id="front_mode" class="container-fluid front_mode">

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%= render 'mockup_homepage/index/breadcrumbs' %>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%= render 'homepage/button_global_settings' %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <%= current_user.email if current_user.present? == true %>
      <%= render 'mockup_homepage/index/main_media_object' %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-10 col-sm-11 col-lg-11">
      <%= render 'mockup_homepage/index/related_form_search' %>
    </div> <!-- /col -->
    <div class="col-xs-2 col-sm-1 col-lg-1">
      <%= render 'mockup_homepage/index/button_new' %>
    </div> <!-- /col -->
  </div> <!-- /row -->


  <div class="row">
    <div class="col-xs-12">
      <%= render 'mockup_homepage/index/related_list_group' %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <div class="text-center">
        <%= render 'mockup_homepage/index/related_pagination' %>
      </div>
    </div> <!-- /col -->
  </div> <!-- /row -->

</div> <!-- /front_mode -->
~~~~~~~~




---



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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
