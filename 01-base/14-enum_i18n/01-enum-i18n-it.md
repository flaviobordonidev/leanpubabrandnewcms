# <a name="top"></a> Cap 14.1 - enum con internazionalizzazione



## Risorse interne

- [vedi 52-integram-agency-blog - c05-enum_with_i18n - 01-enum_with_i18n]()



## Risorse esterne

- [Easily make enum compatible with i18n without gem in Rails](https://qiita.com/daichirata/items/9495e2548417a4507fec)
- [Rails i18n - How to translate enum of a model](https://stackoverflow.com/questions/43116134/rails-i18n-how-to-translate-enum-of-a-model/43156292)
- [Guida Rails per i18n](http://guides.rubyonrails.org/i18n.html)



## Apriamo il branch "Enum con I18n"

```bash
$ git checkout -b ein
```



## Rendiamo il menu a cascada multilingua (Enum with i18n)

Per impostare la lingua italiana lavoriamo nei files yaml.

Sapendo che i campi del *_form* li ritrovo in *activerecord:* istintivamente ci verrebbe da inserirli sotto *activerecord: -> attributes: -> user: -> role:* mettendo di seguito le varie voci del menu.

***codice n/a - .../config/locales/it.yml - line: 1***

```yaml
  activerecord:
    attributes:
      user:
        role:
          admin: "amministratore"
          author: "autore"
          moderator: "moderatore"
          user: "utente"
```

Invece le voci dell'elenco vanno sotto *user/role:* che è nella *stessa gerarchia del modello* ossia con la stessa indentatura di *user:*.

***codice 01 - .../config/locales/it.yml - line: 33***

```yaml
  activerecord:
    attributes:
      user:
        role: "ruolo"
      user/role:
        admin: "amministratore"
        author: "autore"
        moderator: "moderatore"
        user: "utente"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01_01-config-locales-it.yml)



## Completiamo la traduzione anche in inglese

Per completezza manteniamo allineato anche il file per la traduzione in inglese.

***codice 02 - .../config/locales/en.yml - line: 33***

```yaml
  activerecord:
    attributes:
      user:
        role: "role"
      user/role:
        admin: "administrator"
        author: "author"
        moderator: "moderator"
        user: "user"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01_02-config-locales-en.yml)



## Creiamo i metodi da usare nelle view

Con questa struttura possiamo usare i metodi:

- *<Model>.model_name.human*
- *<Model>.human_attribute_name("<attribute>")*
- *<Model>.human_attribute_name("<attribute>.<nested_attribute>")*

per cercare in modo trasparente le traduzioni per *il modello* e *i nomi degli attributi*. 
Nel caso in cui sia necessario accedere ad attributi nidificati all'interno di un determinato modello, è necessario nidificarli sotto *modello/attributo* a livello di modello nel file di traduzione (*locales/xx.yml*).

```bash
$ rails c
-> User.model_name.human
-> User.human_attribute_name("role")
-> User.human_attribute_name("role.admin")
-> User.human_attribute_name("role.moderator")
```

Esempio:

```bash


2.4.1 :001 > Post.model_name.human
 => "articolo" 
2.4.1 :002 > Post.human_attribute_name(:content_type)
 => "tipologia"
2.4.1 :003 > Post.human_attribute_name("content_type.image")
 => "immagine" 
2.4.1 :004 > Post.human_attribute_name("content_type.video_youtube")
 => "video YouTube"
```

Vediamo come gestire la traduzione

```bash
$ rails c
-> Post.content_types
-> Post.content_types.map
-> Post.content_types.map{ |k,v| [k, Post.human_attribute_name("content_type.#{k}")]}
-> Post.content_types.map{ |k,v| [k, Post.human_attribute_name("content_type.#{k}")]}.to_h

2.4.1 :013 > Post.content_types
 => {"image"=>0, "video_youtube"=>1, "video_vimeo"=>2, "audio"=>3} 
2.4.1 :014 > Post.content_types.map
 => #<Enumerator: {"image"=>0, "video_youtube"=>1, "video_vimeo"=>2, "audio"=>3}:map> 
2.4.1 :015 > Post.content_types.map{ |k,v| [k, Post.human_attribute_name("type.#{k}")]}
 => [["image", "immagine"], ["video_youtube", "video YouTube"], ["video_vimeo", "video Vimeo"], ["audio", "audio"]] 
 2.4.1 :016 > Post.content_types.map{ |k,v| [k, Post.human_attribute_name("type.#{k}")]}.to_h
 => {"image"=>"immagine", "video_youtube"=>"video YouTube", "video_vimeo"=>"video Vimeo", "audio"=>"audio"} 
```

I> al posto di xxx.to_h si poteva usare Hash[xxx]
I>
I> quindi avremmo avuto Hash[Post.content_types.map{ |k,v| [k, Post.human_attribute_name("content_type.#{k}")]}]




## Inseriamo la traduzione nel view

Ora che conosciamo la definizione e come accedervi possiamo inserirli nel view

al posto di 

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
~~~~~~~~
  <div class="field">    
    <%= form.label :content_type %>
    <%= form.select(:content_type, Post.content_types.keys.map {|content_type| [content_type.titleize, content_type]}) %>
  </div>
~~~~~~~~
    
possiamo avere

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
~~~~~~~~
  <div class="field">    
    <%= form.label :content_type %>
    <%= form.select(:content_type, Post.content_types.keys.map {|content_type| [Post.human_attribute_name("content_type.#{content_type}"), content_type]}) %>
  </div>
~~~~~~~~

oppure visualizzarli come radio_buttons

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
~~~~~~~~
  <div class="field">    
    <%= form.label :content_type %>
    <%= form.collection_radio_buttons :content_type, Hash[Post.content_types.map { |k,v| [k, Post.human_attribute_name("content_type.#{k}")] }], :first, :second %>
  </div>
~~~~~~~~

volendo si può creare un helper

{title=".../app/helpers/posts_helper.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
module PostsHelper
  def h_human_attribute_types
    Hash[Post.content_types.map { |k,v| [k, Post.human_attribute_name("content_type.#{k}")] }]
  end
end
~~~~~~~~

in modo da avere un view più "dry"

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=12}
~~~~~~~~
  <div class="field">    
    <%= form.label :content_type %>
    <%= form.collection_radio_buttons :content_type, h_human_attribute_content_types, :first, :second %>
  </div>
~~~~~~~~

Un altro modo è quello di creare una variabile virtuale nel Model.



## Implementiamo nel Model

{title=".../models/post.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~

(vedi virtual attribute con get_read, get_write ....)

  Post.content_types.map{ |k,v| [k, Post.human_attribute_name("content_type.#{k}")]}.to_h
~~~~~~~~

  # def self.human_attribute_enum_value(attr_name, value)
  #   human_attribute_name("#{attr_name}.#{value}")
  # end

  # def human_attribute_enum(attr_name)
  #   self.class.human_attribute_enum_value(attr_name, self[attr_name])
  # end


---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:main
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
