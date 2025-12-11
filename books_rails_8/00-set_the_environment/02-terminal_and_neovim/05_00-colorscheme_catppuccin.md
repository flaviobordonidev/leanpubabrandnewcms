# <a name="top"></a> Installiamo il colorscheme Catppuccin

Ci sono migliaia di colorscheme ma uno dei più usati è Catppuccin.
Piace anche a me e quindi lo usiamo.



## Installiamo catppuccin

- [sito: catppuccin](https://catppuccin.com/)
- [Github: catppucin](https://github.com/catppuccin)
- [Github: catppucin - port: Neovim](https://github.com/catppuccin/nvim)

Nel sito github di catpuccin, nel port Neovim, c'è il codice per installarlo con `lazy.vim`.

```shell
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 }
```

Inseriamola nei plugin del nostro file di configurazione

***Codice 01 -  ~/.config/nvim/init.lua - linea:22***

```shell
local plugins = {
 { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
local opts = {}

-- Inizializza Lazy con i plugins e le opzioni
require("lazy").setup(plugins, opts)
```

So now lazy will include this plugin when it calls `setup`.
Usciamo da nvim e rientriamo.

```shell
:q

❯ nvim init.lua
```

E, se non è già installato, si apre la finestra di Lazy e si vede che installa catppuccin.



## Impostiamo il tema moka di catpuccin

Adesso per far funzionare catppuccin dobbiamo attivare il suo "setup".
Molti plugin in lua export un "setup functions" that you need to call in your configuration.
Questo importa tutte le funzioni e le funzionalità del pacchetto dentro neovim lua runtime così che neovim le può eseguire.

***Codice 02 -  ~/.config/nvim/init.lua - linea:22***

```shell
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
```



## Risorse esterne

- [From 0 to IDE in NEOVIM from scratch | FREE COURSE // EP 1](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=2)
