# bla


Spostiamo lo <style> inline sul layer prima sul file assets/stylesheets/application.

Questo è un passaggio temporaneo che influenza tutta l'applicazione e non è la soluzione più pulita e più elegante.

Spostiamo poi il codice su un file esterno e lo puntiamo prima da assets/stylesheets/application. E questo, più da un punto di vista didattico perché molti tutorial puntano stili su file esterno da application.

Infine sganciamo il file esterno da assets/stylesheets/application e lo leghiamo direttamente sul layer bs_demo facendo una nuova chiamata nell'<head>




> Attenzione! usando l'asset pipeline dopo ogni modifica **dobbiamo** eseguire il *precompile* (`rails assets:precompile`)

```bash
$ rails assets:precompile
```





## Usiamo uno stile per visualizzare la griglia di bootstrap

Al fine di comprendere meglio come funzionano le griglie aggiungiamo uno stile di debug che ne evidenzi la struttura.

Potremmo creare un file "".../app/javascript/stylesheets/debug_bootstrap_grid.scss" ed aggiungerlo a ".../app/javascript/stylesheets/application.scss" con il comando "@import "./debug_bootstrap_grid";" ma essendo il codice di stile una sola semplice riga è più semplice inserirla direttamente in "application.scss".

{id: "01-21-03_01", caption: ".../app/javascript/stylesheets/application.scss -- codice 07", format: JavaScript, line-numbers: true, number-from: 1}
```
// highlight bootstrap grid for Debug
.row > div { min-height:100px; border:1px solid red;}
```

[tutto il codice](#01-21-03_01all)


