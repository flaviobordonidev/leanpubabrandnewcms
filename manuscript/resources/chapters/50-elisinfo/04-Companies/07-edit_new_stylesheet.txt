ATTENZIONE SPOSTIAMO QUESTO CAPITOLO NELLA SEZIONE "07-style"

***
Per il pop-up inizialmente mettiamo i valori in basso.
Poi creiamo un pop-up usando HTML semplice o BootStrap
***

{id: 50-elisinfo-04-Companies-07-companies_edit_new_stylesheet}
# Cap 4.7 -- Rendiamo la view con stile

Inseriamo al partial _form di companies lo stylesheet che abbiamo utilizzato nei mockups.



## Sovrapponiamo una parte del mockup

Prendiamo la parte che visualizza il form in mockups/s1p3_company_new.html.erb e la mettiamo nel nostro _form.

{id: "01-03-01_08", caption: ".../views/companies/_form.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
    <!-- start form style 01 section -->
    <section class="wow fadeIn padding-one-all" id="start-your-project2">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-12 col-lg-7 text-center margin-100px-bottom sm-margin-40px-bottom">
            <div class="position-relative overflow-hidden w-100">
              <!--<span class="text-small text-outside-line-full alt-font font-weight-600 text-uppercase">Contact Form Style 01</span>-->
            </div>
          </div>
        </div>
        <form id="project-contact-form2" action="project-contact.php" method="post">
```

[tutto il codice](#01-03-01_01all)




## Aggiorniamo la parte dinamica di _form

Iniziamo ad implementare le parti di codice che riguardano lo stile.

{id: "01-03-01_08", caption: ".../views/companies/_form.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 1}
```
    <!-- start form style 01 section -->
    <section class="wow fadeIn padding-one-all" id="start-your-project2">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-12 col-lg-7 text-center margin-100px-bottom sm-margin-40px-bottom">
            <div class="position-relative overflow-hidden w-100">
              <!--<span class="text-small text-outside-line-full alt-font font-weight-600 text-uppercase">Contact Form Style 01</span>-->
            </div>
          </div>
        </div>
        <form id="project-contact-form2" action="project-contact.php" method="post">
        
        ...

        </form>
      </div>
    </section>
    <!-- end form style 01 section -->
```


{caption: ".../views/companies/_form.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!-- start form style 01 section -->
<section class="wow fadeIn padding-one-all" id="start-your-project2">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-lg-7 text-center margin-100px-bottom sm-margin-40px-bottom">
        <div class="position-relative overflow-hidden w-100">
          <!--<span class="text-small text-outside-line-full alt-font font-weight-600 text-uppercase">Contact Form Style 01</span>-->
        </div>
      </div>
    </div>
    <!--<form id="project-contact-form2" action="project-contact.php" method="post">-->
    <%= form_with(model: company, local: true) do |form| %>
        
        ...

    <% end %>
    <!--</form>-->
  </div>
</section>
<!-- end form style 01 section -->
```

[tutto il codice](#01-03-01_01all)



NOTA: per passare lo stile "CLASS="my_style"" nel caso di "form.select()" si procede in questo modo:

* https://stackoverflow.com/questions/4081907/ruby-on-rails-form-for-select-field-with-class

<%= f.select(:object_field, ['Item 1', ...], {}, { class: 'my_style_class' }) %>

select helper takes two options hashes, one for select, and the second for html options. So all you need is to give default empty options as first param after list of items and then add your class to html_options.

http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-select


NOTA: per passare lo stile "CLASS="my_style"" nel caso di "form.submit" si procede in questo modo:

* https://stackoverflow.com/questions/5315967/add-a-css-class-to-f-submit

Dando il nome al pulsante:

```
<%= f.submit 'name of button here', :class => 'submit_class_name_here' %>
```

Oppure lasciando il nome di default:

```
<%= f.submit class: 'btn btn-default' %>
```

Da notare che in questo secondo casi NON si mette la virgola ",".

