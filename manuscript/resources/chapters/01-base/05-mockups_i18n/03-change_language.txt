{id: 01-base-05-mockups_i18n-03-change_language}
# Cap 5.3 -- Cambiamo la lingua

Per il cambio della lingua (Internazionalizzazione) ci sono varie soluzioni.


Risorse interne:

* 99-rails_references/i18n/01-cheatsheet




## Alcune forme di cambiare la lingua

Possiamo cambiare il nostro locale usando forme differenti

{format: ruby, line-numbers: false}
```
I18n.locale =
              # "en"
              # params[:locale] if params[:locale].present?
              # current_user.locale
              # request.subdomain
              # request.env["HTTP_ACCEPT_LANGUAGE"]
              # request.remote_ip
```

* Passiamo una stringa fissa per la lingua; ad esempio "en". In questo caso è preferibile usare il default_locale come fatto nel capitolo precedente.
* Passiamo la stringa per la lingua tramite " params[:locale] " se questo è presente. Ad esempio " www.miodominio.com?locale=it " per l'italiano o " www.miodominio.com?locale=en " per l'inglese.
* Passiamo la stringa per la lingua tramite un campo dell'utente loggato. In questo caso ogni utente può avere la sua lingua.
* Passiamo la stringa per la lingua attraverso un sottodominio; ad esempio " www.it.miodominio.com " per l'italiano o " www.en.miodominio.com " per l'inglese.
* Passiamo la stringa per la lingua in funzione della lingua impostata nel nostro browser.
* Passiamo la stringa per la lingua in funzione dell'indirizzo IP dell'utente, usando la geo-localizzazione.




## Passiamo la stringa per la lingua come "params"

Passiamo il cambio lingua tramite parameters.
Per cambiare il "locale" uso un before_action sul file application_controller.rb così si ripercuote su tutta l'applicazione.

Implementiamo la multilingua (i18n) passando sull'URL " it " o " en " come parametro " locale ". Per far questo creiamo il parametro " params[:locale] ". Il nome del parametro è ininfluente. Scegliamo " :locale " solo per maggior chiarezza. Questo parametro lo utiliziamo sull'azione che chiamiamo " set_locale " e la mettiamo su " application_controller " così viene eseguita per tutta l'applicazione. Per farla eseguire la richiamiamo dal " before_action ".

I> il before_action sostituisce il before_filter che si usava su Rails 3


{id: "01-05-02_01", caption: ".../app/controllers/application_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class ApplicationController < ActionController::Base
  before_action :set_locale

  #keep internationalization through links
  def default_url_options
    { locale: I18n.locale }
  end

  #-----------------------------------------------------------------------------
  private
  
  #set language for internationalization
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

Se non è presente nessun parametro è utilizzato il " default_locale " che abbiamo già impostato nel capitolo precedente.

Il metodo "default_url_options" si assicura che il "locale" sia incluso nell'url quando usiamo gli "helpers" per gli instradamenti (routes) come "user_path". Altrimenti dovremmo includere il "param" "locale" ogni volta; per esempio "users_url(locale: I18n.locale)".

In passato usavo la seguente riga di codice in "set_locale": "I18n.locale = params[:locale] if params[:locale].present?"
 



## Verifichiamo preview

Attiviamo il database postgresql e facciamo partire il nostro webserver puma su cloud9

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

Visualizziamo sul browser i vari URLs:

* https://mycloud9path.amazonaws.com/mockups/page_a
* https://mycloud9path.amazonaws.com/mockups/page_a?locale=en
* https://mycloud9path.amazonaws.com/mockups/page_a?locale=it




## Implementiamo i links di cambio lingua

Sulla nostra " page_a " inseriamo due links per il cambio della lingua.

{caption: ".../views/mockups/page_a.html.erb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p> <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
<p> <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> </p>
<p> <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> </p>
```




## Salviamo su Git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "set i18n change language on url via params[:locale]"
```




## publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku mi:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge mi
$ git branch -d mi
```
