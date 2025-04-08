# <a name="top"></a> Cap *asset_pipeline-propshaf*.1 - Estratto dal video conferenza rails 2023

Tratto dal video di Breno Gazzola - Propshft and the Modern Asset Pipeline - Rails World 2023



# Risorse interne

- []()



## Risorse esterne

- [Breno Gazzola - Propshaft and the Modern Asset Pipeline - Rails World 2023](https://www.youtube.com/watch?v=yFgQco_ccgg)

- [How to use CSS in Rails 7 - An Overview](https://learnetto.com/tutorials/how-to-use-css-in-rails-7)
- [Propshaft Rails - Best practices on how to load multiple css files](https://discuss.rubyonrails.org/t/propshaft-rails-best-practices-on-how-to-load-multiple-css-files/80630)
- [propshaft](https://github.com/rails/propshaft)
- [Upgrading from Sprockets to Propshaft](https://github.com/rails/propshaft/blob/main/UPGRADING.md)



## Le funzioni dell'asset pipeline nel passato

Queste funzioni erano necessarie e gestite da sprocket

- Transpiling
- Bundling
- Fingerprinting
- Compression
- Bundlers


## Le funzioni dell'asset pipelina nel 2024

Molte funzioni non sono più necessarie perché sono gestite direttamente dai nuovi browsers.
Quello che ancora serve è:

- Fingerprint
    - No asset helpers
    - Support for import maps
    - Disable for files digested by bundlers
- Bundlers
    - proshaft "ama": (cssbundling-rails, jsbundling-rails)

- ![fig 01](.../01_fig01-Propshaft bundlers.png)


### No asset helpers

Non servono più gli asset helpers come:
- asset_url
- image_url
- font_url

è tutto gestito automaticamente da propshaft



## Su propshaft `./bin/dev` sostituisce `rails s`

Cosa succede eseguendo `./bin/dev`

If you have a rails app with esbuild and bootstrap, this is what happens when you run `./bin/dev`:

```
bin/dev
|
`-> foreman start -f Procfile.dev
    |
    `-> bin/rails server
    |
    `-> yarn build --watch
    |   `-> node_modules/.bin/esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets --watch
    |
    `-> yarn build:css --watch
        `-> node_modules/.bin/sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules --watch
```

You can see what commands you have configured to run in `Procfile.dev`:

```ruby
# Procfile.dev

web: unset PORT && bin/rails s
js: yarn build --watch
css: yarn build:css --watch
```

Yarn will run your commands from package.json:

```json
// package.json
...
  "scripts": {
    "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
}
```

Notice that compiled js and css are saved into `app/assets/builds` which is where rails will look for your assets, *if you never run bin/dev that directory would be empty* and you will get errors about missing assets or your assets will not update when you make any changes.

Now I understand that `./bin/dev` refreshes js/css files ..., is this the only reason I should use "./bin/dev" instead of "rails server"

If js and css is the only thing you have in your Procfile.dev then yes, you could run bin/rails server by itself if you're not working on any frontend assets (you could run all those commands separately if you want).

In case it's not clear, *`bin/dev` is for development only*. In production, your assets are precompiled only once, there is no need to watch for changes. If you add other commands to Procfile.dev then you should probably already know what to do with them in production.



## Aggiorniamo `Procfile.dev` per inserire l'opzione `-b 192.168.64.4` in `.bin/dev`

Per far partire il server, invece di usare `$ rails s`, usiamo:

```shell
$ ./bin/dev
```

Come facciamo ad inserire l'opzione `$ rails s -b 192.168.64.4` ?
La inseriamo nel file `Procfile.dev`

[Codice xx - .../Procfile.dev - linea: 1]()

```shell
web: env RUBY_DEBUG_OPEN=true bin/rails server -b 192.168.64.4
css: yarn watch:css
js: yarn build --watch
```

