# <a name="top"></a> Cap 10.4 - Impostiamo la lingua dalle preferenze dell'utente

Alle modalità di cambio lingua già impostate nei capitoli precedenti aggiungiamo anche quella di un utente



## Apriamo branch
...



## Aggiungiamo un nuovo campo alla tabella users

migration add column to table users

```bash
$ rails g migration AddLanguageToUsers language:string
```

ed effettuiamo il migrate

```bash
$ rails db:migrate
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

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)

