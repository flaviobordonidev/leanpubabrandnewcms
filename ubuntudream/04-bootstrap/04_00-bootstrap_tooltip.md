# <a name="top"></a> Cap 3.3 - Bootstrap verifichiamo il componente tooltips

Continua la verifica dei i principali componenti di BootStrap.
Verifichiamo il componente `tooltips`.
- La parte css si verifica dall'estetica
- La parte js si verifica andando sopra con il mouse -> deve apparire un "baloon" con una scritta.



## Risorse interne

- []()



## Risorse esterne

- [sito bootstrap: tooltips](https://getbootstrap.com/docs/5.3/components/tooltips/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.

Di seguito, a titolo nostalgico/scaramantico, la pagina da cui ho preso il codice che ha funzionato per la prima volta, anche se poi l'ho commentato perché in realtà funziona anche quello di bootstrap. è stata una coincidenza perché ero finalmente riuscito ad installare bootrap correttamente.

- [Enable Bootstrap Tooltips in Rails 7](https://stackoverflow.com/questions/76640876/enable-bootstrap-tooltips-in-rails-7)



## Tooltips

Iniziamo dal componente navbar che installa una barra di navigazione.

- [sito bootstrap: tooltips](https://getbootstrap.com/docs/5.3/components/tooltips/)

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

