# <a name="top"></a> Cap 04.17 - Mettiamo le icone sul pulsante *Dark/Ligth Mode*

Mettiamo le icone sul pulsante *Dark/Ligth Mode* nella barra del menu



## Risorse interne

- []()



## Le icone sullo stylesheet

L'icona è chiamata come `content: "\f185";` ma noi la sostituiamo con un blocco di codice preso da "Bootstrap Icon".

> Questo perché è la cosa più semplice visto che non sono capace di far funzionare l'altra chiamata su Rails. :(

***Codice 01 - .../app/stylesheets/edu/scss/components/_dark-mode-switch.scss - linea:34***

```html+erb
      &:before {
        //content: "\f185";
        content: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='white' class='bi bi-brightness-low-fill' viewBox='0 -3 16 16'><path d='M12 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zM8.5 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 11a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm5-5a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm-11 0a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9.743-4.036a.5.5 0 1 1-.707-.707.5.5 0 0 1 .707.707zm-7.779 7.779a.5.5 0 1 1-.707-.707.5.5 0 0 1 .707.707zm7.072 0a.5.5 0 1 1 .707-.707.5.5 0 0 1-.707.707zM3.757 4.464a.5.5 0 1 1 .707-.707.5.5 0 0 1-.707.707z'/></svg>");

```

***Codice 01 - ...continua - linea:53***

```html+erb
    &:before {
      // content: "\f186";
      content: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='white' class='bi bi-moon-fill' viewBox='-5 -7 24 24'><path d='M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z'/></svg>");
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/03-javascript/01_01-views-mockups-edu_index.html.erb)



## Facciamo precompile

Siccome siamo intervenuti sul codice stylesheets potrebbe essere necessario precompilare per vedere i risultati.

Facciamo un precompile.

```bash
$ rails assets:precompile
```

e facciamo ripartire il web service

```bash
$ rails s -b 192.168.64.3
```
