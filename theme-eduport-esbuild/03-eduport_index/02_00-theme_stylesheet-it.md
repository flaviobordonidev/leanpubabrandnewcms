# <a name="top"></a> Cap 2.2 - Attiviamo stile del tema

Attiviamo lo stylesheets.

Possiamo avere due approcci:

- aggiungere piano piano -> copiare un po' di codice alla volta.
- togliere piano piano -> mettere tutto il codice e togliere quello che non usiamo.

Il primo approccio ci fa capire meglio come è strutturato il codice dello stylesheets ma è più complesso da implementare.
Il secondo è più semplice sia come implementazione iniziale che dei successivi upgrade del tema.
Noi scegliamo il secondo approccio.


## Vediamo la cartella *assets* del tema Eduport

Nella documentazione vediamo questa struttura di cartelle/directories dentro il tema Eduport.
Vediamo la struttura dentro la cartella "assets/", che contiene tutti i files degli "assets" (stylesheets e javascripts) che usa il tema.

- `assets/`<br/>
  Includes all assets files, like CSS, Images, JS, SCSS and plugins used in theme
  - `css/`<br/>
    Includes .css file, used in theme
  - `images/`<br/>
    Includes all images, used in .html files.
  - `js/`<br/>
    Includes plugin's initialization file
  - `scss/`<br/>
    Includes all of raw source files that are used to create the final CSS that is included in theme
  - `vendor/`<br/>
    Includes all plugins files.



## Copiamo le sottocartelle di *assets* che ci interessano

Copiamo i files dell'asset_pipeline (stylesheets e javascripts) dal tema Eduport alla nostra applicazione Rails.

copia da                          | incolla in
| :---                            | :---
.../theme_eduport/assets/css/     | *questa cartella **non** la copiamo perché ha i sorgenti già compilati*
.../theme_eduport/assets/images/  | .../app/assets/images/edu/
.../theme_eduport/assets/js/      | *questa carrella la copiamo più avanti*
.../theme_eduport/assets/scss/    | .../app/assets/stylesheets/edu/scss/
.../theme_eduport/assets/vendor/  | .../app/assets/stylesheets/edu/vendor/

> Le varie sottocartelle ***edu/*** le creiamo noi.

Vediamo il risultato finale.

Cartella copiata            | sottocartelle
| :---                      | :---
.../app/assets/images/edu/  | - about <br/> - avatar <br/> - bg <br/> - ... <br/> - logo.svg
.../app/assets/stylesheets/edu/scss/    | - components <br/> - custom <br/> - dark <br/> - ... <br/> - style.scss
.../app/assets/stylesheets/edu/vendor/  | - animate <br/> - aos <br/> - ... <br/> - tiny-slider



## Attiviamo i files stylesheet da usare

Basta importare lo style.css del tema nel nostro file *application.bootstrap.scss*

***code 01 - .../app/assets/stylesheets/application.bootstrap.scss - line:04***

```scss
@import 'edu/scss/style';
```




## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

facendo refresh dell'url `https://192.168.64.3:3000` funziona senza errori.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_fig01-index1.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index style"
```


## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ep
$ git branch -d ep
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-index-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_00-theme_images-it.md)
