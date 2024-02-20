# Bootstrap

Da rails 6, essendo introdotto webpack, non usiamo più la gemma perché, seppur funzionando, sarebbe obsoleta appoggiandosi a sprokets e all'asset pipeline che è stato rimpiazzato da webpack. L'asset pipeline ancora funziona ma è destinato ad essere abbandonato e sostituito integralmente da webpack.

Riferimenti interni:

* 01-base/21-bootstrap/02-install-bootstrap


Riferimenti web:

- [BootStrap 5 + esbuild in Ruby on Rails 7](https://mixandgo.com/learn/ruby-on-rails/how-to-install-bootstrap)

- [Questo funziona!^_^](https://www.vic-l.com/setup-bootstrap-in-rails-6-with-webpacker-for-development-and-production/)

- [](https://medium.com/@adrian_teh/ruby-on-rails-6-with-webpacker-and-bootstrap-step-by-step-guide-41b52ef4081f)
- [](https://hackernoon.com/integrate-bootstrap-4-and-font-awesome-5-in-rails-6-u87u32zd)
- [](https://www.mashrurhossain.com/blog/rails6bootstrap4)
- [](https://medium.com/@guilhermepejon/how-to-install-bootstrap-4-3-in-a-rails-6-app-using-webpack-9eae7a6e2832)
- [](https://dev.to/vvo/a-rails-6-setup-guide-for-2019-and-2020-hf5)


- [Sito ufficiale di BootStrap](http://getbootstrap.com/getting-started/#download)
- [Sito ufficiale della gemma per BootStrap](https://github.com/twbs/bootstrap-sass)

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/bootstrap)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/twbs/bootstrap-rubygem)
>
> facciamo riferimento al [sito ufficiale](http://getbootstrap.com/docs/4.0/getting-started/download/)



## Installazione da nuovo progetto

Basta semplicemente aggiungere l'opzione `-j esbuild --css bootstrap`.

```bash
$ rails new myappname -j esbuild --css bootstrap
```



## Installazione su progetto già iniziato

Se abbiamo già un progetto Rails 7 iniziato e vogliamo installare BootStrap la situazione è più complicata perché `esbuild` va in conflitto con importmap. Si può comunque installare ma necessita di più lavoro.

The first thing you'll need to do is to install the cssbundling-rails gem and then use the installer that the gem provides to generate the necessary configuration.

```
$ bundle add cssbundling-rails
$ ./bin/rails css:install:bootstrap
```

So let's install the jsbundling-rails gem, and add the esbuild bundler by running the installer that the jsbundling-rails gem provides.

```
$ bundle add jsbundling-rails
$ ./bin/rails javascript:install:esbuild
```

And that's where it gets into trouble. *_*

Because we have some code left over from import maps, which conflicts with how the jsbundling-rails gem works.

So let's fix these problems.

The first thing to do is to install the turbo-rails and stimulus packages.

```
yarn add @hotwired/turbo-rails
yarn add @hotwired/stimulus
```

Then, I'll adjust the import path in the application.js file, and I'll remove the old stimulus imports.

```
--- a/app/javascript/application.js
+++ b/app/javascript/application.js
-import "controllers"
+import "./controllers";

--- a/app/javascript/controllers/index.js
+++ b/app/javascript/controllers/index.js
-import { application } from "controllers/application"
-
-// Eager load all controllers defined in the import map under controllers/**/*_controller
-import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
-eagerLoadControllersFrom("controllers", application)
-
-// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
-// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
-// lazyLoadControllersFrom("controllers", application)
+import { application } from "./application";
```

In the application layout file, I'll remove the javascript_importmap_tags helper since it's no longer required.

```
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
     <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
-    <%= javascript_importmap_tags %>
     <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
   </head>
```

And finally, I'll unlink the other javascript folders leaving just the builds folder and the images folder in the manifest.

```
--- a/app/assets/config/manifest.js
+++ b/app/assets/config/manifest.js
 //= link_tree ../images
-//= link_tree ../../javascript .js
-//= link_tree ../../../vendor/javascript .js
 //= link_tree ../builds
```

So now, if we take a look at the Navbar in the browser, you'll see it looks the same but this time the drop-downs do work.



Vediamo il fix di nuovo ^_^

You can install the missing packages with:

```
yarn add @hotwired/turbo-rails
yarn add @hotwired/stimulus
```

```
// package.json
{
  "name": "app",
  "private": "true",
  "dependencies": {
    "@hotwired/stimulus": "^3.1.0",
    "@hotwired/turbo-rails": "^7.1.3",
    "@popperjs/core": "^2.11.6",
    "bootstrap": "^5.2.1",
    "bootstrap-icons": "^1.9.1",
    "esbuild": "^0.15.7",
    "sass": "^1.54.9"
  },
  "scripts": {
    "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
}
```

```
// app/javascript/application.js
import "@hotwired/turbo-rails"
import "./controllers"
```

```
// app/javascript/controllers/index.js
import { application } from "./application"
```

```
app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
```

```
//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../builds
```
