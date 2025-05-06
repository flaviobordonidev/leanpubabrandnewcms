# <a name="top"></a> Prepariamo la struttura per le pagine CDN Mockups

Creiamo un mockup che prende lo stile, nel nostro caso Tailwind Css, tramite CDN.
Questo non è consigliato per la produzione e più avanti installeremo Tailwind Css direttamente nella nostra app Rails usando importmap, ma per creare dei mockups iniziali è molto utile.

(la struttura che creiamo è talmente generica che possiamo caricare anche Bootstrap tramite CDN o un altro framework)


- creiamo il layout empty
- creiamo il controller cdnmockups_controller con le azioni navbars, buttons, ...
- indichiamo di usare per tutte le azioni il layout empty
- instradiamo nel file routes
- 







## Il `cdnmockups_controller` e le pagine statiche

Creiamo il controller `cdnmockups_controller` e le pagine statiche per fare le prove con Tailwind css.

```shell
❯ rails g controller Cdnmockups tw_base tw_cards tw_navbars
```



