ATTENZIONE SPOSTIAMO QUESTO CAPITOLO NELLA SEZIONE "07-style"


# Aggiungiamo il menu di navigazione

Aggiungiamo il menu di navigazione e puliamo il codice raggruppandolo in partials.
Attenzione! Facciamo pochi partials altrimenti invece di aiutarci ci ostacolano.

Nel codice di questo capitolo abbiamo anche apportato delle piccole modifiche al codice riscrivendo alcuni nomi, dandolgli maggior significato ed eliminando del vecchio codice commentato che comunque possiamo rivedere nei capitoli precedenti.




## Apriamo il branch "Companies Index Navigation Menu"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b cinm
```




## Aggiungiamo il menu di navigazione

aggiungiamo il menu anche se questo codice sarà rivisto perché il mockup non è pulito e ci sono molte voci inutili.


{id: "50-04-12_01", caption: ".../views/companies/index.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "#{t '.html_head_title'}") %>
<%# provide(:menu_nav_link_home, "active") %>

<%# == Meta_data - end ====================================================== %>

<%= render 'layouts/navbar' %>

<!-- start form header section -->
<section class="wow fadeIn padding-one-bottom" id="start-your-project">
  <div class="container">
```

[tutto il codice](#50-04-12_01all)


{id: "50-04-12_02", caption: ".../views/layouts/_navbar.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!-- start header -->
<header>
  <!-- start navigation -->
  <nav class="navbar navbar-default bootsnav background-white header-light navbar-top navbar-expand-lg">
    <div class="container nav-header-container">
      <!-- start logo -->
```

[tutto il codice](#50-04-12_02all)




## Facciamo il partial per il pop-up selections

Il pop-up selections è quello che ci presenta le possibili selezioni quali "aziende", "persone", "componenti", "prodotti", "pratiche", ...

{id: "50-04-12_03", caption: ".../views/companies/_popup_selections_master.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!-- start modal pop-up selections-master -->
<div id="modal-popup-selections-master" class="zoom-anim-dialog mfp-hide col-xl-3 col-lg-6 col-md-7 col-11 mx-auto bg-white text-center modal-popup-main padding-50px-all">
  <%= link_to people_path, class: "btn btn-medium btn-rounded btn-transparent-dark-gray margin-10px-bottom", 'data-wow-delay': "0.6s" do %>
    <%= image_tag "elis/icons/person.png", alt: "person" %> Persona &nbsp&nbsp&nbsp&nbsp
  <% end %>
</div>
<!-- end modal pop-up -->
```

[tutto il codice](#50-04-12_03all)


{id: "50-04-12_04", caption: ".../views/companies/_popup_selections_nested.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!-- start modal pop-up selections-nested -->
<div id="modal-popup-selections-nested" class="zoom-anim-dialog mfp-hide col-xl-3 col-lg-6 col-md-7 col-11 mx-auto bg-white text-center modal-popup-main padding-50px-all">
  <%= link_to company_person_maps_path(master_page: "companies"), class: "btn btn-medium btn-rounded btn-transparent-dark-gray margin-10px-bottom", 'data-wow-delay': "0.6s" do %>
    <%= image_tag "elis/icons/person.png", alt: "person" %> Persona &nbsp&nbsp&nbsp&nbsp
  <% end %>
</div>
<!-- end modal pop-up selections-nested -->
```

[tutto il codice](#50-04-12_01all)



