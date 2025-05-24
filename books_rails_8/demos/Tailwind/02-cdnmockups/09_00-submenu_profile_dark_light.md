# <a name="top"></a> Implementiamo Dark

Introduciamo la parte dark di Tailwind,






Attiviamo la selezione del tema versione scura o versione chiara.
La selezione è fatta nel sottomenu `Profile`.


## Il sottomenu `Profile` sulla barra laterale (PC)

Aggiungiamo il sottomenu `Profile` alla barra laterale, che appare solo su PC.

***Codice 02 - .../app/views/mockups/ud_navbars.html.erb - linea:32***

```html
        <div class="relative" id="profileMenu">
          <a href="#" onclick="toggleProfileMenu(event)" class="hover:bg-gray-700 p-2 rounded flex items-center justify-between">Profile
            <svg class="w-4 h-4 ml-2 transition-transform group-hover:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
            </svg>
          </a>
          <div id="profileSubmenu" class="block bg-gray-700 rounded mt-2 space-y-2 pl-4">
            <a href="#" class="block p-2 hover:bg-gray-600 rounded">AccountSettings</a>
            <a href="#" class="block p-2 hover:bg-gray-600 rounded">Help</a>
            <a href="#" class="block p-2 hover:bg-gray-600 rounded">SignOut</a>
          </div>
        </div>
```



## Il sottomenu `Profile` sulla barra in basso (Mobile)

Aggiungiamo il sottomenu `Profile` alla barra in basso che appare solo su mobile.

***Codice 04 - .../app/views/mockups/ud_navbars.html.erb - linea:32***

```html
      <!-- User Avatar Dropdown -->
      <div class="relative" id="avatarDropdown">
        <button class="focus:outline-none" onclick="toggleDropdown()">
          <img class="h-8 w-8 rounded-full object-cover border border-gray-300 dark:border-gray-600" src="assets/images/avatar/01.jpg" alt="avatar">
        </button>
        <!--<div id="dropdownMenu" class="absolute right-0 mt-2 min-w-[15rem] bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-md shadow-lg hidden z-50">-->
        <div id="dropdownMenu" class="absolute right-0 bottom-full mb-2 min-w-[15rem] bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-md shadow-lg hidden z-50">
          <a href="#" class="block px-4 py-2 text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700">Edit Profile</a>
          <a href="#" class="block px-4 py-2 text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700">Account Settings</a>
          <a href="#" class="block px-4 py-2 text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700">Help</a>
          <a href="#" class="block px-4 py-2 text-sm text-red-600 hover:bg-red-50 dark:hover:bg-red-600 dark:text-red-400">Sign Out</a>
          <hr class="my-2 border-gray-200 dark:border-gray-700">
          <div class="px-4 py-2 text-sm text-gray-700 dark:text-gray-200">Theme</div>
          <div class="flex justify-between items-center px-4 pb-2 gap-2 bg-gray-100 dark:bg-gray-700 rounded-b-md">
            <button onclick="setTheme('light')" class="theme-button flex items-center gap-1 px-2 py-1 rounded hover:bg-gray-200 dark:hover:bg-gray-600"><span>☀️</span><span>Light</span></button>
            <button onclick="setTheme('dark')" class="theme-button flex items-center gap-1 px-2 py-1 rounded hover:bg-gray-200 dark:hover:bg-gray-600"><span>🌙</span><span>Dark</span></button>
            <button onclick="setTheme('auto')" class="theme-button flex items-center gap-1 px-2 py-1 rounded hover:bg-gray-200 dark:hover:bg-gray-600"><span>⚙️</span><span>Auto</span></button>
          </div>
        </div>
      </div>
    </nav>
```


Inseriamo lo script Javascript

```html
    <script>
      function setTheme(theme) {
        if (theme === 'auto') {
          localStorage.removeItem('theme');
          theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        } else {
          localStorage.setItem('theme', theme);
        }
        document.documentElement.classList.remove('light', 'dark');
        //document.documentElement.classList.add(theme);
        console.log("Hello "+theme);
        
      }

      // Evidenzia tema attivo
      const currentTheme = localStorage.getItem('theme') || 'auto';
      document.querySelectorAll('.theme-button').forEach(btn => {
        const btnTheme = btn.textContent.trim().toLowerCase();
        if (btnTheme === currentTheme) {
          btn.classList.add('bg-blue-100', 'text-blue-700', 'font-semibold', 'dark:bg-blue-900', 'dark:text-blue-300');
        } else {
          btn.classList.remove('bg-blue-100', 'text-blue-700', 'font-semibold', 'dark:bg-blue-900', 'dark:text-blue-300');
        }
      });
    </script>
```



## Implementiamo il tema dark anche al resto delle navbars e al main content

Usiamo l'opzione di Tailwind "dark" per inserire lo stile del tema scuro ai vari elementi delle barre di navigazione e del contenuto principale.

