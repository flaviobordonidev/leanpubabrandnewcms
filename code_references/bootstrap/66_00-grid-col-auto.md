# Gestione della griglia




## Le basi


* https://www.w3schools.com/bootstrap4/bootstrap_grid_basic.asp


Grid Classes
The Bootstrap 4 grid system has five classes:

.col- (extra small devices - screen width less than 576px)
.col-sm- (small devices - screen width equal to or greater than 576px)
.col-md- (medium devices - screen width equal to or greater than 768px)
.col-lg- (large devices - screen width equal to or greater than 992px)
.col-xl- (xlarge devices - screen width equal to or greater than 1200px)

The classes above can be combined to create more dynamic and flexible layouts.

Tip: Each class **scales up**, so if you wish to set the **same widths for sm and md, you only need to specify sm**.





## Gestiamo le colonne in modo più responsive possibile

Le colonne lavorano in maniera molto responsive se non diamo indicazioni rigide.

* se mettiamo "-auto" lei si mette il più piccolo possibile in funzione del contenuto
* se non mettiamo il numero alla fine lei si prende tutto lo spazio disponibile.

           <!-- <576px	 ≥576px	   ≥768px	  ≥992px	   ≥1200px -->
            <!-- .col-	.col-sm-	.col-md-	.col-lg-	.col-xl --->

Ad esempio con 2 colonne ho trovato un'ottima soluzione con:

<div class="row">
  <div class="col-12 col-sm-auto">
    <a class="btn btn-medium btn-rounded btn-transparent-dark-gray margin-10px-bottom" data-wow-delay="0.6s" href="#"><%= image_tag "elis/icons/company.png", alt: "company" %> Azienda con offerta di ricovero &nbsp&nbsp&nbsp&nbsp</a>
  </div>
  <div class="col-12 col-sm">
    <input type="text" name="first_name" id="first_name" placeholder="Cerca azienda..." class="medium-input">
  </div>
</div>

In questo caso quando siamo extra small (<576px) vanno a capo e si mettono su due righe.
In tutti gli altri casi a partire da small (≥576px) la prima colonna è il più stretto possibile e la seconda colonna si allarga a prendere tutto lo spazio disponibile nella riga.




Altro:

* https://stackoverflow.com/questions/46824086/how-do-i-get-auto-width-columns-in-bootstrap-4/46824322#46824322

How do I get auto width in Bootstrap 4 columns?
I need 2 column in a row without fixed width, is it possible?

Answer

Use col class. You can use col-* also eg: col-md

  <div class="row">
    <div class="col">Col1</div>
    <div class="col">Col2</div>
  </div>
    
If you use col class the columns will be of equal width. If you use col-auto the width of the column will be the width of the contents in the column.

You can even use a combination of both, like below. In this case the first column width will be equal to the contents of that column. Second column width take the rest of width.

  <div class="row">
    <div class="col-auto">Col1</div>
    <div class="col">Col2</div>
  </div>

Some examples

When using 2 col classes

enter image description here

<div class="container">
  <div class="row">
    <div class="col">
      col - equal columns
    </div>
    <div class="col">
       col - equal columns
    </div>    
  </div>
</div>

When using col-auto for first column and col for second.

enter image description here

<div class="container">
  <div class="row">
    <div class="col-auto">
      col-auto - hello
    </div>
    <div class="col">
       col - this column takes rest of available space
    </div>    
  </div>
</div>
Play here

Show code snippet




## Esempio con le colonne del telefono

In questo primo esempio le colonne si adattano e si presentano bene sul cellulare (mobile-first) ma non sono molto belle sul monitor del PC.

---
<!-- This works OK on mobile and so-so in PC -->
<div class="nested-fields">
  <div class="form-row">
    <%= form.hidden_field :_destroy %>
    <div class="form-group col-auto">
      <%= form.text_field :name, placeholder: "centralino", class: "medium-input" %>
    </div>
    <div class="form-group col">
      <%= form.text_field :prefix, placeholder: "prefisso", class: "medium-input" %>
    </div>
    <div class="form-group col-auto">
      <%= form.text_field :number, placeholder: "numero telefonico", class: "medium-input" %>
    </div>
    <div class="form-group col">
      <small>
        <%= link_to "X", "#", data: { action: "click->nested-form#remove_association" }, class: "btn btn-transparent-dark-gray btn-medium margin-20px-bottom" %>
      </small>
    </div>
  </div>
</div>
---


In questo primo esempio le colonne si adattano e si presentano bene sul monitor del PC ma non nel cellulare.

---
<!-- This works so-so on mobile and OK in PC -->
<div class="nested-fields">
  <div class="form-row">
    <%= form.hidden_field :_destroy %>
    <div class="form-group col-auto">
      <%= form.text_field :name, placeholder: "centralino", class: "medium-input" %>
    </div>
    <div class="form-group col-auto">
      <%= form.text_field :prefix, placeholder: "prefisso", class: "medium-input" %>
    </div>
    <div class="form-group col">
      <%= form.text_field :number, placeholder: "numero telefonico", class: "medium-input" %>
    </div>
    <div class="form-group col-auto">
      <small>
        <%= link_to "X", "#", data: { action: "click->nested-form#remove_association" }, class: "btn btn-transparent-dark-gray btn-medium margin-20px-bottom" %>
      </small>
    </div>
  </div>
</div>
---


Uniamo i due esempi in modo che:

- da colonna "extra-small" (che è col) fino a colonna "small" (che è col-sm) abbiamo le 4 colonne : "-auto", "none", "-auto", "-auto"
- da colonna "medium" (che è col-md) fino a colonna "xlarge" (che è col-xl) abbiamo le 4 colonne  : "-auto", "-auto", "none", "-auto"

In questo modo ho una buona visualizzazione sia su mobile che su PC

---
<!-- This works OK both on mobile and PC -->
<div class="nested-fields">
  <div class="form-row">
    <%= form.hidden_field :_destroy %>
    <div class="form-group col-auto col-md-auto">
      <%= form.text_field :name, placeholder: "centralino", class: "medium-input" %>
    </div>
    <div class="form-group col col-md-auto">
      <%= form.text_field :prefix, placeholder: "prefisso", class: "medium-input" %>
    </div>
    <div class="form-group col-auto col-md">
      <%= form.text_field :number, placeholder: "numero telefonico", class: "medium-input" %>
    </div>
    <div class="form-group col-auto col-md-auto">
      <small>
        <%= link_to "X", "#", data: { action: "click->nested-form#remove_association" }, class: "btn btn-transparent-dark-gray btn-medium margin-20px-bottom" %>
      </small>
    </div>
  </div>
</div>
---