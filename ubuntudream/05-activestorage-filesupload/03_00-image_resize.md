
# <a name="top"></a> Cap 18.3 - Ridimensioniamo immagini

In questo capitolo attiviamo la possibilità di lavorare con le immagini ed implementiamo il ridimensionamento.

## Risorse interne

-[code_reference/image/03_00-image_resize]()



## Risorse esterne

- [Rails guide: Active Storage](https://guides.rubyonrails.org/active_storage_overview.html#transforming-images)



## Ridimensioniamo l'immagine

Per ridimensionare l'immagine possiamo chiamare il metodo `.variant(...)`.

***codice n/a - .../app/views/users/_user.html.erb - line: 62***

```html+erb
    <p><%= image_tag user.avatar_image.variant(resize_to_limit: [100, 100]) %></p>
```

> Attenzione! per funzionare il metodo `.variant(...)` necessita innanzitutto di *image_processing* che a sua volta si appoggia a *Vips* o *MiniMagick*.

Non si visualizza l'immagine ma un'icona di immagine rotta e nella log vediamo l'errore: <br/>

```bash
LoadError (Generating image variants require the image_processing gem. Please add `gem 'image_processing', '~> 1.2'` to your Gemfile.):
```

> Da notare che nell'errore sulla log Rails ci suggerisce di installare la gemma *image_processing*.
> Cosa che facciamo subito.



## installiamo la gemma di gestione delle immmagini

La gemma di gestione consigliata è `image_processing`

Vantaggi di `ImageProcessing`:

- The new methods `#resize_to_fit`, `#resize_to_fill`, etc also sharpen the thumbnail after resizing.
- Fixes the orientation automatically, no more mistakenly rotated images!
- Provides another backend `libvips` that has significantly better performance than `ImageMagick`.
- Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)

Nel gem file la troviamo inserita di default, commentata.

***codice n/a - .../Gemfile - line:48***

```ruby
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
```

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/image_processing)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/janko/image_processing)


***Codice 01 - .../Gemfile - linea:54***

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



## MiniMagick o Vips

Active Storage può usare tanto `Vips` quanto `MiniMagick` per processare il comando `variant`. 

> Noi usiamo *Vips* perché è più recente, è più veloce ed è la scelta di default di Rails 7.

What is vips?
It is an image processing library, so a suite of tools we can use to change images (resize, change colour, etc.).

> Essendo la scelta di default non dobbiamo inserire nulla su `.../config/environments/development.rb`.
> Se invece avessimo voluto usare `MiniMagick` avremmo dovuto aggiungere la riga di codice `config.active_storage.variant_processor = :mini_magick`.



## Installiamo vips

ImageProcessing, richiede l'installazione di "libvips" come backend. 
Installiamo la libreira di backend `vips` nella nostra macchina locale (Ubuntu multipass).

```bash
$ sudo apt install libvips
```

```bash
ubuntu@ubuntufla:~/ubuntudream (asfu)$sudo apt install libvips
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Note, selecting 'libvips42' instead of 'libvips'
libvips42 is already the newest version (8.9.1-2).
libvips42 set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
ubuntu@ubuntufla:~/ubuntudream (asfu)$
```

> Se non dovesse funzionare vedi `code_references/images/03_00-image_resize` dove ci sono altri tentativi da provare.



## Verifichiamo preview

```bash
$ rails s -b 192.168.63.4
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

Nel prossimo capitolo attiviamo Amazon Web Service S3.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
