# <a name="top"></a> Cap 3.4 - Bootstrap verifichiamo il componente popovers

Continua la verifica dei i principali componenti di BootStrap.
Verifichiamo il componente `popovers`.
- La parte css si verifica dall'estetica
- La parte js si verifica cliccando con il mouse -> si deve apprire un "baloon" con una scritta.



## Risorse interne

- []()



## Risorse esterne

- [sito bootstrap: popovers](https://getbootstrap.com/docs/5.3/components/popovers/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.

Di seguito, a titolo nostalgico/scaramantico, la pagina da cui ho preso il codice che ha funzionato per la prima volta, anche se poi l'ho commentato perché in realtà funziona anche quello di bootstrap. è stata una coincidenza perché ero finalmente riuscito ad installare bootrap correttamente.

- [How to init Bootstrap Popover in Webpack Rails project](https://stackoverflow.com/questions/69893532/how-to-init-bootstrap-popover-in-webpack-rails-project)



## Popovers

Iniziamo dal componente navbar che installa una barra di navigazione.

- [sito bootstrap: popovers](https://getbootstrap.com/docs/5.3/components/popovers/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.

Copiamo ed incolliamo il codice di esempio.

[Codice 01 - .../app/views/mockups/test_a.html.erb - linea: 1]()

```html+erb

```



## Attiviamo la parte js

Per funzionare dobbiamo aggiungere del codice javascript



## Vediamo in preview

in preview funziona.

```bash
$ ./bin/dev
```

> In questo caso funziona anche con `$ rails s -b 192.168.64.4` ma con propshaft è meglio usare `./bin/dev`

Il fatto che si apra il menu a cascata, ed anche il menu "hamburger" quando riduci il browser, significa che la parte javascript di BootStrap sta funzionando.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

