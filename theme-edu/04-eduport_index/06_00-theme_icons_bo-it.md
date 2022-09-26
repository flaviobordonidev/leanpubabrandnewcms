# <a name="top"></a> Cap 2.6 - Attiviamo le icone del tema

Mancano le freccette in basso che sono create a livello di stylesheet con il parametro `dropdown-toggle`.

Esempio: `<a class="dropdown-item dropdown-toggle" href="#">Development</a>`

il parametro `dropdown-toggle` crea una freccia fatta come un triangolo. Nel tema eduport è cambiato con una freccia verso il basso differente ma non si visualizza correttamente perché è basata su un font du caralho.  


## workaraund 1

Nel file css cambiamo la chiamata alle icone del font du caralho con quelle di font-awesome che gli assomigliano di più.

[dafa]



## Workaround 2

Il modo più semplice di risolvere è spostare la freccetta in basso dentro il codice html e togliere il parametro `dropdown-toggle` dal link.

[dafa]


## Le frecce in basso nei megamenu

Qualche icona nel thema eduport è ancora rimasta fuori. Ad esempio le freccette nel megamenu sono impostate in un modo differente e per quelle dobbiamo lavorare in maniera differente.

LASCIAMO QUESTA PARTE APERTA per concentrarci sul resto dell'applicazione.
