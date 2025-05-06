# <a name="top"></a> Impostiamo alcune formattazioni base di Tailwind

Facciamo alcune cards con Tailwind CSS.
A titolo di esempio facciamo delle cards per delle ricette di cucina.



## La view `tw_comp_cards` per il componente Card

Creiamo la nuova view `cdnmockups/tw_comp_cards`, la nuova azione `tw_comp_cards` su `cdnmockups_controller` e l'instradamento su `routes`.



## Iniziamo creando la struttura base

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



***Codice 02 - .../app/views/cdnmockups/tw_comp_cards.html.erb - linea:3***

```html
          <!-- card -->
          <div class="bg-white rounded overflow-hidden shadow-md">
            <img class="bg-neutral-100" src="https://images.pexels.com/photos/1058035/pexels-photo-1058035.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" alt="curry">
            <div>
              <span class="font-bold">Spezie</span>
              <span class="block text-sm">Una selezione di spezie</span>
            </div>
            <!-- badge -->
            <div>
              <span>12 min</span>
            </div>
          </div>
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