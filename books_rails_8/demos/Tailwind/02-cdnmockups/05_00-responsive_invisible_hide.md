# <a name="top"></a> Implementiamo Dark

Introduciamo la parte **Responsive** di Tailwind.



## Inseriamo i parametri Responsive

Assicuriamoci che il *meta tag viewport* (`<meta name="viewport"`) sia presente all'interno del tag `<head>` del documento HTML.

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```

E poi aggiungiamo uno dei break points.


Breakpoint prefix	| Minimum width
| :--- | :---
sm:	| 40rem (640px)	
md:	| 48rem (768px)	
lg:	| 64rem (1024px)
xl:	| 80rem (1280px)
2xl: | 96rem (1536px)

Tailwind ha l'approccio "mobile first" quindi l'applicazione senza prefissi di breakpoint deve essere quella per il cellulare.
Quindi iniziamo cambiando il colore dello sfondo partendo da quello del cellulare che lasciamo *grigio* ed allargandosi verso dimensioni più grandi dello schermo passando per *arancione, ambra, lime, ciano e rosa*.

***Codice 01 - .../app/views/cdnmockups/tw_base.html.erb - linea:1***

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
```

***Codice 01 - .../app/views/cdnmockups/tw_base.html.erb - linea:20***

```html
  <body class="bg-gray-50 sm:bg-orange-200 md:bg-amber-200 lg:bg-lime-200 xl:bg-cyan-200 2xl:bg-pink-200 dark:bg-gray-800 dark:sm:bg-orange-800 dark:md:bg-amber-800 dark:lg:bg-lime-800 dark:xl:bg-cyan-800 dark:2xl:bg-pink-800">
```

Adesso se apriamo la pagina su cellulare, o se stringiamo la finestra del browser sotto i 640px avremo lo sfondo grigio.
Mano a mano che allarghiamo passiamo per gli altri colori.



## Aggiungiamo `invisible`

Creaiamo 6 divs e facciamo in modo che 5 siano invisibili su schermi piccoli (mobile first), mano mano che allarghiamo si visualizzeranno.
Da notare che i trattini "---" che abbiamo messo come divisorio rimangono spaziati perché l'elemento è invisibile ma c'è e quindi occupa spazio.

***Codice 02 - .../app/views/cdnmockups/tw_base.html.erb - linea:44***

```html
      <h2 class="my-6">invisible / visible</h2>

      <div>default >= 0rem (0px)</div>
      ---
      <div class="invisible sm:visible">sm	>= 40rem (640px)</div>
      ---
      <div class="invisible md:visible">md	>= 48rem (768px)</div>
      ---
      <div class="invisible lg:visible">lg	>= 64rem (1024px)</div>
      ---
      <div class="invisible xl:visible">xl	>= 80rem (1280px)</div>
      ---
      <div class="invisible 2xl:visible">2xl	>= 96rem (1536px)</div>
      ---
```



## Aggiungiamo `hidden`

Creaiamo 6 divs e facciamo in modo che 5 siano nascosti su schermi piccoli (mobile first), mano mano che allarghiamo si scopriranno.
Da notare che i trattini "---" che abbiamo messo come divisorio inizialmente sono tutti attaccati perché l'elemento quando è nascosto è come se non esistesse e quindi *non* occupa spazio.

Come abbiamo visto il parametro `invisible` lascia l'elemento html presente ma non lo visualizza. Questo vuol dire che rimane lo spazio dove è presente l'elemento. Se invece vogliamo che non resti lo spazio dobbiamo usare il parametro `hidden` che fa in modo che l'elemento è come se non esistesse. Per far tornare ad essere presente l'elemento non c'è il parametro "unhidden" ma dobbiamo usare il parametro `block`. (oppure il parametro `inline-block`).


***Codice 03 - .../app/views/cdnmockups/tw_base.html.erb - linea:44***

```html
      <h2 class="my-6">Hidden / Block</h2>

      <div>default >= 0rem (0px)</div>
      ---
      <div class="hidden sm:block">sm	>= 40rem (640px)</div>
      ---
      <div class="hidden md:block">md	>= 48rem (768px)</div>
      ---
      <div class="hidden lg:block">lg	>= 64rem (1024px)</div>
      ---
      <div class="hidden xl:block">xl	>= 80rem (1280px)</div>
      ---
      <div class="hidden 2xl:block">2xl	>= 96rem (1536px)</div>
      ---
```


Visualizziamo *1 solo elemento* per ogni breakpoint di responsive.

***Codice 04 - .../app/views/cdnmockups/tw_base.html.erb - linea:74***

```html
      <h2 class="mt-4">Uno solo <strong>non</strong> nascosto</h2>
      ---
      <div class="sm:hidden">Mobile (0..639px)</div>
      ---
      <div class="hidden sm:block md:hidden">Tablet (640..767px)</div>
      ---
      <div class="hidden md:block lg:hidden">PC 13" (768..1023px)</div>
      ---
      <div class="hidden lg:block xl:hidden">PC 17" (1024..12879x)</div>
      ---
      <div class="hidden xl:block 2xl:hidden">PC 20" (1280..1535px)</div>
      ---
      <div class="hidden 2xl:block">PC 27" (>= 1536px)</div>
      ---
```