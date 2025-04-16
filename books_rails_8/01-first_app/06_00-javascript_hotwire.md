# <a name="top"></a> JavaScript and Hotwire

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.



## Hotwire

Hotwire gives you Turbo which is a way of accelerating page changes and updates your application will feel as fast and as smooth as a single page application, without you having to write any JavaScript at all.

And then, there's the Stimulus framework for creating that additional functionality that you might need in a really simple way. 
You can have a look at *hotwire.dev* to see more about that.



## Vediamo `importmap`


***Codice 01 - .../config/importmap.rb - linea:1***

```ruby
# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
```

What we're gonna add here is a little piece of JavaScript to just add some additional functionality, pulling something in from NPN!


```shell
❯ bin/importmap pin local-time
```

Esempio:

```shell
❯ bin/importmap pin local-time
Pinning "local-time" to vendor/javascript/local-time.js via download from https://ga.jspm.io/npm:local-time@3.0.3/app/assets/javascripts/local-time.es2017-esm.js
```

So, we can do that using the `importmap pin` command. And as you see, now that I hope back into our config importmap, we've added the local text pin at the bottom, version 3.0.3

***Codice 02 - .../config/importmap.rb - linea:10***

```ruby
pin "local-time" # @3.0.3
```

It pulled that straight off NPN, it downloaded that as a vendor dependency that we can check into our version control system. 
And now, we don't have any runtime dependency whatsoever on NPN, or anything else like that. You don't need anything beyond what Rails ship you with already because Rails 8 is all NO build by default!
That means there's not a transpiler, there's not a bundler, these files are shipped directly to the browser over HTTP2.
And the importmap is what allows us to refer to these files by their *logical names* while still doing far future digestiong, so that they load really quick, and such that they're easily compatible with CDNs and all that goof stuff.



## Vediamo `application.js`

But now that we added that, let's have a look at our `application.js` file.

***Codice 03 - .../app/javascript/application.js - linea:1***

```javascript
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
```

That's the default setup that you have, that the scaffold is going to use.
And as you can see, we're using `turbo-rails`, we're including all the `stimulus controllers`, if we have any.
We're including `trix` and `actiontext` to give the WYSIWYG.
And now we're gonna add that `local-time` packages as well, and we're goinna start `local-time` here.

***Codice 04 - .../app/javascript/application.js - linea:8***

```javascript
import LocalTime from "local-time"
LocalTime.start()
```



## Vediamo la view/partial `views/posts/_post`


Apriamo il partial `_post`

***Codice 05 - .../app/views/posts/_post.html.erb - linea:8***

```html
<div id="<%= dom_id post %>">
  <p>
    <strong>Title:</strong>
    <%= post.title %>
  </p>

  <p>
    <strong>Body:</strong>
    <%= post.body %>
  </p>

</div>
```

And we're using the local-time for adding the updated_at timestamp here.

***Codice 06 - .../app/views/posts/_post.html.erb - linea:8***

```html
  <p>
    <strong>Updated at:</strong>
    <%= time_tag post.updated_at, "data-local": "time", "data-format": "%B %e, %Y %l:%M%P" %>
  </p>
```

And as you can see we're just adding a time_tag, that's just a vanilla HTML tag that has a data local time, that's what activates the local-time JavaScript setup. And we will give it a format for what it should do with that UTC timestamp, and turning it into a local-time that we can have a look at. 



## Vediamo nel browser

```shell
❯ bin/dev
```

So if I reload the browser you see the date of the updated post in the *local time zone* of where you are, but actually underneath, the time tag is gonna be in UTC.

That means we can cache this, and anyone around the world will still get the time displayed in their local time.



## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
