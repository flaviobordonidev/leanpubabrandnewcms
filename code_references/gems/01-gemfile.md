# il Gemfile

## Risorse esterne

- [RubyGem Specifiers](https://guides.rubygems.org/patterns/#pessimistic-version-constraint)



## Come sono gestite le versioni delle gemme


> Evitiamo la prossima versione principale (next major version) con modifiche sostanziali (breaking changes): <br/>
> `gem 'devise', '~> 4.8', '>= 4.8.1'` <br/>
> Ma accettiamo tutti gli aggiornamenti minori che risolvono i bugs (patch digit).


---
Sul Gemfile per mettere più gruppi su un'unica riga si usa un array []. Es:

# Call 'byebug' anywhere in the code to stop execution and get a debugger console
gem 'byebug', group: [:development, :test]
