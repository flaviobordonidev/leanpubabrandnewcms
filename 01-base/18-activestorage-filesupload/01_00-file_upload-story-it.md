# <a name="top"></a> Cap 18.1 - Soluzioni Rail per upload immagini



## Risorse interne

- [99-rails_references/active_storage/add_image-upload_file_aws]()


## Risorse esterne

- [Rails 7 adds the ability to use pre-defined variants](https://www.bigbinary.com/blog/rails-7-adds-ability-to-use-predefined-variants)



## Lo scenario prima di Rails 5.2

Prima di Rails 5.2 e della comparsa di ActiveRecord esistevano varie gemme per gestire gli upload ed i download dei files su rails è meglio usare una gemma specifica tipo:

- shrine
- refile
- carrierwave
- paperclip
- dragonfly



## Shrine

Nel 2018 è la scelta migliore perché è organizzato molto bene il codice è leggera e modulare.



## Refile

Refile è un moderno (nel 2017) "file upload" per applicazioni Ruby. Non ha preso molto piede.
Refile è sviluppato dalla stessa persona che ha fatto carrierwave. E' più semplice e più veloce. 
Purtroppo su C9 mi da errore la "gem "refile-mini_magick". Al posto di Refile usiamo Paperclip. Anche Paperclip usa imagemagick ma non da errore con le sue gemme. Carrierwave sembra preferito a Paperclip ed anche Mikel Hartman lo utilizza però è un sotto capitolo ed usa "fog" per S3. Invece per Paperclip ho i tutorials con la gemma consigliata direttamente da Amazon (gem 'aws-sdk'). Stanno crescendo anche refile, dragonfly e Shrine (https://twin.github.io/file-uploads-asynchronous-world/). La documentazione di Dragonfly https://github.com/markevans/dragonfly è minimalista. Molto interessante la documentazione di Shrine https://github.com/janko-m/shrine anche se ha meno persone che contribuiscono ed ha meno commits di dragonfly, ma anche molti meno issues. ^_^



## Paperclip

Paperclip is deprecated.
For new projects, we recommend Rails' own ActiveStorage.



## salviamo su git

Non c'è nulla da salvare.



## Pubblichiamo su Heroku

Non c'è nulla da pubblicare.


## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/03_00-users_pagination-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md)
