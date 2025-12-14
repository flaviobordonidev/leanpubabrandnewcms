# Snacks picker


# Risorse esterne

- [Why I'm Moving from Telescope to Snacks Picker ](https://www.reddit.com/r/neovim/comments/1ifyfou/why_im_moving_from_telescope_to_snacks_picker_why/)


## Snacks picker

I've been using Telescope as my main picker ever since I started Neovim

I use the LazyVim distro, so even when Folke moved us over to fzf-lua I switched bach to Telescope

Why? Because there's a few things I couldn't do in fzf-lua that I'm really used to in telescope:

The main one is frecency (nvim-telescope/telescope-frecency.nvim), this is similar to zoxide in the terminal, so basically every time you open a file, it increases it's score in an internal database, and keeps track of those scores, so that the next time you search for something, and there are 2 files with the same name, the one with the highest score will show at the top (probably skill issue on my side)

I navigate my buffers with telescope, and I when use the telescope buffers picker, I want it to start in normal mode, I couldn't do that in fzf-lua (probably skill issue on my side)

When hovering over images in fzf-lua (in macOS) it would get stuck

But a few days ago, I noticed a post by Folke in twitter about a new picker he had created, so I decided to give it a try

And long story short, this Snacks picker has replaced my beloved telescope for me

I've created some custom pickers really easily (to search for my completed and uncompleted tasks)

I can increase or decrease the score of a file(path) the same way I do in the telescope-frecency.nvim plugin

I can pick between many different layouts Folke created by default (including ivy), or modify the layouts to my liking

I can start a picker in normal mode instead of insert mode

It works with blink.cmp so if you want to have completions while looking for a file or using any other picker, you can do so, I don't like to, so I disabled it in the blink config

There's an issue with the bullets-vim/bullets.vim plugin, it did not allow me to select an item in the picker when in insert mode and I pressed <CR> (enter), but it can be worked around

All of the details and the demo are covered in the video: 
- [Why I'm Moving from Telescope to Snacks Picker - Why I'm not Using fzf-lua - Frecency feature](https://youtu.be/7hEWG3GP6m0)

If you don't like watching videos:
- [here's my snacks plugin config](https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/snacks.lua)

neovim/neobean/lua/plugins/snacks.lua
'''lua

'''
