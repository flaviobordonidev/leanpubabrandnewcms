# Devise



## Risorse interne

- [01-base/07-authentication/04_00-devise-login_logout-it]()
- [01-base/15-authorization/04_00-devise-login_logout-it]()


## Risorse esterne

-[]()



## Visualizziamo la pagina solo se l'utente è presente


***codice n/a - .../app/controllers/users_controller.rb - line: 2***

```ruby
  before_action :authenticate_user!
```
