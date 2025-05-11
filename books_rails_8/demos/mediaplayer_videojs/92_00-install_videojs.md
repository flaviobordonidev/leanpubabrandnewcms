# <a name="top"></a> Installiamo videojs

[25/05/10]
Installiamo `videojs` nella nostra applicazione RoR.



## Install `videojs` via Importmap

Vediamo il file iniziale di importmap.

***Codice 01 - .../config/importmap.rb - linea:1***

```ruby
# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
```

Installiamo videojs da consolle tramite importmap.

```shell
❯ ./bin/importmap pin video.js
```

> Usare importmap da consolle è molto meglio rispetto ad inserire le linee di codice direttamente sul file "config/importmap.rb". Questo perché si gestisce in automatico tutte le dipendenze che gli servono.

Esempio:

```shell
❯ ./bin/importmap pin video.js
Pinning "video.js" to vendor/javascript/video.js.js via download from https://ga.jspm.io/npm:video.js@8.21.0/dist/video.es.js
Pinning "@babel/runtime/helpers/extends" to vendor/javascript/@babel/runtime/helpers/extends.js via download from https://ga.jspm.io/npm:@babel/runtime@7.27.1/helpers/esm/extends.js
Pinning "@videojs/vhs-utils/es/byte-helpers" to vendor/javascript/@videojs/vhs-utils/es/byte-helpers.js via download from https://ga.jspm.io/npm:@videojs/vhs-utils@4.1.1/es/byte-helpers.js
Pinning "@videojs/vhs-utils/es/containers" to vendor/javascript/@videojs/vhs-utils/es/containers.js via download from https://ga.jspm.io/npm:@videojs/vhs-utils@4.1.1/es/containers.js
Pinning "@videojs/vhs-utils/es/decode-b64-to-uint8-array" to vendor/javascript/@videojs/vhs-utils/es/decode-b64-to-uint8-array.js via download from https://ga.jspm.io/npm:@videojs/vhs-utils@4.1.1/es/decode-b64-to-uint8-array.js
Pinning "@videojs/vhs-utils/es/" to vendor/javascript/@videojs/vhs-utils/es/.js via download from https://ga.jspm.io/npm:@videojs/vhs-utils@4.1.1/es/
/Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/packager.rb:84:in 'Importmap::Packager#handle_failure_response': Unexpected response code (404) (Importmap::Packager::HTTPError)
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/packager.rb:122:in 'Importmap::Packager#download_package_file'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/packager.rb:57:in 'Importmap::Packager#download'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/commands.rb:19:in 'block in Importmap::Commands#pin'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/commands.rb:17:in 'Hash#each'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/commands.rb:17:in 'Importmap::Commands#pin'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/thor-1.3.2/lib/thor/command.rb:28:in 'Thor::Command#run'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/thor-1.3.2/lib/thor/invocation.rb:127:in 'Thor::Invocation#invoke_command'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/thor-1.3.2/lib/thor.rb:538:in 'Thor.dispatch'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/thor-1.3.2/lib/thor/base.rb:584:in 'Thor::Base::ClassMethods#start'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/importmap-rails-2.1.0/lib/importmap/commands.rb:159:in '<main>'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/3.4.0/bundled_gems.rb:82:in 'Kernel.require'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/3.4.0/bundled_gems.rb:82:in 'block (2 levels) in Kernel#replace_require'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/bootsnap-1.18.4/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in 'Kernel#require'
	from /Users/fb/.local/share/mise/installs/ruby/3.4.2/lib/ruby/gems/3.4.0/gems/zeitwerk-2.7.2/lib/zeitwerk/core_ext/kernel.rb:34:in 'Kernel#require'
	from ./bin/importmap:4:in '<main>'
```

> Ci da degli errori su alcune dipendenze che non sono installate ma questo non pregiudica l'installazione base.
> Inoltre gli errori mi sembrano più legati a disallineamenti tra Ruby e importmap.

Vediamo le linee di codice aggiunte su importmap.

***Codice 02 - .../config/importmap.rb - linea:8***

```ruby
pin "video.js" # @8.21.0
pin "@babel/runtime/helpers/extends", to: "@babel--runtime--helpers--extends.js" # @7.27.1
pin "@videojs/vhs-utils/es/byte-helpers", to: "@videojs--vhs-utils--es--byte-helpers.js" # @4.1.1
pin "@videojs/vhs-utils/es/containers", to: "@videojs--vhs-utils--es--containers.js" # @4.1.1
pin "@videojs/vhs-utils/es/decode-b64-to-uint8-array", to: "@videojs--vhs-utils--es--decode-b64-to-uint8-array.js" # @4.1.1
```



## Implementiamo `videojs`

Una volta installato per utilizzarlo lo richiamiamo tramite stimulus.
Creiamo uno "stimulus_controller" per videojs.

***Codice 03 - .../app/javascript/controllers/video_controller.js - linea:8***

```javascript
import { Controller } from "@hotwired/stimulus"
import videojs from "video.js"

export default class extends Controller {
  connect() {
  }
}
```

> In pratica ci siamo copiati il contenuto di `hello_controller.js` aggiungendo `import videojs from "video.js"` e lasciando `connect() {` vuoto.

Preparato lo "stimulus_controller" possiamo aggiungerlo con un `data-controller=` che abbia come valore il nome dello "stimulus_controller" senza il suffisso `_controller`.
Nel nostro caso abbiamo `video_controller` quindi sarà `data-controller="video"`.

***Codice 04 - .../app/views/articles/show.html.erb - linea:1***

```html
<div data-controller="video">
```

Inoltre aggiungiamo al tag `<video>` i parametri richiesti [videojs](https://github.com/videojs/video.js).

***Codice 04 - .../app/views/articles/show.html.erb - linea:1***

```html
  <video
    id="my-player"
    class="video-js"
    controls
    preload="auto"
    poster="//vjs.zencdn.net/v/oceans.png"
    data-setup='{}'>
```

Adesso possiamo far partire il server e vediamo sul browser che funziona.



## Aggiungiamo un tema videojs

Videojs è estremamente personalizzabile ma ha già alcuni temi predefiniti. Installiamo il tema "Forest".
Dalla pagina [Github: videojs/themes](https://github.com/videojs/themes) possiamo selezionare i vari temi.

Copiamo il link di forest su layout/application



Aggiorniamo il parametro "class=" sul tag "video" su views/show.


 vjs-theme-city




## Facciamo partire il server

```shell
❯ bin/dev
```

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`




## Risorse esterne

Tutorials:
- [Episode 17 Implementing VideoJs in Ruby on Rails](https://www.youtube.com/watch?v=SRZZuUDDbb8&t=552s)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)

