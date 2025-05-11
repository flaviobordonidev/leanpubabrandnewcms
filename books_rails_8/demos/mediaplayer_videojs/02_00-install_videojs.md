# <a name="top"></a> Installiamo videojs

[25/05/10]
Abbiamo scelto il media player `videojs` e lo installiamo nella nostra applicazione RoR.



## La scelta del media player

*Rails 8* utilizza di default *Importmap* come alternativa più semplice rispetto a Webpacker o jsbundling-rails. 
Questo significa che non puoi usare direttamente pacchetti NPM come video.js o vidstack a meno di usare uno strumento di build come esbuild o vite. Tuttavia, puoi integrare comunque un video player compatibile in due modi, anche rimanendo fedele all’approccio “no build” di Importmap.

- Video.js è distribuito anche come file JS/CSS su CDN, e quindi puoi includerlo via Importmap e stylesheet_link_tag. 
	Se preferisci non usare CDN, puoi scaricare i file JS e CSS di Video.js e inserirli nella tua cartella `app/assets`.
- Vidstack (Vime) non è adatto a Importmap
	Vidstack è progettato per lavorare con moderni bundler JS e usa componenti Web/React — quindi non è consigliato con Importmap. Potresti forzarne l’uso via CDN, ma è complicato e fragile, e non allineato allo spirito "batteries-included" di Rails.

Se vuoi restare su Importmap, usa Video.js via CDN o con asset locali. Funziona perfettamente, è ben supportato, e non richiede Webpack o esbuild. Vidstack, invece, richiede un bundler JS moderno e non è adatto a un ambiente Rails puro con Importmap.
In produzione è spesso consigliabile evitare le CDN per asset critici, e usare invece asset locali gestiti dal tuo pipeline (es. tramite gli asset di Rails) per motivi di sicurezza, stabilità e controllo.



## Scarichiamo i files di videojs per installazione locale

*Rails 8* utilizza per default *Propshaft* al posto del vecchio Sprockets, e questo comporta differenze importanti nella gestione degli asset. Con Propshaft *non* esiste più app/assets/config/manifest.js, e gli asset statici sono gestiti in modo più simile a un filesystem pubblico, con una pipeline semplificata.



### Come scaricare i files

Il repository di Video.js su GitHub contiene molti file perché lì trovi tutto il codice sorgente, inclusi moduli, plugin, sorgenti TypeScript, esempi di test e configurazioni di build. Ma tu non hai bisogno di tutto questo. Tu hai solo bisogno dei file già "costruiti" (buildati), cioè quelli minificati e pronti per la produzione. Questi file si trovano nel pacchetto NPM dopo la build, oppure serviti direttamente da una CDN (che puoi usare anche solo per scaricare e poi salvare in locale).

Per usare Video.js nella tua app Rails 8 con Importmap, ti bastano due file:

Nome files videojs | Descrizione | Percorso su CDN "zencdn"
|:---   |:---   |:---
`video.min.js` | lo script principale (video player) | https://vjs.zencdn.net/8.10.0/video.min.js
`video-js.min.css` | lo stile base del player | https://vjs.zencdn.net/8.10.0/video-js.min.css

Li possiamo aprire sul browser e fare salva. Oppure possiamo usare la console:

```shell
❯ curl -O https://vjs.zencdn.net/8.10.0/video.min.js
❯ curl -O https://vjs.zencdn.net/8.10.0/video-js.min.css
```



### Dove mettere questi file

Mettili nella cartella `app/assets/builds/` (che con Propshaft è una delle cartelle asset predefinite).

- app/assets/builds/video.min.js
- app/assets/builds/video-js.css

Puoi creare tu la cartella `app/assets/builds/`, anche se non è obbligatorio usare proprio quel nome: con Rails 8 e Propshaft, qualsiasi cartella dentro app/assets/ è automaticamente inclusa nella ricerca degli asset — non serve registrarla esplicitamente (come avveniva con Sprockets).
Con Propshaft, Rails cerca automaticamente i file JS e CSS nelle directory app/assets, lib/assets e vendor/assets.
Digest e fingerprinting sono abilitati in produzione, come con Sprockets, quindi puoi sfruttare il caching del browser.
Puoi controllare cosa viene servito con rails assets:precompile o in bin/rails assets:clobber e assets:clean.



## Includi gli asset nel layout

Nel tuo application.html.erb (o altro layout):

```html
<%= stylesheet_link_tag "video-js.min", media: "all", "data-turbo-track": "reload" %>
<%= javascript_importmap_tags %>
<%= javascript_include_tag "video.min", "data-turbo-track": "reload" %>
```

Niente manifest, niente require: Propshaft serve automaticamente i file presenti nei path asset.



## Aggiungi il player nella view show

```html
<video
  id="my-video"
  class="video-js vjs-default-skin"
  controls
  preload="auto"
  width="640"
  height="264"
  data-setup="{}">
  <source src="<%= video_path('demo.mp4') %>" type="video/mp4" />
  Il tuo browser non supporta il tag video.
</video>
```



## Facciamo partire il server

```shell
❯ bin/dev
```

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`

Funziona!



## Installiamo i temi di videojs

Apri questo link nel browser o usa curl/wget:

📄 Tema forest (CSS):
https://unpkg.com/@videojs/themes@1.0.0/dist/forest/index.css

💡 Se vuoi essere preciso con le versioni, usa sempre @1.0.0 o la più recente.

```shell
❯ curl -O https://unpkg.com/@videojs/themes@1.0.0/dist/forest/index.css
```

Salva il file come:
- app/assets/builds/videojs-theme-forest.css


Includi il tema nel layout
Nel file application.html.erb o equivalente:

```html
<%= stylesheet_link_tag "video-js.min", media: "all", "data-turbo-track": "reload" %>
<%= stylesheet_link_tag "videojs-theme-forest", media: "all", "data-turbo-track": "reload" %>
```

Applica il tema nel markup del player
Nel tag <video>, aggiungi la classe del tema vjs-theme-forest:

```html
<video
  id="my-video"
  class="video-js vjs-theme-forest"
  controls
  preload="auto"
  width="640"
  height="264"
  data-setup="{}">
  <source src="<%= video_path('demo.mp4') %>" type="video/mp4" />
  Il tuo browser non supporta il tag video.
</video>
```

Scarica anche altri temi
I temi disponibili nel pacchetto sono:

- default
- city
- fantasy
- forest
- sea

Puoi esplorarli tutti qui:
https://unpkg.com/@videojs/themes@1.0.0/dist/


```shell
❯ curl -O https://unpkg.com/@videojs/themes@1.0.0/dist/city/index.css
❯ curl -O https://unpkg.com/@videojs/themes@1.0.0/dist/fantasy/index.css
❯ curl -O https://unpkg.com/@videojs/themes@1.0.0/dist/forest/index.css
❯ curl -O https://unpkg.com/@videojs/themes@1.0.0/dist/sea/index.css
```

Va poi cambiato su `views/layouts/application.html.erb` e su `views/articles/show.html.erb`.



## Risorse esterne

-[]()

---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)

