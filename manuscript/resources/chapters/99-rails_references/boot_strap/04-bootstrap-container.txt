# Bootstrp containers

Risorse web:

* https://stackoverflow.com/questions/23062439/am-i-only-supposed-to-have-one-bootstrap-3-container
* https://stackoverflow.com/questions/40905223/is-it-legal-to-use-several-containers-on-the-same-page-in-bootstrap/40905262


## Devo mettere un solo container per pagina?

No si possono avere container multipli (di tipo "sibling") ma NON annidati (di tipo "parent-child").

Per esempio, if you want to have a full width element (screen width, not container width). This is perfectly fine:

<div class="container">
  <div class="col-md-12">
    <p>Content</p>
  </div>
</div>

<div id="full-width-element">
  <p>Other content, stretching full width of the page</p>
</div>

<div class="container">
  <div class="col-md-12">
    <p>Content</p>
  </div>
</div>

Take a look at the examples on the Bootstrap site: http://getbootstrap.com/getting-started/#examples, they use multiple .containers as well.

--
You can use as many as you want. e.g if you want to have multiple sections on a page with different background image or color, you can use sections and within each section you can use a container.

e.g

<section class="bg-1"><div class="container"></div></section>
<section class="bg-2"><div class="container"></div></section>
<section class="bg-3"><div class="container"></div></section>

In your case, you can use a fluid container and define your own sized columns. This way you will have container and your own layout divs.