# <a name="top"></a> Installiamo Ruby on Rails (RoR) sul macOS nativo

Questa installazione è fatta direttamente sul sistema operativo nativo del mio macbook pro senza usare macchine virtuali.



## Install Ruby on macOS

Apriamo il terminale.

Installiamo *Xcode Command Line Tools*

```shell
❯ xcode-select --install
```

Installiamo *Homebrew* e le dipendenze (vedi anche 01-virtual_machine / 01_00-brew)

```shell
❯ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
❯ echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
❯ source ~/.zshrc
❯ brew install openssl@3 libyaml gmp rust
```

Installiamo *Mise* version manager

```shell
❯ curl https://mise.run | sh 
❯ echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.zshrc
❯ source ~/.zshrc 
```

Installiamo *Ruby* globalmente tramite *Mise*

```shell
❯ mise use -g ruby@3
```



## Verifying Your Ruby Install

Once Ruby is installed, you can verify it works by running:

```shell
❯ ruby --version
```

Esempio:

```shell
❯ ruby --version
ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [arm64-darwin24]
```



## Installing Rails

A "gem" in Ruby is a self-contained package of a library or Ruby program. We can use Ruby's gem command to install the latest version of Rails and its dependencies from [RubyGems.org](https://rubygems.org/).

Run the following command to install the latest Rails and make it available in your terminal:

```shell
❯ gem install rails
```

To verify that Rails is installed correctly, run the following and you should see a version number printed out:

```shell
❯ rails --version
```
> ATTENZIONE!
> Se non funziona e ti dice di installarlo chiudi il terminale e riaprilo

Esempio:

```shell
❯ rails --version
Rails 8.0.2
```

If the rails command is not found, try restarting your terminal.
You're ready to [Get Started with Rails](https://guides.rubyonrails.org/getting_started.html)!



## Risorse esterne

- [Sito ufficiale di Ruby in Rails: installazione](https://guides.rubyonrails.org/install_ruby_on_rails.html#install-ruby-on-ubuntu)
- [Chris from GoRails aula del suo corso su hotwire](https://learnhotwire.com/sections/introduction/lessons/rails-application-introduction)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
