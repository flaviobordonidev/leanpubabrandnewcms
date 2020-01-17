# Authorization Authentication Roles

gestiamo l'autorizzazione, l'autenticazione e l'appartenenza ad un ruolo.

Authorization is a requirement for many Rails applications. 
Role-based authorization (  ) is easy to conceptualize and can be added to a User model using 
an Active Record Enum attribute (use the Royce or Rolify gems if access is predicated on more than one assigned role). 
Simple role-based authorization may be all you need. If your controller gets overly complex, switch to Pundit to manage authorization.




## Distinguiamo

Autenticazione è essere in grado di verificare l'identità dell'utente. E' fare accesso/login --> Devise, Authlogic, Clearance
Autorizzazione è chi può fare cosa una volta autenticato. (è dare livelli di accesso differente) --> CanCanCan, Pundit, Authority
Ruolificazione è dare un ruolo ad ogni utente. --> rolify

Per l'Autenticazione scelgo Devise.

Per l'autorizzazione sono indeciso:
La scelta che sembra un poco migliore è Pundit.
CanCan era eccellente ma è stato abbandonato e ripreso da una comunità con CanCanCan.
Comunque entrambe mi sembrano ottime alternative.

https://github.com/CanCanCommunity/cancancan/wiki

*[ruby-toolbox rails_authorization](https://www.ruby-toolbox.com/categories/rails_authorization)

* [sitepoint - Straightforward Rails Authorization with Pundit](https://www.sitepoint.com/straightforward-rails-authorization-with-pundit/)
* [Pundit](https://github.com/elabs/pundit)

*[CanCanCan: The Rails Authorization Dance](https://www.sitepoint.com/cancancan-rails-authorization-dance/)

Episode #188 – Nov 16, 2009 - Declarative Authorization
Episode #192 – Dec 14, 2009 - Authorization with CanCan
Episode #385 – Oct 07, 2012 - Authorization from Scratch Part 1
Episode #386 – Oct 11, 2012 - Authorization from Scratch Part 2


youtube:

* [Rails Authorization With Pundit](https://www.youtube.com/watch?v=qruGD_8ry7k)
* [Codeplace | User Authorization in Ruby on Rails using CanCan](https://www.youtube.com/watch?v=0ZCvLDZQ5HM)





http://stackoverflow.com/questions/35989990/authorization-and-associations-between-user-and-posts

Authentication is being able to verify the identity of the user. This is what Devise solves. This involves logging the user in and out and keeping track of who the current user is.
Authorization is who gets to do what in the application. "User can only create, update and delete HIS OWN comments" is clear cut example of a authorization rule.

https://github.com/RolifyCommunity/rolify

Very simple Roles library without any authorization enforcement supporting scope on resource object.

Let's see an example:

user.has_role?(:moderator, Forum.first)
=> false # if user is moderator of another Forum
This library can be easily integrated with any authentication gem (devise, Authlogic, Clearance) and authorization gem* (CanCanCan, authority)

*: authorization gem that doesn't provide a role class

---

controller
  before_filter :authorize, only: :edit

private

  def authorize
    if current_user && !current_user.admin?
      redirect_to root_url, alert: "Not authorized."
    end
  end

end

Questo funziona ma ha limiti e qualche buco. Spostiamo l'autorizzazione al livello di model.
Iniziamo creando l'oggetto "current_permission"

def current_permission
  @current_permission ||= Permission.new(current_user)
end

def authorize
  if !current_permission.allow?
    ...
  end
end

Dentro il model creo una classe (anche se non eredita da rails)

class Permission < Struct.new(:user)
  def allow?
    user && user.admin?
  end
end



---
