# <a name="top"></a> Il sottomenu `Profile`

Su `navbar_lateral` e su `navbar_bottom` inseriamo il sotto-menu `Profile`



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

Inseriamo il codice javascript per la chiusura del menu.
Il codice lo inseriamo subito prima della chiusura del `</body>`.

***Codice 03 - .../app/views/mockups/ud_navbars.html.erb - linea:85***

```html
    <script>
      function toggleProfileMenu(event) {
        event.preventDefault();
        const submenu = document.getElementById('profileSubmenu');
        submenu.classList.toggle('hidden');
      }
    </script>
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

    <script>
      const menuToggle = document.getElementById('menuToggle');
      const navMenu = document.getElementById('navMenu');
      menuToggle.addEventListener('click', () => {
        navMenu.classList.toggle('hidden');
      });

      function toggleDropdown() {
        document.getElementById('dropdownMenu').classList.toggle('hidden');
      }

      window.addEventListener('click', function(e) {
        const dropdown = document.getElementById('dropdownMenu');
        const avatar = document.getElementById('avatarDropdown');
        if (!avatar.contains(e.target)) {
          dropdown.classList.add('hidden');
        }
      });

      function setTheme(theme) {
        if (theme === 'auto') {
          localStorage.removeItem('theme');
          theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        } else {
          localStorage.setItem('theme', theme);
        }
        document.documentElement.classList.remove('light', 'dark');
        document.documentElement.classList.add(theme);
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
