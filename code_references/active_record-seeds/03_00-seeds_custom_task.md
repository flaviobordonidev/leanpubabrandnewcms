# <a name="top"></a> Cap active_record-seeds.2 - Seeds example

Esempio



## Risorse interne

- []()



## Risorse esterne

- [Seeding a Database in Ruby on Rails](https://ninjadevel.com/seeding-database-ruby-on-rails/)



## Using a custom Rails task to seed actual data
To seed actual data, it is best to create a custom Rails task. 
Let’s generate one to add genres.
First generate the model and then migrate the database. 

```bash
$ rails g model Genre name
$ rails db:migrate
```

Finally create the `task`.

```bash
$ rails g task movies seed_genres
```

This command creates a movies rake file in the `lib/tasks` directory containing the `seed_genres` task.

Copy the code below and paste it into lib/tasks/movies.rake:


***Codice n/a - .../lib/tasks/movies.rake - line: 1***

```ruby
namespace :movies do
  desc "Seeds genres"
  task seed_genres: :environment do
    Genre.create!([{
      name: "Action"
    },
    {
      name: "Sci-Fi"
    },
    {
      name: "Adventure"
    }])

    p "Created #{Genre.count} genres"
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/seeds/01_01-db-seeds.rb)

It’s now listed in the Rails commands list:

```bash
$ rails -T movies
rake movies:seed_genres  # Seeds genres
```

Time to run it!

```bash
$ rails movies:seed_genres
"Created 3 genres"
```
