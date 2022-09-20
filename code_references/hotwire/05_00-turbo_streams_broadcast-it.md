# <a name="top"></a> Cap hotwire.5 - Turbo Streams multi-browsers

La funzione pià potente di Turbo Stream è aggiornare in tempo reale più browsers allo stesso tempo.
In pratica attiva un canale "broadcast" su cui si sintonizzano i vari browser e si aggiornano in tempo reale senza dover fare refresh.



## Risorse esterne

- [hotwire inline crud table](bit.ly/inline-crud)
- [install Redis](https://hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-redis-installation-and-configuration/?fbclid=IwAR2slY02VsvA5RIAR6RExTo9WUCrvQSy3kP4-iMUZCj-XYD9rcANjCl_-kY)
- [Install Redis on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04)
- [Install Redis issues](https://stackoverflow.com/questions/52197246/wsl-redis-encountered-system-has-not-been-booted-with-systemd-as-init-system-pi)



## Turbo Streams Broadcast

(Mandiamo messages ad altri browsers)
Questa è la cosa più potente che turbo-stream può fare. 
You can have multiple browsers subscribed to a stream and then you can send messages to all them, from anywhere in your application.  

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/04_fig03-turbo_stream_multiple_browsers.png)

Vediamo come funziona.
We can create a ***subscription to a steam*** by using the helper `turbo_stream_from`.
Invece della tabella sul submit del form aggiorniamo un nuovo <div> a cui diamo l'id "mybroadcasts".

***code 01 - .../app/views/site/first.html.erb - line:3***

```html+erb
  <%= turbo_stream_from "teststr" %>

  <div id="mybroadcasts"><div>
```


```ruby
$ rails c
> Turbo::StreamsChannel.broadcast_update_to("teststr", target: "mybroadcasts", html: "foo")
```

Non funziona e come risposta nella console riceviamo `nil`. 

```ruby
ubuntu@ubuntufla:~/instaclone $rails c
Loading development environment (Rails 7.0.3.1)
3.1.1 :001 > Turbo::StreamsChannel.broadcast_update_to("teststr", target: "mybroadcasts", html: "foo")
  Rendering html template
  Rendered html template (Duration: 0.1ms | Allocations: 19)
[ActionCable] Broadcasting to teststr: "<turbo-stream action=\"update\" target=\"mybroadcasts\"><template>foo</template></turbo-stream>"
 => nil                     
3.1.1 :002 > 
```

Per farlo funzionare dobbiamo attivare `redit`



## Attiviamo *redis* - installiamo le gemme relative

On Mac, Redis is a system service. And on my machine, it's always on.
It should be started if you're using broadcasts. Because they are sent through Redis.

Nella nostra app sul server Ubuntu non era né attivo né installato.

```
ubuntu@ubuntufla:~/instaclone $redis

Command 'redis' not found, did you mean:

  command 'pedis' from deb pev (0.80-4build1)
  command 'redir' from deb redir (3.2-1)

Try: sudo apt install <deb name>
```


I followed the following instructions to setup and configure redis:


In the Gemfile of your Ruby on Rails project, add the following, outside any of the specific groups because they need to be available to all of the Ruby on Rails environments.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/redis)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/redis/redis-rb)

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/redis-namespace)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/resque/redis-namespace)

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/redis-rails)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/redis-store/redis-rails)

***code 02 - .../Gemfile - line: 33***

