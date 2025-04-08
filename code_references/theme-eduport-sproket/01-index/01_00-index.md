# <a name="top"></a> Cap 1.1 - Il tema eduport

Importiamo su rails il tema eduport attivando tutte le sue caratteristiche di stylesheet e javascript.
Inoltre ricreeremo totalmente alcune pagine.

> Questo tema è quello che abbiamo uato su UbuntuDream.



Nei seguenti capitoli riportiamo nella nostra applicazione alcune pagine del tema eduport esattamente così come sono. Questo ci permette di importare ed adattare tutto lo stylesheets ed il javascript degli elementi che ci interessano per la nostra app. Questo comprende anche le librerie di icone.

I passaggi per importare il tema Eduport sulla nostra app Rails:

1. Scegliamo una pagina html da importare. Ad esempio: *index.html*
2. Usiamo un nuovo layout che chiamiamo "empty" in cui mettiamo solo la chiamata alla view.
3. Importiamo tutto il codice su *mockups/eduport_index.html.erb*
4. Adattiamo le chiamate "header", ossia il codice fuori dai tags <body>...</body>, con quello che abbiamo nel nostro layout di default "application".

5. Aggiorniamo controllers/mockups_controller.rb e config/routes.rb
6. Nel preview vediamo il testo senza stylesheets, images e javascripts
7. copiamo i files stylesheets (css, scss) su "assets/stylesheets/pofo"
8. copiamo le immagini (png, jpg) su "assets/images/pofo"
9. copiamo i files javascripts (js) su "assets/javascripts/pofo"
10. su mockups/mypage.html.erb aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts

11. Refactoring con un nuovo layout che chiamiamo "mockup_eduport" su cui spostiamo la parte fuori dai tags <body>...</body>.
   (rivedi parte boostrap)
3old. Importiamo tutto il codice tra i tags <body>...</body> su *mockups/edu_index.html.erb*



## Risorse interne

- [code_references/theme-eduport/01_00-eduport]()



## Risorse esterne

- [eduport](https://eduport.webestica.com/). 
- Questo tema è un [tema *ufficiali* di bootstrap](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)



## Scarichiamo la versione aggiornata del tema

Il tema eduport è un tema che abbiamo acquistato dalla libreria ufficiale di BootStrap (https://themes.getbootstrap.com/):

- [Bootstrap: tema eduport](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)

Facciamo login e scarichiamo la versione più aggiornata. Ad oggi 19/02/2024 l'ultima versione è la *Version 1.4.1 — 12 Oct, 2023*.
Ci scarica un file *.zip* che scompattiamo.
I files di nostro interesse sono nella cartella `eduport_v1.4.1/template`



## Partiamo dalla pagina index

Vediamo la pagina *index* del tema *eduport*.

> Spesso nei temi la pagina *index* è quella che contiene la maggior parte delle caratteristiche del tema ed è quindi una buona scelta iniziare da questa.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig01-index.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig02-index.png)

Vediamo tutto il codice *<html>* preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

[Codice 01 - .../theme_eduport/index.html - linea: 1](...-01_01-theme_eduport-index)

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="author" content="Webestica.com">
	<meta name="description" content="Eduport- LMS, Education and Course Theme">

	<!-- Dark mode -->
```

> Questo file è **fuori** dalla nostra applicazione Rails: `file:///Users/FB/eduport_v1.4.1/template/index.html`

Nei prossimi paragrafi copiamo e riadattiamo questo codice su una view di mockups della nostra applicazione Ruby on Rails.



## Creiamo la view mockups/eduport_index

Creiamo la pagina `.../app/views/mockups/eduport_index.html.erb` e ci copiamo tutto il codice del file `.../eduport_v1.4.1/template/index.html`.



## Creiamo un layout vuoto per la pagina mockups/eduport_index

Vogliamo lasciare tuto il codice html all'interno della pagina `mockups/eduport_index`, quindi prepariamo un layout vuoto da assegnargli.
Chiamiamo questo layout `empty`.

[Codice 02 - ...views/layouts/empty.html.erb - linea: 1]()

```html
<%= yield %>
```



## Aggiorniamo il controller Mockups

Facciamo in modo che la view `mockups/eduport_index` utilizzi il layout `empty`.

[Codice 03 - .../controllers/mockups_controller.rb - linea: 8]()

```ruby
  def eduport_index
    render layout: 'empty'
  end
```


## Aggiorniamo l'instradamento

Facciamo in modo che la view `mockups/eduport_index` utilizzi il layout `empty`.

[Codice 04 - .../config/routes.rb - linea: 16]()

```ruby
  get 'mockups/eduport_index'
```



## Adattiamo la mockups/index 

Usiamo il layout "application" per adattare il codice della pagina `mockups/eduport_index` che è fuori dai tags `<body>...</body>`. 

Inoltre commentiamo le chiamate a javascript in fondo al codice perché tanto non funzionerebbero perché non hanno i puntamenti corretti all'asset-pipeline e darebbero solo errore nella java console del browser.

[Codice 05 - ...views/mockups/eduport_index.html.erb - linea: 1]()

```html+erb
<!DOCTYPE html>
<html>
<head>
	<title>Ubuntudreamfour</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="author" content="Webestica.com">
	<meta name="description" content="Eduport- LMS, Education and Course Theme">

  <%= csrf_meta_tags %>
  <%= csp_meta_tag %>

	<!-- Dark mode -->
```

[...continua - linea: 89]()

```html+erb
	<!-- Theme CSS -->
	<link rel="stylesheet" type="text/css" href="assets/css/style.css">

	<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
	<%#= javascript_importmap_tags %>
	<%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>

</head>
```

La riga: `<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>` attiva molta formattazione.
La riga: `<%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>` attiva il drop down nei menu.



## Verifichiamo preview

```bash
#$ rails s -b 192.168.64.4
$ ./bin/dev
```

Andiamo con il browser sull'URL:

- http://192.168.64.4:3000/mockups/eduport_index

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig03-index.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig04-index.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Start mockups eduport_index"
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
