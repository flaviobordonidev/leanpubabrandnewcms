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

- *[Model].model_name.human*
- *[Model].human_attribute_name("[attribute]")*
- *[Model].human_attribute_name("[attribute].[nested_attribute]")*

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
user_fb:~/environment/bl7_0 (ein) $ rails c
Loading development environment (Rails 7.0.1)
3.1.0 :001 > User.model_name.admin
(irb):1:in `<main>': undefined method `admin' for #<ActiveModel::Name:0x00007f33208caa00 @name="User", @klass=User (call 'User.connection' to establish a connection), @singular="user", @plural="users", @uncountable=false, @element="user", @human="User", @collection="users", @param_key="user", @i18n_key=:user, @route_key="users", @singular_route_key="user"> (NoMethodError)
3.1.0 :002 > User.model_name.human
 => "utente" 
3.1.0 :003 > User.human_attribute_name("role")
 => "ruolo" 
3.1.0 :004 > User.human_attribute_name("role.admin")
 => "amministratore" 
3.1.0 :005 > User.human_attribute_name("role.moderator")
 => "moderatore" 
3.1.0 :006 > 
```

Vediamo come gestire la traduzione

```bash
$ rails c
-> User.roles
-> User.roles.map
-> User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}
-> User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}.to_h
```

> al posto di `xxx.to_h` si può usare `Hash[xxx]`. <br/>
> quindi avremmo avuto `Hash[User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}]`

Esempio:

```bash
3.1.0 :002 > User.roles
 => {"user"=>0, "admin"=>1, "moderator"=>2, "author"=>3} 
3.1.0 :003 > User.roles.map
 => #<Enumerator: ...> 
    #<Enumerator: {"user"=>0, "admin"=>1, "moderator"=>2, "author"=>3}:map> 
3.1.0 :004 > User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}
 => [["user", "utente"], ["admin", "amministratore"], ["moderator", "moderatore"], ["author", "autore"]] 
3.1.0 :005 > User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}.to_h
 => {"user"=>"utente", "admin"=>"amministratore", "moderator"=>"moderatore", "author"=>"autore"} 
3.1.0 :006 > Hash[User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}]
 => {"user"=>"utente", "admin"=>"amministratore", "moderator"=>"moderatore", "author"=>"autore"} 
3.1.0 :007 > 
```



## Inseriamo la traduzione nel view

Ora che conosciamo la definizione e come accedervi possiamo inserirla nel view.

***codice 03 - .../views/users/_form.html.erb - line: 33***

```html+erb
  <div>
    <%= form.label :role %>
    <%#= form.select(:role, User.roles.keys.map {|role| [role.titleize,role]}) %>
    <%= form.select(:role, User.roles.keys.map {|role| [User.human_attribute_name("role.#{role}"), role]}) %>
  </div>
```

oppure visualizzarli come *radio_buttons*.


***codice n/a - .../views/users/_form.html.erb - line: 33***

```html+erb
  <div>
    <%= form.label :role %>
    <%= form.collection_radio_buttons :role, Hash[User.roles.map { |k,v| [k, User.human_attribute_name("role.#{k}")] }], :first, :second %>
  </div>
```

volendo si può creare un helper.


***codice n/a - .../app/helpers/users_helper.rb - line: 33***

```ruby
module UsersHelper
  def h_human_attribute_types
    Hash[User.roles.map { |k,v| [k, User.human_attribute_name("role.#{k}")] }]
  end
end
```

in modo da avere un view più *"dry"*.

***codice n/a - .../views/users/_form.html.erb - line: 33***

```html+erb
  <div>
    <%= form.label :role %>
    <%= form.collection_radio_buttons :role, h_human_attribute_content_types, :first, :second %>
  </div>
```

Un altro modo è quello di creare una variabile virtuale nel Model.



## Creiamo una variabile virtuale nel Model

Vedi virtual attribute con *get_read*, *get_write*, ...

***codice n/a - .../models/user.rb - line: 33***

```ruby
  User.roles.map{ |k,v| [k, User.human_attribute_name("role.#{k}")]}.to_h
```

```ruby
  # def self.human_attribute_enum_value(attr_name, value)
  #   human_attribute_name("#{attr_name}.#{value}")
  # end

  # def human_attribute_enum(attr_name)
  #   self.class.human_attribute_enum_value(attr_name, self[attr_name])
  # end
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Apriamo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ein:main
$ heroku run rails db:migrate
```



## Chiudiamo il branch

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ein
$ git branch -d ein
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04-implement_roles-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/01-enum-i18n-it.md)
