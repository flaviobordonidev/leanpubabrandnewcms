# <a name="top"></a> Cap *active_record*.6 - Trovare i records (Dynamic Finders Methods)



## Risorse esterne

- [API Rails - find](https://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-find)
- [API Rails - order](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-order)
- [14 Dynamic Finders](http://guides.rubyonrails.org/active_record_querying.html)
- [How to Use The Rails Where Method (With Examples)](https://www.rubyguides.com/2019/07/rails-where-method/)



***code 01 - .../db/migrate/xxx_create_lessons.rb - line:1***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_01-db-migrate-xxx_create_lessons.rb)


## Selezione base dei records

Apriamo la *sqlite* console.

```ruby
$ sqlite
> select * frome users limit 10;
> select "users".* FROM "users" WHERE "users"."id" = ? LIMIT ? [["id", 1], ["LIMIT", 1]]
> select "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ? [["LIMIT", 1]]
> select "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT ? [["LIMIT", 1]]
> select "users".* FROM "users" WHERE "users"."name" = ? DESC LIMIT ? [["name", "John"], ["LIMIT", 1]]
```

> `ASC` fa un ordinamento crescente sulla colonna di default che è "id".

Apriamo la rails console.

```ruby
$ rails c
> User.find(1) # OK: record with id = 1
> User.find("x") # ERROR: ActiveRecord::RecordNotFound
> User.find([1, 2]) # OK: record with id = 1 AND record with id = 2
> User.first # OK: the record with the lower "id" (usually id = 1)
> User.first(2) # OK: the two records with the lower "id"
> User.last # OK: the record with the higher "id"
> User.last(3) # OK: the three records with the higher "id"
> USer.find_by(name: "John")
```

Se non ci sono records:

- `User.first` returns `nil`
- `User.first!` returns `exception`

> Atttenzione! 
> I "bang methos", ossia quelli che finiscono con il punto esclamativo "!", sono ***dangerous***
> perché possono o ritornare un `exception` oppure eseguire un'azione di modifica.
> Vanno usati con cautela ed attenzione. (Se si può, è meglio evitarli)


Esempio:

```ruby
$ rails c
> 

```




## Selezione con `where`

Apriamo la rails console.

```ruby
$ rails c
> User.where("name = 'John'") # funziona ma è meglio approccio differente
> params = { search_term: "John" }
> User.where("name = '#{params[:search_term]}'") # funziona ma rischi attacchi di sql-injection

> User.where("name = ? AND email = ?", params[:search_term], "email")
> User.where("name = :name AND email = :email", {name: "John", email: "email"})

> User.where(name: "John")
> User.where.not(name: "John")

> User.where(name: "John").or(User.where(name: "Ann"))

> User.where(name: "John").where(name: "Emma")
```



## Selezione con *filtri*

Apriamo la rails console.

```ruby
$ rails c
> User.where("created_at >= :this_month", { this_month: Date.today.beginning_of_month}).order(created_at: :desc)
```




## Deprecated

[Railcasts 415-upgrading-to-rails-4]()

***code n/a - .../app/models/episode.rb - line:1***

```ruby
  @episodes = Episode.published.find_all_by_pro(false) # DEPRECATED!
  @episodes = Episode.published.where(pro: false) # OK!
```




## Domanda su Stackoverflow

I have a database that has stored information of some users. I know for example: User.find(1) will return the user with id:1
What should I call to find a user by email? I searched a lot but could not find anything. I also tried User.find(:email => "xyz@abc.com") but it doesn't work.

Use

```ruby
User.find_by_email("abc@xyz.com")
```

Oppure si può usare

```ruby
User.where(email: "abc@xyz.com").first
```



## Esempio 1 - Donamat. Fare le somme dei pagamenti corretti divisi per contanti e pos

```ruby
     kiosk.tot_cash_cents = kiosk.transactions.where(payment_check: "PAYMENT_OK", cash_pos: "CASH").sum(:cents)
      kiosk.tot_pos_cents = kiosk.transactions.where(payment_check: "PAYMENT_OK", cash_pos: "POS").sum(:cents)
      #kiosk.tot_donations = kiosk.transactions.where(payment_check: "PAYMENT_OK").count
      kiosk.tot_donations = kiosk.transactions.where(payment_check: "PAYMENT_OK").size
```

Per contare tutti i records è preferibile usare `.size`.



## The `where` method

In Rails, you can query the database through your models to access your data.
You can do this using ActiveRecord methods.

Like `where`, `find`, or `find_by`.

- `find_by` -> a single record or **nil**
- `where`   -> **ActiveRecord::Relation** object
- `find`    -> a single record, found by its primary column (usually **id**), raises an exception if not found



## Basic Where Conditions

The purpose of using where is to build a query that filters the information in your database, so you only get the rows you want.

For example: Given a Book model, with title, author & category. You may want to find out all the books by a specific author, or all the books filed under a particular category.

Here’s a query:

```ruby
Book.where(category: "Ruby")
```

This returns all the books with a category of “Ruby”.

You can also combine conditions.

Like this:

```ruby
Book.where(category: "Ruby", author: "Jesus Castello")
```


This returns books that match both category & author.

And you can combine where with a scope.

```ruby
# scope definition
class Book
  scope :long_title, -> { where("LENGTH(title) > 20") }
end

# controller code
@books = Book.long_title.where(category: "Ruby")
```

Using a hash (fruit: "apple"), allows you to check if a column is equal to something.

But what if you aren’t looking for equality?

Then you’ll have to use a string.

## Rails Where: Greater Than & Less Than

If you want to check for “greater than”, “less than”, or something like that…

Do it like this:

```ruby
Book.where("LENGTH(title) > 20")
```

If you need to interpolate values…

Do it like this:

```ruby
Book.where("LENGTH(title) > ?", params[:min_length])
```

This ? is called a “placeholder”, and it’s used for security to avoid “SQL injection” attacks.

Another option is to use named placeholders.

Example:

```ruby
Book.where("LENGTH(title) > :min", min: params[:min_length])
```

I find this less common than the question mark placeholder, but it could be useful for queries involving many interpolated values.



## How to Use Where Not & Where Or Conditions

Let’s look at more complex queries.

If you want to check that a condition is NOT true, then you can combine where with the not method.

Here’s an example:

```ruby
Book.where.not(category: "Java")
```

Another example:

```ruby
Book.where.not(title: nil)
```

This finds Books with a title that’s not nil.

What about an OR condition?

You can combine where with the or method to get rows that match ANY of two or more conditions.

Here’s how it works:

```ruby
Book.where(category: "Programming").or(Book.where(category: "Ruby"))
```

This combines two where queries into one.

Give it a try!

## Rails Where IN Array Example

All the examples we have seen look for one specific value.

But you can look for multiple values.

How?

Using an array!

Example:

```ruby
Book.where(id: [1,2,3])
```

This generates an “IN” query that will search, at the same time, all these ids.

```ruby
SELECT "books".* FROM "books" WHERE "books"."id" IN (1, 2, 3)
```

You’ll find this query in the rails logs.

## Rails Joins Association Condition

If you’re looking to match based on an association value, you’ll have to make that association available with the joins method.

Then you can do this:

```ruby
Book.joins(:comments).where(comments: { id: 2 })
```

With this query you get all the books, which have a comment, and the comment id is 2.

For the string version:

```ruby
Book.joins(:comments).where("comments.id = 2")
```

Where comments is the table name, and id is column name.



## How to Search Inside Text With A Where LIKE Condition

If you want to implement a search function, you may want to allow for a partial match.

You can do this with a “LIKE” query.

Here’s an example:

```ruby
Book.where("title LIKE ?", "%" + params[:q] + "%")
```

This finds all the titles that have the search text, provided by the params (params[:q]), anywhere inside the title.

> In SQL, % is a wildcard character.
