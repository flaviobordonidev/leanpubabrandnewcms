# <a name="top"></a> Cap 8.3 - enum con internazionalizzazione



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

Sapendo che i campi del *_form* li ritrovo in *activerecord:* istintivamente ci verrebbe da inserirli sotto *activerecord: -> attributes: -> user: -> language:* mettendo di seguito le varie voci del menu.

***codice n/a - .../config/locales/it.yml - line: 1***

```yaml
  activerecord:
    attributes:
      user:
        language:
          it: "Italiano"
          en: "Inglese"
          pt: "Portoghese"
```

Invece le voci dell'elenco vanno sotto ***user/language:*** che è nella *stessa gerarchia del modello* ossia con la stessa indentatura di *user:*.

***codice 01 - .../config/locales/it.yml - line: 33***

```yaml
  activerecord:
    attributes:
      user:
        language: "lingua"
      user/language:
        it: "Italiano"
        en: "Inglese"
        pt: "Portoghese"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01_01-config-locales-it.yml)



## Completiamo la traduzione anche in inglese

Per completezza manteniamo allineato anche il file per la traduzione in inglese.

***codice 02 - .../config/locales/en.yml - line: 33***

```yaml
  activerecord:
    attributes:
      user:
        language: "language"
      user/language:
        it: "Italian"
        en: "English"
        pt: "Portuguese"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01_02-config-locales-en.yml)



## Creiamo i metodi da usare nelle view

Con questa struttura possiamo usare i metodi:

- `[Model].model_name.human`
- `[Model].human_attribute_name("[attribute]")`
- `[Model].human_attribute_name("[attribute].[nested_attribute]")`

per cercare in modo trasparente le traduzioni per *il modello* e *i nomi degli attributi*. 
Nel caso in cui sia necessario accedere ad attributi nidificati all'interno di un determinato modello, è necessario nidificarli sotto *modello/attributo* a livello di modello nel file di traduzione (*locales/xx.yml*).

```bash
$ rails c
> User.model_name.human
> User.human_attribute_name("language")
> User.human_attribute_name("language.it")
> User.human_attribute_name("language.en")
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (lng)$rails c
Loading development environment (Rails 7.0.4)      
3.1.1 :000 > User.model_name.human
 => "utente" 
3.1.1 :001 > User.human_attribute_name("language")
 => "lingua" 
3.1.1 :002 > User.human_attribute_name("language.it")
 => "Italiano" 
3.1.1 :003 > User.human_attribute_name("language.ru")
 => "Ru" 
3.1.1 :004 > User.human_attribute_name("language.pt")
 => "Portoghese" 
3.1.1 :005 > User.human_attribute_name("language.en")
 => "Inglese" 
3.1.1 :006 > I18n.locale = :en
 => :en 
3.1.1 :007 > User.human_attribute_name("language.en")
 => "English" 
3.1.1 :008 > User.human_attribute_name("language.pt")
 => "Portuguese" 
3.1.1 :009 > User.human_attribute_name("language.it")
 => "Italian" 
```

Vediamo come gestire la traduzione

```bash
$ rails c
> User.languages
> User.languages.map
> User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}
> User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}.to_h
```

> al posto di `xxx.to_h` si può usare `Hash[xxx]`. <br/>
> quindi avremmo avuto `Hash[User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}]`

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (lng)$rails c
Loading development environment (Rails 7.0.4)                                         
3.1.1 :001 > User.languages
 => {"it"=>0, "en"=>1, "pt"=>2} 
3.1.1 :002 > User.languages.map
 => #<Enumerator: ...> 
    #<Enumerator: {"it"=>0, "en"=>1, "pt"=>2}:map> 
3.1.1 :003 > User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}
 => [["it", "Italiano"], ["en", "Inglese"], ["pt", "Portoghese"]] 
3.1.1 :004 > User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}.to_h
 => {"it"=>"Italiano", "en"=>"Inglese", "pt"=>"Portoghese"} 
3.1.1 :005 > Hash[User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}]
 => {"it"=>"Italiano", "en"=>"Inglese", "pt"=>"Portoghese"} 
3.1.1 :006 > exit
```



## Inseriamo la traduzione nel view

Ora che conosciamo la definizione e come accedervi possiamo inserirla nel view.

***codice 03 - .../views/users/_form.html.erb - line:42***

```html+erb
  <div>
    <%= form.label :language %>
    <%#= form.select(:language, User.languages.keys.map {|language| [language.titleize,language]}) %>
    <%#= form.select(:language, User.languages.keys.map {|language| [User.human_attribute_name("language.#{language}"), language]}) %>
    <%= form.select :language, User.languages.keys.map {|language| [User.human_attribute_name("language.#{language}"), language]}, {}, class: "form-control" %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01_03-views-users-_form.html.erb)

oppure visualizzarli come *radio_buttons*.


***codice n/a - .../views/users/_form.html.erb - line:42***

```html+erb
  <div>
    <%= form.label :language %>
    <%= form.collection_radio_buttons :language, Hash[User.languages.map { |k,v| [k, User.human_attribute_name("language.#{k}")] }], :first, :second %>
  </div>
```



## Aggiorniamo il controller

Permettiamo di passare la nuova colonna `language`.

***Codice 04 - .../app/controllers/users_controller.rb - linea:42***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:avatar_image, :username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :shown_fields, :role, :language)
    end
```



## Aggiorniamo application controller

***Codice 05 - .../app/controllers/application_controller.rb - linea:42***

```ruby
    #set language for internationalization
    def set_locale
      if current_user.language.present?
        I18n.locale = current_user.language
      else
        # Se non ho assegnato il parametro :locale allora gli passo la lingua impostata sul browser
        # (per testare usa Google chrome Extension: Locale Switcher)
        params[:locale] = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first if params[:locale].blank?
        case params[:locale]
        when "it", "en"
          I18n.locale = params[:locale]
        else
          I18n.locale = I18n.default_locale
        end
      end
    end
```

> questo va bene per ubuntudream ma non per elisinfo, perché la lingua del current_user vince anche sul params[:locale]. Invece params[:locale] deve essere più forte in modo da poter forzare una lingua diversa tramite User Interface se vogliamo provarne una diversa.

> Potrebbe aver senso se vogliamo che la User Interface abbia una traduzione legata all'utente ed invece la scelta cambia la lingua solo alle traduzioni dinamiche (quelle sul database)



## volendo si può creare un helper


***codice n/a - .../app/helpers/users_helper.rb - line:42***

```ruby
module UsersHelper
  def h_human_attribute_types
    Hash[User.languages.map { |k,v| [k, User.human_attribute_name("language.#{k}")] }]
  end
end
```

in modo da avere un view più *"dry"*.

***codice n/a - .../views/users/_form.html.erb - line:42***

```html+erb
  <div>
    <%= form.label :language %>
    <%= form.collection_radio_buttons :language, h_human_attribute_content_types, :first, :second %>
  </div>
```

Un altro modo è quello di creare una variabile virtuale nel Model.



## Creiamo una variabile virtuale nel Model

Vedi virtual attribute con *get_read*, *get_write*, ...

***codice n/a - .../models/user.rb - line:42***

```ruby
  User.languages.map{ |k,v| [k, User.human_attribute_name("language.#{k}")]}.to_h
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
$ rails s -b 192.168.64.3
```

Apriamo il browser sull'URL:

- http://192.168.64.3:3000/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
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



## Pubblichiamo su render.com

Lo fa in automatico prendendo il backup fatto su Github. ^_^



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-languages/04_00-implement_languages-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/01_00-theory-it.md)
