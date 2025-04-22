# <a name="top"></a> Aggiungiamo l'autenticazione

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.


## Let's go to production
[24:29 / 30:10]

Authentication is one of the newer features in Rails.

```shell
❯ rails g authentication
```

It basically gives you a default setup for tracking sessions, tracking passwords, and even doing password resets.
What it does not give you is a signup flow, because that's usually quite specific to a given application.
So, we leave that as an exercise for the reader!

But as you can see herem it adds a handful of migrations, one for users, and one for sessions!
So, we're gonna run Rails db:migrate again!


```shell
❯ rails db:migrate
```



# vediamo models session

And then we're going to hop in here and have a look at what was actually generated.
We have the session controller, that's probably the most important.
It allows unauthenticated access to just new and create.
Everything else by default will be behind the authentication lock!
There's also a rate limit to make sure that people don't bombard you with attempts to log into users do not have accesss to.
And then, we do the authentication using the email address and passwords and start a new session from there.

***Codice 01 - .../app/controllers/sessions_controller.rb - linea:1***

```ruby
class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
```

If we hop to the session, you can see it just is very basic Rails actve record.

***Codice 02 - .../app/models/session.rb - linea:1***

```ruby
class Session < ApplicationRecord
  belongs_to :user
end
```

***Codice 03 - .../app/controllers/concerns/authentication.rb - linea:1***

```ruby
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_path
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || root_url
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end
```



## Vediamo seeds

Now, we're gonna set up a default user that the system should have as we're working with it to allow us to log in since we don't have that signup flow.
So that's just gonna be my email address and 123 password!

***Codice 04 - .../db/seeds.rb - linea:10***

```ruby
User.create! email_address: "dhh@hey.com", password: "123"
```

We can hop back into our CLI and run Rails db:seed, that's gonna run the file *.../db/seeds.rb* and set things up.

```shell
❯ rails db:seed
```



## Vediamo nel browser

Restart the development server

```shell
❯ bin/dev
```

Now, if we hop back onto local host and we try to log in 



## Sign out

Now, let's add a way to sign out to the main layout.
We can add that with a button to sign out.

***Codice 05 - .../app/views/layouts/application.html.erb - linea:10***

```ruby
    <%= button_to "Sign out", session_path, method: :delete if authenticated? %>
```

It's gonna hit the session path, and it's gonna use a method of delete to delete that session if we're authenticated, as you can see.
So, it's not gonna show that button if we're not already authenticated, which is good because this layout is also used for login.



## Vediamo nel browser

Restart the development server

```shell
❯ bin/dev
```

Now we have a sign out button.



## Debug

Se non abbiamo definito l'instradamento principale di "root" riceviamo un errore sul log_out perché sessions_controller usa la variabile `root_url`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/01-first_app/10_fig01-authentication_root_url_error.png)

Per risolverlo basta definire l'instradamento di "root".

***Codice 06 - .../config/routes.rb - linea:18***

```ruby
  root "posts#index"
```



## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)
- [Rails 8 Authentication](https://avohq.io/blog/rails-8-authentication)
- [appsignal.com - Pre-build a Secure Authentication Layer - 25-04-16](https://blog.appsignal.com/2025/04/16/pre-build-a-secure-authentication-layer-with-authentication-zero-for-ruby-on-rails.html)

---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
