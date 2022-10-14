
# <a name="top"></a> Cap 18.3 - Ridimensioniamo immagini

In questo capitolo attiviamo la possibilità di lavorare con le immagini ed implementiamo il ridimensionamento.



## Risorse esterne

- [Rails guide: Active Storage](https://guides.rubyonrails.org/active_storage_overview.html#transforming-images)
- [upgrade-guide-active-storage-in-rails-6](https://bloggie.io/@kinopyo/upgrade-guide-active-storage-in-rails-6)
- [Resize Images with Active Storage in Rails](https://www.youtube.com/watch?v=pLCYFVd0tFo)



## Ridimensioniamo l'immagine

Per ridimensionare l'immagine possiamo chiamare il metodo `.variant(...)`.

***codice n/a - .../app/views/users/_user.html.erb - line: 62***

```html+erb
  <p><%= image_tag @user.avatar_image.variant(resize: "400x400") %></p>

    <%= image_tag user.avatar.variant(resize_to_limit: [100, 100]) %>

```

> Attenzione! per funzionare il metodo `.variant(...)` necessita di *MiniMagick* o *Vips*.

Non si visualizza l'immagine ma un'icona di immagine rotta e nella log vediamo l'errore: <br/>

```bash
LoadError (Generating image variants require the image_processing gem. Please add `gem 'image_processing', '~> 1.2'` to your Gemfile.):
```

> Da notare che nell'errore sulla log Rails ci suggerisce di installare la gemma *image_processing*.
> Cosa che faremo fra poco.



## MiniMagick o Vips

Active Storage can use either Vips or MiniMagick as the variant processor. The default depends on your config.load_defaults target version, and the processor can be changed by setting config.active_storage.variant_processor.

The two processors are not fully compatible, so when migrating an existing application between MiniMagick and Vips, some changes have to be made if using options that are format specific:

<!-- MiniMagick -->
<%= image_tag user.avatar.variant(resize_to_limit: [100, 100], format: :jpeg, sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 80) %>

<!-- Vips -->
<%= image_tag user.avatar.variant(resize_to_limit: [100, 100], format: :jpeg, saver: { subsample_mode: "on", strip: true, interlace: true, quality: 80 }) %>

> Vantaggi: *Vips* è più recente e più veloce di *MiniMagick* sarebbe la scelta migliore ma...
>
> Svantaggi: *Vips* non è ancora supportato di default su Heroku.

Per evitarci problemi su Heroku scegliamo *MiniMagick*.


> ATTENZIONE! DA RIVEDERE.
> Mi sembra di capire che Rails 7.0 di default usa VIPS

- https://tosbourn.com/vips-rails-7-heroku/

Suppose you’re starting a new project using Rails 7 and ActiveStorage to handle image uploads. In that case, one change you will notice is vips is the standard way we manipulate images now, replacing ImageMagick.


What is vips?
First of all, you might be wondering what vips is. It is an image processing library, so a suite of tools we can use to change images (resize, change colour, etc.).



## installiamo la gemma di gestione delle immmagini

Per gestire *MiniMagick* fino a rails 5.2 si usava la gemma *mini_magick*. 

> [l'ultima versione della gemma](https://rubygems.org/gems/mini_magick)
> è ferma alla versione 4.11.0 del 06 Novembre 2020. <br/>
> La gemma *mini_magick* ci permetteva la manipolazione delle immagini con un minimo uso di memoria. Questa gemma si appoggiava a ImageMagick / GraphicsMagick per l'elaborazione delle immagini. (di seguito il manuale [tutorial github della gemma](https://github.com/minimagick/minimagick))

Da rails 6.0 la scelta di default è *image_processing*. 
Infatti nel gem file la troviamo inserita di default, commentata. 

***codice n/a - .../Gemfile - line:48***

```ruby
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
```

Vantaggi di *ImageProcessing*:

- The new methods #resize_to_fit, #resize_to_fill, etc also sharpen the thumbnail after resizing.
- Fixes the orientation automatically, no more mistakenly rotated images!
- Provides another backend libvips that has significantly better performance than ImageMagick.
- Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)


> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/image_processing)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/janko/image_processing)


***codice 01 - .../Gemfile - line:48***

```ruby
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12', '>= 1.12.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/03_01-gemfile.rb)

> In realtà la gemma è già presente nel Gemfile basterebbe solo decommentarla però non è la versione più aggiornata. <br/>
> Nota: la versione *1.2* è più piccola della versione *1.12* perché le versioni non sono come i numeri decimali; il "." serve solo per dividere le varie sotto versioni.


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Installiamo la libreria di backend "imagemagick" su Ubuntu multipass

ImageProcessing, cosi come faceva MiniMagick, richiede l'installazione di "ImageMagick" come backend. 
Per funzionare image_processing ha bisogno di imagemagick presente, quindi installiamolo su Ubuntu multipass.

> Lato produzione, Heroku lo installa automaticamente.

Visto che abbiamo Ubuntu nella nostra istanza multipass, usiamo *apt*.


> ATTENZIONE DA RIVEDERE!!!
> Sembra che da Rails 7 la libreria di default è "vips" quindi `sudo apt install imagemagick` NON serve.


```bash
$ sudo apt install imagemagick
$ sudo apt install libvips-tools
```

> Curiosamente dobbiamo installare anche la libreria di *Vips*.


Se non funziona eseguire:

```bash
$ sudo apt update
$ sudo apt install imagemagick
$ sudo apt install libvips-tools
```

Se neanche questo funziona eseguire:

```bash
$ sudo add-apt-repository main
$ sudo apt update
$ sudo apt install imagemagick
$ sudo apt install libvips-tools
```



## Verifichiamo lo spazio disco disponibile




## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```
andiamo all'URL:

- https://mycloud9path.amazonaws.com/example_posts/10

verifichiamo che adesso la pagina show visualizza un'immagine di 200x200.


Le tre principali forme di resize sono:

- resize_to_fit: Will downsize the image if it's larger than the specified dimensions or upsize if it's smaller.
- resize_to_limit: Will only resize the image if it's larger than the specified dimensions
- resize_to_fill: Will crop the image in the larger dimension if it's larger than the specified dimensions




## salviamo su git

```bash
$ git add -A
$ git commit -m "Implement ImageProcessing and ImageMagick"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku asfu:main
$ heroku run rails db:migrate
```

> Serve `heroku run rails db:migrate` perché abbiamo cambiato la struttura dela database.


Abbiamo gli avvisi perché ancora non stiamo usando un servizio terzo per archiviare i files

```bash
remote: ###### WARNING:
remote: 
remote:        You set your `config.active_storage.service` to :local in production.
remote:        If you are uploading files to this app, they will not persist after the app
remote:        is restarted, on one-off dynos, or if the app has multiple dynos.
remote:        Heroku applications have an ephemeral file system. To
remote:        persist uploaded files, please use a service such as S3 and update your Rails
remote:        configuration.
remote:        
remote:        For more information can be found in this article:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku
remote:        
remote: 
remote: 
remote: ###### WARNING:
remote: 
remote:        We detected that some binary dependencies required to
remote:        use all the preview features of Active Storage are not
remote:        present on this system.
remote:        
remote:        For more information please see:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku
remote:        
remote: 
remote: 
remote: ###### WARNING:
remote: 
remote:        There is a more recent Ruby version available for you to use:
remote:        
remote:        2.6.5
remote:        
remote:        The latest version will include security and bug fixes, we always recommend
remote:        running the latest version of your minor release.
remote:        
remote:        Please upgrade your Ruby version.
remote:        
remote:        For all available Ruby versions see:
remote:          https://devcenter.heroku.com/articles/ruby-support#supported-runtimes
```

> Nel mio caso con rails 6 riuscivo a farle vedere e dopo alcune ore si corrompevano.
>
> Con rails 7 invece sembra che le carichi ma le visualizza corrottte da subito.

Heroku accetta uploads di immagini direttamente sul suo sito ma è bene attivare un servizio terzo: Amazon S3, Google GCS, Microsoft AzureStorage, Digitalocean, ...
Attenzione. Anche se le immagini heroku le accetta si rischia che queste vengono cancellate dopo un po' di tempo. E comunque occupano del prezioso spazio su Heroku.
es: 
Effettuato l'upload del file "Screen Shot 2018-06-14 at 11.35.28.png" ed è stata caricata su:

https://quiet-shelf-47596.herokuapp.com/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJbWQyWVhKcFlXNTBjeTl6UmxKM2IxYzNjamN4UzNWU2VGcFdXbWQwY2tSdFkwMHZZalZpTkdFMFpXTXhPREF6TW1abU5HRmxNemhrTURaaU5EWmxOV1k1WVRWbE5qQTFOalExWkRNeFpUaGpNbVEzWWpBeU9ESXpaakl4WmpFM09Ua3paZ1k2QmtWVSIsImV4cCI6IjIwMTgtMDYtMjVUMTQ6NDY6MjcuNjkyWiIsInB1ciI6ImJsb2Jfa2V5In19--2d9e91046d31c6045815219e10ec136825b9ae6e/Screen%20Shot%202018-06-14%20at%2011.35.28.png?content_type=image%2Fpng&disposition=inline%3B+filename%3D%22Screen+Shot+2018-06-14+at+11.35.28.png%22%3B+filename%2A%3DUTF-8%27%27Screen%2520Shot%25202018-06-14%2520at%252011.35.28.png

Nel prossimo capitolo attiviamo Amazon Web Service S3.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge asfu
$ git branch -d asfu
```



## Facciamo un backup su Github

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
