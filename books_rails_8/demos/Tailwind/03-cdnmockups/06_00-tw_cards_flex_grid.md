# <a name="top"></a> Implementiamo delle cards

Facciamo alcune cards con Tailwind CSS.
A titolo di esempio facciamo delle cards per delle ricette di cucina.

**ATTENZIONE**
**Il file** `06_99-app-views-cdnmockups-tw_comp_cards.html.erb` **è quello più completo**.



## La view `tw_comp_cards` per il componente Card

Creiamo la nuova view `cdnmockups/tw_comp_cards`, la nuova azione `tw_comp_cards` su `cdnmockups_controller` e l'instradamento su `routes`.



## Iniziamo creando la struttura base

La struttura della DOM con le cards nella sezione `<main>`.

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

    <script src="scripts.js">
      ...
    </script>
  </body>
</html>
```



### Struttura base di una card

La struttura base di una cards ha un'immagine, un titolo, una descrizione ed uno o più "badges" per alcune funzioni ad esempio il cuore per evidenziare un like, oppure il tempo di cottura in una ricetta, oppure le visualizzazioni, le stelle, o altro.

Esempio in cui uso tutti tags `<div>`.

```html
<!-- card -->
<div>
  <img src="" alt="">
  <div>
    <span>Titolo</span>
    <span>Descrizione</span>
  </div>
  <!-- badge -->
  <div>
    <span>tempo di preparazione</span>
  </div>
</div>
<!-- card - end -->
```

Posso usare anche sempre `<div>` ma è meglio, quando possibile, usare dei tags già definiti su `<html5>`
The `<div>` element should be used only when no other semantic element (such as `<article>` or `<nav>`) is appropriate.
The `<section>` HTML element represents a generic standalone section of a document, which doesn't have a more specific semantic element to represent it. *Sections should always have a heading*, with very few exceptions.
If you are only using the element as a styling wrapper, use a `<div>` instead.
`<section>` tells browsers and screen readers that the content inside it should be grouped together, like a section in an article.
`<div>` does not impart any meaning and is simply used to help with layout.

Esempio in cui uso vari tags html.

```html
  <!-- cards -->
  <article>
    <img></img>
    <header>
      <h2></h2>
      <p></p>
    </header>
    <!-- badge -->
    <aside>
      <span>badge</span>
    </aside>
  </article>
```

In questo esempio ho organizzato meglio a "livello semantico" la mia card facendo un parallelo con l'articolo.

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



## La card con la ricetta

***Codice 01 - .../app/views/cdnmockups/tw_comp_cards.html.erb - linea:24***

```html
          <!-- card -->
          <div class="bg-white">
            <img class="bg-neutral-100" src="" alt="">
            <div>
              <span class="font-bold">Spezie</span>
              <span class="block text-sm">Una selezione di spezie</span>
            </div>
            <!-- badge -->
            <div>
              <span>tempo di preparazione</span>
            </div>
          </div>
          <!-- card - end -->
```

Nella cards con la ricetta miglioriamo la semantica sostituendo i tags `<div>` con i tags `<article>`, `<h2>`, `<p>`, ...
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



## Moltiplichiamo le cards su container Flex

Quando abbiamo più cards e vogliamo che la loro larghezza vari in funzione della quantità di contentuto, è utile inserirle su un contenitore flex. Con un contenitore flex le cards non andranno mai su una seconda riga ma si stringeranno sempre di più.


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

Quando abbiamo più cards e vogliamo che rispettino delle larghezze prestabilite e che l'eccesso di contentuto si sviluppi in verticale, è utile inserirle su una griglie. Se abbiamo più cards rispetto al numero di colonne indicato, che sono quelle che determinano la larghezza prestabilita, allora le cards in eccesso andranno automaticamente su una nuova riga.

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



## Usare una grid a 12 colonne come BootStrap

Possiamo creare una griglia a 12 colonne, come fa Boorstrap, ed inserire poi le colonne che ci servono davvero usando il `col-span-`.
Ad esempio il seguente codice crea una colonna su cellulare, due colonne su tablet e 3 colonne su PC.

```html
<div class="grid grid-cols-12 gap-4">
  <div class="col-span-12 md:col-span-6 lg:col-span-4">Responsive</div>
</div>
```

`col-span-`      | # colonne
|:---            |:---
`col-span-12:`   | 1 colonna su collulare (da 0px in su)
`md:col-span-6:` | 2 colonne su tablet (da 768px in su)
`lg:col-span-4:` | 3 colonne da PC (da 1024px in su)



## Mantenere insieme icona e testo 

Per far sì che l’icona dell’orologio e la scritta “5 min” restino sempre insieme su una sola riga, devi racchiuderle in un **contenitore `inline-flex` con `whitespace-nowrap`**.

Ecco come puoi correggere il blocco interessato:

```html
<span class="inline-flex items-center text-sm whitespace-nowrap">
  <svg xmlns="http://www.w3.org/2000/svg"
       width="16" height="16" fill="currentColor"
       class="bi bi-clock mr-1"
       viewBox="0 0 16 16">
    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
  </svg>
  5 min
</span>
```

Spiegazione:
- `inline-flex`: dispone svg e testo sulla stessa linea.
- `items-center`: li allinea verticalmente.
- `whitespace-nowrap`: impedisce l’andata a capo all’interno del blocco.
- `mr-1`: margine a destra dell’icona, per distanziare dal testo.




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

- [CSS Flex vs Grid (using Tailwind CSS) | Which to choose?](https://www.youtube.com/watch?v=NUDLB5WG_6E)