```ruby
# A Ruby client that tries to match Redis' API one-to-one 
gem 'redis', '~> 4.8'

# Adds a Redis::Namespace class which can be used to namespace calls to Redis
gem 'redis-namespace', '~> 1.9'

# Redis for Ruby on Rails
gem 'redis-rails', '~> 5.0', '>= 5.0.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/05_02-Gemfile.rb)

Eseguiamo l'installazione della gemma con bundle

Now, run the `bundle install` command in order to generate the Gemfile.lock file.

```bash
$ bundle install
```

Esempio:
```bash
ubuntu@ubuntufla:~/instaclone $bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...
Using rake 13.0.6
Using concurrent-ruby 1.1.10
Using i18n 1.12.0
Using minitest 5.16.2
Using tzinfo 2.0.5
Using activesupport 7.0.3.1
Using builder 3.2.4
Using erubi 1.11.0
Using racc 1.6.0
Using nokogiri 1.13.8 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.18.0
Using rails-html-sanitizer 1.4.3
Using actionview 7.0.3.1
Using rack 2.2.4
Using rack-test 2.0.2
Using actionpack 7.0.3.1
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.3.1
Using globalid 1.0.0
Using activejob 7.0.3.1
Using activemodel 7.0.3.1
Using activerecord 7.0.3.1
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.3.1
Using mail 2.7.1
Using digest 3.1.0
Using timeout 0.3.0
Using net-protocol 0.1.3
Using strscan 3.0.4
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.3.1
Using actionmailer 7.0.3.1
Using actiontext 7.0.3.1
Using public_suffix 4.0.7
Using addressable 2.8.0
Using bcrypt 3.1.18
Using bindex 0.8.1
Using msgpack 1.5.4
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.5.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.6.1
Using orm_adapter 0.5.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.0
Using railties 7.0.3.1
Using responders 3.0.1
Using warden 1.2.9
Using devise 4.8.1
Using importmap-rails 1.1.5
Using jbuilder 2.11.5
Using puma 5.6.4
Using rails 7.0.3.1
Fetching redis 4.8.0
Installing redis 4.8.0
Fetching redis-store 1.9.1
Installing redis-store 1.9.1
Fetching redis-rack 2.1.4
Installing redis-rack 2.1.4
Fetching redis-actionpack 5.3.0
Installing redis-actionpack 5.3.0
Fetching redis-activesupport 5.3.0
Installing redis-activesupport 5.3.0
Fetching redis-namespace 1.9.0
Installing redis-namespace 1.9.0
Fetching redis-rails 5.0.2
Installing redis-rails 5.0.2
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.3.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using sqlite3 1.4.4
Using stimulus-rails 1.1.0
Using turbo-rails 1.1.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 19 Gemfile dependencies, 86 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/instaclone $
```



## Installiamo dotenv-rails

In order to easily connect to Redis from our Ruby on Rails application, we are going to additionally use the environment variables management gem, `dotenv-rails` - install it and in your .env file add these three environment variables for development.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/dotenv-rails)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/bkeepers/dotenv)

Mettiamolo all'interno dei gruppi *:development* e *:test*.

***code 02 - .../Gemfile - line: 64***

```ruby
group :development, :test do
  ...
  # Autoload dotenv in Rails.
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/05_03-Gemfile.rb)

> Volendo mettere tutto in un'unica riga di codice potevamo farlo così: <br/>
> `gem 'dotenv-rails', '~> 2.8', '>= 2.8.1', groups: [:development, :test]`

Eseguiamo l'installazione della gemma con bundle

Now, run the `bundle install` command in order to generate the Gemfile.lock file.

```bash
$ bundle install
```

Esempio:

```bash
ubuntu@ubuntufla:~/instaclone $bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...   
Using rake 13.0.6           
Using concurrent-ruby 1.1.10
Using i18n 1.12.0
Using minitest 5.16.2
Using tzinfo 2.0.5
Using activesupport 7.0.3.1
Using builder 3.2.4
Using erubi 1.11.0
Using racc 1.6.0
Using nokogiri 1.13.8 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.18.0
Using rails-html-sanitizer 1.4.3
Using actionview 7.0.3.1
Using rack 2.2.4
Using rack-test 2.0.2
Using actionpack 7.0.3.1
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.3.1
Using globalid 1.0.0
Using activejob 7.0.3.1
Using activemodel 7.0.3.1
Using activerecord 7.0.3.1
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.3.1
Using mail 2.7.1
Using digest 3.1.0
Using timeout 0.3.0
Using net-protocol 0.1.3
Using strscan 3.0.4
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.3.1
Using actionmailer 7.0.3.1
Using actiontext 7.0.3.1
Using public_suffix 4.0.7
Using addressable 2.8.0
Using bcrypt 3.1.18
Using bindex 0.8.1
Using msgpack 1.5.4
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.5.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.6.1
Using orm_adapter 0.5.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.0
Using railties 7.0.3.1
Using responders 3.0.1
Using warden 1.2.9
Using devise 4.8.1
Fetching dotenv 2.8.1
Installing dotenv 2.8.1
Fetching dotenv-rails 2.8.1
Installing dotenv-rails 2.8.1
Using importmap-rails 1.1.5
Using jbuilder 2.11.5
Using puma 5.6.4
Using rails 7.0.3.1
Using redis 4.8.0
Using redis-store 1.9.1
Using redis-rack 2.1.4
Using redis-actionpack 5.3.0
Using redis-activesupport 5.3.0
Using redis-namespace 1.9.0
Using redis-rails 5.0.2
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.3.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using sqlite3 1.4.4
Using stimulus-rails 1.1.0
Using turbo-rails 1.1.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 20 Gemfile dependencies, 88 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```


create `.env` file in the main project root and add:

***code 04 - .../.env - line:1***

