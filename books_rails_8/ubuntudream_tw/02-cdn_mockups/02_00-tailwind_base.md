# <a name="top"></a> Impostiamo alcune formattazioni base di Tailwind

Impostiamo alcune formattazioni base di Tailwind principalmente per assicurarci che il "caricamento" tramite CDN stia funzionando.

Impostiamo il cambio di colore del background in funzione della dimensione dello schermo ed attiviamo la parte "dark" per i backgrounds e per il text.

Inoltre attiviamo il cambio di dark/light tramite un pulsante e del codice javascript.



## The basic DOM

- [Intro to HTML5: The Main Tag - Part 9](https://www.youtube.com/watch?app=desktop&v=vftAJ2KEBV8)


<html>
  <head>
    <title></title>
    <meta name="author" content="Flavio Bordoni">
    <meta charset="utf-8">

    <link rel="stylesheet" href="css/style.css" type="text/css">
  </head>
  <body>

    <header>
      <nav></nav>
      <form> search... </form>
    </header>

    <main>
      ...
      <article>
        <header>
        </header>
        <img></img>
        <footer></footer>
      </article>
      ...
      <article>
      </article>
    </main>

    <footer>
      <nav></nav>
      <p>copyright</p> ...
    </footer>

    <script src="scripts.js>
    </script>
  </body>
</html>


- <header> tag is for logical organization. Dentro l'header subito dopo il <body> puoi mettere <nav> tags e <form> tags.
    si possono avere tanti tags <header>
- <main> tag is for logical organization. Si concentra sulla parte principale della pagina. Per i non vedenti ad esempio arrivo diretto al "<main>" evitando di leggere header con nav e/o lateral nav,...
    Ci dovrebbe essere solo 1 tag <main>. (Eventualmente un altro come invisible o hidden). 
- <footer> tag is for logical organization. Dentro il footer alla fine del <body> ho "GPR", "Copyrights", "Contact info", "Legal info", "P.IVA", ...
    Si possono avere tanti tags <footer>

Posso usare anche sempre <div> ma è meglio, quando possibile, usare dei tags già definiti su <html5>
The <div> element should be used only when no other semantic element (such as <article> or <nav>) is appropriate.
The <section> HTML element represents a generic standalone section of a document, which doesn't have a more specific semantic element to represent it. Sections should always have a heading, with very few exceptions.
If you are only using the element as a styling wrapper, use a <div> instead

Esempio:
  <!-- cards -->
  <div>
    <img></img>
    <div>
      <span></span>
      <span></span>
    </div>
    <div>banner</div>
  </div>

  <!-- cards -->
  <article>
    <img></img>
    <header>
      <h2></h2>
      <p></p>
    </header>
    <aside>banner</aside>
  </article>

In questo esempio in basso ho organizzato meglio a "livello semantico" la mia card facendo un parallelo con l'articolo.

The <aside> tags should provide additional information that helps, but is not required for the page. The aside should be short, providing extra info, not be another article itself.


The <article> HTML element represents a self-contained composition in a document, page, application, or site, which is intended to be independently distributable or reusable. Examples include: a forum post, a magazine or newspaper article, a blog entry, a product card, a user-submitted comment, an interactive widget or gadget, or any other independent item of content.

A given document can have multiple articles in it; for example, on a blog that shows the text of each article one after another as the reader scrolls, each post would be contained in an <article> element, possibly with one or more <section>s within.


<article class="forecast">
  <h1>Weather forecast for Seattle</h1>
  <article class="day-forecast">
    <h2>03 March 2018</h2>
    <p>Rain.</p>
  </article>
  <article class="day-forecast">
    <h2>04 March 2018</h2>
    <p>Periods of rain.</p>
  </article>
  <article class="day-forecast">
    <h2>05 March 2018</h2>
    <p>Heavy rain.</p>
  </article>
</article>



## Risorse esterne

- [ Beginner Tailwind [FULL COURSE] - 9 ore](https://www.youtube.com/watch?v=wEM5NdJ-8HY)

