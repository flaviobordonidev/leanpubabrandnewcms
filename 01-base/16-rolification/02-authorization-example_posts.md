# <a name="top"></a> Cap 16.2 - Implementiamo le autorizzazioni per example_posts


> DA RIVEDERE. E' PUNDIT CON ALCUNE GESTIONI DI RUOLO USANDO ROLIFY



## Apriamo il branch "Authorization ExamplePost"

```bash
$ git checkout -b aep
```




## Aggiungiamo policy per ExamplePost

Per aggiungere una policy per un modello specifico aggiungiamo il nome del model.

```bash
$ rails g pundit:policy ExamplePost
```

[tutto il codice: Gemfile](#beginning-authentication-authorization-rolification-08b-policies-application_policy.rb)




### Aggiungiamo rolify e resourcify ai models della relazione uno a molti

Oltre la relazione uno-a-molti aggiungiamo la chiamata **resourcify** per permettere alla gemma rolify di creare ruoli basati sui posts

***codice n/a - .../app/models/post.rb - line: 2***

```ruby
  resourcify

  belongs_to :user
```

***codice n/a - ...continua - line: 9***

```
  rolify

  has_many :posts
```




## Aggiungiamo ruolo di amministratore al primo utente

Usando roliy associamo il ruolo ":admin" al primo utente

```bash
$ rails c
> u = User.first
> u.has_role? :admin
# false
> u..add_role :admin
> u.has_role? :admin
# true
```




## Implementiamo policy che autorizza la creazione di un nuovo post solo all'ammministratore

{title=".../app/policies/example_post_policy.rb", lang=ruby, line-numbers=on, starting-line-number=3}
```
class ExamplePostPolicy < ApplicationPolicy
  
  def create?
    @user.admin?
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

```

Non dobbiamo implementare anche **new?** perché su **application_policy** viene impostato di default che **new?** prende le stesse autorizzazioni di **create?**.
Come possiamo vedere nella seguente chiamata:

{title=".../app/policies/application_policy.rb", lang=ruby, line-numbers=on, starting-line-number=21}
```
  def new?
    create?
  end
```



## Implementiamo nel controller

Adesso che la policy di autorizzazione è pronta possiamo indicare all'azione **create** del controller **post** di passare per l'autorizzazione


{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=21}
```
  def new
    @example_post = ExamplePost.new
    authorize @example_post
...

  def create
    @example_post = ExamplePost.new(example_post_params)
    @example_post.user = current_user
    authorize @example_post
...
```




## aggiorniamo git 

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add pundit authorization on action new of example_post"
```




## Completiamo implementando le policies per tutte le azioni rest-full per ExamplePost

Autorizziamo l'index visibile a tutti mentre tutte le altre azioni le può eseguire solo l'amministratore. Inoltre mettiamo un controllo per vedere se è presente un utente loggato. Nel caso in cui nessuno ha fatto login permettere solo la visualizzazione dell'index e vietare tutto il resto.

{title=".../app/policies/example_post_policy.rb", lang=ruby, line-numbers=on, starting-line-number=3}
```
class ExamplePostPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    #@user.present? ? @user.has_role?(:admin) : false
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end
  
  def create?
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end
  
  def update?
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end

  def destroy?
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
```

[tutto il codice: Gemfile](#beginning-authentication-authorization-rolification-08c-policies-example_post_policy.rb)




## Implementiamo nel controller

Adesso che la policy di autorizzazione è pronta possiamo indicare all'azione **create** del controller **post** di passare per l'autorizzazione

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=6}
```
  def index
    @example_posts = ExamplePost.all
    authorize @example_posts
```

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=13}
```
  def show
    authorize @example_post
```

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=18}
```
  def new
    @example_post = ExamplePost.new
    authorize @example_post
```

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=25}
```
  def edit
    authorize @example_post
```

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=31}
```
  def create
    @example_post = ExamplePost.new(example_post_params)
    authorize @example_post
```

{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=49}
```
  def update
    authorize @example_post
```


{title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=64}
```
  def destroy
    authorize @example_post
```

[tutto il codice: Gemfile](#beginning-authentication-authorization-rolification-08d-controllers-example_posts_controller.rb)




## aggiorniamo git 

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add pundit authorization on all actions of example_post"
```




## Messaggio di non autorizzato invece dell'errore

you want to add a standard error message that shows whenever a non-authorized user tries to access a restricted page. To do so, add the following to your ApplicationController.

#app/controllers/application_controller.rb
 
...
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
  private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end






## aggiorniamo git 

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add favorites company_person_maps seeds"
```




## Publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku fcpms:master
$ heroku run rake db:migrate
```

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge fcpms
$ git branch -d fcpms
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```





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
