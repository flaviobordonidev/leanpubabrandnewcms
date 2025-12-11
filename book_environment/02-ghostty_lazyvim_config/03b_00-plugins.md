
# <a name="top"></a> LazyVim 14 ha preinstallati i seguenti plugins


[La0zyVim 14](https://www.lazyvim.org/plugins) provides a set of preconfigured plugins enabled by default. All you need to do to utilize these plugins is install the **LazyVim starter template**.

Vediamo i plugins attivi divisi per categorie.

UI: Enhance the user interface with features such as status line, buffer line, indentation guides, dashboard, and icons.
Neovim si può configurare in vari modi ma quello più attuale è con l'utilzzo del linguaggio di programmazione `lua`.

Lua è uno scripting language that has a runtime built into nVim.
Util: Contains utilities for session management, shared functionality, and other handy tools.

LazyVim → È il preset di configurazione base. Fornisce impostazioni già pronte, keymaps, plugin essenziali e integrazione coerente tra loro.
lazy.nvim → Gestore di plugin moderno e asincrono. Si occupa di scaricare, aggiornare e caricare i plugin in modo ottimizzato.



nvim-neo-tree/neo-tree.nvim (incluso da LazyVim) → File explorer avanzato con preview, gestione file/cartelle e ricerca integrata. Collegato a <leader>e.

## Plugins
Di seguito i plugins indicati nel sito: [La0zyVim.org/plugins](https://www.lazyvim.org/plugins)


## Coding 
Faster coding with features such as snippets, autocompletion, and more.

- mini.pairs - auto pairs
- ts-comments.nvim - comments
- mini.ai - Better text-objects
- lazydev.nvim


## Colorscheme
Default color schemes (TokyoNight and Catppuccin).

- Gruvbox
- tokyonight.nvim
- catppuccin
- bufferline.nvim (optional)


## Editor
Provides functionality like a file explorer, search and replace, fuzzy finding, git integration.

- grug-far.nvim - search/replace in multiple files
- flash.nvim - Flash enhances the built-in search functionality by showing labels at the end of each match, letting you quickly jump to a specific location.
- which-key.nvim - which-key helps you remember key bindings by showing a popup with the active keybindings of the command you started typing.
- gitsigns.nvim - git signs highlights text that has changed since the list git commit, and also lets you interactively stage & unstage hunks in a commit.
- trouble.nvim - better diagnostics list and others
- todo-comments.nvim - Finds and lists all of the TODO, HACK, BUG, etc comment in your project and loads them into a browsable list.


## Formatting
Set up formatters using conform.nvim.

- conform.nvim
- mason.nvim


## Linting
Manage linters with the nvim-lint plugin.

- nvim-lint



## LSP
configure the Language Server Protocol (LSP) client.
The syntax for adding, deleting and changing LSP Keymaps, is the same as for plugin keymaps, but you need to configure it using the opts() method.

- nvim-lspconfig - lspconfig 
- mason.nvim
- mason-lspconfig.nvim
- mason.nvim - cmdline tools and lsp servers
- mason.nvim - pin to v1 for now
- mason-lspconfig.nvim


## TreeSitter
advanced syntax highlighting and plugins that use Treesitter parsers

- which-key.nvim
- nvim-treesitter - Treesitter is a new parser generator tool that we can use in Neovim to power faster and more accurate syntax highlighting.
- nvim-treesitter-textobjects
- nvim-ts-autotag - Automatically add closing tags for HTML and JSX


## UI

- bufferline.nvim - This is what powers LazyVim's fancy-looking tabs, which include filetype icons and close buttons.
- lualine.nvim - statusline
- noice.nvim - Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
- mini.icons - icons
- nui.nvim - ui components
- snacks.nvim


## Util

- snacks.nvim - Snacks utils
- persistence.nvim - Session management. This saves your session in the background, keeping track of open buffers, window arrangement, and more. You can restore sessions when returning through the dashboard.
- plenary.nvim - library used by other plugins







## Cosa ho attivo con questa configurazione

Vediamo una panoramica ordinata di quali plugin hai attivi con questa configurazione LazyVim e a cosa servono.
Ho preso l’elenco da lazy-lock.json e dai tuoi file in lua/plugins.


🖥️ Interfaccia e navigazione
bufferline.nvim → Barra in alto per navigare tra buffer aperti con tab visivi.
lualine.nvim → Barra di stato inferiore personalizzabile con informazioni su file, modalità, Git, ecc.
which-key.nvim → Mostra un menu interattivo con le scorciatoie disponibili quando premi <leader> o altri tasti mappati.
noice.nvim → Migliora i messaggi, notifiche e prompt di Neovim con una UI più leggibile.
tokyonight.nvim + catppuccin + gruvbox.nvim → Schemi di colore (tema dell’editor). Attualmente Gruvbox è configurato come predefinito.
mini.icons → Set di icone per file, cartelle e UI di Neovim.

📝 Scrittura e sintassi
nvim-treesitter → Evidenziazione sintattica avanzata basata su parsing strutturale del codice.
nvim-treesitter-textobjects → Selezione e movimento tra elementi logici del codice (funzioni, classi, blocchi).
nvim-ts-autotag → Chiude automaticamente i tag HTML/XML.
ts-comments.nvim → Gestione dei commenti ottimizzata per linguaggi supportati da Tree-sitter.
friendly-snippets → Libreria di snippet pronta all’uso per molti linguaggi.
mini.pairs → Inserimento automatico di parentesi, virgolette, ecc.

💡 AIuto alla scrittura del codice
blink.cmp (completion engine) → Sistema di autocompletamento veloce e modulare.
hrsh7th/nvim-cmp → Motore di completamento configurato per Blink e altre sorgenti.
cmp-emoji → Completamento emoji.
mini.ai → Movimenti intelligenti per selezionare parti di testo/codice.

🔍 Ricerca e navigazione nel codice
nvim-telescope/telescope.nvim → Finder potente per file, testo, simboli, ecc.
telescope-fzf-native (opzionale se attivo) → Backend più veloce per Telescope.
trouble.nvim (disabilitato nella tua config) → Pannello per diagnosticare errori LSP, TODO, warnings.
todo-comments.nvim → Evidenzia e lista i commenti tipo TODO, FIXME nel codice.
grug-far.nvim → Ricerca e sostituzione su più file con UI interattiva.

🌍 LSP e linguaggi
- nvim-lspconfig → Configura i server LSP per completamento, linting, refactoring.
- mason.nvim → Installa e gestisce server LSP, formatter e linter.
- mason-lspconfig.nvim → Collega Mason a LSPconfig.
- typescript.nvim → Migliora il supporto TypeScript con comandi extra (rinomina file, organizza import).
- persistence.nvim → Salva e ripristina le sessioni di lavoro.

🔧 Formattazione e linting
conform.nvim → Formattatore di codice.
nvim-lint → Linter per il controllo errori.
stylua, shfmt, flake8, ecc. → Formatter/linter installati tramite Mason per Lua, shell e Python.

📂 Git
gitsigns.nvim → Mostra cambi Git a fianco delle linee, consente stage/unstage rapidi.

📌 In sintesi:
Explorer → Neo-tree.
Completamento → Blink + nvim-cmp.
Sintassi → Tree-sitter.
Ricerca → Telescope.
LSP → nvim-lspconfig + Mason.
UI → LazyVim + Bufferline + Lualine + Noice + Which-key.
Extra → gestione TODO, Git, snippet, formattazione.

