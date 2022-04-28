# Preloas scopes

questo è utile per ottimizzare le prestazioni (performances)


Risorse web:

* [How to Preload Rails Scopes](https://www.justinweiss.com/articles/how-to-preload-rails-scopes//?source=post_page-----5a0444d8b759----------------------)



## 

Rails’ scopes make it easy to find the records you want:

app/models/review.rb
class Review < ActiveRecord::Base
  belongs_to :restaurant

  scope :positive, -> { where("rating > 3.0") }
end
irb(main):001:0> Restaurant.first.reviews.positive.count
  Restaurant Load (0.4ms)  SELECT  `restaurants`.* FROM `restaurants`  ORDER BY `restaurants`.`id` ASC LIMIT 1
   (0.6ms)  SELECT COUNT(*) FROM `reviews` WHERE `reviews`.`restaurant_id` = 1 AND (rating > 3.0)
=> 5
But if you’re not careful with them, you’ll seriously hurt your app’s performance.

Why? You can’t really preload a scope. So if you tried to show a few restaurants with their positive reviews:

irb(main):001:0> restauraunts = Restaurant.first(5)
irb(main):002:0> restauraunts.map do |restaurant|
irb(main):003:1*   "#{restaurant.name}: #{restaurant.reviews.positive.length} positive reviews."
irb(main):004:1> end
  Review Load (0.6ms)  SELECT `reviews`.* FROM `reviews` WHERE `reviews`.`restaurant_id` = 1 AND (rating > 3.0)
  Review Load (0.5ms)  SELECT `reviews`.* FROM `reviews` WHERE `reviews`.`restaurant_id` = 2 AND (rating > 3.0)
  Review Load (0.7ms)  SELECT `reviews`.* FROM `reviews` WHERE `reviews`.`restaurant_id` = 3 AND (rating > 3.0)
  Review Load (0.7ms)  SELECT `reviews`.* FROM `reviews` WHERE `reviews`.`restaurant_id` = 4 AND (rating > 3.0)
  Review Load (0.7ms)  SELECT `reviews`.* FROM `reviews` WHERE `reviews`.`restaurant_id` = 5 AND (rating > 3.0)
=> ["Judd's Pub: 5 positive reviews.", "Felix's Nightclub: 6 positive reviews.", "Mabel's Burrito Shack: 7 positive reviews.", "Kendall's Burrito Shack: 2 positive reviews.", "Elisabeth's Deli: 15 positive reviews."]
Yep, that’s an N+1 query. The biggest cause of slow Rails apps.

You can fix this pretty easily, though, if you think about the relationship in a different way.

Convert scopes to associations
When you use the Rails association methods, like belongs_to and has_many, your model usually looks like this:

app/models/restaurant.rb
class Restaurant < ActiveRecord::Base
  has_many :reviews
end
But if you check out the documentation, you’ll see that they can do more. You can pass other parameters to those methods and change how they work.

scope is one of the most useful. It works just like the scope from earlier:

app/models/restaurant.rb
class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :positive_reviews, -> { where("rating > 3.0") }, class_name: "Review"
end
irb(main):001:0> Restaurant.first.positive_reviews.count
  Restaurant Load (0.2ms)  SELECT  `restaurants`.* FROM `restaurants`  ORDER BY `restaurants`.`id` ASC LIMIT 1
   (0.4ms)  SELECT COUNT(*) FROM `reviews` WHERE `reviews`.`restaurant_id` = 1 AND (rating > 3.0)
=> 5
Now, you can preload your new association with includes:

irb(main):001:0> restauraunts = Restaurant.includes(:positive_reviews).first(5)
  Restaurant Load (0.3ms)  SELECT  `restaurants`.* FROM `restaurants`  ORDER BY `restaurants`.`id` ASC LIMIT 5
  Review Load (1.2ms)  SELECT `reviews`.* FROM `reviews` WHERE (rating > 3.0) AND `reviews`.`restaurant_id` IN (1, 2, 3, 4, 5)
irb(main):002:0> restauraunts.map do |restaurant|
irb(main):003:1*   "#{restaurant.name}: #{restaurant.positive_reviews.length} positive reviews."
irb(main):004:1> end
=> ["Judd's Pub: 5 positive reviews.", "Felix's Nightclub: 6 positive reviews.", "Mabel's Burrito Shack: 7 positive reviews.", "Kendall's Burrito Shack: 2 positive reviews.", "Elisabeth's Deli: 15 positive reviews."]
Instead of 6 SQL calls, we only did two.

(Using class_name, you can have multiple associations to the same object. This comes in handy pretty often.)

What about duplication?
There still might be a problem here. The where("rating > 3.0") is now on your Restaurant class. If you later changed positive reviews to rating > 3.5, you’d have to update it twice!

It gets worse: If you also wanted to grab all the positive reviews a person has ever left, you’d have to duplicate that scope over on the User class, too:

app/models/user.rb
class User < ActiveRecord::Base
  has_many :reviews
  has_many :positive_reviews, -> { where("rating > 3.0") }, class_name: "Review"
end
It’s not very DRY.

There’s an easy way around this, though. Inside of where, you can use the positive scope you added to the Review class:

app/models/restaurant.rb
class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :positive_reviews, -> { positive }, class_name: "Review"
end
That way, the idea of what makes a review a positive review is still only in one place.

Scopes are great. In the right place, they can make querying your data easy and fun. But if you want to avoid N+1 queries, you have to be careful with them.

So, if a scope starts to cause you trouble, wrap it in an association and preload it. It’s not much more work, and it’ll save you a bunch of SQL calls.