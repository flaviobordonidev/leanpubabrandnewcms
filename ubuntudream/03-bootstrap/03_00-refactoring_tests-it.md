# <a name="top"></a> Cap 3.2 - Refactoring dei Tests

Riportiamo sotto **stimulus** il codice dei tests BootStrap.



## Risorse interne

- []()



## Risorse esterne

- [Rails 7, Bootstrap 5 e importmaps](https://www.youtube.com/watch?v=ZZAVy67YfPY)



## Navbar

Per il navbar non serve refactoring perché usa il javascript incluso in BootStrap



## Popover

Per popover facciamo il refactoring inserendo **stimulus**.

[DAFA]



## Toasts

Per toasts facciamo il refactoring inserendo **stimulus**.
Creiamo uno *stimulus controller* da terminale.

```bash
$ rails g stimulus toast
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (main)$rails g stimulus toast
      create  app/javascript/controllers/toast_controller.js
ubuntu@ubuntufla:~/ubuntudream (main)$
```

Creiamo dentro lo *stimulus controller* il nuovo metodo `notify` in cui inseriamo il codice javascript.

***code 01 - .../app/javascript/controllers/toast_controller.js - line:1***

```javascript
  notify() {
    const toastLiveExample = document.getElementById('liveToast')
    const toast = new bootstrap.Toast(toastLiveExample)
    toast.show()
  }
```

Adesso inseriamo le chiamate *stimulus* nel codice html.

***code 02 - .../app/javascript/controllers/toast_controller.js - line:1***

```html+erb
  <!--<div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">-->
  <div id="liveToast" data-controller="toast" data-action="click->toast#notify" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
```
