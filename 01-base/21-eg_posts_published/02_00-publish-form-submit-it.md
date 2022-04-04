# <a name="top"></a> Cap 21.2 - Implementiamo un check_box per la pubblicazione

Rendiamo possibile pubblicare un articolo con un check-box in modifica (*eg_posts/_form*).



## Risorse interne

- 99-rails_references/data_types/date_time


 
## Verifichiamo dove eravamo rimasti

```bash
$ git status
$ git log
```



## Apriamo il branch "Published Submit"

```bash
$ git checkout -b ps
```



## Aggiorniamo il controller

Torniamo indietro e visualizziamo tutto l'elenco degli articoli.

> Nei prossimi capitoli creeremo due elenchi di articoli uno per gli autori, che include anche i non pubblicati, ed uno per i lettori, che include solo i pubblicati.<br/>
> Ma al momento ci serve vedere tutti gli articoli per permettere di andare in modifica e mettere il segno di spunta per la pubblicazione.

Aggiorniamo l'azione `index` nel controller.

***codice 01 - .../app/controllers/eg_posts_controller.rb - line:9***

```ruby
    @pagy, @eg_posts = pagy(EgPost.all, items: 2)
    #@pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
```

Per passare i valori a `:published` e `:published_at` tramite form abilitiamo i campi nella *whitelist*.<br/>
Aggiorniamo il *metodo privato* `eg_post_params` nel controller.

***codice 01 - ...continua - line:28***

```ruby
    # Only allow a list of trusted parameters through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :price, :header_image, :content, :published, :published_at, :user_id)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/01_02-models-post.rb)

> Su rails 6 il commento era più simpatico: `# Never trust parameters from the scary internet, only allow the white list through.`.



## Aggiorniamo il form

Creiamo il *check_box :published* ed il *text_field :published_at*.

***codice 02 - .../app/views/eg_posts/_form.html.erb - line:29***

```html+erb
  <div class="field">
    <%= form.label :published, class: "control-label" %>
    <%= form.check_box :published, class: "form-control" %>
    <%#= f.check_box :remove_logo, "data-size" => "medium", "data-on-color" => "primary", "data-on-text" => "SI", "data-off-color" => "default", "data-off-text" => "NO" %>
  </div>

  <div class="field">
    <%= form.label :published_at, class: "control-label" %>
    <%= form.text_field :published_at, class: "form-control" %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/02_02-views-eg_posts-_form.html.erb)



## Aggiorniamo index e show

Nella pagina *eg_posts/index* ed *eg_posts/show* aggiungiamo l'indicazione se l'articolo è pubblicato (published) o è ancora una bozza (draft) e quindi non pubblicata (unpublished). Inoltre la aggiungiamo la data di pubblicazione.<br/>
Aggiorniamo il partial.

***codice 03 - .../app/views/eg_posts/_eg_post.html.erb - line:46***

```html+erb
  <p>
    <strong>published:</strong>
    <%= eg_post.published %>
  </p>

  <p>
    <strong>published_at:</strong>
    <%= l eg_post.published_at, format: :my_long if eg_post.published_at.present? %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/02_03-views-eg_posts-_eg_post.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts



## Riempiamo in automatico il campo published_at sul database

Se il campo `published_at` è *nil* e la casella `published` ha il segno di spunta, allora impostiamo in automatico il valore con la data attuale. Se invece la casella `published` non ha il segno di spunta, togliamo la data a `published_at`.

Il seguente codice non funziona.

***codice n/a - .../app/controllers/eg_posts_controller.rb - line:5***

```ruby
    @post.published_at |= Time.now if @post.published == true  
```

Neanche questo.

***codice n/a - .../app/controllers/eg_posts_controller.rb - line:5***

```ruby
    @post.update(published_at: DateTime.current) if @post.published == true and @post.published_at.blank?
```

Visto che lavoriamo sui parametri che vengono passati sul *submit del form* è meglio lavorare su `params`.<br/>
Aggiorniamo l'azione `update` nel controller.

***codice 04 - .../app/controllers/eg_posts_controller.rb - line:46***

```ruby
  def update
    #raise "published è #{params[:post][:published] == "1"} - published_at è #{params[:post][:published_at].blank?} - La data di oggi è #{DateTime.current}"
    # params restituisce una stringa ed il check-box restituisce "1" se flaggato.
    params[:eg_post][:published_at] = "#{DateTime.current}" if params[:eg_post][:published] == "1" and params[:eg_post][:published_at].blank?
    params[:eg_post][:published_at] = "" if params[:eg_post][:published] == "0"
```


Aggiorniamo l'azione `create` nel controller.

***codice 04 - ...continua - line:29***

```ruby
  def create
    # params restituisce una stringa ed il check-box restituisce "1" se flaggato.
    params[:eg_post][:published_at] = "#{DateTime.current}" if params[:eg_post][:published] == "1" and params[:eg_post][:published_at].blank?
    params[:eg_post][:published_at] = "" if params[:eg_post][:published] == "0"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/02_04-controllers-eg_posts_controller.rb)



## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts

Nella pagina edit, sul submit del form:

- se published è flaggato e published_at è vuoto, allora è messa in automatico la data attuale.
- se published è flaggato e published_at ha una data, allora è lasciata quella data.
- se published non è flaggato, allora published_at è automaticamente cancellato



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add published to views/eg_posts with automatic update of published_at"
```



## Pubblichiamo su heroku

```bash
$ git push heroku ps:main
```



## Chiudiamo il branch

Lo chiudiamo nei prossimi capitoli.



## Facciamo un backup su Github

Lo facciamo più avanti


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/01_00-published_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/03_00-virtual_attribute.md)
