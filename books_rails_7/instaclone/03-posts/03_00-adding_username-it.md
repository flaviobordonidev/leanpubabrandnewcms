# <a name="top"></a> Cap 1.5 - Aggiungiamo username

Aggiungiamo la colonna `username` alla tabella `users`.



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Adding the username](https://school.mixandgo.com/targets/267)



## Il nuovo campo username

Nella view invece dell'email vogliamo vedere il nome dell'utente.

***code 01 - .../app/views/posts/_post.html.erb - line:4***

```html+erb
    <div><%= post.user.username %></div>
```

Per farlo dobbiamo aggiungere un nuovo campo al database e lo facciamo con un migration.

```bash
$ rails g migration add_username_to_users
```

Aggiorniamo il migrate creato


***code 02 - .../db/migrate/xxx_add_username_to_users.rb - line:1***

```ruby
class AddUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, default: nil
  end
end
```

eseguiamo il migrate

```bash
$ rails db:migrate
```

Inoltre aggiungiamo un *validation* per assicurarci che sia sempre presente.


***code 03 - .../app/models/users.rb - line:9***

```ruby
  validates :username, presence: true
```



## Aggiorniamo anche il *registration* model

Nel view di *devise* registration/new aggiungiamo il campo username

***code 04 - .../app/views/devise/registrations/new.html.erb - line:4***

```html+erb
  <div class="field">
    <%= f.label :username %><br />
    <%= f.text_field :username %>
  </div>
```

> ATTENZIONE: <br/>
> Prima di provarlo nel browser dobbiamo *autorizzare* questo nuovo campo per *devise*, perché *devise* non conosce il campo `username`. Lui conosce solo il campo `email`.

Aggiorniamo l'application controller per *autorizzare* il nuovo campo `username` per *devise*.

***code 05 - .../app/controllers/application_controller.rb - line:2***

```ruby
  before_action :configure_permitted_params, if: :devise_controller?

  protected

    def configure_permitted_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
```

> Usiamo l'helper `devise_parameter_sanitizer` messo a disposizione da *devise*.



## Vediamo Preview

Adesso possiamo vedere il risultato finale nel browser.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08_00-gemfile_ruby_version.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/02_00-inizializziamo_git.md)
