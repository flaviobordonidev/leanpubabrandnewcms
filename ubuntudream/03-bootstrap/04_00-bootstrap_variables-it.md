# <a name="top"></a> Cap 3.4 - Le variabili di BootStrap

Per cambiare le impostazioni delle variabili di BootStrap è importante definirle **prima** di importare la libreria di BootStrap



## Risorse interne

- []()



## Risorse esterne

- [Bootstrap 5 in Rails 7 - importmaps & sprockets](https://blog.eq8.eu/til/how-to-use-bootstrap-5-in-rails-7.html)
- [list of all variables](https://github.com/twbs/bootstrap-rubygem/blob/master/assets/stylesheets/bootstrap/_variables.scss)
- [advanced way how to change variables](https://github.com/twbs/bootstrap-rubygem/issues/210)



## Cambiamo qualche variabile di BootStrap

If you want to change some variables:

***code 01 - .../app/assets/stylesheets/application.scss - line:01***

```scss
$primary: #c11;
@import "bootstrap";
```
