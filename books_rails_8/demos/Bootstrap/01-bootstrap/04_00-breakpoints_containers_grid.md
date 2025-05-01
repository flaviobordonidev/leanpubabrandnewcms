# <a name="top"></a> Breakpoints Containers Grid

Introduciamo la griglia bootstrap ed il comportamento responsive che si adatta a diversi devices (mobile, tablet, pc, ...)




## I Breakpoints

- [Corso Bootstrap 5 Italiano Introduttivo da 3 ore - 23:58 di 3:06:59](https://www.youtube.com/watch?v=50R7mnfW7nA)

I `Breakpoints` sono dei "punti di rottura"; sono i punti in cui un design *responsive* capisce che è cambiato uno schermo. Si tratta della grandezza in pixels. Sono dei punti che vanno a definire che il layout cambia modo di approcciarsi in base alla larghezza dello schermo.

I Breakpoint sono quei "punti di rottura" che utilizzeremo per le *media query*.
Le *media query* sono delle funzioni CSS che ci permettono di dire al nostro codice: "Se hai questo spazio ti comporti così", "Se hai quest'altro spazio ti comporti in qeust'altro modo".

*Mobile first* è l'idea dei Breakpoints quindi si parte sempre a ragionare dalla versione più piccola e poi pian piano ci si allarga.

Vediamo i breakpoints:

Breakpoint   | Class infix  | Dimensions  | Devices
| :---       | :--          | :---        | :---
Extra Small  | _none_       | <576 px     | Cellulari
Small        | sm           | >=576 px    | iPad, Tablet
Medium       | md           | >=768 px    | Notebook 15"
Large        | lg           | >=992 px    | Notebook 17" e PC desktop
Extra Large  | xl           | >=1200 px   | Pc desktop con monitor grandi
Extra Extra Large  | xxl    | >=1400 px   | Pc desktop con monitor molto grandi



## Containers

- [Corso Bootstrap 5 Italiano Introduttivo da 3 ore - 30:10 di 3:06:59](https://www.youtube.com/watch?v=50R7mnfW7nA)

Sono i componenti fondamentali di bootstrap che contengono tutto il resto.
Abbiamo 3 tipi di container:
- `.container` quello di default
- `.container-(breakpoint)` sono: `.container-sm`, `.container-md`, `.container-lg`,...
- `.container-fluid` che va sempre al 100% della larghezza

Vediamoli spiegati meglio nella tabella:

[]              | Extra Small <576 px  | Small >=576 px  | Medium >=768 px | Large >=992 px | X-Large >=1200 px | XX-Large >=1400 px 
| :---          | :--          | :---           | :---            | :---           | :---              | :---
`.container`    | 100%         | 540 px         | 720 px          | 960 px         | 1140 px           | 1320 px
`.container-sm` | 100%         | 540 px         | 720 px          | 960 px         | 1140 px           | 1320 px
`.container-md` | 100%         | 100%           | 720 px          | 960 px         | 1140 px           | 1320 px
`.container-lg` | 100%         | 100%           | 100%            | 960 px         | 1140 px           | 1320 px
`.container-xl` | 100%         | 100%           | 100%            | 100%           | 1140 px           | 1320 px
`.container-xxl` | 100%        | 100%           | 100%            | 100%           | 100%              | 1320 px
`.container-fluid` | 100%      | 100%           | 100%            | 100%           | 100%              | 100%



## Grid

- [Corso Bootstrap 5 Italiano Introduttivo da 3 ore - 36:20 di 3:06:59](https://www.youtube.com/watch?v=50R7mnfW7nA)

La Grid di bootstrap è diversa dai "CSS grid" e si basa su "flexbox".
It’s built with [flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox) and is fully responsive.

Vediamo il primo esempio:

***Codice 02 - .../app/views/mockups/bs_grid.html.erb - linea:1***

```html
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
```



## Gutters

Gli spazi tra le righe e le colonne
