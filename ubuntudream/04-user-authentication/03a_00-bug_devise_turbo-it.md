# <a name="top"></a> Cap 3.3 - La domanda fatta al prof. Cezar


Oggetto:
Bug fix: Devise doesn't support turbo_stream

Testo:
Dear Cezar,
to fix the compatibility issue between *devise* and *turbo_stream* you just fix the following one line of code:

***.../config/initializers/devise.rb - line:266***

```ruby
  # config.navigational_formats = ['*/*', :html]
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

In internet I found articles that suggest to make more adjustements:

- [devise-auth-setup-in-rails-7](https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be)
- [Go Rails video](https://gorails.com/episodes/devise-hotwire-turbo)
- [Go Rails: github - initializer/devise](https://github.com/gorails-screencasts/hotwire-devise/blob/master/config/initializers/devise.rb)
- [Go Rails: github - devise_controller](https://github.com/gorails-screencasts/hotwire-devise/blob/master/app/controllers/users/devise_controller.rb)

I've extracted the following recommendations.

***file 01 - .../config/initializers/devise.rb - line:03***

```ruby
# Turbo doesn't work with devise by default.
# Keep tabs on https://github.com/heartcombo/devise/issues/5446 for a possible fix
# Fix from https://gorails.com/episodes/devise-hotwire-turbo
Rails.application.reloader.to_prepare do
  class TurboFailureApp < Devise::FailureApp
    def respond
      if request_format == :turbo_stream
        redirect
      else
        super
      end
    end

    def skip_format?
      %w(html turbo_stream */*).include? request_format.to_s
    end
  end
end
```

***file 01 - .../continue - line:34***

```ruby
  # Configure the parent class to the devise controllers.
  config.parent_controller = 'Users::DeviseController'
```

***file 01 - .../continue - line:266***

```ruby
  # config.navigational_formats = ['*/*', :html]
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

***file 01 - .../continue - line:301***

```ruby
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
```


***file 02 - .../app/controllers/users/devise_controller.rb - linea:01***

```ruby
class Users::DeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
```

Are this recommendation still valid?
Is it better to use them?

Thanks