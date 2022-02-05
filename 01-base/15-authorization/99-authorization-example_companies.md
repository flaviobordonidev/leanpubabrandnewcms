# Implementiamo le autorizzazioni per example_companies

Saltiamo questo capitolo perché va sviluppato con più calma.

Ampliamo la gestione delle autorizzazioni introducendo anche autorizzazioni di visione o modifica degli articoli a seconda dell'azienda per cui l'utente lavora.




## Apriamo il branch "Authorization ExampleCompanies"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b aec
```




## Scenario articoli aziendali privati

In questo scenario
* Ogni utente che non appartiene a nessuna azienda non può vedere nessun articolo
* Ogni utente con o senza ruolo, che appartiene ad una o più aziende, ha accesso alla lettura di tutti gli articoli delle aziende a cui appartiene
* Ogni utente con ruolo moderatore, che appartiene ad una o più aziende, può modificare tutti gli articoli delle aziende a cui appartiene
* Ogni utente con ruolo autore, che appartiene ad una o più aziende, può modificare solo i suoi articoli delle aziende a cui appartiene

Questo scenario utillizza la tabella example_companies


Per implementare questo scenario dobbiamo prima creare una relazione uno-a-molti tra utente ed azienda. (In questo scenario consideriamo che un utente può lavorare per una sola azienda)




## Aggiungiamo policy per ExampleCompany

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g pundit:policy ExampleCompany


ec2-user:~/environment/myapp (aec) $ rails g pundit:policy ExampleCompany
Running via Spring preloader in process 6341
      create  app/policies/example_company_policy.rb
      invoke  test_unit
      create    test/policies/example_company_policy_test.rb
```

questo crea la seguente policy

{title=".../app/policies/example_company_policy.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class ExampleCompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
```










- if policy(Company).new?
  = link_to 'Nova empresa', new_company_path
  
  
  
- if policy(company).update?
  td = link_to 'Editar', edit_company_path(company)
  
  
  
  
  
  ---

08-authentication-redirect_to_login

# Reinstradamento su login se utente non loggato

Implementiamo la "protezione" di devise che è una restrizione all'accesso. Ossia, decidere a livello di controller quali pagine vengono inviate al login in caso un utente non loggato tenti visualizzarle.




## Proteggiamo il controller users

Forziamo il reinstradamento alla pagina di login per utente non autenticato, eccetto show ed index.

{title=".../app/controllers/users_controller.rb", lang=ruby, line-numbers=on, starting-line-number=60}
```
  before_action :authenticate_user!, except: [:show, :index]
```




## Proteggiamo il controller example_posts

Forziamo il reinstradamento alla pagina di login per utente non autenticato, eccetto index.

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=60}
```
  before_action :authenticate_user!, except: [:index]
```





## Esempio di protezione per una azione non Restful

Abbiamo fatto un buon lavoro finora, ma come fare per restringere l'accesso ad una certa pagina?

Sul controller "pages" invece di una azione restful (index, show, new/create, edit/update), vogliamo restringere l'accesso a chi non è autenticato all'azione "secret".

Anche in questo caso Devise ci viene in aiuto: dobbiamo solo usare il metodo corrispondente come before_action. Per prima cosa, abbiamo bisogno di una pagina speciale da limitare. Chiamiamola "segreto" per semplicità:


config/routes.rb

[...]
get '/secret', to: 'pages#secret', as: :secret
[...]
A dead simple view:

views/pages/secret.html.erb

<% header "Secret!" %>
You don’t even need to add the secret method to the PagesController – Rails will define it implicitly.

Modify the menu a bit:

views/layouts/application.html.erb

[...]
<ul class="nav navbar-nav">
  <li><%= link_to 'Home', root_path %></li>
  <% if user_signed_in? %>
    <li><%= link_to 'Secret', secret_path %></li>
  <% end %>
</ul>
[...]
And now tweak the controller:

pages_controller.rb

[...]
before_action :authenticate_user!, only: [:secret]
[...]






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
