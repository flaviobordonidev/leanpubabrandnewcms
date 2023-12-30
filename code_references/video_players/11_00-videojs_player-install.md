# <a name="top"></a> Cap video_players 10 - Il media player videojs

Installiamo il player videojs su Rails 7

## Risorse interne

- []()



## Risorse esterne

- [Episode 17 Implementing VideoJs in Ruby on Rails](https://www.youtube.com/watch?v=SRZZuUDDbb8)
- [VideoJS](https://videojs.com/)
- [VideoJS: getting started](https://videojs.com/getting-started/)
- [VideoJS: guide](https://videojs.com/guides)
- [VideoJS: API Documentation](https://docs.videojs.com/)
- [VideoJS: blog](https://videojs.com/blog)
- [VideoJS: GitHub](https://github.com/videojs/video.js)



## Installiamo videojs tramite importmap

Basta eseguire un comando e saranno incluse (pinning) molte librerie che servono a video.js.

```bash
$ ./bin/importmap pin video.js
```

Esempio:

```bash
ubuntu@ubuntufla:~/videojs_test $./bin/importmap pin video.js
Pinning "video.js" to https://ga.jspm.io/npm:video.js@7.18.1/dist/video.es.js
Pinning "@babel/runtime/helpers/assertThisInitialized" to https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/assertThisInitialized.js
Pinning "@babel/runtime/helpers/construct" to https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/construct.js
Pinning "@babel/runtime/helpers/extends" to https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/extends.js
Pinning "@babel/runtime/helpers/inherits" to https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/inherits.js
Pinning "@babel/runtime/helpers/inheritsLoose" to https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/inheritsLoose.js
Pinning "@videojs/vhs-utils/es/byte-helpers" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/byte-helpers.js
Pinning "@videojs/vhs-utils/es/containers" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/containers.js
Pinning "@videojs/vhs-utils/es/decode-b64-to-uint8-array" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/decode-b64-to-uint8-array.js
Pinning "@videojs/vhs-utils/es/" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/
Pinning "@videojs/vhs-utils/es/id3-helpers" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/id3-helpers.js
Pinning "@videojs/vhs-utils/es/media-groups" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/media-groups.js
Pinning "@videojs/vhs-utils/es/resolve-url" to https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/resolve-url.js
Pinning "@videojs/xhr" to https://ga.jspm.io/npm:@videojs/xhr@2.6.0/lib/index.js
Pinning "@xmldom/xmldom" to https://ga.jspm.io/npm:@xmldom/xmldom@0.7.13/lib/index.js
Pinning "dom-walk" to https://ga.jspm.io/npm:dom-walk@0.1.2/index.js
Pinning "global/document" to https://ga.jspm.io/npm:global@4.4.0/document.js
Pinning "global/window" to https://ga.jspm.io/npm:global@4.4.0/window.js
Pinning "is-function" to https://ga.jspm.io/npm:is-function@1.0.2/index.js
Pinning "keycode" to https://ga.jspm.io/npm:keycode@2.2.1/index.js
Pinning "m3u8-parser" to https://ga.jspm.io/npm:m3u8-parser@4.7.0/dist/m3u8-parser.es.js
Pinning "min-document" to https://ga.jspm.io/npm:min-document@2.19.0/index.js
Pinning "mpd-parser" to https://ga.jspm.io/npm:mpd-parser@0.21.0/dist/mpd-parser.es.js
Pinning "mux.js/lib/tools/parse-sidx" to https://ga.jspm.io/npm:mux.js@6.0.1/lib/tools/parse-sidx.js
Pinning "mux.js/lib/utils/clock" to https://ga.jspm.io/npm:mux.js@6.0.1/lib/utils/clock.js
Pinning "safe-json-parse/tuple" to https://ga.jspm.io/npm:safe-json-parse@4.0.0/tuple.js
Pinning "url-toolkit" to https://ga.jspm.io/npm:url-toolkit@2.2.5/src/url-toolkit.js
Pinning "videojs-vtt.js" to https://ga.jspm.io/npm:videojs-vtt.js@0.15.5/lib/browser-index.js
ubuntu@ubuntufla:~/videojs_test $
```

Le possiamo vedere sul file `importmap`

# Pin npm packages by running ./bin/importmap

***codice 01 - .../config/importmap.rb - linea:8***

```ruby
pin "video.js", to: "https://ga.jspm.io/npm:video.js@7.18.1/dist/video.es.js"
pin "@babel/runtime/helpers/assertThisInitialized", to: "https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/assertThisInitialized.js"
pin "@babel/runtime/helpers/construct", to: "https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/construct.js"
pin "@babel/runtime/helpers/extends", to: "https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/extends.js"
pin "@babel/runtime/helpers/inherits", to: "https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/inherits.js"
pin "@babel/runtime/helpers/inheritsLoose", to: "https://ga.jspm.io/npm:@babel/runtime@7.23.4/helpers/esm/inheritsLoose.js"
pin "@videojs/vhs-utils/es/byte-helpers", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/byte-helpers.js"
pin "@videojs/vhs-utils/es/containers", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/containers.js"
pin "@videojs/vhs-utils/es/decode-b64-to-uint8-array", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/decode-b64-to-uint8-array.js"
pin "@videojs/vhs-utils/es/", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/"
pin "@videojs/vhs-utils/es/id3-helpers", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/id3-helpers.js"
pin "@videojs/vhs-utils/es/media-groups", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/media-groups.js"
pin "@videojs/vhs-utils/es/resolve-url", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/resolve-url.js"
pin "@videojs/xhr", to: "https://ga.jspm.io/npm:@videojs/xhr@2.6.0/lib/index.js"
pin "@xmldom/xmldom", to: "https://ga.jspm.io/npm:@xmldom/xmldom@0.7.13/lib/index.js"
pin "dom-walk", to: "https://ga.jspm.io/npm:dom-walk@0.1.2/index.js"
pin "global/document", to: "https://ga.jspm.io/npm:global@4.4.0/document.js"
pin "global/window", to: "https://ga.jspm.io/npm:global@4.4.0/window.js"
pin "is-function", to: "https://ga.jspm.io/npm:is-function@1.0.2/index.js"
pin "keycode", to: "https://ga.jspm.io/npm:keycode@2.2.1/index.js"
pin "m3u8-parser", to: "https://ga.jspm.io/npm:m3u8-parser@4.7.0/dist/m3u8-parser.es.js"
pin "min-document", to: "https://ga.jspm.io/npm:min-document@2.19.0/index.js"
pin "mpd-parser", to: "https://ga.jspm.io/npm:mpd-parser@0.21.0/dist/mpd-parser.es.js"
pin "mux.js/lib/tools/parse-sidx", to: "https://ga.jspm.io/npm:mux.js@6.0.1/lib/tools/parse-sidx.js"
pin "mux.js/lib/utils/clock", to: "https://ga.jspm.io/npm:mux.js@6.0.1/lib/utils/clock.js"
pin "safe-json-parse/tuple", to: "https://ga.jspm.io/npm:safe-json-parse@4.0.0/tuple.js"
pin "url-toolkit", to: "https://ga.jspm.io/npm:url-toolkit@2.2.5/src/url-toolkit.js"
pin "videojs-vtt.js", to: "https://ga.jspm.io/npm:videojs-vtt.js@0.15.5/lib/browser-index.js"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)



## Aggiungiamo uno STIMULUS CONTROLLER

Duplichiamo il controller di default `hello_controller.js` e lo rinominiamo `video_controller.js`.
Poi lo modifichiamo così:
- aggiungiamo import videojs
- togliamo dal connect la riga con "hello world"

***codice 02 - .../app/javascript/controllers/video_controller.js - linea:2***

```javascript
import videojs from "video.js"

export default class extends Controller {
  connect() {
  }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Andiamo sulla show page ed annidiamo il codice dentro il tag che richiama lo stimulus controller

***codice 03 - .../app/views/articles/show.html.erb - linea:1***

```html+erb
<div data-controller="video">
  ...
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)



## Aggiungiamo lo stylesheet

Lo prendiamo da [GitHub: videojs - Quick Start](https://github.com/videojs/video.js).

La prima azione è sul layout

***codice 04 - .../app/views/layouts/application.html.erb - linea:9***

```html+erb
<link href="//vjs.zencdn.net/8.3.0/video-js.min.css" rel="stylesheet">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


la seconda è sul tag `<video>` nella view `show`

***codice 05 - .../app/views/articles/show.html.erb - linea:6***

```html+erb
  <video
    id="my-player"
    class="video-js"
    controls
    preload="auto"
    poster="//vjs.zencdn.net/v/oceans.png"
    data-setup='{}'>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Ripartiamo con il preview

```bash
$ rails s -b 192.168.64.7
```

Nell'url del browser inseriamo: http://192.168.64.7:3000/
Funziona.



## Videojs Themes

Aggiungiamo il tema "forest".
Lo prendiamo da [GitHub: videojs/themes](https://github.com/videojs/themes).

La prima azione è sul layout

***codice 04 - .../app/views/layouts/application.html.erb - linea:10***

```html+erb
    <link href="https://unpkg.com/@videojs/themes@1/dist/forest/index.css" rel="stylesheet">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


la seconda è sul tag `<video>` nella view `show` aggiungiamo `vjs-theme-forest` all'attributo `class`.

***codice 05 - .../app/views/articles/show.html.erb - linea:6***

```html+erb
  <video
    id="my-player"
    class="video-js vjs-theme-forest"
    controls
    preload="auto"
    poster="//vjs.zencdn.net/v/oceans.png"
    data-setup='{}'>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)


Ripartiamo con il preview

```bash
$ rails s -b 192.168.64.7
```

Nell'url del browser inseriamo: http://192.168.64.7:3000/
Funziona.
