# Callbacks

Risorse web

* [Rails Guides](http://guides.rubyonrails.org/active_record_callbacks.html)
* [Best practise](https://engineering.gusto.com/the-rails-callbacks-best-practices-used-at-gusto/)
* [Callbacks usin Concern](https://medium.freecodecamp.org/add-callbacks-to-a-concern-in-ruby-on-rails-ef1a8d26e7ab)




## ActiveRecord Callbacks
Callbacks are methods that are triggered when certain events happen in the lifecycle of an ActiveRecord model. A list of ActiveRecord Callbacks can be seen on the Rails Guides. To give you an idea of some of the callbacks available:

* before_validation
* after_validation
* before_save
* before_create
* before_update
* before_destroy
* after_save
* after_create
* after_update
* after_destroy
* around_save
* around_create
* around_update
* around_destroy
* after_commit/after_rollback (which are linked to database entries / rollbacks)
* after_initialize (when new is called on a record)
* after_find (whenever Active Record loads a record from the database)
* after_touch (when a record is touched)

I> before_action è una callback ma è usata più nei controllers e non nei models


---


~~~~~~~~
class User < ApplicationRecord
  before_validation :normalize_name, on: :create
 
  # :on takes an array as well
  after_validation :set_location, on: [ :create, :update ]
 
  private
    def normalize_name
      self.name = name.downcase.titleize
    end
 
    def set_location
      self.location = LocationService.query(self)
    end
end
~~~~~~~~

It is considered good practice to declare callback methods as private. If left public, they can be called from outside of the model and violate the principle of object encapsulation.
