# <a name="top"></a> Cap best-practiesr.2 - Sulla sicurezza

Buone pratiche per il nome del controller dell'homepage



## Risorse interne

- []()



## Risorse esterne

- [Welcome/home page in Ruby on Rails - best practice](https://stackoverflow.com/questions/349743/welcome-home-page-in-ruby-on-rails-best-practice)



## Il nome per il controller dell'homepage

The [official Ruby on Rails routing guide](http://guides.rubyonrails.org/routing.html#using-root) uses `PagesController`. It actually suggests `pages#main`, though to me it makes more sense to go with `pages#home` (because "homepage" is the ubiquitous term/concept). Additionally, this controller can handle other *page-oriented* actions such as `pages#about`, `pages#contact`, `pages#terms`, `pages#privacy`, etc.
