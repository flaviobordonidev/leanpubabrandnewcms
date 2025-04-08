# <a name="top"></a> Cap 18.2 - Vediamo la pagina della lezione

Mettiamo lo style preso dal tema edu nelle views che abbiamo creato.



## Apriamo il branch "Edu Style Lesson"

```bash
$ git checkout -b esl
```



## Steps show

In questa pagina presentiamo di volta in volta un passaggio (step) della lezione (lesson).

- lessons/:id/steps/:id


***Codice 01 - .../app/views/steps/show.html.erb - linea:01***

```html+erb

```


## Layer full_screen

Questa pagina la presentiamo "full-screen", ossia togliamo la barra di navigazione per lasciare più spazio al video. 

> Se l'utente mette il video a schermo intero, quando finisce e sparisce il player e si presenta il form, risulta bloccato se è a schermo intero. Deve uscire da schermo intero per compilare il form.
Essendo tanti piccoli video non è pratico metterli a schermo intero.<br/>
> PROMEMORIA: Cerchiamo l'opzione dello YT player per togliere la possibilità di mettere a schermo intero.

Quindi attiviamo un nuovo layer. Copiamo il `layers/application` e rinominiamo la copia `layers/full_screen`.

Dalla copia commentiamo la chiamata della barra del menu.


***Codice 02 - .../app/views/layers/full_screen.html.erb - linea:01***

```html+erb

```



