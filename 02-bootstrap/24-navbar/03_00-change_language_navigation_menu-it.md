{id: 01-base-24-dashboard_navbar-03-change_language_navigation_menu}
# Cap 24.3 -- Implementiamo la voce dropbox per il cambio di lingua 




{id: "01-24-03_01", caption: ".../app/views/layouts/_dashboard_navbar.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 16}
```
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Inglese
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Italiano</a>
          <a class="dropdown-item" href="#">Inglese</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Alieno</a>
        </div>
      </li>
```



{id: "01-24-03_02", caption: ".../app/views/layouts/_dashboard_navbar.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 16}
```
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <% case params[:locale] %>
          <% when "en" %>
            Inglese
          <% when "it" %>
            Italiano
          <% else %>
            Italiano <!-- default -->
          <% end %>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <%= link_to params.permit(:locale).merge(locale: 'en'), class: "dropdown-item #{'active' if params[:locale] == 'en'}" do %>
            <span class="glyphiconmy ico_language_us right-pad"></span> Inglese
          <% end %>
          <%= link_to params.permit(:locale).merge(locale: "it"), class: "dropdown-item #{'active' if params[:locale] == 'it'}" do %>
            <span class="glyphiconmy ico_language_it right-pad"></span> Italiano
          <% end %>
        </div>
      </li>
```




## Visualizziamo la nav bar anche in mockups/page_a 

Andiamo sul controller di mockups


{id: "01-24-03_03", caption: ".../app/controllers/mockups_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 4}
```
class MockupsController < ApplicationController
  def page_a
    render layout: 'dashboard'
  end
```

[tutto il codice](#01-24-03_03all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/






salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Add navbar language"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku dn:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge dn
$ git branch -d dn
```




## aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo








Fine.

******************************
DI SEGUITO VECCHIO CODICE:


implementiamo su global_settings la possibilità di cambiare lingua. Al momento sono presenti solo due lingue inglese ed italiano. Aggiungiamo al tab/panel logout anche il tab/panel language e lo impostiamo come tab/panel attivo. 

{title=".../app/views/global_settings/index.html.erb", lang=ruby, line-numbers=on, starting-line-number=1}
```
<div class="container-fluid rear_mode">

  <div class="row">
    <div class="col-xs-9 col-sm-10 col-lg-11">
      <ul class="nav nav-pills bottom-pad top-pad left-pad">
        <li class="<%= 'active' if params[:tab_active].nil? or params[:tab_active] == 'language' %>">
          <%= link_to "#pane_language", "data-toggle" => "tab" do %>
            <%= content_tag :span,"", class: "glyphiconmy ico_language" %>
          <% end %>
          <!-- <a href="#pane_language" data-toggle="tab"><span class="glyphiconmy ico_language"></span></a> -->
        </li>

        <li class="<%= 'active' if params[:tab_active] == 'logout' %>">
          <%= link_to "#pane_logout", "data-toggle" => "tab" do %>
            <%= content_tag :span,"", class: "glyphiconmy ico_logout" %>
          <% end %>
          <!-- <a href="#pane_logout" data-toggle="tab"><span class="glyphiconmy ico_logout"></span></a> -->
        </li>
      </ul>
    </div>
    <div class="col-xs-3 col-sm-2 col-lg-1">
      <%= render "button_close" %>
    </div> <!-- /col -->
  </div> <!-- /row -->

  <div class="row">
    <div class="col-xs-12">
      <div class="tab-content">
        <div id="pane_language" class="tab-pane <%= 'active' if params[:tab_active] == nil or params[:tab_active] == 'language'  %>">
          <div class="text-center bottom-pad">
            <h4>Language</h4>
          </div>
          <%= render 'pane_language' %>
        </div>
        
        <div id="pane_logout" class="tab-pane <%= 'active' if params[:tab_active] == 'logout'  %>">
          <div class="text-center bottom-pad">
            <h4>Logout</h4>
          </div>
          <%= render 'pane_logout' %>
        </div>
      </div><!-- /.tab-content -->
    </div> <!-- /col -->
  </div> <!-- /row -->

</div> <!-- /rear_mode -->
```


{title=".../app/views/global_settings/_pane_language.html.erb", lang=ruby, line-numbers=on, starting-line-number=3}
```
<div class="list-group left-pad right-pad bottom-pad">
  <%= link_to params.permit(:locale).merge(locale: 'en'), class: "list-group-item #{'active' if params[:locale] == 'en'}" do %>
    <span class="glyphiconmy ico_language_us right-pad"></span> Inglese
  <% end %>
  <%= link_to params.permit(:locale).merge(locale: "it"), class: "list-group-item #{'active' if params[:locale] == 'it'}" do %>
    <span class="glyphiconmy ico_language_it right-pad"></span> Italiano
  <% end %>
</div>

<div class="list-group left-pad right-pad bottom-pad">
  <%= link_to homepage_show_path, class: "btn btn-primary btn-block" do %>
   ok
  <% end %>
</div>
```






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
