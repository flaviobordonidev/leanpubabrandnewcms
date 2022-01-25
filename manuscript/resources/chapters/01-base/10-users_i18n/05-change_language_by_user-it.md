# Impostiamo la lingua dalle preferenze dell'utente

Alle modalità di cambio lingua già impostate nei capitoli precedenti aggiungiamo anche quella di un utente




## Apriamo branch
...




## Aggiungiamo un nuovo campo alla tabella users

migration add column to table users


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddLanguageToUsers language:string
```

ed effettuiamo il migrate


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails db:migrate
```




## Abilitiamo il nuovo campo "language" per devise

Permettiamo il passaggio del parametro "language" che con devise è fatto tramite "devise_parameter_sanitizer".
Questa è la sicurezza per il mass-assignment che nei controllers è fatto normalmente con "params.require(:my_model_name).permit(:column1_name, :column2_name)"

{id: "01-06-03_01", caption: ".../app/controllers/appllication_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 19}
```
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

{id: "01-06-03_01", caption: ".../app/controllers/appllication_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 19}
```
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

