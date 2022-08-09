# <a name="top"></a> Cap 8.1 - User profile

Mettiamo lo stile eduport alla gestione dell'utente.
Più specificamente permettere all'utente loggato di modificare il suo profilo.


## Risorse interne

- [01-base/09-manage_users/02_00-users_protected-it.md - Working Around Rails 7’s Turbo]()
- [01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md - Attiviamo upload immagine per il model eg_post]()
- [01-base/02-bootstrap/03-users_layout/03_00-users_add_fields_round_image-it.md - Aggiungiamo i campi Immagine e Bio agli utenti]()




## Risorse esterne

- []()


## Scegliamo la pagina dal tema eduport

Abbiamo selezionato "instructor-edit-profile.html"

***code 01 - eduport_v1.2.0/template/instructor-edit-profile.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_01-instructor-edit-profile.html)




## Progettiamo le colonne per la tabela users

La tabella avrà le seguenti colonne:

* first_name        -> (65 caratteri) il Nome della persona
* last_name         -> (65 caratteri) il Cognome della persona
* username          -> (65 caratteri) il Nome/Nick name mostrato nell'app
* email_id          -> (65 caratteri) l'email con cui fai login
* location          -> (65 caratteri) La nazione dove sei
* bio / about_me    -> (160 caratteri) Una Bio / Una descrizione dell'utente. (Brief description for your profile.)

* profile_image     -> immagine caricata con active_storage su aws S3

* password          -> (65 caratteri) La password

* phone_number      -> (20 caratteri) questo andrebbe nella tabella morphic "telephonable"




## Progettiamo la tabela lessons

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali

Colonna                 | Descrizione
----------------------- | -----------------------
`name:string`           | (255 caratteri) Nome esercizio / aula / lezione  (es: View of mount Vermon, The isle of the death, ...) - Questo appare nelle cards nell'index
`duration:integer`      | Quanto dura l'esercizio in media. (Uso un numero intero che mi rappresenta quanti **minuti** dura. es: 90 minuti, 180 minuti, ...)



## Attiviamo upload immagine per il model user

Implementiamo un campo in cui carichiamo le immagini per i nostri articoli usando *has_one_attached* di active_storage.

***codice 04 - .../app/models/eg_post.rb - line:2***

```ruby
  has_one_attached :header_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_04-models-eg_post.rb)


Ogni volta che facciamo l'upload di un'immagine come *header_image* questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



## Aggiorniamo il controller

Inseriamo il nostro nuovo campo *header_image* nella whitelist.

***codice 05 - .../app/controllers/eg_posts_controller.rb - line: 72***

```ruby
    # Only allow a list of trusted parameters through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :price, :header_image, :user_id)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_05-eg_posts_controller.rb)



## Implementiamo la view

***codice 06 - .../app/views/eg_posts/_form.html.erb - line:40***

```html+erb
  <div class="field">
    <%= form.label :header_image %>
    <%= form.file_field :header_image %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)



Per visualizzare l'immagine basta `image_tag @eg_post.header_image` ma per sicurezza mettiamo anche un controllo.

***codice 07 - .../app/views/eg_posts/_eg_post.html.erb - line:34***

```html+erb
<% if @eg_post.header_image.attached? %>
  <p><%= image_tag @eg_post.header_image %></p>
<% else %>
  <p>Nessuna immagine presente</p>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)

> INFO: non usiamo `.present?` perché darebbe sempre *true*. Per verificare la presenza del file allegato dobbiamo usare `.attached?`.

