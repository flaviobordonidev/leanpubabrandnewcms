# <a name="top"></a> Cap *fonts_icons*.3 - I programmi per rendere le icone un set di fonts

Esempio di Font Awesome icon: `<i class="fas fa-shopping-cart text-danger"></i>`



## Risorse interne

- [15-theme-edu/02-mockups-first-page/04_00-theme_icons]()



## Risorse esterne

- [Using Font Awesome 6 in a Rails 7 project that uses importmaps](https://pablofernandez.tech/2022/03/12/using-font-awesome-6-in-a-rails-7-project-that-uses-importmaps/)
- [Can Font Awesome be used with importmaps in Rails 7?](https://stackoverflow.com/questions/71430573/can-font-awesome-be-used-with-importmaps-in-rails-7)



## Installiamo ed implementiamo fontawesome

Per installare ed attivare fontawesome è sufficiente modificare solo 2 files:

- .../config/importmap.rb
- .../app/javascript/application.js

Il primo file lo riempiamo in automatico con il seguente comando da terminale.

```bash
$ ./bin/importmap pin @fortawesome/fontawesome-free \
                    @fortawesome/fontawesome-svg-core \
                    @fortawesome/free-brands-svg-icons \
                    @fortawesome/free-regular-svg-icons \
                    @fortawesome/free-solid-svg-icons
```

Esempio

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$./bin/importmap pin @fortawesome/fontawesome-free \
>                     @fortawesome/fontawesome-svg-core \
>                     @fortawesome/free-brands-svg-icons \
>                     @fortawesome/free-regular-svg-icons \
>                     @fortawesome/free-solid-svg-icons
Pinning "@fortawesome/fontawesome-free" to https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/fontawesome.js
Pinning "@fortawesome/fontawesome-svg-core" to https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.1.1/index.es.js
Pinning "@fortawesome/free-brands-svg-icons" to https://ga.jspm.io/npm:@fortawesome/free-brands-svg-icons@6.1.1/index.es.js
Pinning "@fortawesome/free-regular-svg-icons" to https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.1.1/index.es.js
Pinning "@fortawesome/free-solid-svg-icons" to https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.1.1/index.es.js
ubuntu@ubuntufla:~/bl7_0 (bs)$
```

Questo inserisce le seguenti linee di codice su *importmap.rb*.

***codice 01 - .../config/importmap.rb - line:8***

```ruby
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/fontawesome.js"
pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.1.1/index.es.js"
pin "@fortawesome/free-brands-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-brands-svg-icons@6.1.1/index.es.js"
pin "@fortawesome/free-regular-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.1.1/index.es.js"
pin "@fortawesome/free-solid-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.1.1/index.es.js"
```

Poi le importiamo da *application.js* per renderle disponibili alla nostra applicazione.

***codice 01 - .../app/javascript/application.js - line:8***

```javascript
import {far} from "@fortawesome/free-regular-svg-icons"
import {fas} from "@fortawesome/free-solid-svg-icons"
import {fab} from "@fortawesome/free-brands-svg-icons"
import {library} from "@fortawesome/fontawesome-svg-core"
import "@fortawesome/fontawesome-free"
library.add(far, fas, fab)
```

Precompiliamo il tutto ed attiviamo il preview.

```bash
$ rails assets:precompile
$ rails s -b 192.168.64.3
```

Esempio

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$rails assets:precompile
I, [2022-04-25T17:54:32.583780 #62954]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-fd160c89b391e8d4d5b3fc55211e23d654138ef31496a267185c1be97adcdd8e.js
I, [2022-04-25T17:54:32.584907 #62954]  INFO -- : Writing /home/ubuntu/bl7_0/public/assets/application-fd160c89b391e8d4d5b3fc55211e23d654138ef31496a267185c1be97adcdd8e.js.gz
ubuntu@ubuntufla:~/bl7_0 (bs)$rails s -b 192.168.64.3
```

Le icone sono finalmente visualizzate ^_^.
