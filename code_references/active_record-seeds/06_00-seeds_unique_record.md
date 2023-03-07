# <a name="top"></a> Cap active_record-seeds.6 - usiamo la faker gem

Esempio



## Risorse interne

- []()



## Risorse esterne

- [Seeding a Database in Ruby on Rails](https://ninjadevel.com/seeding-database-ruby-on-rails/)



## Initial seed

Open the db/seeds.rb file, and paste this:

```ruby
5.times do |i|
  Product.create(name: "Product ##{i}", description: "A product.")
end
```


## Loading more seeds using Faker
If you need, for example, 100 movies, you can replace your app/db/seeds.rb file with this:

***Codice 01 - app/db/seeds.rb - linea:01***

```ruby
Movie.destroy_all

100.times do |index|
  Movie.create!(title: "Title #{index}",
                director: "Director #{index}",
                storyline: "Storyline #{index}",
                watched_on: index.days.ago)
end

p "Created #{Movie.count} movies"
```

Now run `rails db:seed`:

```bash
$ rails db:seed              
"Created 100 movies"
```

But the result doesn’t look realistic at all:

```bash
$ rails runner 'p Movie.select(:title, :director, :storyline).last'
#<Movie id: nil, title: "Title 99", director: "Director 99", storyline: "Storyline 99">
```

Time to use Faker, a gem that generates random values. Add it into the development group in your Gemfile:

***Codice 02 - .../Gemfile - linea:01***

```ruby
group :development, :test do
  # ...

  gem 'faker'
end
```


Run `bundle install` and replace app/db/seeds.rb with this:

***Codice 03 - app/db/seeds.rb - linea:01***

```ruby
Movie.destroy_all

100.times do |index|
  Movie.create!(title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 0).chop,
                director: Faker::Name.name,
                storyline: Faker::Lorem.paragraph,
                watched_on: Faker::Time.between(from: 4.months.ago, to: 1.week.ago))
end

p "Created #{Movie.count} movies"
```


Check it out again:

```bash
$ rails db:seed              
"Created 100 movies"
$ rails runner 'p Movie.select(:title, :director, :storyline, :watched_on).last'
#<Movie id: nil, title: "Toy Story 2", director: "Michael Dickinson", storyline: "Modi esse et at eum deserunt harum qui itaque reru...", watched_on: "2020-11-18">
```

Much better!
