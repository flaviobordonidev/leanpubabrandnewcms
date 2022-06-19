# <a name="top"></a> Cap ajax.1 - Overview

Vediamo la gestiona asincrona di Javascript ed altro.
Questa sezione tratta:

- ajax
- turbo (che ha sostituito turbo_link)
- hotwire
- stimulus


> ajax: AJAX stands for Asynchronous JavaScript and XML. AJAX is a technique for creating better, faster, and more interactive web applications.

> Turbo: Turbo uses complementary techniques to dramatically reduce the amount of custom JavaScript that most web applications will need to write: Turbo Drive accelerates links and form submissions by negating the need for full page reloads.

> hotwire: Hotwire is an alternative approach to building modern web applications without using much JavaScript by sending HTML instead of JSON over the wire.

> [Rails 7.0: Fulfilling a vision](https://rubyonrails.org/2021/12/15/Rails-7-fulfilling-a-vision)
>
>Hotwire’s combination of Turbo and Stimulus deliver all the tools needed to produce fantastic user experiences that leave little to nothing on the table in contrast to single-page applications – at a fraction of the complexity. It’s the default choice for new Rails apps, replacing the far more limited options of Turbolinks and Rails UJS.



## Risorse esterne

Gorails:

- [Refactoring Javascript with Stimulus Values API & Defaults - #423 · November 29, 2021](https://gorails.com/episodes/refactoring-javascript-with-stimulus-values-api-defaults?autoplay=1)
- [How to use Bootstrap with CSS bundling in Rails - #417 · October 11, 2021](https://gorails.com/episodes/bootstrap-css-bundling-rails?autoplay=1)
- [Dynamic Select Fields in Rails with Hotwire - #408 · August 2, 2021](https://gorails.com/episodes/dynamic-select-fields-with-rails-hotwire?autoplay=1)
- [How to use Devise with Hotwire & Turbo.js - #377 · January 1, 2021](https://gorails.com/episodes/devise-hotwire-turbo?autoplay=1)
- [How to use Hotwire in Rails - #376 · December 23, 2020](https://gorails.com/episodes/hotwire-rails?autoplay=1)
- [How to use Hotwire in Rails - Premiered Dec 23, 2020](https://www.youtube.com/watch?v=Qp6sxgjA-xY)

Mix & GO:

- [Hotwire: Reactive Rails Applications Without JavaScript](https://www.youtube.com/watch?v=m5dDxpXKXJM)



## HotWire

Un nuovo approccio per scrivere reactive applications che sono più *server-side* e *html-over-the-wire*.



## Turbo Drive

Rimpiazza il vecchio *turbo_link* e permette di ricaricare la pagina velocemente perché fa il merge dell'*<header>* html e ricarica solo il *<body>*. Inoltre usa alcuni meccanismi di *caching*.

Il browser manda un *request* che è intercettato da Turbo Drive in un *fetch* ed inviato al server...

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/01_fig01-turbo_drive_request.png)

...ed il server risponde con un full document html in cui il <body> è replaced e l'<head> merged.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/01_fig02-turbo_drive_response.png)



## Turbo Frames

Velocizza ancora di più rispetto a *turbo drive* perché **non** ricarica tutto il <body> ma solo le parti racchiuse nei *turbo frames*.

Il browser manda un *request* che è intercettato da Turbo Frames in un *fetch* ed inviato al server...

> questa volta il fetch è della sola parte di codice dentro il *turbo frame*. <br/>
> Attenzione! <br/>
> Viene eseguito **un solo** turbo frame alla volta! quindi, anche se ci sono più turbo frames nella stessa pagina, è elaborato il codice del solo turbo frame che fa partire il request del browser. 

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/01_fig03-turbo_frames_request.png)

...ed il server risponde con il solo nuovo frame.

> Attenzione! <br/>
> Viene rimpiazzato **un solo** turbo frame alla volta!

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/01_fig04-turbo_frames_response.png)



## Turbo Streams

Turbo Frame rimpiazza una sola parte di codice alla volta. Se vogliamo interagire con più parti di codice allora abbiamo bisogno di Turbo Streams.

Turbo Streams ci permette di fare updates nella pagina in molteplici posti. Ossia aggiornare in più punti attraverso ***istruzioni multiple** nel response.

Ad esempio se facciamo submit di un form ed inviamo la fetch/request dal browser al server...

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/01_fig05-turbo_streams_request.png)

...ed il server, invece di rispondere con 1 solo frame, risponde con **istruzioni multiple**: aggiorna il counter, sostituisce quel contenuto ed elimina quell'altro contenuto. Tutto in un'unica response.

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/01_fig06-turbo_streams_response.png)

