# <a name="top"></a> Cap ajax.1 - Overview


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


Altro:

- [Five Turbo Lessons I Learned the Hard Way](https://www.viget.com/articles/five-turbo-lessons-i-learned-the-hard-way/)



## Panoramica sulle gestioni asincrone

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



## Five Turbo Lessons I Learned the Hard Way

1. 
Turbo Stream fragments are server responses (and you don't have to write them by hand).
You don't really need to write any stream markup at all. 
It's cleaner to just use the built-in Rails methods, i.e.

```ruby
render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
```

[Vedi The docs on Turbo Streams on how tu use with rails](https://turbo.hotwired.dev/handbook/streams#streaming-from-http-responses)


2.
Send `:unprocessable_entity` to re-render a form with errors.
For create/update actions, we follow the usual pattern of redirect on success, re-render the form on error. Once you enable Turbo, however, that direct rendering stops working. The solution is to return a 422 status, though we prefer the `:unprocessable_entity` alias (so like render :new, status: :unprocessable_entity). This seems to work well with and without JavaScript and inside or outside of a Turbo frame.

3.
Use data-turbo="false" to break out of a frame
If you have a link inside of a frame that you want to bypass the default Turbo behavior and trigger a full page reload, include the data-turbo="false" attribute (or use data: { turbo: false } in your helper).

Update from good guy Leo: you can also use target="_top" to load all the content from the response without doing a full page reload, which seems (to me, David) what you typically want except under specific circumstances.

4.
Use requestSubmit() to trigger a Turbo form submission via JavaScript
If you have some JavaScript (say in a Stimulus controller) that you want to trigger a form submission with a Turbo response, you can't use the usual submit() method. This discussion thread sums it up well:

It turns out that the turbo-stream mechanism listens for form submission events, and for some reason the submit() function does not emit a form submission event. That means that it’ll bring back a normal HTML response. That said, it looks like there’s another method, requestSubmit() which does issue a submit event. Weird stuff from JavaScript land.

So, yeah, use requestSubmit() (i.e. this.formTarget.requestSubmit()) and you're golden (except in Safari, where you might need this polyfill).

5.
Loading the same URL multiple times in a Turbo Frame
I hit an interesting issue with a form inside a frame: in a listing of comments, I set it up where you could click an edit link, and the content would be swapped out for an edit form using a Turbo Frame. Update and save your comment, and the new content would render. Issue was, if you hit the edit link again, nothing would happen. Turns out, a Turbo frame won’t reload a URL if it thinks it already has the contents of that URL (which it tracks in a src attribute).

The solution I found was to append a timestamp to the URL to ensure it's always unique. Works like a charm.

Update from good guy Joshua: this has been fixed an a recent update.