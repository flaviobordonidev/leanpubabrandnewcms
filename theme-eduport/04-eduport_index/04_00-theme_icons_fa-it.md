# <a name="top"></a> Cap 2.2 - Attiviamo le icone FontAwesome (fa)

Il tema Eduport usa Font Awesome icons. 

<i class="fas fa-shopping-cart text-danger"></i>

- fas = font awesome solid
- far = font awesome regular
- ...



## Risorse esterne

- [Ruby on Rails #76 Fontawesome with Importmaps in Rails 7](https://www.youtube.com/watch?v=c-EbQDB0RsQ)
- [Fontawesome + Importmaps + Rails 7](https://blog.corsego.com/fontawesome-importmaps-rails7)

- [Using Font Awesome 6 in a Rails 7 project that uses importmaps](https://pablofernandez.tech/2022/03/12/using-font-awesome-6-in-a-rails-7-project-that-uses-importmaps/)
- [Can Font Awesome be used with importmaps in Rails 7?](https://stackoverflow.com/questions/71430573/can-font-awesome-be-used-with-importmaps-in-rails-7)



## Installazione con importmap

Per installare ed attivare fontawesome aggiorniamo i seguenti files:

- `.../config/importmap.rb`
- `.../app/javascript/application.js`

Il primo file lo riempiamo in automatico con il seguente comando da terminale.

```bash
$ ./bin/importmap pin @fortawesome/fontawesome-free \
                    @fortawesome/fontawesome-svg-core \
                    @fortawesome/free-brands-svg-icons \
                    @fortawesome/free-regular-svg-icons \
                    @fortawesome/free-solid-svg-icons --download
```

Esempio

```bash
ubuntu@ubuntufla:~/ubuntudream (nb)$./bin/importmap pin @fortawesome/fontawesome-free \
>                     @fortawesome/fontawesome-svg-core \
>                     @fortawesome/free-brands-svg-icons \
>                     @fortawesome/free-regular-svg-icons \
>                     @fortawesome/free-solid-svg-icons --download
Pinning "@fortawesome/fontawesome-free" to vendor/javascript/@fortawesome/fontawesome-free.js via download from https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.2.0/js/fontawesome.js
Pinning "@fortawesome/fontawesome-svg-core" to vendor/javascript/@fortawesome/fontawesome-svg-core.js via download from https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.2.0/index.mjs
Pinning "@fortawesome/free-brands-svg-icons" to vendor/javascript/@fortawesome/free-brands-svg-icons.js via download from https://ga.jspm.io/npm:@fortawesome/free-brands-svg-icons@6.2.0/index.mjs
Pinning "@fortawesome/free-regular-svg-icons" to vendor/javascript/@fortawesome/free-regular-svg-icons.js via download from https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.2.0/index.mjs
Pinning "@fortawesome/free-solid-svg-icons" to vendor/javascript/@fortawesome/free-solid-svg-icons.js via download from https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.2.0/index.mjs
ubuntu@ubuntufla:~/ubuntudream (nb)$
```


Per poter usare le librerie importate nella nostra app dobbiamo importarle in *application.js*.

***codice 02 - .../app/javascript/application.js - line:08***

```javascript
import {far} from "@fortawesome/free-regular-svg-icons"
import {fas} from "@fortawesome/free-solid-svg-icons"
import {fab} from "@fortawesome/free-brands-svg-icons"
import {library} from "@fortawesome/fontawesome-svg-core"
import "@fortawesome/fontawesome-free"
library.add(far, fas, fab)
```



## Verifichiamo in preview

Precompiliamo il tutto ed attiviamo il preview.

```bash
$ rails assets:precompile
$ rails s -b 192.168.64.3
```

> la precompilazione è opzionale.

Esempio

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$rails assets:precompile
I, [2022-04-25T17:54:32.583780 #62954]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-fd160c89b391e8d4d5b3fc55211e23d654138ef31496a267185c1be97adcdd8e.js
I, [2022-04-25T17:54:32.584907 #62954]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-fd160c89b391e8d4d5b3fc55211e23d654138ef31496a267185c1be97adcdd8e.js.gz
ubuntu@ubuntufla:~/bl7_0 (bs)$rails s -b 192.168.64.3
```

Le icone sono finalmente visualizzate ^_^.



## Alternativa - importmap tramite CDN

Il file di importmap lo avremmo potuto aggiornare con delle chiamate CDN omettendo l'opzione `--download`.

```bash
$ ./bin/importmap pin @fortawesome/fontawesome-free \
                    @fortawesome/fontawesome-svg-core \
                    @fortawesome/free-brands-svg-icons \
                    @fortawesome/free-regular-svg-icons \
                    @fortawesome/free-solid-svg-icons
```

Esempio

```bash
ubuntu@ubuntufla:~/ubuntudream (main)$./bin/importmap pin @fortawesome/fontawesome-free \
>                     @fortawesome/fontawesome-svg-core \
>                     @fortawesome/free-brands-svg-icons \
>                     @fortawesome/free-regular-svg-icons \
>                     @fortawesome/free-solid-svg-icons
Pinning "@fortawesome/fontawesome-free" to https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.2.0/js/fontawesome.js
Pinning "@fortawesome/fontawesome-svg-core" to https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.2.0/index.mjs
Pinning "@fortawesome/free-brands-svg-icons" to https://ga.jspm.io/npm:@fortawesome/free-brands-svg-icons@6.2.0/index.mjs
Pinning "@fortawesome/free-regular-svg-icons" to https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.2.0/index.mjs
Pinning "@fortawesome/free-solid-svg-icons" to https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.2.0/index.mjs
ubuntu@ubuntufla:~/ubuntudream (main)$
```

Questo inserirebbe le seguenti linee di codice su *importmap.rb*.
E questo mette a disposizione le librerie nella nostra app attraverso CDN (ossia repositories esterni).

***codice n/a - .../config/importmap.rb - line:10***

```ruby
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.2.0/js/fontawesome.js"
pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.2.0/index.mjs"
pin "@fortawesome/free-brands-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-brands-svg-icons@6.2.0/index.mjs"
pin "@fortawesome/free-regular-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.2.0/index.mjs"
pin "@fortawesome/free-solid-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.2.0/index.mjs"
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index style"
```


## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ep
$ git branch -d ep
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



## Andiamo in produzione con render.com

Eseguiamo il deploy manuale scegliendo "da ultimo commit".



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-index-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_00-theme_images-it.md)
