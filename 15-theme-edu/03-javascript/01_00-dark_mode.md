# Cambiamo in DarkMode facendo click sul pulsante nella barra del menu



## Risorse esterne

- [localStorage](https://www.w3schools.com/jsref/prop_win_localstorage.asp)
- [Document.documentElement](https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement)
- [HTML DOM Document documentElement](https://www.w3schools.com/jsref/prop_document_documentelement.asp)



## Analizziamo il codice del tema eduport per cambiare su dark mode

prendiamo la pagina index nel menu il pulsante per cambiare in dark mode

***codice 08 - .../app/views/mockups/edu_index.html.erb - line: 583***

```html
					<!-- Dark mode switch START -->
					<li>
						<div class="modeswitch-wrap" id="darkModeSwitch">
							<div class="modeswitch-item">
								<div class="modeswitch-icon"></div>
							</div>
							<span>Darku mode</span>
						</div>
					</li> 
					<!-- Dark mode switch END -->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/03-javascript/01_01-views-mockups-edu_index.html.erb)


Analizziamo il codice javascript che viene con il tema. La parte che ci interessa è il *Dark mode*

***codice 02 - .../app/javascript/controllers/tweet_controller.js - line: 986***

```javascript
    // START: 24 Dark mode
    darkMode: function () {

        let theme = localStorage.getItem('data-theme'); // variabile che tiene in memoria se light o dark
        var style = document.getElementById("style-switch"); // su <head> è il link a style.css
        var dir = document.getElementsByTagName("html")[0].getAttribute('dir'); //definisce se è rtl

        var changeThemeToDark = () => {
          document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
          if(dir == 'rtl') {
              style.setAttribute('href', 'assets/css/style-dark-rtl.css');
          } else {
              style.setAttribute('href', 'assets/css/style-dark.css');
          }
          localStorage.setItem("data-theme", "dark") // save theme to local storage
        }

        var changeThemeToLight = () => {
          document.documentElement.setAttribute("data-theme", "light") // set theme light
          if(dir == 'rtl') {
              style.setAttribute('href', 'assets/css/style-rtl.css');
          } else {
              style.setAttribute('href', 'assets/css/style.css');
          }
          
          localStorage.setItem("data-theme", 'light') // save theme to local storage
        }

        if(theme === 'dark'){
          changeThemeToDark()
        } else if (theme == null || theme === 'light' ) {
          changeThemeToLight();
        }

        const dms = e.select('#darkModeSwitch');
        if (e.isVariableDefined(dms)) {
            dms.addEventListener('click', () => {
              let theme = localStorage.getItem('data-theme'); // Retrieve saved them from local storage
              if (theme ==='dark'){
                  changeThemeToLight()
              } else{
                  changeThemeToDark()
              }
            });
        }
    },
    // END: Dark mode
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/03-javascript/01_01-views-mockups-edu_index.html.erb)


Analizziamo il codice:

`localStorage`

The localStorage object allows you to save key/value pairs in the browser.

code                             | Description
-------------------------------- | -----------------------------------------
Save Data to Local Storage       | localStorage.setItem(key, value);
Read Data from Local Storage     | let lastname = localStorage.getItem(key);
Remove Data from Local Storage   | localStorage.removeItem(key);
Remove All (Clear Local Storage) | localStorage.clear();




Quello che fa è vedere se nel tag <html> c'è l'attributo `data-theme` ed eventualmente vedere che valore ha.

> `theme = localStorage.getItem('data-theme')`

Se c'è ed è dark allora usegui la funzione di cambiare in tema dark

> `if(theme === 'dark')` -> `changeThemeToDark()`

Altrimenti esegui la funzione di cambiare in tema light

> `else if (theme == null || theme === 'light')` -> `changeThemeToLight()`


> Document.documentElement returns the Element that is the root element of the document 
> (for example, the <html> element for HTML documents).

- document.documentElement returns the <html> element.
- document.body returns the <body> element








## Introduciamo stimulus

***codice 02 - .../app/javascript/controllers/tweet_controller.js - line: 986***

```javascript

```
