# <a name="top"></a> Cap 1.4 - Bootstrap Icons

Aggiungiamo le icone du Bootstrap 5.



## Risorse esterne

- [Bootstrap sito ufficiale: icons](https://icons.getbootstrap.com/)
- [Bootstrap document: icons](https://getbootstrap.com/docs/5.1/extend/icons/)



## Apriamo il branch

Lo abbiamo lasciato aperto nel capitolo precedente.



## Attiviamo le icone di bootstrap

Non abbiamo bisogno di attivarle.

> In alcuni tutorials attivano le icone in `.../app/assets/stylesheets/application.bootstrap.scss` inserendo le seguenti due righe:<br\>
> per bootstrap: `@import 'bootstrap/scss/bootstrap';` <br/>
> per le icone `@import 'bootstrap-icons/font/bootstrap-icons';`
>
> Inoltre lo stesso bootstrap suggerisce di attivarle con `$ npm i bootstrap-icons`.
>
> Ma tutto questo non è necessario. Si possono usare ugalmente copiando la parte *svg* e nel prossimo paragrafo vediamo come fare.



## Usiamo le icone di bootstrap

Andiamo sul sito https://icons.getbootstrap.com/ e scegliamo un'icona.

Usage
Bootstrap Icons are SVGs, so you can include them into your HTML in a few ways depending on how your project is setup. 

> We recommend using a ***width: 1em*** (and optionally height: 1em) for easy resizing via font-size.


***codice 01 - .../app/views/mockups/bs_icons.html.erb - line:11***

```html+erb
      <svg class="bi bi-activity" width="1rem" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg" >
        <path fill-rule="evenodd" d="M6 2a.5.5 0 0 1 .47.33L10 12.036l1.53-4.208A.5.5 0 0 1 12 7.5h3.5a.5.5 0 0 1 0 1h-3.15l-1.88 5.17a.5.5 0 0 1-.94 0L6 3.964 4.47 8.171A.5.5 0 0 1 4 8.5H.5a.5.5 0 0 1 0-1h3.15l1.88-5.17A.5.5 0 0 1 6 2Z"/>
      </svg>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-install/03_00-bootstrap_javascript-it.md)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-install/03_00-bootstrap_javascript-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/01-bootstrap/05_00-inline_source_maps.md)
