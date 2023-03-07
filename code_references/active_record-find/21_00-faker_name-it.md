# <a name="top"></a> Cap active_recors.21 - Creiamo delle persone finte



## Popoliamo la tabella *people* con dati finti / di esempio

If you need to populate your database with a lot of data, you can do it by opening up the Rails console and copy/paste this code snippet.

```bash
$ rails console
```

For this code snippet to work, you need to have the faker gem in your Gemfile.

```ruby
1000.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email)
end
```

And if you want to generate a few color records for each user, you can do it with the following code snippet.

```ruby
User.all.each do |user|
  Food.create(name: Faker::Food.vegetables, user: user)
end
```


## Altri esempi

```ruby
User.all.each do |u|
  3.times { Color.create(name: Faker::Color.color_mame, user: u)}
end
```
