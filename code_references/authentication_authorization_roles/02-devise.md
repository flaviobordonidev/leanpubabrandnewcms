# Devise

installiamo e configuriamo devise


## Risorse interne

* 01-base/07-authentication/02-authentication-devise_install
* 01-base/07-authentication/06-manage_users


## Risorse web

- [Sito di devise](https://github.com/plataformatec/devise)
- https://github.com/plataformatec/devise/wiki/Example-Applications
- http://railsapps.github.io/tutorial-rails-devise-rspec-cucumber.html
- http://railsapps.github.io/tutorial-rails-mongoid-devise.html
- Railscasts pro 209-devise-revised
- http://railsapps.github.io/tutorial-rails-mongoid-devise.html

- https://www.mirrorcommunications.com/blog/build-a-blog-with-devise-part-2
  In this tutorial, we will install devise and create the user and post model. We will also set up emails in production with the Heroku Sendgrid addon.

- https://www.mirrorcommunications.com/blog/build-a-blog-with-devise-part-3
  We are likely going to need at least two to three posts just to customize devise. The first thing I want to do is add the FriendlyId gem, so we can create nice looking user and post urls, such as: https://yourdomain/users/your-name.

- https://github.com/plataformatec/devise/wiki/How-Tos1

- https://devcenter.heroku.com/articles/using-the-cli

- [Permetti agli utenti di editare la loro password](https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password)

- https://github.com/plataformatec/devise
- https://github.com/plataformatec/devise/wiki/How-To:-Add-sign_in,-sign_out,-and-sign_up-links-to-your-layout-template
- https://github.com/plataformatec/devise/wiki/How-To:-Change-the-default-sign_in-and-sign_out-routes
- https://github.com/plataformatec/devise#configuring-routes

- [Gestire gli utenti tramite interfaccia CRUD](https://github.com/plataformatec/devise/wiki/How-To:-Manage-users-through-a-CRUD-interface)

- [redirect to a specific page on successful sign_in](https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign_in,-sign_out,-and-or-sign_up)
- [elaborate on the redirect](https://stackoverflow.com/questions/13129254/how-to-direct-user-to-a-specific-page-after-logging-in-with-devise-and-rails)




## Avvisi di passaggio di versione

> Attenzione!
>
> For Rails 5, note that protect_from_forgery is no longer prepended to the before_action chain, so if you have set authenticate_user before protect_from_forgery, your request will result in "Can't verify CSRF token authenticity." To resolve this, either change the order in which you call them, or use protect_from_forgery prepend: true.

> Attenzione!
> Strong Parameters
> The Parameter Sanitizer API has changed for Devise 4



## Visualizziamo i messaggi di errore

Nel file views/layout/application.html.erb e negli altri layouts che utiliziamo in alternativa deve esserci il codice di visualizzazione degli errori.

nell'applicazione usata nel tutorial usiamo il seguente codice:

{id: "01-07-05_01", caption: ".../app/views/layouts/application.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 13}
~~~~~~~~
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>    
~~~~~~~~


Un codice alternativo (da sviluppare meglio) potrebbe essere questo:

{id: "01-07-05_01", caption: ".../app/views/layouts/application.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 13}
~~~~~~~~
<% flash.each do |name,msg| %>
  <div class='alert alert-<%= name == :notice ? 'success' : 'error' %>'>
    <a class='close' data-dismiss='alert'>&#215;</a>
    <%= msg %>
  </div>
<% end %>
~~~~~~~~


---

> codice preso da [01-base/07-authentication/04-devise-login_logout]

oppure già predisposto per formattazione BootStrap ed inserimento icone

{id: "01-07-04_07", caption: ".../app/views/mockups/page_a.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 8}
```
<p>
  <% if current_user.present? %>
    <%= link_to destroy_user_session_path, method: :delete, class: "btn btn-danger" do %>
       <span class="glyphicon ico_logout"></span> Logout
    <% end %>
  <% else %>
    <%= link_to new_user_session_path, class: "btn btn-danger" do %>
       <span class="glyphicon ico_login"></span> Login
    <% end %>
  <% end %>
</p>
```

[tutto il codice](#01-07-04_07all)



## Permettiamo agli utenti di editare la loro password

QUESTO PARAGRAFO NON L'HO IMPLEMENTATO

Questo non so se mi serve... Mi sa che lo posso eliminare....

ApplicationController.rb:
```
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
```