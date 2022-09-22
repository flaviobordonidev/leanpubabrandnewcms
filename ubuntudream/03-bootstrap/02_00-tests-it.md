# <a name="top"></a> Cap 3.2 - Testiamo Bootstrap

Verifichiamo che BootStrap è installato correttamente testando i suoi componenti principali.



## Risorse interne

- []()



## Risorse esterne

- [Rails 7, Bootstrap 5 e importmaps](https://www.youtube.com/watch?v=ZZAVy67YfPY)



## Navbar

Iniziamo dal componente navbar che installa una barra di navigazione.

- [navbar](https://getbootstrap.com/docs/5.2/components/navbar/)

Copiamo ed incolliamo il codice di esempio.

***code 01 - .../app/views/mockups/index.html.erb - line: 1***

```html+erb
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
```

in preview funziona.

```bash
$ rails s -b 192.168.64.3
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig01-navbar1.png)

> Il fatto che si apra il menu a cascata, ed anche il menu "hamburger" quando riduci il browser, significa che la parte javascript di BootStrap sta funzionando.



## Popover

Inseriamo il componente popover che installa un bottone che apre una finestra di messaggio.

- [popover](https://getbootstrap.com/docs/5.2/components/popovers/)

Copiamo ed incolliamo il codice di esempio del bottone.

***code 02 - .../app/views/mockups/index.html.erb - line: 1***

```html+erb
<button type="button" class="btn btn-lg btn-danger" data-bs-toggle="popover" data-bs-title="Popover title" data-bs-content="And here's some amazing content. It's very engaging. Right?">Click to toggle popover</button>
```

Popover usa una parte di codice javascript che è esterna a BootStrap, nello specifico usa popper.
Noi popper lo abbiamo già installato ed è pronto ad essere usato.
Non ci resta che aggiungere la parte di javascript che esegua popper. Questa parte di codice è nella docuementazione BootStrap, un poco più in basso rispetto al codice del bottone.
Copiamo e incolliamo il codice che esegue popper.

***code 03 - .../app/javascript/application.js - line: 1***

```javascript
var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
})
```

> In realtà il codice in alto è stato tolto dalla documentazione di BootStap 5.2 perché è stato sostituito con del codice che utilizza `stimulus`. Ma questo lo vediamo più avanti.


in preview funziona.

```bash
$ rails s -b 192.168.64.3
```

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig03-popover.png)





## Toasts

Inseriamo il componente toasts che installa la comparsa di messaggi di notificazione.

- [popover](https://getbootstrap.com/docs/5.2/components/popovers/)

Copiamo ed incolliamo il codice di esempio del bottone.

***code 04 - .../app/views/mockups/index.html.erb - line: 1***

```html+erb
<button type="button" class="btn btn-primary" id="liveToastBtn">Show live toast</button>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <img src="..." class="rounded me-2" alt="...">
      <strong class="me-auto">Bootstrap</strong>
      <small>11 mins ago</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      Hello, world! This is a toast message.
    </div>
  </div>
</div>
```


Come per il popover, abbiamo bisogno di un po' di codice javascript che dia il comportamento al toasts.

***code 05 - .../app/javascript/application.js - line:13***

```javascript
const toastTrigger = document.getElementById('liveToastBtn')
const toastLiveExample = document.getElementById('liveToast')
if (toastTrigger) {
  toastTrigger.addEventListener('click', () => {
    const toast = new bootstrap.Toast(toastLiveExample)

    toast.show()
  })
}
```

in preview funziona.

```bash
$ rails s -b 192.168.64.3
```

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-bootstrap/02_fig04-toasts.png)

> Il messaggio, in basso a destra, dopo pochi secondi sparisce.
