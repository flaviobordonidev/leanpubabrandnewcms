# <a name="top"></a> Impostiamo alcune formattazioni base di Tailwind

Facciamo alcune cards con Tailwind CSS.
A titolo di esempio facciamo delle cards per delle ricette di cucina.


## La view `tw_comp_cards` per il componente Card

Creiamo la nuova view `cdnmockups/tw_comp_cards`, la nuova azione `tw_comp_cards` su `cdnmockups_controller` e l'instradamento su `routes`.


## Iniziamo creando la struttura base

La struttura della DOM nel suo insieme.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/ubuntudream_tw/02-cdn_mockups/07_fig01-DOM_header_nav_main_footer.png)

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
    <!-- <link rel="stylesheet" href="css/style.css" type="text/css"> -->
  </head>
  <body>

    <header>
      <nav>...</nav>
      <form> search... </form>
      ...
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
        ...
      </article>
      ...
    </main>

    <footer>
      <nav>...</nav>
      <p>copyright</p> ...
      ...
    </footer>

    <script src="scripts.js">
      ...
    </script>
  </body>
</html>
```


La struttura base di una cards ha un'immagine, un titolo, una descrizione ed uno o più "badges" per alcune funzioni ad esempio il cuore per evidenziare un like, oppure il tempo di cottura in una ricetta, oppure le visualizzazioni, le stelle, o altro.

***Codice 01 - .../app/views/cdnmockups/tw_comp_cards.html.erb - linea:3***

```html
          <!-- card -->
          <div class="bg-white">
            <img class="bg-neutral-100" src="" alt="">
            <div>
              <span class="font-bold">Titolo</span>
              <span class="block text-sm">Descrizione</span>
            </div>
            <!-- badge -->
            <div>
              <span>tempo di preparazione</span>
            </div>
          </div>
          <!-- card - end -->
```



## L'elemento `<div>`

Posso usare anche sempre <div> ma è meglio, quando possibile, usare dei tags già definiti su <html5>
The <div> element should be used only when no other semantic element (such as <article> or <nav>) is appropriate.
The <section> HTML element represents a generic standalone section of a document, which doesn't have a more specific semantic element to represent it. Sections should always have a heading, with very few exceptions.
If you are only using the element as a styling wrapper, use a <div> instead

Esempio in cui uso tutti tags `<div>`:

```html
  <!-- cards -->
  <div>
    <img></img>
    <div>
      <span></span>
      <span></span>
    </div>
    <div>banner</div>
  </div>
```

Esempio in cui uso vari tags html:

```html
  <!-- cards -->
  <article>
    <img></img>
    <header>
      <h2></h2>
      <p></p>
    </header>
    <aside>banner</aside>
  </article>
```

In questo esempio in basso ho organizzato meglio a "livello semantico" la mia card facendo un parallelo con l'articolo.

- The <aside> tags should provide additional information that helps, but is not required for the page. The aside should be short, providing extra info, not be another article itself.
- The <article> HTML element represents a self-contained composition in a document, page, application, or site, which is intended to be independently distributable or reusable. Examples include: a forum post, a magazine or newspaper article, a blog entry, a product card, a user-submitted comment, an interactive widget or gadget, or any other independent item of content.

A given document can have multiple articles in it; for example, on a blog that shows the text of each article one after another as the reader scrolls, each post would be contained in an <article> element, possibly with one or more <section>s within.

```html
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
```



## Continuiamo con la struttura base

Adesso miglioriamo la semantica sostituendo i tags `<div>` con i tags `<article>`, `<h2>`, `<p>`, ...
Inoltre inseriamo i percorsi all'immagine ed introduciamo il "badge".

***Codice 02 - .../app/views/cdnmockups/tw_comp_cards.html.erb - linea:3***

```html
          <!-- card -->
          <article class="bg-white rounded overflow-hidden shadow-md">
            <img class="bg-neutral-100" src="https://images.pexels.com/photos/1058035/pexels-photo-1058035.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" alt="curry">
            <header>
              <h2 class="font-bold">Spezie</h2>
              <p class="block text-sm">Una selezione di spezie</p>
            </header>
            <!-- badge -->
            <aside>
              <span>12 min</span>
            </aside>
          </article>
```

Nel primo `<div>`, quello che definisce la card:

- bg-white 
- rounded 
- overflow-hidden fa in modo che tutto quello che esce dallo spazio del div sia nascosto. Questo evita che l'immagine fuoriesca con gli angoli non arrotondati. 
- shadow-md

Nel tag `<img>`:

- w-full allunga l'immagine per tutta la larghezza dell'elemento che la contiene
- h-32 fissa l'altezza a 32 evitando che l'immagine allargandosi aumenti troppo in altezza
- object-cover evita che l'immagine sia allungata ("stretched")


```html
          <!-- cards go here -->
            <!-- w-full allunga l'immagine per tutta la larghezza dell'elemento che la contiene -->
            <!-- h-32 fissa l'altezza a 32 evitando che l'immagine allargandosi aumenti troppo in altezza -->
            <!-- object-cover evita che l'immagine sia allungata ("stretched") -->
            <img src="https://images.pexels.com/photos/1058035/pexels-photo-1058035.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" alt="curry" class="w-full h-32 sm:h-48 object-cover">
            <div class="m-4">
              <span class="font-bold">5 Bean Chili Stew</span>
              <!-- block fa in modo che vada sulla seconda linea (in pratica è come se non ci fosse lo <span> che di default è "inline") -->
              <span class="block text-sm">Recipe by Mario</span>
            </div>
            <div class="bg-amber-400 text-amber-800 text-xs uppercase text-bold rounded-full p-2 absolute top-0 ml-2 mt-2">
              <svg class="inline-block" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-play-btn" viewBox="0 0 16 16">
                <path d="M6.79 5.093A.5.5 0 0 0 6 5.5v5a.5.5 0 0 0 .79.407l3.5-2.5a.5.5 0 0 0 0-.814z"/>
                <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
              </svg>
              <span>25 min</span>
            </div>
          </div>
