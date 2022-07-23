# <a name="top"></a> Cap debug.1 - Debugging Rails in Development


## Risorse esterne

- [Debugging Rails](https://www.youtube.com/watch?v=MJSZ3WcgHeE)
- https://gist.github.com/philsmy/e5de9b16279300f30ae8a6286ce05fdb
- https://www.youtube.com/watch?v=MJSZ3WcgHeE
- https://guides.rubyonrails.org/debugging_rails_applications.html
- https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem



## LOG messages sul backend

Inseriamo nella log, con `Rails.logger.debug`, quanto tempo ci mette ad essere eseguito un pezzo di codice.
Inseriamo nel codice queste due righe per il debug:

```ruby
start = Time.current

# the code to debug

Rails.logger.debug "The code took #{Time.current - start}
```

Ad esempio:

```ruby
def index
  start = Time.current
  @post = Post.all.reverse
  Rails.logger.debug "The index method took #{Time.current - start}"
end
```

Poi eseguiamo l'applicazione con `$ rails s`, andiamo sul browser ed apriamo l'index.
Nella log vedremo il messaggio.



## Log con `rescue StandardError`

```ruby
...
now = Time.current
tenant, store = AmazonImporter.prepare_tenant_store(tenant_id, store_id)
store_marketplace = Marketplace.find_by(sales_channel: store.sales_channel)

return unless tenant.subscriptions&.current

begin
  Elasticsearch::TenantEvent.new(tenant_id: tenant.id, event_type: 'import_orders_from_amazon', additional: store_id).save
rescue StandardError
  Rails.logger.warn $ERROR_INFO
end
```



## Creiamo il nostro proprio LOGGER

Dentro `.../config/initializer` creiamo il nuovo file `loggers.rb`

***code: n/a - .../config/initializer/loggers.rb - line:n/a***

```ruby
  logfile = File.open(Rails.root.join('log/order_task_logger.log'), 'a') # create log file
  logfile.sync = true # automatically flushes data to file
  TASKS_LOGGER = Logger.new(logfile) # constant accessible anywhere
  TASKS_LOGGER.level = Rails.env.development? ? Logger::DEBUG : Logger::WARN
```

Personalizziamolo:

```ruby
  logfile = File.open(Rails.root.join('log/flavio_bordoni_logger.log'), 'a') #create log file
  logfile.sync = true #automatically flushes data to file
  FLAVIO_LOGGER = Logger.new(logfile) # constant accessible anywhere
  FLAVIO_LOGGER.level = Rails.env.development? ? Logger::DEBUG : Logger::WARN
```

Riprendiamo l'esempio di prima

```ruby
def index
  start = Time.current
  @post = Post.all.reverse
  Rails.logger.debug "The index method took #{Time.current - start}"
  ::FLAVIO_LOGGER.debug "We did it Wonderful!"
end
```

Facciamo ripartire il server rails `$ rails s`, andiamo sul browser ed apriamo l'index.
Nella log vedremo il messaggio ed inoltre avremo il nuovo file `log/flavio_bordoni_logger.log` con il messaggio "We did it Wonderful!".


> Per approfondimenti su Logging! `logger.(debug|info|warn|error|fatal|unknown)` (https://scoutapm.com/blog/debugging-with-rails-logger)



## LOG messages sul frontend

Mettiamo delle informazioni di debug direttamente sul frontend della nostra applicazione.

Putting debug info into views using `debug` helper (or `to_yaml` or `inspect`)

```html+erb
  <% if Rails.env.development? %>
    <div class='row'>
    <div class='col'>
    <%= debug time_tracker %>
    </div>
    </div>
  <% end %>
```

>  `debug` è un helper che stampa molte informazioni sull'oggetto che gli è passato.

Se non vogliamo che appaia nella pagina web ma solo nel codice della pagina possiamo usare `<div class='row' hidden>`



## Marginalia gem

`marginalia` gem to add info into SQL comments - LOVE THIS - https://github.com/basecamp/marginalia

Aggiungiamola alla nostra app

```bash
$ bundle add marginalia
```


Dentro `.../config/initializer` creiamo il nuovo file `marginalia.rb`

***code: n/a - .../config/initializer/marginalia.rb - line:n/a***

```ruby
Marginalia::Comment.components = [:line]
```

> Volendo più informazioni possiamo aggiungere `Marginalia::Comment.components = [:application, :controller, :action]`



## byebug gem

Questa gemma è installata di default in rails. 

- `byebug` (https://github.com/deivid-rodriguez/byebug)
  - https://blog.usejournal.com/why-byebug-will-be-your-best-friend-when-programming-in-rails-98e06f46bdb6


Riprendiamo l'esempio di prima ed inseriamo `byebug` nel codice.

```ruby
def index
  byebug
  start = Time.current
  @post = Post.all.reverse
  Rails.logger.debug "The index method took #{Time.current - start}"
  ::FLAVIO_LOGGER.debug "We did it Wonderful!"
end
```

Attiviamo il server `$ rails s` ed andiamo nella pagina `index` sul browser.
Nella log vediamo `byebug` in azione. Blocca il codice e mette una linea di comando che ci permette di interagire.

```ruby
> l   # questo comando ci fa la lista del codice seguente
> v l   # questo comando ci fa la lista delle variabili locali
> v g   # questo comando ci fa la lista delle variabili globali
> n   # esegue la prossima linea di codice
> c   # continua ad eseguire tutto il codice restante
```

Si può anche inserire `byebug` in parti di codice con `if...`

esempio

```ruby
def index
  byebug if ...
```



## web_console gem

Questa gemma è installata di default in rails. 

- `web_console` (https://github.com/rails/web-console)
  - https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-web-console-gem
  - config.web_console.whitelisted_ips = ['2405:6583:e80:2200:29f9:5c2f:71d9:b238', '::/0']



## ngrok

Invece di usare `https//localhost:3000` con ngrog posso avere un indirizzo esterno che è molto utile nella vita reale.

> ngrok ti permette di eseguire nomi virtuali nel tuo url di sviluppo.
> ngrok let's you run virtual domains and point them to your local machine.

```bash
$ bash ngrok.sh
```

***code:n/a - .../config/environments/development.rb - line:n/a***

```ruby
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.hosts << "zonmaster.ngrok.io"
```

Funziona ma la nosta console non riesce più a funzionare.
Per farla funzionare aggiungiamo una whitelist:


```ruby
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.hosts << "zonmaster.ngrok.io"
  config.web_console.whitelisted_ips = ['::/0']
```

> nelle parentesi quadre possiamo mettere una lista di ips. altrimenti `'::/0'` li include tutti.



## VSCode

- https://lankydan.dev/2017/05/12/debugging-a-rails-server-in-visual-studio-code
- install gems
- configure Spring <- makes me nervous!
- run




## Memory Gems

"Memory profile" è più per gli sviluppatori di Rails. Chi usa Rails si aspetta che abbiano già verificato ed ottimizzato l'impatto sulla memoria.

`memory_profiler` gem (who is using what) (https://github.com/SamSaffron/memory_profiler)
`derailed_benchmarks` (memory leaks, etc) (https://github.com/zombocom/derailed_benchmarks)
`stackprof` memory profiling (https://github.com/tmm1/stackprof)

> TIP: To run production on your machine with postgres change the database.yml


