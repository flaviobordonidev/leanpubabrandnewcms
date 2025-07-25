# <a name="top"></a> Implementiamo Dark

Introduciamo la parte dark di Tailwind,


## Inseriamo il parametro `dark:`

Introduciamo `dark`

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
  <body class="bg-gray-50 dark:bg-gray-800">

    <main>
      <h1 class="bg-yellow-100 text-blue-800 dark:bg-yellow-800 dark:text-blue-100 my-3 mx-6 text-center text-9xl font-extrabold">Hello, world!</h1>
      <div class="bg-yellow-200 dark:bg-yellow-900 mx-2 px-4 py-2">
        <button type="button" class="inline-flex items-center rounded-md bg-blue-50 dark:bg-blue-900 px-2 py-1 text-xs font-medium text-blue-700 dark:text-blue-100 ring-1 ring-blue-700/10 ring-inset">Primary</button>
        <button type="button" class="inline-flex items-center rounded-md bg-gray-50 dark:bg-gray-900 px-2 py-1 text-xs font-medium text-gray-600 dark:text-gray-100 ring-1 ring-gray-500/10 ring-inset">Secondary</button>
        <button type="button" class="inline-flex items-center rounded-md bg-green-50 dark:bg-green-900 px-2 py-1 text-xs font-medium text-green-700 dark:text-green-100 ring-1 ring-green-600/20 ring-inset">Success</button>
        <button type="button" class="inline-flex items-center rounded-md bg-red-50 dark:bg-red-900 px-2 py-1 text-xs font-medium text-red-700 dark:text-red-100 ring-1 ring-red-600/10 ring-inset">Danger</button>
        <button type="button" class="inline-flex items-center rounded-md bg-yellow-50 dark:bg-yellow-900 px-2 py-1 text-xs font-medium text-yellow-800 dark:text-yellow-100 ring-1 ring-yellow-600/20 ring-inset">Warning</button>
      </div>
    </main>

  </body>
</html>
```


## Verifichiamo dark forzando nel browser

Possiamo attivarlo solo cambiando manualmente le impostazioni del browser.

Firefox -> Preferences -> General -> Language and Appearance / Website appearance



## Attiviamo dark da javascript

Per far si che si possa attivare darkmode tramite javascript, siccome stiamo lavorando tramite CDN dobbiamo aggiungere queste linee all'head.

***Codice 02 - .../app/views/cdnmockups/tw_base.html.erb - linea:13***

```html
    <!-- CONFIGURA IL DARK MODE PER USARE LA CLASSE "dark" -->
    <script>
      tailwind.config = {
        darkMode: 'class',
      }
    </script>
```

⚠️ Questa configurazione è obbligatoria se usi Tailwind da CDN e vuoi usare `document.documentElement.classList.add('dark')`.

Adesso possiamo attivare darkmode dalla console del browser (F12) con il seguente javascript

```javascript
document.documentElement.classList.add('dark')
document.documentElement.classList.remove('dark')
document.documentElement.classList.toggle('dark')
document.documentElement.classList.toggle('dark')
```



## Aggiungiamo il comando javascript ad un pulsante

Creaimao il pulsante "Dark" e gli associamo la chiamata javascript che abbiamo usato prima sulla console del browser.

***Codice 03 - .../app/views/cdnmockups/tw_base.html.erb - linea:31***

```html
      <button onclick="document.documentElement.classList.add('dark')"
        class="my-4 mx-6 px-3 py-1 bg-gray-200 dark:bg-gray-700 text-gray-900 dark:text-white rounded">
        Add Dark Mode
      </button>
      <button onclick="document.documentElement.classList.remove('dark')"
        class="my-4 mx-6 px-3 py-1 bg-gray-200 dark:bg-gray-700 text-gray-900 dark:text-white rounded">
        Remove Dark Mode
      </button>
      <button onclick="document.documentElement.classList.toggle('dark')"
        class="my-4 mx-6 px-3 py-1 bg-gray-200 dark:bg-gray-700 text-gray-900 dark:text-white rounded">
        Toggle Dark Mode
      </button>
```



## Risorse esterne

- []()


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