```





---
---






<div class="grid grid-cols-12 gap-4">
  <div class="col-span-6 bg-blue-200">Metà</div>
  <div class="col-span-6 bg-blue-400">Altra metà</div>
</div>


<div class="grid grid-cols-12 gap-4">
  <div class="col-span-4 bg-red-200">4 colonne</div>
  <div class="col-span-8 bg-red-400">8 colonne</div>
</div>



---

Sì, con le breakpoint classes di Tailwind. Per esempio:

<div class="grid grid-cols-12 gap-4">
  <div class="col-span-12 md:col-span-6 lg:col-span-4">Responsive</div>
</div>

- col-span-12: su mobile
- md:col-span-6: da 768px in su (tablet)
- lg:col-span-4: da 1024px in su (desktop)


---

Come tradurre in tailwind il seguente layout bootstrap che ha anche le "row":

<div class="container text-center">
  <div class="row">
    <div class="col">
      Column
    </div>
    <div class="col">
      Column
    </div>
    <div class="col">
      Column
    </div>
  </div>
</div>

Ottimo esempio! Quello che hai mostrato è un classico layout Bootstrap con una container, una row e tre col, ognuna delle quali si distribuisce in modo equamente spaziale all'interno della riga (grazie al comportamento Flexbox implicito di Bootstrap sulle row).

In Tailwind, non esiste una classe astratta row, ma possiamo ricreare lo stesso identico layout in due modi principali:

✅ Versione equivalente in Tailwind (con Flexbox)

<div class="container mx-auto text-center">
  <div class="flex">
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
  </div>
</div>


Se preferisci usare Grid (più vicino al modello 12 colonne):

<div class="container mx-auto text-center">
  <div class="grid grid-cols-3 gap-4">
    <div class="border p-4">Column</div>
    <div class="border p-4">Column</div>
    <div class="border p-4">Column</div>
  </div>
</div>

Bootstrap rende automaticamente col stackabili su mobile. In Tailwind devi specificarlo così:

<div class="container mx-auto text-center">
  <div class="flex flex-col md:flex-row">
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
    <div class="flex-1 border p-4">Column</div>
  </div>
</div>



## CSS Flex vs Grid (using Tailwind CSS) | Which to choose?

- [CSS Flex vs Grid (using Tailwind CSS) | Which to choose?](https://www.youtube.com/watch?v=NUDLB5WG_6E)

Nell'immagine `03_fig01-tw_flex_on_email_button` è meglio usare `flex` invece di `grid` perché ci interessa che il pulsante si *adatti al contenuto*, ossia a quello che c'è scritto dentro. In questo caso "Get a demo". Se domani ci voglio scrivere "Get a free demo", usando `flex` il pulsante si allunga da solo. Se invece usavo grid che succedeva? Boh! è da provare.




---
---



## Moltiplichiamo le cards su container Flex

vedi http://127.0.0.1:3000/mockups/tw_comp_cards

```html
    <!-- Main Content -->
    <main>

      <!-- Flex container of the cards -->
      <div class="flex w-full gap-6">

        <!-- card -->
        ...

        <!-- card -->
        ...
```

Come si può vedere su container Flex le cards si allargano in funzione del contenuto e se sono di più si schiacciano per cercare di lasciarle tutte sulla stessa riga.



## Moltiplichiamo le cards su container Grid

vedi http://127.0.0.1:3000/mockups/tw_comp_cards

```html
    <!-- Main Content -->
    <main>

      <!-- Grid container of the cards -->
      <div class="grid md:grid-cols-3 gap-6">

        <!-- card -->
        ...

        <!-- card -->
        ...
```

Come si può vedere su container Grid le cards restano della larghezza definita nelle colonne e se sono di più del numero delle colonne vanno automaticamente sulla riga successiva.



## Risorse esterne

- [ Tailwind CSS Tutorial #9 - Cards ](https://www.youtube.com/watch?v=vqKie-xmcFs&list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw&index=9)
- [ Tailwind CSS Tutorial #10 - Badges ](https://www.youtube.com/watch?v=cY0XJY98d3w&list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw&index=10)
- [ Tailwind CSS Tutorial #12 - Grids ](https://www.youtube.com/watch?v=_r2qB44o_Fs&list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw&index=12)
- [ Tailwind CSS Tutorial #13 - Buttons ](https://www.youtube.com/watch?v=kMiMlB5PZRM&list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw&index=13)
- [ Tailwind CSS Tutorial #14 - Icons ](https://www.youtube.com/watch?v=aNmBiqK2uQ0&list=PL4cUxeGkcC9gpXORlEHjc5bgnIi5HEGhw&index=14)

- [ How to create card in Tailwind css? - usa flex invece di grid. Io preferisco grid.](https://www.youtube.com/watch?v=jSNF_cY5M3w)

- [ Create Stunning Product Cards with Tailwind CSS | Tailwind CSS Tutorial - usa <div class="card">](https://www.youtube.com/watch?v=9DxrX8-ZXQ4)

- [ Responsive Design Card - Tailwind CSS Tutorial [ Hindi ] - card con foto a sx ](https://www.youtube.com/watch?v=1naZDgCBNGU)
- [ How to Create Responsive Card in Tailwind CSS | Tutorial - card con foto a sx continuo](https://www.youtube.com/watch?v=UbhxJgtYHm4)


- [ Beginner Tailwind [FULL COURSE] - 9 ore](https://www.youtube.com/watch?v=wEM5NdJ-8HY)
- []