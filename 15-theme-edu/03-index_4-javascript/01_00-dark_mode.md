# Cambiamo in DarkMode facendo click sul pulsante nella barra del menu



## Risorse esterne

- [localStorage](https://www.w3schools.com/jsref/prop_win_localstorage.asp)
- [Document.documentElement](https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement)
- [HTML DOM Document documentElement](https://www.w3schools.com/jsref/prop_document_documentelement.asp)



## Analizziamo il codice del tema eduport per cambiare su dark mode

prendiamo la pagina index nel menu il pulsante per cambiare in dark mode

***codice 01 - .../app/views/mockups/edu_index.html.erb - line: 583***

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

Nel nostro casu usiamo la key: `data-theme` per archiviare il valore `dark` o il valore `light`.

Inizialmente guardiamo se c'è il valore archiviato ed eventualmente lo prendiamo:

> `theme = localStorage.getItem('data-theme')`

- Se è presente ed è `dark`, allora eseguiamo la funzione `changeThemeToDark()`
- Se non è presente o è `light`, allora eseguiamo la funzione `changeThemeToLight()`


> In queto tema l'eventuale attributo `dir` sul tag `<html>` è usato per i siti con la scrittura da destra a sinistra (rtl) as esempio quelli arabi.

**Vediamo la funzione `changeThemeToDark()`**

Fa tre cose:

- imposta sul tag `<html>` l'attributo `data-theme="dark`
- imposta lo stylesheet a `style-dark-rtl.css` (o `style-dark-rtl.css` nel caso di siti arabi)
- archivia nel `localStorage` del browser la variabile `data-theme` con valore `dark`.


> **Document.documentElement** returns the Element that is the root element of the document. 
> For example for HTML documents: <br>
> `document.documentElement` returns the `<html>` element. <br>
> `document.body` returns the `<body>` element.

Adesso che abbiamo un'idea di come lavora il codice riportiamolo su stimulus



## Introduciamo stimulus

Per cambiare stile da *light* a *dark* usiamo il pulsante sulla barra del menu. Come abbiamo visto non è un link di tipo `<a>` ma è messo tra tags `<div>` quindi inseriamo il richiamo allo *stimulus controller* nel `<li>` che contiene il set di *tags* `<div>`.

> `data-controller="darktheme"` richiama lo *stimulus controller* ***darktheme_controller.js***.

Ed inseriamo l'azione *click* come attributo sul primo `<div>`.

> `data-action="click->darktheme#switch"`

***codice 03 - .../app/views/mockups/edu_index.html.erb - line: 583***

```html
					<!-- Dark mode switch START -->
					<li data-controller="darktheme">
						<div class="modeswitch-wrap" id="darkModeSwitch" data-action="click->darktheme#modeswitch">
							<div class="modeswitch-item">
								<div class="modeswitch-icon"></div>
							</div>
							<span>Dark mode</span>
						</div>
					</li> 
					<!-- Dark mode switch END -->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/03-javascript/01_01-views-mockups-edu_index.html.erb)



***codice 04 - .../app/javascript/controllers/darktheme_controller.js - line: 986***

```javascript
  modeswitch(){
    //console.log("CARALHOOO")
    //let theme = localStorage.getItem('data-theme'); // variabile che tiene in memoria se light o dark
    let theme = document.documentElement.getAttribute("data-theme"); // get <html> attribute
    let darkpath = document.documentElement.getAttribute("data-darkpath") //get <html> attribute
    let lightpath = document.documentElement.getAttribute("data-lightpath") //get <html> attribute
    console.log(lightpath)
    let mystyle = document.getElementById("style-switch"); // su <head> è il link a style.css

    if(theme == null || theme === 'light'){
      document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
      mystyle.setAttribute('href', darkpath);
      //localStorage.setItem("data-theme", "dark") // save theme to local storage
    } else if (theme === 'dark' ) {
      document.documentElement.setAttribute("data-theme", "light") // set theme to dark
      mystyle.setAttribute('href', lightpath);
      //localStorage.setItem("data-theme", "light") // save theme to local storage
    }
  }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/03-javascript/01_01-views-mockups-edu_index.html.erb)


Nel tag `<html>` mettiamo i parametri:

- `data-theme="light"`
- `data-darkpath="<%=stylesheet_path "edu/scss/style-dark.css" %>"`
- `data-lightpath="<%=stylesheet_path "edu/scss/style.css" %>"`

> dobbiamo usare l'helper rails `stylesheet_path` per prendere il percorso che crea l'asset pipe-line di rails. Infatti sul frontend non abbiamo il path lineare *edu/scss/style.css* ma una versione differente che evita problemi di cash durante lo sviluppo. L'elemento principale è un codice numerico aggiunto al nome del file.

***codice 05 - .../app/views/layouts/application.html.erb - line: 1***

```html-erb
<!DOCTYPE html>
<html data-theme="light" data-darkpath="<%=stylesheet_path "edu/scss/style-dark.css" %>" data-lightpath="<%=stylesheet_path "edu/scss/style.css" %>">
  <head>
    <title>Eduport</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= stylesheet_link_tag 'edu/scss/style.css', media: 'all', 'data-turbolinks-track': 'reload', id: 'style-switch' %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

Ricordiamoci di dichiarare gli styleshhets in `app/assets/config/manifest.js`

***codice 06 - .../app/assets/config/manifest.js - line: 6***

```javascript
 //= link edu/scss/style.css
 //= link edu/scss/style-dark.css
```


Con questo codice cambiamo il tema tutte le volte che premiamo il pulsante.
Quello che ci manca è renderlo permanente sul cambio pagina o il refresh del browser.

La cosa migliore è farlo lato rails direttamente sul layout usando il params[] come abbiamo fatto per il mantenimento della lingua (italiano, inglese, portoghese,...)

Ma visto che stiamo lavorando lato javascript possiamo farlo usando la funzione `connect()`

***codice 07 - .../app/javascript/controllers/darktheme_controller.js - line: 986***

```javascript

  connect() {
    //eseguito appena caricato il codice
    let theme = localStorage.getItem('data-theme'); // variabile che tiene in memoria se light o dark
    let darkpath = document.documentElement.getAttribute("data-darkpath") //get <html> attribute
    let lightpath = document.documentElement.getAttribute("data-lightpath") //get <html> attribute
    console.log(theme)
    let mystyle = document.getElementById("style-switch"); // su <head> è il link a style.css

    if(theme == null || theme === 'light'){
      document.documentElement.setAttribute("data-theme", "light") // set theme to dark
      mystyle.setAttribute('href', lightpath);
      //localStorage.setItem("data-theme", "dark") // save theme to local storage
    } else if (theme === 'dark' ) {
      document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
      mystyle.setAttribute('href', darkpath);
      //localStorage.setItem("data-theme", "light") // save theme to local storage
    }
  }

  modeswitch(){
    //console.log("CARALHOOO")
    //let theme = localStorage.getItem('data-theme'); // variabile che tiene in memoria se light o dark
    let theme = document.documentElement.getAttribute("data-theme"); // get <html> attribute
    let darkpath = document.documentElement.getAttribute("data-darkpath") //get <html> attribute
    let lightpath = document.documentElement.getAttribute("data-lightpath") //get <html> attribute
    console.log(lightpath)
    let mystyle = document.getElementById("style-switch"); // su <head> è il link a style.css

    if(theme == null || theme === 'light'){
      document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
      mystyle.setAttribute('href', darkpath);
      localStorage.setItem("data-theme", "dark") // save theme to local storage
    } else if (theme === 'dark' ) {
      document.documentElement.setAttribute("data-theme", "light") // set theme to dark
      mystyle.setAttribute('href', lightpath);
      localStorage.setItem("data-theme", "light") // save theme to local storage
    }
  }
```

Ed in questo caso abbiamo dovuto anche attivare i `localStorage.setItem(...)` nella funzione `modeswitch()`.

Questa non è una soluzione ottimale perché inizia a caricare sempre lo stile *light*, anche quando deve caricare il 'dark'. La correzione è fatta quasi subito, quando arriva alla funzione *connect()*, ma si intravede il cambio di stile. Lavorando direttamente sul layout lato Rails non si avrebbe questo effetto.

Ma questo lo faremo più avanti.
