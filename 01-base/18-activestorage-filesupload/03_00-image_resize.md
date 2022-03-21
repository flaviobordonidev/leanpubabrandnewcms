

## Ridimensioniamo l'immagine

Per ridimensionare l'immagine possiamo chiamare il metodo ".variant(...)"

***codice n/a - .../app/views/eg_posts/show.html.erb - line: 62***

```html+erb
  <p><%= image_tag @eg_post.header_image.variant(resize: "400x400") %></p>
```

> Attenzione! per funzionare il *.variand* necessita di minimagic.




## installiamo la gemma di gestione delle immmagini

Fino a rails 5.2 si usava la gemma "mini_magick". La gemma "mini_magick" ci permette la manipolazione delle immagini con un minimo uso di memoria. Questa gemma si appoggia ad  ImageMagick / GraphicsMagick per l'elaborazione delle immagini.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mini_magick)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/minimagick/minimagick)


Ma da rails 6.0 è proposta la gemma "image_processing" quindi usiamo quest'ultima.

- https://bloggie.io/@kinopyo/upgrade-guide-active-storage-in-rails-6

ImageProcessing's advantages:

- The new methods #resize_to_fit, #resize_to_fill, etc also sharpen the thumbnail after resizing.
- Fixes the orientation automatically, no more mistakenly rotated images!
- Provides another backend libvips that has significantly better performance than ImageMagick.
- Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)


> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/image_processing)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/janko/image_processing)


***codice 08 - .../Gemfile - line: 25***

```ruby
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'image_processing', '~> 1.10', '>= 1.10.3'
```

[tutto il codice](#01-18-02_08all)

> In realtà la gemma è già presente nel Gemfile basterebbe solo decommentarla però non è la versione più aggiornata. Quindi lascio la linea commentata ed aggiungo la più aggiornata, così in caso di problemi attivo quella commentata che sappiamo essere stata testata con Rails.

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Installiamo la libreria di backend "imagemagick" su aws Cloud9

ImageProcessing, cosi come faceva MiniMagick, richiede l'installazione di "ImageMagic" come backend. 
Per funzionare image_processing ha bisogno di imagemagick presente, quindi installiamolo su Cloud9. (Per la produzione, Heroku lo installa automaticamente)

> ImageProcessing è anche in grado di gestire il backend "Libvips" che è una nuova libreria più performante ma ad oggi Gennaio 2020 quest'ultima non è supportata da Heroku e quindi non la usiamo.

Visto che abbiamo Ubuntu nella nostra aws Cloud9, usiamo "apt-get".

```bash
$ sudo apt-get install imagemagick
```

Se non funziona eseguire:

```bash
$ sudo apt-get update
$ sudo apt-get install imagemagick
```

Se neanche questo funziona eseguire:

```bash
$ sudo add-apt-repository main
$ sudo apt-get update
$ sudo apt-get install imagemagick
```

> Attenzione! Se avessimo scelto di far girare aws cloud9 su Amazon Linux invece di Ubuntu avremmo dovuto usare "yum" invece di "apt-get".

```bash
$ sudo yum install ImageMagick
```



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
$ git commit -m "Install ActiveStorage and begin implementation with ImageProcessing and ImageMagic"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku asfu:master
$ heroku run rails db:migrate
```

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
