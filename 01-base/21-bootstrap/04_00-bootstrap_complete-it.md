# <a name="top"></a> Cap 21.3 - Tests di funzionamento di Bootstrap

Completiamo la parte di installazione di boostrap aggiungendo la funzionalità "inline" per il css solo lato development perché ci aiuta in fase di debug. Inoltre aggiungiamo le icone.



## Apriamo il branch



## TURN ON INLINE SOURCE MAPS (SO WE CAN DEBUG RAILS 7 BOOTSTRAP)

Inline Source Maps
With SassC-Rails, it's also extremely easy to turn on inline source maps. Simply add the following configuration to your development.rb file:

in config/environments/development.rb add this line:

 config.sass.inline_source_maps = true

Also, the sassc-rails gem README advises this note as well:

After adding this config line, you may need to clear your assets cache (rm -r tmp/cache/assets), stop spring, and restart your rails server. You may also wish to disable line comments (config.sass.line_comments = false).

Note, as indicated, these source maps are inline. They will not generate additional files or anything like that. Instead, they will be appended to the compiled application.css file.



## Verifichiamo il tooltip
questo ha bisogno anche di javascript per il mouse-hover



## Verifichiamo il toast
questo ha bisogno anche di javascritp



## Verifichiamo il menu (nav_bar)
questo ha bisogno anche di javascript