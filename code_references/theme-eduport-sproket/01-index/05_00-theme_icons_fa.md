# <a name="top"></a> Cap 4.5 - Attiviamo le icone del tema

Il tema Eduport usa Font Awesome icons. 

<i class="fas fa-shopping-cart text-danger"></i>


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



## La libreria Bootstrap Icons

Non c'è solo fontawesome ma ci sono anche le icone di bootstrap.

Bootstrap ci offre due possibilità di inserimento delle icone.
Le possiamo inserire con il codice SVG oppure con il riferimento letterale come in questo esempio 

```html
<i class="bi bi-ui-radios-grid me-2"></i>
```

ad esempio da:

```html
						<a class="nav-link bg-primary bg-opacity-10 rounded-3 text-primary px-3 py-3 py-xl-0" href="#" id="categoryMenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="bi bi-ui-radios-grid me-2"></i>
						<span>Category</span></a>
```

a:

```html
						<a class="nav-link bg-primary bg-opacity-10 rounded-3 text-primary px-3 py-3 py-xl-0" href="#" id="categoryMenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ui-radios-grid" viewBox="0 0 16 16">
							<path d="M3.5 15a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm9-9a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5zm0 9a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zM16 3.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0zm-9 9a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0zm5.5 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zm-9-11a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm0 2a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
						</svg>
						<span>Category</span></a>
```



## Installiamo ed implementiamo Bootstrap Icons

Install bootstrap-icons.

```bash
npm i bootstrap-icons
```

Add this line to app/assets/stylesheets/application.bootstrap.scss.


***codice 01 - .../app/assets/stylesheets/application.scss - line:8***

```scss
//@import "bootstrap-icons/font/bootstrap-icons";
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css");
```

> per usare la riga commentata possiamo scaricare il file dall'url della seconda riga...


Edit config/initializers/assets.rb.

***codice 02 - .../config/initializers/assets.rb - line:8***

```ruby
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
```

Start up server with bin/dev command. That's all!




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



## Le frecce in basso nei megamenu

Qualche icona nel thema eduport è ancora rimasta fuori. Ad esempio le freccette nel megamenu sono impostate in un modo differente e per quelle dobbiamo lavorare in maniera differente.

LASCIAMO QUESTA PARTE APERTA per concentrarci sul resto dell'applicazione.