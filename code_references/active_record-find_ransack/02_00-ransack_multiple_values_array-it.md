


## Risorse esterne

- [Rails Ransack gem: search for multiple values with one condition](https://stackoverflow.com/questions/70018758/rails-ransack-gem-search-for-multiple-values-with-one-condition)



## Rails Ransack gem: search for multiple values with one condition

I use ransack gem and I have a select field event_id which can be either a string or an array, eg: 90 or [ 145, 147, 148 ]

The code I have, returns an error when an array is passed in:

```ruby
ransack("job_name_cont" => job_name, "event_id_eq" => event_id).result
[1] pry(Job)> ransack("job_name_cont" => job_name, "event_id_eq" => event_ids).result 
NoMethodError: undefined method `to_i' for [145, 147, 148]:Array
Did you mean?  to_s
               to_a
               to_h
```

My model:

```ruby
class Job < ActiveRecord::Base
  belongs_to :event
end
```

```ruby
class Event < ActiveRecord::Base
  has_many :jobs, dependent: :destroy
end
```

How can i search with event_id is array?

If you look over Ransack's Search Matchers you will see one with `*_in` - match any values in array, which is what you need if you want to search in arrays.

Because your `event_ids` can come in either as a string or an array and `*_in` requires and array, we have to make sure we always feed it an array.

```ruby
[event_ids].flatten # returns an array all the time
```

The query below should works properly now.

```ruby
ransack("job_name_cont" => job_name, "event_id_in" => [event_ids].flatten).result
```
