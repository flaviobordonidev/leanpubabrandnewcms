# <a name="top"></a> Il tema eduport

Dopo una grande ricerca ho finalmente trovato un tema che mi soddisfa per UbuntuDream.

La grafica dell'interfaccia utente (User Interface) che mi piace simulare è quella usata nell'app [Headspace](https://www.headspace.com/).

Il tema che ci si avvicina è [eduport](https://eduport.webestica.com/). 
Inoltre questo tema è un [tema ufficiale di bootstrap](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)



## Scarichiamo la versione aggiornata del tema

Il tema eduport è un tema che abbiamo acquistato dalla libreria ufficiale di BootStrap (https://themes.getbootstrap.com/):

- [Bootstrap: tema eduport](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)

Facciamo login, con le credenziali che ho salvato su keepass e bitwarden, e scarichiamo la versione più aggiornata. 

Ad oggi 23/04/2025 l'ultima versione è la *Version 1.4.2*.
(Il 19/02/2024 la versione era la *Version 1.4.1*.)

Ci scarica un file *.zip* che scompattiamo.
I files di nostro interesse sono nella cartella `eduport_v1.4.2/template`



## I passaggi per importare il tema Eduport sulla nostra app Rails

Importiamo html
1. Scegliamo una pagina html da importare
2. Creiamo il nuovo layout `empty` in cui mettiamo solo la chiamata alla view
3. Creiamo una pagina su mockups e copiamoci tutto il codice della pagina html
4. Aggiorniamo config/routes.rb
5. Aggiorniamo mockups_controller e indichiamo di usare il layout `empty` nell'azione della nuova pagina creata
6. Adattiamo le chiamate su `<header>...</header>` alla convenzione Ror

Importiamo style e js
7. copiamo i files stylesheets (css, scss) su "assets/stylesheets/edu"
8. copiamo le immagini (png, jpg) su "assets/images/edu"
9. copiamo i files javascripts (js) su "assets/javascripts/edu"
10. su mockups/mypage.html.erb aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts

Refactoring
11. Creiamo il nuovo layout `eduport` su cui **spostiamo** la parte fuori dai tags <body>...</body>
12. Sul mockups_controller nell'azione della nuova pagina creata indichiamo di usare il layout `eduport`


Nel prossimo capitolo iniziamo l'importazione.

---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
