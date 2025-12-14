# <a name="top"></a> Installiamo il fuzzy finder Telescope

telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.



## Installiamo telescope

- [sito di lazy: telescope](https://www.lazyvim.org/extras/editor/telescope)
- [Github: telescope](https://github.com/nvim-telescope)
- [Github: telescope - Neovim](https://github.com/nvim-telescope/telescope.nvim)


Nel sito (https://github.com/nvim-telescope/telescope.nvim) prendiamo le istruzioni per Using lazy.nvim

```shell
-- init.lua:
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }

-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
```

E le inseriamo nel nostro file `int.lua` oppure potremmmo metterlo nel nostro file `plugins/telescope.lua` (ma questo lo vediamo più avanti).

Inseriamola nei plugin del nostro file di configurazione

***Codice 01 -  ~/.config/nvim/init.lua - linea:22***

```shell
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  }
}
local opts = {}

-- Inizializza Lazy con i plugins e le opzioni
require("lazy").setup(plugins, opts)
```

Adesso usciamo e rientriamo su nvim ed il packetmanager lazy aggiungerà il plugin Telescope.

```shell
:q

❯ nvim init.lua
```

E, se non è già installato, si apre la finestra di Lazy e si vede che lo installa.



## Inizializziamo Telescope

Per usare Telescope non basta installarlo ma dobbiamo anche inizializzarlo (come abbiamo fatto anche per catppuccin).

Sempre nel sito (https://github.com/nvim-telescope/telescope.nvim) prendiamo le istruzioni per Using Lua:

```shell
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
```

Ed usiamole nel nostro file di configurazione

***Codice 01 -  ~/.config/nvim/init.lua - linea:22***

```shell

-- Inizializza Lazy con i plugins e le opzioni
require("lazy").setup(plugins, opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

```






## Risorse esterne

- [From 0 to IDE in NEOVIM from scratch | FREE COURSE // EP 1](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=2)

4. Telescope
5. Treesitter