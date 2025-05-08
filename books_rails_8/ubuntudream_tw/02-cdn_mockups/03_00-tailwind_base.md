# <a name="top"></a> Impostiamo alcune formattazioni base di Tailwind

Impostiamo alcune formattazioni base di Tailwind principalmente per assicurarci che il "caricamento" tramite CDN stia funzionando.

Impostiamo il cambio di colore del background in funzione della dimensione dello schermo ed attiviamo la parte "dark" per i backgrounds e per il text.

Inoltre attiviamo il cambio di dark/light tramite un pulsante e del codice javascript.



## The basic DOM

La struttura base HTML.

- html
  - head
  - body
    - header
    - main
    - footer

Tags | Descrizione | usi multipli
| :--- | :--- | :---
`<header>`  | This tag is for logical organization. Dentro l'header subito dopo il `<body>` puoi mettere `<nav>` tags e `<form>` tags. | si possono avere tanti tags `<header>`
`<main>`    | This tag is for logical organization. Si concentra sulla parte principale della pagina. Per i non vedenti ad esempio arrivo diretto al `<main>` evitando di leggere header con nav e/o lateral nav,... | Ci dovrebbe essere solo 1 tag `<main>`. (Eventualmente un altro come invisible o hidden). 
`<footer>`  | This tag is for logical organization. Dentro il footer alla fine del `<body>` ho "GPR", "Copyrights", "Contact info", "Legal info", "P.IVA", ... | Si possono avere tanti tags `<footer>`


```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta ...>
    ...
    <title>Tailwind Base</title>
    ...
    <link rel="stylesheet" href="css/style.css" type="text/css">
    ...
  </head>
  <body>
    <header>
      ...
    </header>
    <main>
      ...
    </main>
    <footer>
      ...
    </footer>
    <script src="scripts.js">
      ...
    </script>
  </body>
</html>
```




## The Tailwind Hello page



***Codice 01 - .../app/views/cdnmockups/tw_base.html.erb - linea:1***

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="author" content="Flavio Bordoni">
    <title>Tailwind Base</title>

    <!-- IMPORTA TAILWIND -->
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body>

    <main>
      ...
    </main>

  </body>
</html>
```




## Risorse esterne

- [ Beginner Tailwind [FULL COURSE] - 9 ore](https://www.youtube.com/watch?v=wEM5NdJ-8HY)
- [Intro to HTML5: The Main Tag - Part 9](https://www.youtube.com/watch?app=desktop&v=vftAJ2KEBV8)

