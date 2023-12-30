# <a name="top"></a> Cap video_players 10 - Prepariamo l'ambiente

Prepariamo una nuova app rails con un video su cui installeremo il media player videojs


## Risorse interne

- []()



## Risorse esterne

- [Episode 17 Implementing VideoJs in Ruby on Rails](https://www.youtube.com/watch?v=SRZZuUDDbb8)
- [VideoJS](https://videojs.com/)



## Creiamo nuova app rails


```bash
$ rails --version
$ rails new videojs_test --database=postgresql
```



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT /dev/vda1
```



## Apriamo l'applicazione localmente

Per aprire la nuova applicazione entriamo nella cartella e facciamo partire il web server

```bash
$ cd videojs_test
$ rails s -b 192.168.64.7
```

Nell'url del browser inseriamo: http://192.168.64.7:3000/

Abbiamo un errore di connessione al database che non esiste.



## Verifichiamo connessione

Anche se lo abbiamo già visto nel preview, verifichiamo anche da terminale che non c'è comunicazione con il database.

```bash
$ rails db:migrate
```


## Creiamo i databases

Il nome dei databases lo vediamo nel file `.../config/database.yml`
Creiamo i databases per development e test usando il comando `createdb` di postgreSQL.

```bash
$ sudo service postgresql start
$ createdb videojs_test_development
$ createdb videojs_test_test
```

Sappiamo che sono stati creati perché non abbiamo nessun errore.



## Verifichiamo connessione

```bash
$ rails db:migrate
```

Come per la creazione dei databases, anche per il db:migrate non ho messaggi di conferma sul terminale. Sappiamo che c'è comunicazione perché il comando adesso non da nessun errore.

Ripartiamo con il preview

```bash
$ rails s -b 192.168.64.7
```

Nell'url del browser inseriamo: http://192.168.64.7:3000/

Adesso funziona



## Creiamo la struttura per degli articoli


```bash
$ rails g scaffold article title content
$ rails active_storage:install
$ rails db:prepare
```

> note: Da Rails 6 il comando `rails db:prepare` fa tre azioni in un solo comando:
- `rails db:create` #to create the database
- `rails db:migrate` #to migrate the tables from schema to database
- `rails db:seed` #to seed the data
In questo caso specifico, visto che abbiamo già creato i databases e non abbiamo seeds, è identico a `rails db:migrate`



## Inseriamo la colonna per i files con i video

Nel model inseriamo il campo active_storage per il file del video.

***codice 01 - .../app/models/article.rb - linea:1***

```ruby
class Article < ApplicationRecord
  has_one_attached :video
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Nel controller aggiorniamo "strong parameters"

***codice 02 - .../app/controllers/articles_controller.rb - linea:66***

```ruby
    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :video)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Nel view "_form" aggiungiamo il campo per i "files video"

***codice 03 - .../app/views/articles/_form.html.erb - linea:24***

```html+erb
  <div>
    <%= form.label :video, style: "display: block" %>
    <%= form.file_field :video %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Aggiorniamo gli instradamenti

***codice 04 - .../config/routes.rb - linea:6***

```ruby
  root "articles#index"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Facciamo vedere il video

***codice 05 - .../app/views/articles/show.html.erb - linea:5***

```html+erb
<video>
  <source src="<%= rails_blob_path(@article.video)%>" />
</video>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Ripartiamo con il preview

```bash
$ rails s -b 192.168.64.7
```

Nell'url del browser inseriamo: http://192.168.64.7:3000/

Facciamo clic su nuovo articolo, diamo il titolo, una descrizione ed inseriamo un file video.
Facciamo clic su "salva" e vediamo il risultato.

> nota: su Firefox ho la possibilità col tasto destro di fare play. Invece su google_chrome resta solo l'immagine fissa e non so come farlo partire. Comunque questo lo risolviamo con il media player videojs che installeremo nel prossimo capitolo.
