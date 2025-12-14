# <a name="top"></a> Verifichiamo le configurazioni di Neovim

Neovim si può configurare in vari modi ma quello più attuale è con l'utilzzo del linguaggio di programmazione `lua`.
Lua è uno scripting language that has a runtime built into nVim.



## Vediamo il file di configurazione '.lua'

nVim di default va a cercare la configurazione nel path: `~/.config/nvim/`
Potremmo mettere tutta la configurazione nel singolo file: `~/.config/nvim/init.lua`
Però questo file diventerebbe troppo grande e sarebbe difficile da mantenere.

Per questo motivo quando abbiamo installato lazy.vim compiandoci la cartella github ci siamo trasportati, oltre al file `~/.config/nvim/init.lua` anche delle sotto-cartelle e tanti altri files `.lua` in modo da avere la configurazione divisa in varie "aree di competenza".
Un esempio molto chiaro sono i plugins che vengono separati ognuno sul suo file dentro la cartella `~/.config/nvim/plugins/`.

Ma vediamo con calma come sono i files di configurazione.

Innanzitutto abbiamo la cartella `~/.config/nvim/` che inizialmente non c'era e dentro:

- nvim/
|- lua/
  |- config/
    |- autocmds.lua
    |- keymaps.lua
    |- lazy.lua
    |- options.lua
  |- plugins/
    |- example.lua
|- LICENSE
|- README.md
|- init.lua
|- lazy-lock.json
|- lazyvim.json
|- stylua.toml



## Vediamo init.lua

> Per convenzione NeoVim appena parte cerca i file di configurazione nel "runtimepath"

Questo è il file principale e quello in cui potremmo avere tutta la configurazione. Siccome la configurazione è distribuita nel file principale è rimasto solo il puntamnento a `~/.config/nvim/config/lazy.lua`

***Codice 01 -  ~/.config/nvim/init.lua - linea:1***

```lua
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
```




## Vediamo config/lazy.lua

Qui c'è lo script che carica 'lazy.vim' e possiamo compararlo con quanto troviamo nell'installazione single file di Lazy.

***Codice 02 -  ~/.config/nvim/config/lazy.lua - linea:1***

```lua
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

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
```























# Editiamo il file init.lua

In neovim per prima cosa salviamo il file con `:w` (write)

***Codice 01 -  ~/.config/nvim/init.lua - linea:1***

```shell
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
```

> Mette spazi quando uso il TAB, invece di mettere un carattere tab.
> Inoltre indenta tutto di 2 spazi quando premo tab

Salviamo con `:w`
Eseguiamo il file con `:source %`

Ed abbiamo ERRORI!
Questo succede perché questo *non* è un vim script file. Questo è LUA.
Non scriviamo codice script vim in un file lua.
Quindi come impostiamo parametri vim in un file lua?
E' fatto tramite `meta-accessors`. Nel nostro caso usiamo il meta-accessor `vim.cmd("...")`
Usiamolo

***Codice 02 -  ~/.config/nvim/init.lua - linea:1***

```shell
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
```

Eseguiamo il file con `:source %`
E questa volta non riceviamo errori! (in pratica resta tutto come prima del comando, senza nessun avviso di successo *_*)











## Risorse esterne

- [From 0 to IDE in NEOVIM from scratch | FREE COURSE // EP 1](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=2)


1. The init.lua file
2. lazy.nvim
3. Colorscheme
4. Telescope
5. Treesitter
