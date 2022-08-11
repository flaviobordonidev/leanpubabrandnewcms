# Seeds on separated files



## Risorse esterne

- [split-your-rails-seeds](https://medium.com/@ethanryan/split-your-rails-seeds-file-into-separate-files-in-different-folders-3c57be765818)



## Split Your Rails Seeds File into Separate Files in Different Folders

I’m working on a Rails backend app to serve as the API for my database.
The database will have a lot of screenplays within it, and each screenplay has a lot of text.

I quickly realized I didn’t want to store all those screenplays in a single seeds.rb file, as that file would be difficult to manage with inevitable edits, and annoying to keep adding to.
Luckily, there’s an easy way to split a seeds file into multiple files.

I added a **“seeds”** directory to my */db* folder.

Within that folder, I added some extra files full of data for my database.
Then in my seeds.rb file, I added this line:

***codice 01 - .../db/seeds.rb - line: 1***

```ruby
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/seeds/01_01-db-seeds.rb)

Now when I run `rake db:seed` (or `rake db:reset`, my preferred method) my Rails app loads every *.rb* file within the */db/seeds* directory.

Sweet!

But what if I want to have folders within my /db/seeds folder?
Easy, I just add another line to my seeds.rb file:

***codice n/a - .../db/seeds.rb - line: 1***

```ruby
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
Dir[File.join(Rails.root, 'db', 'seeds/folder_name_here', '*.rb')].sort.each do |seed|
  load seed
end
```

Now my Rails app loads every *.rb* file within the */db/seeds* directory, and every *.rb* file within the *seeds/folder_name_here* directory.

Even better, I can substitute that *‘folder_name_here’* with the handy splat operator, AKA the asterisk, AKA *:

***codice 02 - .../db/seeds.rb - line: 1***

```ruby
Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].sort.each do |seed|
  load seed
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/seeds/01_02-db-seeds.rb)

Now my Rails app will load every *.rb* file within *every folder* within */db/seeds*. 

So easy! Thanks splat operator.
Keeping organized and seeding databases full of data, baby!

Thanks for reading, friends.
