# Come ordiniamo le classi Tailwind


In Tailwind non c’è una “regola ufficiale” unica che tutti seguono, ma ci sono convenzioni molto diffuse che ti fanno guadagnare leggibilità, review più facili e meno conflitti nei merge. La best practice vera è: scegli uno stile e applicalo sempre, idealmente automatizzandolo.

La soluzione più adottata oggi è far ordinare automaticamente le classi con Prettier + plugin Tailwind (ti evita di pensarci). Se lo fai, lui impone un ordine “sensato” e consistente. Se invece vuoi una regola mentale per scriverle a mano, ecco cosa funziona bene nella pratica.


## Ordine consigliato (manuale)

- LAYOUT/POSITIONING  : block, flex, grid, items-center, justify-between, gap-4, relative, absolute, z-50
- SIZING              : w-full, max-w-5xl, h-12, min-h-[60vh], aspect-*, size-*, max-h-*, min-w-* 
- SPACING             : m-..., p-... (margin e padding vicini, spesso insieme)
- SHAPE/BORDERS       : rounded-2xl, border, border-neutral-200, ring-*, outline-* 
- BACKGROUND          : bg-white, bg-neutral-900/80, bg-gradient-*, bg-cover, bg-center
- TYPOGRAPHY          : text-neutral-900, text-sm, font-semibold, leading-tight, tracking-*, uppercase, lowercase, line-clamp-*, fill-*, stroke-* 
- EFFECTS             : shadow, opacity-90, backdrop-blur, transition, duration-200
- STATES              : hover:*, focus:*, focus-visible:*, active:*, disabled:*, group-hover:*, peer-checked:* 
- RESPONSIVE          : sm:*, md:*, lg:* 
- THEME               : dark:* (o contrast-more:, motion-reduce:, print:, data-theme:*, ...)
- ACCESSIBILITY       : forced-color-adjust-auto, sr-only, not-sr-only, aria-*

questo ordine è “leggibile” perché racconta una storia.
Prima definisci la “scatola” (LAYOUT),poi le sue dimensioni (SIZING), poi la spaziatura (SPACING), poi la “pelle”, ossia forma e bordi (SHAPE/BORDERS), poi il colore (COLORS), poi la tipografia (TYPOGRAPHY), poi gli effetti (EFFECTS), poi le interazioni e gli stati (SATES), poi i responsive (RESPONSIVE) e infine i temi (THEME). Questo perché quando leggi una riga vuoi capire subito “che oggetto è” prima di capire “come si colora”.

Perché nella lettura umana funziona così:

- cos’è (layout, dimensioni)
- com’è (colori, tipografia)
- che effetto ha (shadow, transition)
- come reagisce (hover, active, focus)



### La classe base viene sempre prima

La classe base viene sempre prima, la variante dopo

Sì : bg-white dark:bg-neutral-800
No : dark:bg-neutral-800 bg-white



### Padding prima di Margin?

In realtà è indifferente chi va prima ma a me piace pensare prima padding e poi margin per una lettura dal "dentro al fuori".

- cos’è l’elemento (layout, dimensioni)
- come è fatto dentro → padding (Il padding è intrinseco al componente.) 
- come si distanzia dagli altri → margin (Il margin è relazionale; dipende dal contesto.)

Quindi:

[p-…] → definisce il corpo dell’oggetto
[m-…] → definisce la relazione con l’esterno

px-4 py-3 mt-2 mb-6

Si legge come: “Questo elemento ha questo respiro interno, e poi questo spazio rispetto agli altri”

Immagina una card come se fosse un cuscino:

- padding = imbottitura del cuscino
- margin = spazio tra un cuscino e l’altro sul divano

Quando descrivi un cuscino, prima parli di com’è fatto e poi di dove lo metti.



### Tenere tutti gli hover: vicini?

Sì, di solito è una buona idea. Gli “stati” sono più facili da scansionare se sono raggruppati:

class="... transition hover:bg-neutral-100 hover:shadow-lg focus:ring-2 active:scale-[0.99]"



### Responsive (sm:, md:) 

base -> sm: -> md: -> lg: -> xl: -> 2xl:

Sì  : h-40 sm:h-56 md:h-72
No  : md:h-72 h-40 sm:h-56

Esempio chiaro:

class="h-40 sm:h-56 md:h-72 object-cover object-top"



### dark:: tutto alla fine o accoppiato al “light”?

Qui ci sono due scuole. Entrambe sono valide; ti dico pro/contro e poi ti suggerisco cosa fare.

A) dark: alla fine (raggruppato)

Pro: leggi prima la versione “base”, poi la variante dark tutta insieme; facile da cercare/ritoccare.

Contro: quando cambi un colore “light” devi ricordarti di aggiornare anche quello dark più in fondo.

Esempio:

class="bg-white text-neutral-900 border-neutral-200
       dark:bg-neutral-800 dark:text-neutral-50 dark:border-neutral-700"


B) dark: subito accoppiato vicino alla classe base

Pro: vedi immediatamente la coppia (light/dark), meno rischio di dimenticare.

Contro: la classe diventa più “rumorosa” visivamente, soprattutto se ce ne sono tante.

Esempio:

class="bg-white dark:bg-neutral-800 text-neutral-900 dark:text-neutral-50 border-neutral-200 dark:border-neutral-700"


Per UI come la tua (molti elementi, molte card), di solito funziona meglio A: raggruppare i dark: alla fine, perché mantiene leggibile la “base” e rende evidente che quella parte è solo tema.