```
REDIS_DB=0
REDIS_URL=redis://127.0.0.1
REDIS_PORT=6379
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/05_04-.env)

those are the default host and port of every Redis installation.

Next, we are going to tell our Ruby on Rails application to connect to Redis upon booting by creating the dedicated initializer.

Create `redis.rb` file in `config/initializers` and add:

***code 05 - .../config/initializers/redis.rb - line:1***

```ruby
# frozen_string_literal: true

Redis.current = Redis.new(url:  ENV['REDIS_URL'],
                          port: ENV['REDIS_PORT'],
                          db:   ENV['REDIS_DB'])
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/05_04-.env)

As you can see, in our environment we have separated the Redis URL and DB variables. Concatenated, they result in the Redis host, and it is how Ruby on Rails Action Cable uses them. Open its configuration and change it to the following.

***config/cable.yml***

```yml
development:
  #adapter: async
  adapter: redis
​
test:
  adapter: test
​
production:
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") %>/<%= ENV.fetch("REDIS_DB") %>
  channel_prefix: app_production
```

​
I personally like to keep the development environment as close to the production one as possible in order to catch any bugs at the earliest stage.

To do that, you might consider changing the development Action Cable configuration to the same as production one - this way while writing your Ruby on Rails application's code and running it locally, you will use Redis as well.

> Se proviamo ad attivare il `rails s -b 192.168.64.3` otteniamo un errore di connessione a redis: <br/>
> *Error connecting to Redis on 127.0.0.1:6379 (Errno::ECONNREFUSED) (Redis::CannotConnectError)* <br/>
> perché non abbiamo installato redis su ubuntu multipass.



## Installiamo redis su ubuntu multipass

Step 1 — Installing and Configuring Redis
In order to get the latest version of Redis, we will use apt to install it from the official Ubuntu repositories.

First, update your local apt package cache if you haven’t done so recently:

```bash
$ sudo apt update
```

Then, install Redis by typing:

```bash
$ sudo apt install redis-server
```

This will download and install Redis and its dependencies. Following this, there is one important configuration change to make in the Redis configuration file, which was generated automatically during the installation.

Open this file with your preferred text editor:

```
$ sudo nano /etc/redis/redis.conf
```

Inside the file, find the `supervised` directive. This directive allows you to declare an init system to manage Redis as a service, providing you with more control over its operation. The supervised directive is set to no by default. Since you are running Ubuntu, which uses the systemd init system, change this to `systemd`.

***code n/a - /etc/redis/redis.conf - line:n/a***

```
# If you run Redis from upstart or systemd, Redis can interact with your
# supervision tree. Options:
#   supervised no      - no supervision interaction
#   supervised upstart - signal upstart by putting Redis into SIGSTOP mode
#   supervised systemd - signal systemd by writing READY=1 to $NOTIFY_SOCKET
#   supervised auto    - detect upstart or systemd method based on
#                        UPSTART_JOB or NOTIFY_SOCKET environment variables
# Note: these supervision methods only signal "process is ready."
#       They do not enable continuous liveness pings back to your supervisor.
supervised systemd
```

That’s the only change you need to make to the Redis configuration file at this point, so save and close it when you are finished. Then, restart the Redis service to reflect the changes you made to the configuration file:

```bash
$ sudo systemctl restart redis.service
```

With that, you’ve installed and configured Redis and it’s running on your machine. Before you begin using it, though, it’s prudent to first check whether Redis is functioning correctly.

Se il comando sopra non funziona puoi usare quest'altro.

```bash
$ sudo service redis-server start
```

> If you wonder, "how would you know that the service name was 'redis-server'?" You can see them using `service --status-all`.

Adesso possiamo far partire il server rails: `rails s -b 192.168.64.3`



## Verifichiamo preview

Su una sessione di teminale attiviamo il *server rails*.

```bash
$ rails s -b 192.168.64.3
```

Apriamo due browsers differenti, o due sessioni dello stesso browser, sullo stesso url:

- http://192.168.64.3:3000/site/first

> questi si connetteranno alla nostra stessa stringa `teststr` di turbo-stream. 

Apriamo una nuova sessione di teminale ed attiviamo la *rails console*.
Da questa rails console mandiamo broadcast sulla `teststr` la stringa html: "foo"

```ruby
$ rails c
> Turbo::StreamsChannel.broadcast_update_to("teststr", target: "mybroadcasts", html: "foo")
```

Questa volta funziona! ^_^

In figura 1 si vedono due browsers che puntano alla stessa pagina e sono "in linea" sullo *stream broadcast* `teststr`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/05_fig01-broadcast-example1_1.png)

In figura 2 abbiamo lanciato da un'altro terminale la stringa `html: "foo"` tramite `rails console`.
Ed entrambi i browser si sono automaticamente aggiornati senza necessità di fare un refresh.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/05_fig02-broadcast-example1_2.png)


