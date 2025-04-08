# <a name="top"></a> Cap 3.1 - Gestiamo le immagini

Con propshaft non dovremmo più usare gli helpers...

...però se oltre a "propshaft" carichiamo i bundlers (`cssbundling-rails` e `jsbundling-rails`) allora ritorna l'uso degli helpers descritti in questi capitoli:

- [code_references/asset_pipeline-sprocket/11_00-image_tag.md]()


## Come gestire le immagini con proshaft

Credo che la soluzione per non usare gli helpers sia **propshaft + importmap + Dart Sass**.

> Il progetto HEY del fondatore di rails usa "propshaft" con "Dart Sass" ma questo forse lo proverò su Rails 8.0 perché ci sono diversi tutorials che dicono sia difficile configurare "Dart Sass"...

> Al momento essendo riuscito a far funzionare "proshaft" con i bundlers "cssbundling-rails e jsbundling-rails" su rails 7.1 resto con questa configurazione.

Questo capitolo probabilmente lo riempirò con rails 8.0 se riesco a far funzionare "propshaft" con "importmap" e forse servirà "Dart Sass".
> Questo vuol dire che non carico i bundlers (`cssbundling-rails` e `jsbundling-rails`).

Ma ad oggi su rails 7.1 li sto usando e quindi per le immagini facciamo riferimento a:

- [code_references/asset_pipeline-sprocket/11_00-image_tag.md]()
