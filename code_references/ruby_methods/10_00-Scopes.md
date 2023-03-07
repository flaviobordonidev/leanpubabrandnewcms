
## Scopes

As these chains of method calls grow longer, making the chains themselves available for reuse becomes a concern. Once again, Rails delivers. An Active Record scope can be associated with a Proc and therefore may have arguments:

```ruby
 	class Order < ActiveRecord::Base
 	scope :last_n_days, lambda { |days| where('updated < ?' , days) }
 	end
```

Such a named scope would make finding the last week’s worth of orders a snap:

```ruby
 	orders = Order.last_n_days(7)
```

Simpler scopes can simply be a set of method calls:

```ruby
 	class Order < ActiveRecord::Base
 	scope :checks, where(pay_type: :check)
 	end
```

Scopes can also be combined. Finding the last week’s worth of orders that were paid by check is just as easy:

```ruby
 	orders = Order.checks.last_n_days(7)
```

In addition to making your application code easier to write and easier to read, scopes can make your code more efficient. The previous statement, for example, is implemented as a single SQL query.

ActiveRecord::Relation objects are equivalent to an anonymous scope:

```ruby
 	in_house = Order.where('email LIKE "%@pragprog.com"')
```

Of course, relations can also be combined:

```ruby
 	in_house.checks.last_n_days(7)
```

Scopes aren’t limited to where conditions; we can do pretty much anything we can do in a method call: limit, order, join, and so on. Just be aware that Rails doesn’t know how to handle multiple order or limit clauses, so be sure to use these only once per call chain.
