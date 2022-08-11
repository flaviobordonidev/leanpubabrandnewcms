# Gestiamo i files CSV tramite Paperclip

per gestire gli upload ed i download dei files CSV su rails è meglio usare una gemma specifica tipo:

* refile
* carrierwave
* paperclip
* dragonfly
* shrine

Refile è un moderno "file upload" per applicazioni Ruby. Refile è sviluppato 
dalla stessa persona che ha fatto carrierwave. E' più semplice e più veloce.
Purtroppo su C9 mi da errore la "gem "refile-mini_magick"

Al posto di Refile usiamo Paperclip. Anche Paperclip usa imagemagick ma non da errore con le sue gemme.
Carrierwave sembra preferito a Paperclip ed anche Mikel Hartman lo utilizza però è un sotto capitolo ed usa "fog" per S3
invece Paperclip ho i tutorials con la gemma consigliata direttamente da Amazon (gem 'aws-sdk').
Stanno crescendo anche refile, dragonfly e Shrine (https://twin.github.io/file-uploads-asynchronous-world/)
quindi Paperclip per il momento va benisssimooo.

* https://www.sitepoint.com/uploading-files-with-paperclip/
* https://devcenter.heroku.com/articles/paperclip-s3
* https://github.com/thoughtbot/paperclip/wiki/Paperclip-with-Amazon-S3
* https://github.com/thoughtbot/paperclip
* http://stackoverflow.com/questions/36315596/how-do-i-read-files-in-rails-images-text-from-amazon-s3-that-were-uploaded-m
* https://www.youtube.com/watch?v=0_2VBDoowHs&noredirect=1
* https://aws.amazon.com/sdk-for-ruby/
* https://rubygems.org/gems/aws-sdk

* https://richonrails.com/articles/getting-started-with-paperclip
* http://www.rubydoc.info/gems/paperclip/Paperclip/ClassMethods




# installiamo Paperclip


I> ATTENZIONE!
I>
I> Verifica sempre gli ultimi aggiornamenti sul readme.md di https://github.com/thoughtbot/paperclip

Aggiungiamo la "gem" di ruby:

[codice: 03-04 gemfile 01](#code-03-04-gemfile-01)

{title="Gemfile", lang=ruby, line-numbers=on, starting-line-number=37}
~~~~~~~~
# File Upload
gem 'paperclip'
gem 'aws-sdk', '~> 2.3'
~~~~~~~~

La gemma "mini_magick" ci aiuta con l'integrazione di refile su Rails e 
l'implementazione dell'elaborazione delle immagini. MiniMagick richiede 
ImageMagic installato. Per installarlo su Ubuntu basta eseguire:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo apt-get install imagemagick
~~~~~~~~

Se non funziona eseguire:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo apt-get update
~~~~~~~~

Se neanche questo funziona eseguire:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo add-apt-repository main
~~~~~~~~


Eseguiamo l'installazione della gemma con bundle

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ bundle install
~~~~~~~~




# Creiamo la tabella per i files CSV

I files veri e propri li archiviamo in locale per un primo test e successivamente su amazon S3.
Però uso una tabella per tenere il nome dei files ed il percorso/metodo per gestirli.

Negli esempi di paperclip solitamente si aggiunge un campo image alle tabelle su cui vogliamo inserire immagini.
Nel nostro caso aggiungiamo un campo csvfile ad una tabella in cui volgiamo inserire files CSV.

A titolo d'esempio prendiamo la tabella che gestisce tutti i chioschi per le donazioni, quindi creiamo una tabella che si chiama kiosks.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g scaffold Kiosk serial:string
~~~~~~~~

Aggiungiamo la tabella al database

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~




## Aggiungiamo il campo csvfile al model Kiosk


Usiamo lo script di generazione di Paperclip per creare il migration

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails generate paperclip Kiosk csvfile
~~~~~~~~

questo crea il migrate:

{title="db/migrate/xxx_add_attachment_csvfile_to_kiosks.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddAttachmentCsvfileToKiosks < ActiveRecord::Migration
  def self.up
    change_table :kiosks do |t|
      t.attachment :csvfile
    end
  end

  def self.down
    remove_attachment :kiosks, :csvfile
  end
end
~~~~~~~~

Il metodo "attachment" è introdotto da Paperclip ed aggiunge con un'unica chiamata le seguenti colonne:

* {attachment}_file_name
* {attachment}_file_size
* {attachment}_content_type
* {attachment}_updated_at


Aggiungiamo il campo al database

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rake db:migrate
~~~~~~~~




## Aggiungiamo paperclip csvfile al model

{title="app/models/kiosk.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class Kiosk < ApplicationRecord
    
  # paperclip column
  has_attached_file :csvfile

end
~~~~~~~~




## Aggiungiamo validazione paperclip csvfile al model

Aggiungo la validazione altrimenti ho un errore. questo è stato implementato per aumentare la sicurezza.

{title="app/models/transaction.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class Kiosk < ApplicationRecord

  # paperclip column
  has_attached_file :csvfile
  validates_attachment :csvfile,
                      content_type: { content_type: ["text/plain"] }

end
~~~~~~~~


Nel content_type viene passato un array con i mime types.
come scelgo i mime types?

Quelli più usati sono: ["image/jpeg", "image/gif", "image/png", "text/plain", "application/pdf"]

Di seguito alcuni links con una lista più completa dei mime types:

* https://www.sitepoint.com/web-foundations/mime-types-complete-list/
* http://stackoverflow.com/questions/6554951/validate-extension-in-paperclip-ruby-on-rails
* http://stackoverflow.com/questions/8818251/how-to-validate-file-content-type-to-pdf-word-excel-and-plain-text-for-paperc
* http://stackoverflow.com/questions/26347844/rails-paperclip-file-type-validation-add-pdf




## Aggiungiamo paperclip csvfile al controller


{title="app/controllers/kiosks_controller.rb", lang=ruby, line-numbers=on, starting-line-number=70}
~~~~~~~~
  # Never trust parameters from the scary internet, only allow the white list through.
  def kiosk_params
    params.require(:kiosk).permit(:csvfile, :serial)
  end
~~~~~~~~

I> Note that you only have to permit csvfile, not csvfile_file_name or other fields. Those are used internally by Paperclip.




## Importaimo il file csv manualmente

Aggiungiamo paperclip csvfile al views/kiosks/_form.html.erb (chiamato dall'azione new)

[codice: views 01](#code-csv-04-views-01)

{title="views/kiosks/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=19}
~~~~~~~~
  <div class="field">
    <%= f.label :csvfile %>
    <%= f.file_field :csvfile, class: 'form-control'%>
  </div>
~~~~~~~~

In pratica basta semplicemente aggiungere il campo **f.file_field :csvfile** al form.

I> Se usi Rails 3 devi includere sul metodo **form_for** anche :html => { :multipart => true }.


Aggiungiamo anche una riga sull'index con il nome del file caricato (uploaded)

[codice: views 02](#code-csv-04-views-02)

{title="views/kiosks/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
    <th>CSVfilename</th>
~~~~~~~

{title="views/kiosks/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
    <td><%= transaction.csvfile_file_name %></td>
~~~~~~~

Adesso è tutto pronto per provare paperclip e caricare manualmente un file CSV usando il form new di kiosk.
Il nome sarà sul database ed il file è importato localmente in public/system/kiosks/csvfiles/000/000/001/original/TSC01_transactions.txt




## Importiamo il file csv automaticamente

Creiamo un rake file per importare in automatico

* http://stackoverflow.com/questions/37860251/import-data-from-csv-file-to-postgresql-database-in-rails

