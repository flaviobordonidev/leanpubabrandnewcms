# I Layouts

Mettiamo in piedi un piccolo blog di esempio con vari articoli (*eg_posts*) in modo da avere le strutture principali che possano essere utili per qualsiasi applicazione.

L'applicazione userà 3 temi differenti (tutti basati su bootstrap):

- uno per i lettori che vedono il tema principale del sito: `application.html.erb`
- uno per chi si logga (autori e amministratori) che vede il tema di gestione interna: `dashboard.html.erb`
- uno dedicato alla sola pagina di login: `entrance.html.erb`

> Per completezza citiamo anche il quarto layout che è quello di `mockup.html.erb`




## Layouts *empty* e *mockups*

Creiamo un layout completamente vuoto in modo che non aggiunge nulla al codice che inseriamo nella view.
Questo layout ci è utile nel caso in cui copiamo tutto il codice di una pagina web compresi i tag <html>, <header>, <body>, eccetera.

***codice 01 - .../app/views/layouts/empty.html.erb - line:1***

```html+erb
<%= yield %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/05_01-views-layouts-empty.html.erb)

> Il codice `<%= yield %>` passa tutto il codice presente nel *view*. Se non lo mettiamo nel browser si presente una pagina vuota perché tutto il codice che è nel *view* non viene passato.

> questo file è identico a "mailer.text.erb"

Nel layout *empty* non è attiva tutta la parte *bootstrap*. è solo un layout di "passaggio". Quello che invece usiamo nei nostri *mockups* è una struttura minima di layout che comprenda tutta la parte di *bootstrap*. Chiamiamo questo layout "*mockup*".

***codice 02 - .../app/views/layouts/mockup.html.erb - line:1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>Mockups</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/05_02-views-layouts-mockup.html.erb)


