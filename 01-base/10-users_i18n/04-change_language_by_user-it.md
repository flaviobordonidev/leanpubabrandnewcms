# <a name="top"></a> Cap 10.4 - Impostiamo la lingua dalle preferenze dell'utente

Alle modalità di cambio lingua già impostate nei capitoli precedenti aggiungiamo anche quella di un utente



## Apriamo branch

continuiamo con lo stesso branch del capitolo precedente



## Progettiamo un nuovo campo per la tabela users

Per assegnare una lingua ad ogni utente inseriamo un nuovo campo enum con le possibili scelte.

> Nel db postgresql si possono implementare dei campi di tipo *enum* ma per attivare la gestione *enum* di Rails usiamo la tipologia "integer" nel db. 
> Implementeremo la gestione del campo con la tipologia *enum* direttamente nel model più avanti in questo capitolo.

Alla tabella aggiungiamo la seguente colonna:

* language        -> (integer) nel nostro caso 0 = "it" e 1 = "en"



## Aggiungiamo il nuovo campo alla tabella users

Migration add column to table users

```bash
$ rails g migration AddLanguageToUsers language:integer
```

Modifichiamo il migrate aggiungendo che il *valore di default* è quello della lingua italiana (ossia "0").

***codice 01 - .../db/migrate/xxx_add_role_to_users.rb - line: 1***

```ruby
    add_column :users, :language, :integer, default: 0
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04_01-xxxx_add_language_to_users.rb)


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```

ed otteniamo la seguente modifica alla tabella *users*.

***codice n/a - .../db/schema.rb - line: 35***

```ruby
    t.integer "language", default: 0
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04_02-db-schema.rb)



## Aggiorniamo il Model implementando ENUM

***codice 02 - .../models/user.rb - line: 3***

```ruby
  #enum language: [:it, :en]
  enum language: {it: 0, en: 1}
```

[tutto il codice](#01-13-03_03all)

Le due linee di codice in alto sono equivalenti solo la seconda linea di codice è più flessibile per eventuali aggiunte o eliminazioni all'elenco.



## Assegnamo una lingua ai nostri utenti da terminale rails

Da terminale: 

- verifichiamo tutti i ruoli presenti nella colonna *language* assegnata ad enum.
- verifichiamo che tutti gli utenti hanno il campo della colonna *language* con il valore di default "0", che tramite *enum* corrisponde al valore "it".


```bash
$ rails c
-> User.languages
-> User.all
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (ui) $ rails c
Loading development environment (Rails 7.0.1)
3.1.0 :001 > User.languages
 => {"it"=>0, "en"=>1} 
3.1.0 :002 > User.all
  User Load (0.6ms)  SELECT "users".* FROM "users"
 =>                                                
[#<User id: 4, name: "David", email: "david@test.abc", created_at: "2022-02-01 16:28:14.397848000 +0000", updated_at: "2022-02-01 16:28:14.397848000 +0000", language: "it">,
 #<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2022-02-01 16:29:06.259332000 +0000", updated_at: "2022-02-01 16:29:06.259332000 +0000", language: "it">,
 #<User id: 7, name: "Flav", email: "flav@test.abc", created_at: "2022-02-01 17:11:04.252571000 +0000", updated_at: "2022-02-01 17:11:04.252571000 +0000", language: "it">,
 #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2022-02-01 16:26:18.569214000 +0000", updated_at: "2022-02-03 10:03:36.219345000 +0000", language: "it">,
 #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-03 12:08:18.378467000 +0000", language: "it">,
 #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2022-02-01 16:27:25.761382000 +0000", updated_at: "2022-02-04 17:19:10.336174000 +0000", language: "it">] 
3.1.0 :003 > 
```



## Assegniamo al primo utente la lingua italiana.

```bash
-> User.first.it!

oppure

-> User.first.update(language: :it)

oppure

-> u= User.first 
-> u.language = :it 
-> u.save 
```






## Abilitiamo il nuovo campo "language" per devise

Permettiamo il passaggio del parametro "language" che con devise è fatto tramite "devise_parameter_sanitizer".
Questa è la sicurezza per il mass-assignment che nei controllers è fatto normalmente con "params.require(:my_model_name).permit(:column1_name, :column2_name)"

***codice 01 - .../app/controllers/appllication_controller.rb - line: 19***

```ruby
  #-----------------------------------------------------------------------------
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role, :name, :language])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :language])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role, :name, :language])
    end
```

[tutto il codice](#01-06-03_01all)

Questo ci permette di aggiungere il campo "language" nei form dell'utente




## Cambiamo lingua da utente

Alle modalità di cambio lingua già impostate nei capitoli precedenti aggiungiamo anche quella di un utente

***codice 01 - .../app/controllers/appllication_controller.rb - line: 19***

```ruby
before_action :set_locale

.
.
.

  #-----------------------------------------------------------------------------
  private
  
    #set language for internationalization
    def set_locale
      if user_signed_in?
        I18n.locale = current_user.language
      else
        I18n.locale = params[:locale] || locale_from_header || I18n.default_locale
      end
    end
  
    def locale_from_header
      request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
    end
```

[tutto il codice](#01-06-03_01all)



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
$ git push heroku ui:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge ui
$ git branch -d ui
```



## Facciamo un backup su Github

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)

