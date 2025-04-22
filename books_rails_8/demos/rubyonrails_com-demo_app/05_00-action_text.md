# <a name="top"></a> Action text

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.



## Action text

Let's install `action_text` that is one of the framework that is part of Rails but it's not set up by default but you can set it up by running `rails action_text:install`

```shell
❯ rails action_text:install
❯ rails db:migrate
```

That's going to give you a WYSIWYG editor (What You See Is What You Get), that is currently powered by `Trix`! (The open source WYSIWYG editor made in JavaScript!). And it also sets up Active Storage.
Active Storage is a way to deal with attachments and other files in your Rails application.

Esempio:

```shell
❯ rails action_text:install
Installing JavaScript dependencies
      append  app/javascript/application.js
      append  config/importmap.rb
      create  app/assets/stylesheets/actiontext.css
      create  app/views/active_storage/blobs/_blob.html.erb
      create  app/views/layouts/action_text/contents/_content.html.erb
Ensure image_processing gem has been enabled so image uploads will work (remember to bundle!)
        gsub  Gemfile
       rails  railties:install:migrations FROM=active_storage,action_text
Copied migration 20250413204817_create_active_storage_tables.active_storage.rb from active_storage
Copied migration 20250413204818_create_action_text_tables.action_text.rb from action_text
      invoke  test_unit
      create    test/fixtures/action_text/rich_texts.yml

❯ rails db:migrate
Could not find gem 'image_processing (~> 1.2)' in locally installed gems.
Run `bundle install --gemfile /Users/fb/ror/blog/Gemfile` to install missing gems.

❯ bundle install --gemfile /Users/fb/ror/blog/Gemfile
Fetching gem metadata from https://rubygems.org/.........
Resolving dependencies...
Fetching ffi 1.17.1 (arm64-darwin)
Fetching mini_magick 5.2.0
Installing mini_magick 5.2.0
Installing ffi 1.17.1 (arm64-darwin)
Fetching ruby-vips 2.2.3
Installing ruby-vips 2.2.3
Fetching image_processing 1.14.0
Installing image_processing 1.14.0
Bundle complete! 22 Gemfile dependencies, 122 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
1 installed gem you directly depend on is looking for funding.
  Run `bundle fund` for details

❯ rails db:migrate
== 20250413204817 CreateActiveStorageTables: migrating ========================
-- create_table(:active_storage_blobs, {id: :primary_key})
   -> 0.0024s
-- create_table(:active_storage_attachments, {id: :primary_key})
   -> 0.0015s
-- create_table(:active_storage_variant_records, {id: :primary_key})
   -> 0.0013s
== 20250413204817 CreateActiveStorageTables: migrated (0.0053s) ===============

== 20250413204818 CreateActionTextTables: migrating ===========================
-- create_table(:action_text_rich_texts, {id: :primary_key})
   -> 0.0062s
== 20250413204818 CreateActionTextTables: migrated (0.0062s) ==================
❯
```

Facciamo ripartire il server `puma`.

```shell
❯ bin/dev
```



## andiamo al model `Post`

***Codice 01 - .../app/models/post.rb - linea:1***

```ruby
class Post < ApplicationRecord
  has_rich_text :body
end
```

Questo converte il campo `body` da "plain text" a "rich text" che ha un suo editor WYSIWYG ed accetta attachments and uploads.



## andiamo al view/partial `posts/_form`

Per usare il rich text dobbiamo cambiare la dichiarazione da `textarea` a `rich_textarea`

***Codice 02 - .../app/views/posts/_form.html.erb - linea:21***

```html
    <%= form.textarea :body %>
```


***Codice 03 - .../app/views/posts/_form.html.erb - linea:21***

```html
    <%= form.rich_textarea :body %>
```




## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
