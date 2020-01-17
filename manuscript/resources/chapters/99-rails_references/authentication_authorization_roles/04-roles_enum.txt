# Roles -Enum

Questo approccio è semplice e permette di avere più ruoli fissi (es: user, vip, admin) o (es: silver, gold, platinum, diamond).
Questo livello permette di gestire più del 90% delle esigenze delle applicazioni web.

Aggiungiamo i vari ruoli utilizzando un attributo (role attribute). Questo vuol dire aggiungere una colonna "role" di tipo integer sulla tabella "users" e dichiarare l'uso di "enum" sul model User.


Risorse interne:

* 01-base/13-roles/03-roles-enum


Risorse web:

* [articolo lungo vai al paragrafo Implementing Roles - Enum Roles](http://railsapps.github.io/rails-authorization.html)
* [esempio roles](https://github.com/RailsApps/rails-devise-roles/blob/master/app/views/users/_user.html.erb)
* [esempio pundit](https://github.com/RailsApps/rails-devise-pundit/blob/master/app/views/users/_user.html.erb)

* [Ruby on Rails - how to create perfect enum in 5 steps](https://naturaily.com/blog/ruby-on-rails-enum)
* [Ruby on Rails 5.2.0 - Module - ActiveRecord::Enum](https://api.rubyonrails.org/v5.2.0/classes/ActiveRecord/Enum.html)

* [Ruby on Rails: Customize the devise user (Screencast #1)](https://www.youtube.com/watch?v=5inpxIHKhkE)

