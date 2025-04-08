# <a name="top"></a> Cap 4.1 - Il tema eduport UBUNTUDREM

Dopo una grande ricerca ho finalmente trovato un tema che mi soddisfa per UbuntuDream.

La grafica dell'interfaccia utente (User Interface) che mi piace simulare è quella usata nell'app [Headspace](https://www.headspace.com/).

Il tema che ci si avvicina è [eduport](https://eduport.webestica.com/). 
Inoltre questo tema è un [tema *ufficiali* di bootstrap](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)



## Risorse interne

La varie pagine del tema eduport e spiegazioni più dettagliate sono nella sezione `code_references/theme-edupor` a partire dal primo capitolo:

- [code_references/theme-eduport/01_00-eduport]()



## Apriamo il branch "Eduport"

```bash
$ git checkout -b ep
```



## Scarichiamo la versione aggiornata del tema

Ad oggi 19/02/2024 l'ultima versione è la *Version 1.4.1 — 12 Oct, 2023*.

Per maggiori dettagli vedi:

- [code_references/theme-eduport/01_00-eduport]()



## Creiamo la view mockups/test_eduport_index

Creiamo la pagina `.../app/views/mockups/test_eduport_index.html.erb` e ci copiamo tutto il codice del file `.../eduport_v1.4.1/template/index.html`.

> scegliamo la pagina `index.html` perché spesso è quella che usa la maggior parte dello stylesheet e javascript del tema quindi ci è più utile per vedere se stiamo importando correttamente tutta la parte css, js, le immagini e i fonts.



## Creiamo un layout vuoto per la pagina mockups/test_eduport

Vogliamo lasciare tuto il codice html all'interno della pagina `mockups/test_eduport_index`, quindi prepariamo un layout vuoto da assegnargli.
Chiamiamo questo layout `empty`.

[Codice 01 - ...views/layouts/empty.html.erb - linea: 1]()

```html
<%= yield %>
```



## Aggiorniamo il controller Mockups

Facciamo in modo che la view `mockups/test_eduport_index` utilizzi il layout `empty`.

[Codice 02 - .../controllers/mockups_controller.rb - linea: 8]()

```ruby
  def eduport_index
    render layout: 'empty'
  end
```


## Aggiorniamo l'instradamento

Facciamo in modo che la view `mockups/eduport_index` utilizzi il layout `empty`.

[Codice 03 - .../config/routes.rb - linea: 16]()

```ruby
  get 'mockups/eduport_index'
```



## Adattiamo la mockups/index 

Qui andiamo diretti ai punti da modificare.
Per vedere maggiori spiegazioni e dettagli vedi:

- [code_references/theme-eduport/01_00-eduport]()


[Codice 04 - ...views/mockups/eduport_index.html.erb - linea: 1]()

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
$ rails s -b 192.168.64.4
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
