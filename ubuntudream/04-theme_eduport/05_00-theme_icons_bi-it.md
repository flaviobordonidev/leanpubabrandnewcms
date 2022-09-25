# <a name="top"></a> Cap 2.2 - Attiviamo le icone del tema

Il tema Eduport usa Bootstrap Icons. 

Esempio di BootStrap icon: `<i class="bi bi-ui-radios-grid me-2"></i>`



## Risorse interne

- [References: fonts icons](99-code_references/fonts_icons/04_00-bs_icons-it.md)



## Installiamo con importmap

Nel loro sito vediamo che ci consigliano di installare tramite npm: `npm i bootstrap-icons`.

Noi possiamo usarlo per importmap

```bash
$ importmap pin bootstrap-icons
oppure
$ ./bin/importmap pin bootstrap-icons
```

***NON FUNZIONA :(***





## La libreria Bootstrap Icons

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