E se funziona dalla rails console, funziona anche da qualsiasi altra parte. 

> da notare che abbiamo usato un "html" payload ma possiamo anche usare *partials* o *json* objects, or anything else that can be rendered.



## Usiamo un Model nel broadcast

Generiamo il Model *Post* con il solo attributo *title*.

```bash
$ rails g model Post title
$ rails db:migrate
```

Dentro il model inseriamo una `after_create` callback che attiva il nostro broadcast "teststr".

Inside the model we can add an `after_create` callback that calls `broadcast_update_to` with a "teststr" stream and a "mybroadcasts" id, as the target.  
And we can call the broadcasting method without the model prefix because Active Record already includes the broadcasts module.

***code xx - .../app/models/post.rb - line:1***

```ruby
class Post < ApplicationRecord
  after_create_commit do
    broadcast_update_to("teststr",
      target: "broadcasts",
      html: "Post #{title} was created."
    )
  end

  # after_update_commit do
  #   broadcast_prepend_to("teststr",
  #     target: "broadcasts",
  #     html: "<div>[#{Time.now}] UPDATE: Changed title to #{title}</div>".html_safe
  #   )
  # end
end
```



## Verifichiamo preview

Torniamo sulla configurazione dell'esempio precedente e nel terminale con la `rails console` inseriamo il comando di creazione di un nuovo Post.

```ruby
$ rails c
> Post.create(title: "ZYX")
```



## Aggiungiamo after_update_commit


***code xx - .../app/models/post.rb - line:1***

```ruby
class Post < ApplicationRecord
  after_create_commit do
    broadcast_update_to("teststr",
      target: "mybroadcasts",
      html: "Post #{title} was created."
    )
  end

  after_update_commit do
    broadcast_prepend_to("teststr",
      target: "mybroadcasts",
      html: "<div>[#{Time.now}] UPDATE: Changed title to #{title}</div>".html_safe
    )
  end
end
```



## Verifichiamo preview

Torniamo sulla configurazione dell'esempio precedente e nel terminale con la `rails console` inseriamo il comando di creazione di un nuovo Post.

```ruby
$ rails c
> post = Post.first
> post.update(title: "Cambiato ^_^")
```



## Lavoriamo dal Site controller

Commentiamo le callbacks sul model Post.

***code xx - .../app/models/post.rb - line:1***

```ruby
class Post < ApplicationRecord
  # after_create_commit do
  #   broadcast_update_to("teststr",
  #     target: "mybroadcasts",
  #     html: "Post #{title} was created."
  #   )
  # end

  # after_update_commit do
  #   broadcast_prepend_to("teststr",
  #     target: "mybroadcasts",
  #     html: "<div>[#{Time.now}] UPDATE: Changed title to #{title}</div>".html_safe
  #   )
  # end
end
```

Ed aggiorniamo il controller site.

***code xx - .../app/controllers/site_controller.rb - line:3***

```ruby
  def third
    @name, @email, @age = params[:person].values_at(:name, :email, :age)
    @count = params[:count].to_i + 1
    @post = Post.create(title: @name)
    @post.broadcast_prepend_to("teststr", target: "mybroadcasts", html: "NEW POST: #{@post.title}")
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_05-controllers-site_controller.rb)



## Verifichiamo preview

Torniamo sulla configurazione dell'esempio precedente ma usiamo il solo terminale con `rails s ...`.

Questa volta per eseguire il Broadcast basta inserire un nome nel campo Name del form ed effettuare il submit premendo il pulsante "save".



## Aggiungiamo un partial

Nel "site_controller" se non usiamo l'opzione `html:...` nel `.broadcast_prepend_to(...)`, allora per convenzione Rails è utilizzato il partial con lo stesso nome dell'istanza. (nel nostro caso `_post.html.erb`)

***code xx - .../app/controllers/site_controller.rb - line:3***

```ruby
  def third
    @name, @email, @age = params[:person].values_at(:name, :email, :age)
    @count = params[:count].to_i + 1
    @post = Post.create(title: @name)
    @post.broadcast_prepend_to("teststr", target: "mybroadcasts")
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/hotwire/04_05-controllers-site_controller.rb)


***code xx - .../app/views/posts/_post.html.erb - line:3***

```html+erb
NEW POST (da partial): <%= post.title %>
```

> Da notare che usiamo `post` e non `@post`



## Verifichiamo preview

Torniamo sulla configurazione dell'esempio precedente ma usiamo il solo terminale con `rails s ...`.

Questa volta per eseguire il Broadcast basta inserire un nome nel campo Name del form ed effettuare il submit premendo il pulsante "save".


