# <a name="top"></a> Cap 2.1 - La pagina sign-in

Implementiamo la pagina `sign-in` di *eduport* su Rails.

> Propedeutico a questa sezione è aver fatto la sezione [code_references/theme-eduport-sproket/01-index]()



## Risorse interne

- [code_references/theme-eduport-sproket/01-index]()



## Risorse esterne

- [eduport: sign-in](https://eduport.webestica.com/sign-in.html)



## Partiamo dalla pagina index

Vediamo la pagina `sign-in` del tema *eduport*.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig01-index.png)

Vediamo tutto il codice *<html>* preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

[Codice 01 - .../theme_eduport/sign-in.html - linea: 91](...-01_01-theme_eduport-sign-in)

```html
<!-- **************** MAIN CONTENT START **************** -->
<main>
	<section class="p-0 d-flex align-items-center position-relative overflow-hidden">
	
		<div class="container-fluid">
			<div class="row">
				<!-- left -->
				<div class="col-12 col-lg-6 d-md-flex align-items-center justify-content-center bg-primary bg-opacity-10 vh-lg-100">
					<div class="p-3 p-lg-5">
						<!-- Title -->
						<div class="text-center">
							<h2 class="fw-bold">Welcome to our largest community</h2>
							<p class="mb-0 h6 fw-light">Let's learn something new today!</p>
						</div>
```

> Questo file è **fuori** dalla nostra applicazione Rails: `file:///Users/FB/eduport_v1.4.1/template/sign-in.html`



## Creiamo la view mockups/eduport_signin

Creiamo la pagina `.../app/views/mockups/eduport_signin.html.erb` e ci copiamo tutto il codice del file `.../eduport_v1.4.1/template/sign-in.html`.



## Aggiorniamo il controller Mockups

Facciamo in modo che la view `mockups/eduport_signin` utilizzi il layout `empty`.

[Codice n/a - .../controllers/mockups_controller.rb - linea: 8]()

```ruby
  def eduport_signin
    render layout: 'empty'
  end
```


## Aggiorniamo l'instradamento

[Codice n/a - .../config/routes.rb - linea: 16]()

```ruby
  get 'mockups/eduport_signin'
```



## Adattiamo la mockups/sign-in 

Usiamo il layout "application" per adattare il codice della pagina `mockups/eduport_signin` che è fuori dai tags `<body>...</body>`. 

Inoltre commentiamo le chiamate a javascript in fondo al codice perché tanto non funzionerebbero perché non hanno i puntamenti corretti all'asset-pipeline e darebbero solo errore nella java console del browser.

[Codice 02 - ...views/mockups/eduport_index.html.erb - linea: 90]()

```html+erb
	<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
	<%#= stylesheet_link_tag "/scss/style", "data-turbo-track": "reload" %>
    <%= stylesheet_link_tag :all, "data-turbo-track": "reload" %>
	<%#= javascript_importmap_tags %>
	<%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>
```

La riga: `<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>` attiva molta formattazione.
La riga: `<%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>` attiva il drop down nei menu.



## Verifichiamo preview

```bash
#$ rails s -b 192.168.64.4
$ ./bin/dev
```

Andiamo con il browser sull'URL:

- http://192.168.64.4:3000/mockups/eduport_signin

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig02-index.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Start mockups eduport_index"
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
