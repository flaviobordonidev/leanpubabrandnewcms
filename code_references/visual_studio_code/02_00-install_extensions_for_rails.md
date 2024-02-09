# <a name="top"></a> Cap 1 - Configuriamo Visual Studio Code per Ruby on Rails

Il nostro ambiente di sviluppo Visual Studio Code.
In questo capitolo installiamo le *estensioni* di Visual Studio Code per lavorare meglio con Ruby on Rails.



## Risorse esterne

- [Visualstudio.com - ruby](https://code.visualstudio.com/docs/languages/ruby)
- [Ruby LSP by Shopify](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp)
- [The Best VS Code Themes 2023](https://medium.com/quick-code/the-best-vs-code-themes-2022-9e9b648c4596)
- [Lesson 3 - Configure VSCode for Rails Development](https://www.youtube.com/watch?v=WHVqcN3S_jI)

- [VS Code extensions for ruby on rails](https://dev.to/thomasvanholder/10-vs-code-extensions-for-ruby-on-rails-developers-89a)
- [how-pro-ruby-developers-customize-vs-code](https://dev.to/appmapruby/how-pro-ruby-developers-customize-vs-code-2hee)
- [10-vs-code-extensions](https://dev.to/thomasvanholder/10-vs-code-extensions-for-ruby-on-rails-developers-89a)

- [Remote Development with VS Code on Mac](https://medium.com/macoclock/remote-development-with-vscode-on-mac-in-simple-5-steps-6ae100938d67)



## Estensioni che ho installato

@installed

- Ruby LSP               : by Shopify. Per gestire Ruby. (consigliato anche dalla documentazione di vscode).
- One dark pro           : by binaryify. Tema (@theme) che ho scelto. Uso il suo color theme "One dark pro darker".
- Material Icon Theme    : by Philipp Kief (pkief.com). Per le icone.
- ERB Formatter/Beautify : by Ali Ariff. Per formattare pagine *.erb* con i tasti *SHIFT+OPTION+F*.


## Estensioni che ho considerato

Elenco in ordine alfabetico

- [auto-add-brackets by aliariff](https://marketplace.visualstudio.com/items?itemName=aliariff.auto-add-brackets)
- [dotenv by mikestead](https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv)
- [endwise by kaiwood](https://marketplace.visualstudio.com/items?itemName=kaiwood.endwise)
- [ERB Formatter/Beautify]() --> formatter per files *.erb*
- [GitHub Copilot]() --> Fortemente consigliata ma è a pagamento e costa 10 € al mese.
- [Monokai pro](@theme) --> Tema (@theme) Secondo classificato.
- [rails by bung87](https://marketplace.visualstudio.com/items?itemName=bung87.rails)
- [rspec-snippets by karunamurti](https://marketplace.visualstudio.com/items?itemName=karunamurti.rspec-snippets)
- [Ruby by rebornix](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby) --> rimpiazzata da Ruby LSP
- [Ruby by Peng VL]() --> This extension is deprecated. Use the Ruby LSP extension instead.
- [Ruby LSP by Shopify](https://github.com/Shopify/vscode-shopify-ruby) --> installata
- [simple-ruby-erb by vortizhe](https://marketplace.visualstudio.com/items?itemName=vortizhe.simple-ruby-erb)
- [solargraph by castwide](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph) --> Fortemente consigliata in passato.
    ( forse rimpiazzata da Ruby LSP?!? vedi: https://www.youtube.com/watch?v=mkLDPpDSWng )
- [vscode-run-rspec-file by Thadeu](https://marketplace.visualstudio.com/items?itemName=Thadeu.vscode-run-rspec-file)
- [vscode ruby]() --> is depricated and we should use Ruby LSP instead.



## Installiamo il formatter per .erb

- [Lesson 3 - Configure VSCode for Rails Development](https://www.youtube.com/watch?v=WHVqcN3S_jI)

Click sull'*icona dell'ingranaggio* in basso a sinistra e scegli *keyboard shortcuts* .
Nell'elenco di tutti gli shortcuts filtra per *format document*. Ti si presenteranno due linee con la sequenza di tasti (keybinding) = *SHIFT+OPTION+F*.
Questa è la sequenza di tasti per formattare il tuo codice.
Apriamo un file *.erb* e premiamo i tasti *SHIFT+OPTION+F*. Ci apparirà il messaggio "There is no formatter for 'erb' file installed."

Installiamo l'estensione *ERB Formatter/Beautify by Ali Ariff*.
Non basta solo installare l'estensione ma dobbiamo anche installare la gemma. Quindi apriamo un nuovo terminale ed eseguiamno il comando.

```shell
$ gem install htmlbeautifier

# or

$ sudo gem install htmlbeautifier
```

Esempio:

```shell
fb@MacBook-Pro-di-Flavio-2_leanpubabrandnewcms% gem install htmlbeautifier
Fetching htmlbeautifier-1.4.2.gem
ERROR:  While executing gem ... (Gem::FilePermissionError)
    You dont have write permissions for the /Library/Ruby/Gems/2.6.0 directory.

fb@MacBook-Pro-di-Flavio-2_leanpubabrandnewcms% sudo gem install htmlbeautifier
Password:
Fetching htmlbeautifier-1.4.2.gem
Successfully installed htmlbeautifier-1.4.2
Parsing documentation for htmlbeautifier-1.4.2
Installing ri documentation for htmlbeautifier-1.4.2
Done installing documentation for htmlbeautifier after 0 seconds
1 gem installed
```

Inoltre dobbiamo inserire del codice sul *settings.json* di vscode.
Click sull'*icona dell'ingranaggio* in basso a sinistra e scegli *settings*.
Arrivati sui *settings* facciamo la ricerca per la parola "settings" in modo da limitare le scelte.
Scendiamo in basso nell'elenco e clicchiamo su "Edit in setting.json". 
Questo ci apre il file *setting.json*. (A volte aggiunge la riga di codice da dove hai cliccato. Quel codice in più lo puoi cancellare.)

```json
    "[erb]": {
        "editor.defaultFormatter": "aliariff.vscode-erb-beautify",
        "editor.formatOnSave": true
      },
      "files.associations": {
        "*.html.erb": "erb"
      },
      "vscode-erb-beautify.customEnvVar": {
        "LC_ALL": "en_US.UTF-8"
      }
```

Esempio:

```json
{
    "workbench.iconTheme": "material-icon-theme",
    "workbench.colorTheme": "One Dark Pro Darker",
    "[erb]": {
        "editor.defaultFormatter": "aliariff.vscode-erb-beautify",
        "editor.formatOnSave": true
      },
      "files.associations": {
        "*.html.erb": "erb"
      },
      "vscode-erb-beautify.customEnvVar": {
        "LC_ALL": "en_US.UTF-8"
      }
}
```



## Syntax color highlight

Per la colorazione del codice ci pensa l'estensione Ruby LSP



## Code completion

Per l'intellisense (il completamento automatico del codice) ci pensa l'estensione Ruby LSP.

Altre estensioni da considerare sono:
- Ruby Solargraph (Intelligent code completion and documentation while you’re writing code.)
- Copilot



## Close *end*

Credo lo faccia già l'estensione Ruby LSP.

Altre estensioni da considerare sono:
- Endwise (Be wise and never forget to close the end immediately.)



## Database Schema

- Rails DB Schema (Get quick insight on the defined database schema while you’re typing.)



## Code formatter

Rubocop
[Code formatter for writing Ruby.](https://stackoverflow.com/questions/53367947/rubocop-on-vscode-not-working-error-rubocop-is-not-executable/53367974)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/08_00-gemfile_ruby_version.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/01_00-git_story.md)
