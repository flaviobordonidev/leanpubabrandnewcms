# <a name="top"></a> Cap active_record-seeds.1 - Seeds example

Popoliamo la tabella di esempio `movies`.



## Risorse interne

- []()



## Risorse esterne

- [Seeding a Database in Ruby on Rails](https://ninjadevel.com/seeding-database-ruby-on-rails/)



## Creiamo il model `Movie` e relativa tabella `movies`


```bash
$ rails g model Movie title director storyline:text watched_on:date
```

Here you are setting the title and director as strings (default type if not specified), storyline as text, and watched_on as date (when setting dates, not datetimes, the convention is to append on to the name).

Rails will generate a migration for you adapted to the default database, which is SQLite. Migrations are saved in db/migrate. Let’s see how it looks like!

***Codice n/a - .../db/migration.rb - line: 1***

```ruby
class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.text :storyline
      t.date :watched_on

      t.timestamps
    end
  end
end
```

As you can see, Rails adds the version you are using in square brackets at the end of the parent class.
The timestamps statement will generate the created_at and updated_at fields automatically. Very handy.
Let’s run it.

```bash
$ rails db:migrate
```



## Creating some seeds
Open the db/seeds.rb file, and paste this:


***Codice n/a - .../db/seeds.rb - line: 1***

```ruby
Movie.destroy_all

Movie.create!([{
  title: "Soul",
  director: "Pete Docter",
  storyline: "After landing the gig of a lifetime, a New York jazz pianist suddenly finds himself trapped in a strange land between Earth and the afterlife.",
  watched_on: 1.week.ago
},
{
  title: "The Lord of the Rings: The Fellowship of the Ring",
  director: "Peter Jackson",
  storyline: "The Fellowship of the Ring embark on a journey to destroy the One Ring and end Sauron's reign over Middle-earth. A young Hobbit known as Frodo has been thrown on an amazing adventure, when he is appointed the job of destroying the One Ring, which was created by the Dark Lord Sauron.",
  watched_on: 2.years.ago
},
{
  title: "Terminator 2",
  director: "James Cameron",
  storyline: "Terminator 2 follows Sarah Connor and her ten-year-old son John as they are pursued by a new, more advanced Terminator: the liquid metal, shapeshifting T-1000, sent back in time to kill John Connor and prevent him from becoming the leader of the human resistance.",
  watched_on: 3.years.ago
}])

p "Created #{Movie.count} movies"
```

First, you destroy all movies to have a clean state and add three movies passing an array to the create method. The seeds file uses Rails ActiveSupport, to use those handy Ruby X.ago statements to define dates.



In the end, there’s some feedback about the total movies created. Let’s run it!

```bash
$ rails db:seed
> "Created 3 movies"
```

You can execute this command as many times as you need. Existing records are deleted thanks to the first line containing the destroy statement.

To check them, you can use rails runner:

```bash
$ rails runner 'p Movie.pluck :title'
> ["Soul", "The Lord of the Rings: The Fellowship of the Ring", "Terminator 2"]
```



## Setup the Database
The rails `db:setup` task will create the database, load the schema and initialize it with the seed data.



## Resetting the Database
The rails `db:reset` task will drop the database and set it up again. This is functionally equivalent to rails `db:drop` `db:setup`.

```
$ rails db:seed
"Created 3 movies"
```

