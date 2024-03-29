# <a name="top"></a> Cap migrate.10 - Cambia una colonna per valori unici

How do I make a column unique and index it in a Ruby on Rails migration?



## Risorse web:

- [how-do-i-make-a-column-unique-and-index-it](https://stackoverflow.com/questions/1449459/how-do-i-make-a-column-unique-and-index-it-in-a-ruby-on-rails-migration)


I would like to make a column unique in Ruby on Rails migration script. What is the best way to do it? Also is there a way to index a column in a table?

I would like to enforce unique columns in a database as opposed to just using `:validate_uniqueness_of`.

The short answer:

```ruby
add_index :table_name, :column_name, unique: true
```

To index multiple columns together, you pass an array of column names instead of a single column name,

```ruby
add_index :table_name, [:column_name_a, :column_name_b], unique: true
```

For finer grained control, there's a "execute" method that executes straight SQL.

That's it!

If you are doing this as a replacement for regular old model validations, just check to see how it works. I'm not sure the error reporting to the user will be as nice. You can always do both.




## Esempio 1 - donamat semplice

Evito doppioni sulla sola colonna "id_check"

```bash
$ rails g migration AddUniqueToIdCheckInTransactions
```

***code: n/a - .../db/migrate/xxx_add_video_id_and_social_media_to_posts.rb - line:1***

```ruby
class AddUniqueToIdCheckInTransactions < ActiveRecord::Migration[5.0]
  def change
    add_index :transactions, :id_check, unique: true
  end
end
```

Questo non mi è utile perché ogni chiosco ha una sua numerazione che ricomincia da "1" per le transazioni.
Quindi il campo id_check ha duplicati perche ogni chiosco ha la sua numerazione.
Facciamo un indice multiplo kiosk_id -> id_check

***code: n/a - .../db/migrate/xxx_add_video_id_and_social_media_to_posts.rb - line:1***

```ruby
class AddUniqueToIdCheckInTransactions < ActiveRecord::Migration[5.0]
  def change
    add_index :transactions, [:kiosk_id, :id_check], unique: true
  end
end
```
