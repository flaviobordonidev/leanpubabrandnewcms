# <a name="top"></a> Cap active_record-seeds.4 - Seeds using console

Esempio



## Risorse interne

- []()



## Risorse esterne

- [Seeding a Database in Ruby on Rails](https://ninjadevel.com/seeding-database-ruby-on-rails/)



## Loading seeds using the console

The console is handy for playing with your data.
Did you know that you can load and access your seeds from the inside? Try this:

```ruby
$ rails c
Loading development environment (Rails 6.1.3)
> Rails.application.load_seed
```

> Per modifiche non permanenti apri la console in modalità "sandbox"

```ruby
$ rails c --sandbox
Loading development environment (Rails 6.1.3)
> Rails.application.load_seed
```


## Playing with data using the console sandbox
Sometimes you will need to run destructive commands on real data in your development or production environment without making the changes permanent. It’s kind of like a safe mode where you can do whatever you want and then go to a previous state.

This mode is called sandbox, and you can access it with the command `rails c --sandbox`

This technique is handy for debugging a real database, such as when a user says they are trying to update their profile name and see a weird error. You could reproduce that error directly using sandbox mode without affecting the actual data.