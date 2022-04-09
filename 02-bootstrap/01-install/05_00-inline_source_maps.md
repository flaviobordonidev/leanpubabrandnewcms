





## TURN ON INLINE SOURCE MAPS (SO WE CAN DEBUG RAILS 7 BOOTSTRAP)

- [TURN ON INLINE SOURCE MAPS](https://jasonfleetwoodboldt.com/courses/stepping-up-rails/rails-7-bootstrap/)
- [sassc-rails gem README](https://github.com/sass/sassc-rails)

Inline Source Maps
With SassC-Rails, it's also extremely easy to turn on inline source maps. Simply add the following configuration to your development.rb file.

***codice 03 - .../config/environments/development.rb - line:55***

```ruby
 config.sass.inline_source_maps = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_01-views-layouts-application.html.erb)


After adding this config line, you may need to clear your assets cache.

```bash
$ rm -r tmp/cache/assets
 ```

Stop spring, and restart your rails server. 

You may also wish to disable line comments (config.sass.line_comments = false).

***codice n/a - .../config/environments/development.rb - line:55***

```ruby
 config.sass.line_comments = false
```

Note, as indicated, these source maps are inline. They will not generate additional files or anything like that. Instead, they will be appended to the compiled application.css file.


What is a source map?
A source map is a file that maps from the transformed source to the original source, enabling the browser to reconstruct the original source and present the reconstructed original in the debugger.

Why an *inline* source map?
Today I learned that it is possible to include source maps directly into your minified JavaScript file instead of having them in a separate example.min.map file. I wonder: why would anybody want to do something like that?

- The benefit of having source maps is clear to me: one can for example debug errors with the original, non-compressed source files while running the minified files. 
- The benefit of minimization is also clear: the size of source files is greatly reduced, making it quicker for browsers to download.

So why on Earth I would want to include the source maps into the minified file, given that the maps have size even greater than the minified code itself?

I searched around and the only reason I could see that people inline source maps is for use in development. Inlined source maps should not be used in production.

The rational for inlining the source maps with your minified files is that the browser is parsing the exact same JavaScript in development and production. Some minifiers like Closure Compiler do more than 'just' minify the code. Using the advanced options it can also do things like: dead code removal, function inlining, or aggressive variable renaming. This makes the minified code (potentially) functionally different than the source file.



