# <a name="top"></a> Le barre di navigazione

La nostra app è "mobile first" quindi deve funzionare bene sui cellulari prima di tutto e poi impostiamo anche la grafica per PC con monitor più grandi.

Tre barre di navigazione di cui due visualizzate.
- su cellulare abbiamo Barra in alto e Barra in basso
- su pc abbiamo Barra in alto e Barra laterale

Questa struttura è interessante ma nei prossimi capitoli ci sposteremo poi ad una soluzione con solo due barre di navigazione sia su cellulare che su PC; la barra in alto e la barra in basso (non utilizzeremo la barra laterale).



## Iniziamo creando la struttura base

Implementiamo la struttura della DOM nel suo insieme includendo `<header>`, `<main>`, `footer`.
- Su `<header>` inseriamo: `<nav>`.
- Su `<main>` inseriamo le cards (`<article>`).
- Su `<footer>` inseriamo il copyright `<p>`.

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

    <div id="sidebar">
      <nav>...</nav>
      ...
    </div>

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


## Navbars / menu

Nell'applicazione ci sono 3 tipi di menu che sono all'interno delle seguenti barre di navigazione:
- `navbar_top`     (visualizzata sempre)
- `navbar_bottom`  (visualizzata solo su mobile)
- `navbar_lateral` (visualizzata solo su PC)



## Navbars su mobile

Prendendo ispirazione da Airbnb e da DropBox, sul cellulare ho deciso di creare due barre di navigazione, una in alto ed una in basso.

La barra di navigazione in basso (`navbar_bottom`) è quella principale ed ha 5 pulsanti:
- Cerca
- Favoriti
- UbuntuDream (home)
- Messaggi
- Profilo

I primi quattro caricano delle nuove pagine invece il "profilo" apre un sotto menu con i seguenti pulsanti:
- [Foto e nome utente]
- Edit profile
- Account settings
- Help
- Sign out
- [light | dark | auto]


La barra di navigazione in alto (`navbar_top`) invece cambia da pagina a pagina in funzione del contenuto.
Normalmente comunque ha la "barra di ricerca" ed un pulsante per i "filtri".



## Navbars su PC

La barra di navigazione in alto (`navbar_top`) è identica a quella del mobile. (una differenza potrebbe essere quella di avere i filtri già aperti)

La barra di navigazione laterale (`navbar_lateral`) rimpiazza la `navbar_bottom` ed ha la differenza che il pulsante "profilo" è sostituito da un sottomenu a cascata che risulta di default già aperto.



## La view `mockups/ud_navbars`

come abbiamo visto in precedenza nel capitolo xxx abbiamo già creato mockups_controller ed alcune views.
Adesso aggiungiamo la view `mockups/ud_navbars.html.erb`



## Prepariamo le navbars

Prepariamo i 3 tipi di menu ed il contenuto principale

***Codice 01 - .../app/views/mockups/ud_navbars.html.erb - linea:11***

```html
    <!-- Navbar Top (always visible) -->
    <header class="fixed top-0 left-0 right-0 bg-white border-b shadow-md flex justify-around items-center h-16 z-50 lg:ml-64">
```


***Codice 01 - .../app/views/mockups/ud_navbars.html.erb - linea:25***

```html
    <!-- Sidebar Lateral (only desktop) -->
    <aside class="hidden lg:block fixed top-0 left-0 w-64 h-full bg-gray-800 text-white pt-20 p-4">
```


***Codice 01 - .../app/views/mockups/ud_navbars.html.erb - linea:35***

```html
    <!-- Main Content -->
    <main class="mt-18 pt-2 lg:pl-64 mb-18 lg:mb-0 pb-2 container mx-auto px-4">
```


***Codice 01 - .../app/views/mockups/ud_navbars.html.erb - linea:55***

```html
    <!-- Navbar Bottom (only mobile) -->
    <nav class="fixed bottom-0 left-0 right-0 bg-white border-t shadow-lg flex justify-around items-center h-16 lg:hidden">
```

Vediamo come si presentano su Mobile e su PC.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/ubuntudream_tw/02-mockups/02_fig01-ud_mobile_navbars.png)
  
![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/ubuntudream_tw/02-mockups/02_fig02-ud_pc_navbars.png)


Nell'immagine `07_fig92-tw_flex_on_email_button` è meglio usare `flex` invece di `grid` perché ci interessa che il pulsante si *adatti al contenuto*, ossia a quello che c'è scritto dentro. In questo caso "Get a demo". Se domani ci voglio scrivere "Get a free demo", usando `flex` il pulsante si allunga da solo. Se invece usavo grid che succedeva? Boh! è da provare.



## Risorse esterne

- []()


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