...





 la CDN di Tailwind non abilita darkMode: 'class' di default. Per far funzionare il cambio tema con classi dark:* (es. dark:bg-gray-600), devi configurare Tailwind direttamente nel browser, subito dopo lo script della CDN.

```html
 <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Three Navbars Example</title>

  <!-- IMPORTA TAILWIND -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- CONFIGURA IL DARK MODE PER USARE LA CLASSE "dark" -->
  <script>
    tailwind.config = {
      darkMode: 'class',
    }
  </script>
</head>
```

Hai questo nel <head>:

html
Copia
Modifica
<script src="https://cdn.tailwindcss.com"></script>
In questo caso, devi anche configurare Tailwind inline per attivare darkMode: 'class', altrimenti funziona solo media!

Aggiungi subito dopo il tag di import questo codice:

html
Copia
Modifica
<script>
  tailwind.config = {
    darkMode: 'class',
  };
</script>
Quindi il blocco completo diventa:

html
Copia
Modifica
<head>
  ...
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      darkMode: 'class',
    };
  </script>
</head>
Questo è molto probabilmente il problema nel tuo caso!

✅ 5. Ultimo test: prova con un elemento visibile
Metti questo blocco nel <body>:

html
Copia
Modifica
<div class="p-4 bg-white dark:bg-black text-black dark:text-white">
  Tema attivo
</div>
Ora, prova a eseguire dalla console:

js
Copia
Modifica
document.documentElement.classList.add('dark')
Dovresti vedere il blocco cambiare colore in tempo reale. Se sì, allora tutto funziona.

🔁 In sintesi: controlli da fare
Aggiungi tailwind.config = { darkMode: 'class' }; se usi Tailwind via CDN ✅

Accertati che la classe dark venga applicata a <html> ✅

Controlla che le classi dark:* siano nel tuo HTML correttamente ✅

Se usi la CDN, verifica in DevTools che html abbia effettivamente class="dark" ✅

Vuoi che ti prepari una versione minimale funzionante da copiare e incollare per fare un test a parte?




Hai detto:
non ho il file tailwind.config.js perché sto usando     <script src="https://cdn.tailwindcss.com"></script> e non sto usando tailwind configurato su Ruby on Rails.


ChatGPT ha detto:
Perfetto, allora il problema è esattamente quello: la CDN di Tailwind non abilita darkMode: 'class' di default. Per far funzionare il cambio tema con classi dark:* (es. dark:bg-gray-600), devi configurare Tailwind direttamente nel browser, subito dopo lo script della CDN.

✅ Soluzione definitiva
Nel tuo <head>, modifica così:

html
Copia
Modifica
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Three Navbars Example</title>

  <!-- IMPORTA TAILWIND -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- CONFIGURA IL DARK MODE PER USARE LA CLASSE "dark" -->
  <script>
    tailwind.config = {
      darkMode: 'class',
    }
  </script>
</head>
⚠️ Questa configurazione è obbligatoria se usi Tailwind da CDN e vuoi usare document.documentElement.classList.add('dark').

🔁 Poi: rivedi il tuo script setTheme
Il tuo codice può rimanere quello che ti avevo proposto prima, oppure anche più semplice. Ecco una versione base che funziona ora che Tailwind è configurato:

html
Copia
Modifica
<script>
  function setTheme(theme) {
    const root = document.documentElement;
    root.classList.remove('light', 'dark');

    if (theme === 'auto') {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      theme = prefersDark ? 'dark' : 'light';
    }

    root.classList.add(theme);
    localStorage.setItem('theme', theme);

    // evidenzia bottone attivo
    document.querySelectorAll('.theme-button').forEach(btn => {
      const btnTheme = btn.textContent.trim().toLowerCase();
      btn.classList.toggle('bg-blue-100', btnTheme === theme);
      btn.classList.toggle('text-blue-700', btnTheme === theme);
    });
  }

  document.addEventListener('DOMContentLoaded', () => {
    const savedTheme = localStorage.getItem('theme') || 'auto';
    setTheme(savedTheme);
  });
</script>
✅ Testa ora!
Carica la tua pagina.

Clicca su "☀️ Light", "🌙 Dark" o "⚙️ Auto" nel menu dropdown.

Verifica che lo sfondo o i colori cambiino.



## Test minimale per vedere se la classe dark ha effetto

Prova a forzare manualmente il tema in console:
Apri la console del browser (F12).
Esegui:

```javascript
document.documentElement.classList.add('dark')
```

Il background dovrebbe cambiare (ad esempio, se usi dark:bg-gray-600 nel <main> o simili).

Se non succede nulla, allora:
- Le classi dark:bg-... non sono caricate da Tailwind (magari perché non hai incluso il file tailwind.config.js).
- Oppure stai usando Tailwind in versione CDN ma senza opzione darkMode: 'class' (che non è supportata nel CDN di default).