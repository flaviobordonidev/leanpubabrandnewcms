# <a name="top"></a> Installiamo il packetmanager per Neovim: Lazy

Il packetmanager è quella cosa che gestisce ed installa e gestisce i pacchetti aggiuntivi per nvim.



## I principali packetmanagers: Lazy e Packer

Ci sono essenzialmente due gestori di pacchetti (packetmanagers) che vanno per la maggiore:
- [`packer.nvim`](https://github.com/wbthomason/packer.nvim)
- [`lazy.nvim`](https://github.com/folke/lazy.nvim)

Noi scegliamo [`lazy.nvim`](https://www.lazyvim.org/) perché oggi 02/08/2025 sembra sia più performante di packer.



## Installiamo lazy

There are multiple ways to install lazy.nvim. 

- [Structured Setup](https://www.lazyvim.org/installation)
- [Sinngle File Setup](https://lazy.folke.io/installation)

The Structured Setup is the recommended way, but you can also use the Single File Setup if you prefer to keep everything in your init.lua.



## Structured Setup

Quello consigliato che non ho usato solo perché stavo seguendo un vecchio video youtube del 2024.
Oggi userei questo.



### Make a backup of your current Neovim files:

Facciamo un backup della nostra configurazione nvim.

```shell
# required
❯ mv ~/.config/nvim{,.bak}

# optional but recommended
❯ mv ~/.local/share/nvim{,.bak}
❯ mv ~/.local/state/nvim{,.bak}
❯ mv ~/.cache/nvim{,.bak}
```



### Clone the starter

Install the LazyVim Starter

```shell
❯ git clone https://github.com/LazyVim/starter ~/.config/nvim
```

In questo modo installiamo già in `~/.config` tutti files e le cartelle di default per nvim.
> Seguendo i video su youtube anche noi andremo poi a creare più files e cartelle per gestire meglio nvim.
> Usando questo metodo di installazione abbiamo il vantaggio che i files e le cartelle di default sono le più aggiornate e standardizzate.
> comunque alla fine arriveremo ad avere praticamente la stessa cosa con eventuali differenze minime.

Remove the .git folder, so you can add it to your own repo later

```shell
❯ rm -rf ~/.config/nvim/.git
```

Start Neovim!

```shell
❯ nvim
```


## Verifichiamo lo "stato di salute" di nvim

Una volta dentro nvim eseguiamo il comando:

```shell
:checkhealth
```

Vediamo alcuni errori.
Per risolvere alcuni errori eseguiamo il comando:

Refer to the comments in the files on how to customize LazyVim.

```shell
:LazyHealth
```

> tip:
> It is recommended to run `:LazyHealth` after installation. This will load all plugins and check if everything is working correctly.

verifichiamo di nuovo con:

```shell
:checkhealth
```

E resta qualche errore. Più tardi li risolviamo con l'aiuto dell'intelligenza artificiale Chat GPT



## I pacchetti installati

La versione 14 che è quella di oggi (04/08/2025), installa i seguenti 34 pacchetti:

Added Plugins
- fzf-lua as a replacement for telescope.nvim
    to use telescope.nvim instead, enable the editor.telescope extra
- blink.cmp as a replacement for nvim-cmp
    to use nvim-cmp instead, enable the coding.nvim-cmp extra

- which-key.nvim to help you remember your keymaps.




- 
















## Sinngle File Setup

Per installarae nvim sto seguendo una serie di video su youtube (https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=2) che sono del 2024 e che usano l'installazione da Single file Setup (forse perché all'epoca era l'unica possibile).
Oggi 02/08/2025 lo script del Single file setip si è migliorato ed è più elaborato, aggiungendo gestione degli errori, altri controlli e nuove funzioni:

***Codice 01 -  ~/.config/nvim/init.lua - linea:1***

```shell
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
```

Quello dei video youtube del 2024, che ho usato e che ha comunque funzionato, è questo:

```shell
❯ cd ~/.config/nvim
❯ nvim init.lua
```

***Codice 02 -  ~/.config/nvim/init.lua - linea:1***

```lua
-- Setup Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {}
local opts = {}

require("lazy").setup(plugins, opts)
```

è uno script molto più semplice e dritto al punto. In pratica verifica se lazy.vim è in stallato.
Se non lo è allora lo installa lanciando il clone del repository su github.

> In questo caso il repository github è quello di "folke" che è ilcreatore di Lazy. Nel caso dell'installar strutturato il repository github invece è "LazyVim" comunque navigando tra i files dell'installer strutturato troviamo comunque lo stesso script del single file ed il riferimento a `local lazyrepo = "https://github.com/folke/lazy.nvim.git"`. 

Poi definiamo le due variabili `plugins` e `opts` e le definiamo come "hash" con `= {}` o megilo in lua si dice "tabelle" perché possono accettare diversi tipi di valori all'interno. Possono funzionare come "array" (in lua *non* si definisce un array con `= []`), come "hash", come "tuple", ...

E nell'ultima riga inizializiamo `lazy` con i relativi "plugins" e "opzioni" che inseriremo nelle variabili `plugins` e `opts`.

Adesso siamo pronti a lanciare `lazy` eseguendo nel file nvim il comando `:Lazy`

Si aprirà la finestra di `lazy`.
Per uscire dalla finestra di `lazy` usiamo `:q`
E torneremo al file aperto su nvim

> It is recommended to run `:checkhealth` lazy after installation.

"Nel mio caso molti check verdi ma anche alcuni check rossi con errore, e dei warning"!!!
Facendo l'installazione "Structured setup" probabilmente sarebbe risultato tutto verde.
Comunque andando avanti con la configurazione posso manualmente correggere i problemi e rendere tutto verde.


## Requirements

- Neovim >= 0.8.0 (needs to be built with LuaJIT)
- Git >= 2.19.0 (for partial clones support)
- a [Nerd Font](https://www.nerdfonts.com/) (optional)
- luarocks to install rockspecs. You can remove rockspec from opts.pkg.sources to disable this feature.



### Nerd Font

Nel sito di [Nerd Font](https://www.nerdfonts.com/) vado su download e trovo una marea di fonts tra cui scegliere.

In fondo alla pagina c'è Other Download & Install Options (Homebrew)


```shell
❯ brew install --cask font-<FONT NAME>-nerd-font
```

Scelgo il font "Hack Nerd Font"

```shell
❯ brew install --cask font-hack-nerd-font
```



### luarocks

Per installare LuaRocks su macOS basta:

```shell
❯ brew install luarocks
```

Verifica:

```shell
❯ luarocks --version
```


Configurare LuaRocks per essere visibile a Neovim
Per far sì che Neovim veda i pacchetti installati con LuaRocks, aggiungi questa riga nel tuo init.lua prima di caricare i plugin:

lua

```lua
-- Dì a Neovim dove LuaRocks mette i pacchetti
pcall(require, "luarocks.loader")
```

Questo carica automaticamente nel package.path e package.cpath i moduli Lua installati con LuaRocks.

Integrazione base con lazy.nvim
Quando configuri un plugin in lazy.nvim, se questo ha dipendenze LuaRocks, puoi specificarlo con l’opzione rocks.

Esempio:
Supponiamo di avere un plugin che richiede lua-cjson:

```lua
require("lazy").setup({
  {
    "myusername/myplugin",
    rocks = { "lua-cjson" } -- Nome pacchetto su LuaRocks
  }
})
```

Quando lazy.nvim installa il plugin, eseguirà anche:

```shell
❯ luarocks install lua-cjson
```


Esempio pratico
Per esempio, se usi telescope-fzf-native con una libreria JSON extra:

```lua
require("lazy").setup({
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    rocks = { "lua-cjson" }
  }
})
```

In questo modo:

- Lazy.nvim installerà il plugin.
- Controllerà se hai LuaRocks.
- Installerà automaticamente lua-cjson.


Vantaggi
Nessun bisogno di ricordare a mano quali librerie Lua installare.
Funziona su macOS senza configurazioni extra.
Se cambi computer, quando sincronizzi Neovim lazy.nvim installerà anche tutte le librerie Lua necessarie.

📌 Nota:
Se non usi ancora librerie Lua esterne nei tuoi plugin, non vedrai subito differenze. Ma appena un plugin richiede qualcosa da LuaRocks, questa configurazione ti eviterà errori tipo module not found.





## Risorse esterne

- [From 0 to IDE in NEOVIM from scratch | FREE COURSE // EP 1](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=2)

3. Colorscheme
4. Telescope
5. Treesitter
