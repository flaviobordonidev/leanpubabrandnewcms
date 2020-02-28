{id: 01-base-26-eg_posts_published-02-publish-form-submit}
# Cap 26.2 -- Implementiamo un check_box per la pubblicazione

Dentro il partial authors/posts/_form implementiamo un check-box che indica se pubblicato. In seguito possiamo formattare il check-box in stile iphone.
Nella pagina authors/posts/index implementiamo una semplice indicazione se l'articolo è pubblicato (published) o è in bozza (draft).

Per approfondimenti vedi capitolo 99-rails_references/data_types/date_time



 
## Verifichiamo dove eravamo rimasti

{caption: "terminal", format: bash, line-numbers: false}
```
$ git status
$ git log
```




## Apriamo il branch "Published Submit"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b ps
```





## Aggiorniamo il controller

Torniamo indietro sull'azione index e visualizziamo tutto l'elenco degli articoli.
Nei prossimi capitoli creeremo due elenchi di articoli uno per gli autori, che include anche i non pubblicati, ed uno per i lettori, che include solo i pubblicati.
Ma al momento ci serve vedere tutti gli articoli per permettere di andare in modifica e mettere il segno di spunta per la pubblicazione.

{id: "01-26-02_01", caption: ".../app/controllers/eg_posts_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 5}
```
    @pagy, @eg_posts = pagy(EgPost.all, items: 2)
    #@pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
```

Per passare i valori a published e published_at tramite form abilitiamo i campi nella whitelist.

{caption: ".../app/controllers/eg_posts_controller.rb -- continua", format: ruby, line-numbers: true, number-from: 5}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :user_id, :price, :header_image, :content, :published, :published_at)
    end
```

[tutto il codice](#01-26-02_01all)




## Creiamo il check_box "published" ed il text_field "published_at"


{id: "01-26-02_02", caption: ".../app/views/eg_posts/_form.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 29}
```
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

[tutto il codice](#01-26-02_02all)




## Riempiamo in automatico il campo published_at sul database

Se il campo "published_at" è "nil" e la casella "published" ha il segno di spunta, allora impostiamo in automatico il valore con la data attuale. Se invece la casella "published" non ha il segno di spunta, togliamo la data a "published_at".
Visto che lavoriamo sui parametri che vengono passati sul submit del form è meglio lavorare su params.
Aggiorniamo sia l'azione "update" sia l'azione "create" del controller.

{id: "01-26-02_03", caption: ".../app/controllers/eg_posts_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 48}
```
  def update
    #raise "published è #{params[:post][:published] == "1"} - published_at è #{params[:post][:published_at].blank?} - La data di oggi è #{DateTime.current}"
    # params restituisce una stringa ed il check-box restituisce "1" se flaggato.
    params[:eg_post][:published_at] = "#{DateTime.current}" if params[:eg_post][:published] == "1" and params[:eg_post][:published_at].blank?
    params[:eg_post][:published_at] = "" if params[:eg_post][:published] == "0"
```

{caption: ".../app/controllers/eg_posts_controller.rb -- continua", format: ruby, line-numbers: true, number-from: 31}
```
  def create
    # params restituisce una stringa ed il check-box restituisce "1" se flaggato.
    params[:eg_post][:published_at] = "#{DateTime.current}" if params[:eg_post][:published] == "1" and params[:eg_post][:published_at].blank?
    params[:eg_post][:published_at] = "" if params[:eg_post][:published] == "0"
```

[tutto il codice](#01-26-02_03all)



Il seguente codice non funzionerebbe:

{caption: ".../app/controllers/eg_posts_controller.rb -- codice s.n.", format: ruby, line-numbers: true, number-from: 5}
```
    @post.published_at |= Time.now if @post.published == true  
```

e neanche questo:

{caption: ".../app/controllers/eg_posts_controller.rb -- codice s.n.", format: ruby, line-numbers: true, number-from: 5}
```
    @post.update(published_at: DateTime.current) if @post.published == true and @post.published_at.blank?
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts

Nella pagina edit, sul submit del form:

* se published è flaggato e published_at è vuoto, allora è messa in automatico la data attuale.
* se published è flaggato e published_at ha una data, allora è lasciata quella data.
* se published non è flaggato, allora published_at è automaticamente cancellato




## Aggiorniamo index

{id: "01-26-02_04", caption: ".../app/views/eg_posts/index.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 22}
```
      <th>Pubblicato</th>
```

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 38}
```
        <td><%= eg_post.published_at %></td>
```




## Formattiamo il campo data

creiamo l'attributo virtuale "published_at_formatted".
Nel model nella sezione " # == Instance Methods ", sottosezione " ## getter method "

{id: "01-26-02_05", caption: ".../app/models/eg_post.rb -- codice 05", format: ruby, line-numbers: true, number-from: 13}
```
  ## getter method
  def published_at_formatted 
    if published_at.present?
      published_at.strftime('%-d %-b %Y')
      #"Pubblicato il #{published_at.strftime('%-d %-b %Y')}"
    else
      "non pubblicato"
    end
  end
```

Aggiorniamo index

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 38}
```
        <td><%= eg_post.published_at_formatted %></td>
```




## Aggiorniamo show

{id: "01-26-02_06", caption: ".../app/views/eg_posts/show.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 22}
```
<p>
  <strong>Pubblicato:</strong>
  <%= @eg_post.published_at_formatted %>
</p>
```


ATTENZIONE: Come possiamo vedere abbiamo già gestito un modo differente di formattazione della data che ci permette di includere anche l'internazionalizzazione con lingue differenti. Nel prossimo paragrafo implementeremo questo metodo I18n anche per la data di pubblicazione.





## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add published to views/eg_posts with automatic update of published_at"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ps:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ps
$ git branch -d ps
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




