# methods .new .save .create .build


* .create  is equivalent to .new followed by .save. It's just more succinct.
* .create! is equivalent to .new followed by .save! (throws an error if saving fails).

For create, one cannot pass false as an argument which you can do with save. Passing false as an argument will skip all rails validations
Although it is correct that create calls new and then save there is a big difference between the two alternatives in their return values.
Save returns either true or false depending on whether the object was saved successfully to the database or not. This can then be used for flow control as per the first example in the question above.
Create will return the model regardless of whether the object was saved or not. This has implications for the code above in that the top branch of the if statement will always be executed even if the object fails validations and is not saved.
If you use create with branching logic you are at risk of silent failures which is not the case if you use new + save.
create! doesn't suffer from the same issue as it raises and exception if the record is invalid.
The create alternative can be useful in controllers where respond_with is used for API (JSON/XML) responses. In this case the existence of errors on the object will cause the errors to be returned in the response with a status of unprocessable_entity, which is exactly what you want from an API.
I would always use the new + save option for html, especially if you are relying on the return value for flow control.

3. .build   is mostly an alias for .new. The most important part, however, is that these methods can be called through an association (has_many, etc.) to automatically link the two models.

Build is different from New. But the difference is not that it sets the association link (New does that too for the new instance). The difference is that Build populates the caller with the new instance, but New doesn't. So for example: Wall.posts.new gives you a new post associated with your Wall, but Wall.posts is still empty after this call. Wall.posts.build gives you a new post associated with your Wall, and your Wall.posts now has one post in it.
The only difference between some_firm.clients.new and some_firm.clients.build seems to be that build also adds the newly-created client to the clients collection:

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
henrym:~/testapp$ rails c
Loading development environment (Rails 3.0.4)
r:001 > (some_firm = Firm.new).save   # Create and save a new Firm
=> true
r:002 > some_firm.clients         # No clients yet
 => []
r:003 > some_firm.clients.new     # Create a new client
 => #<Client id: nil, firm_id: 1, created_at: nil, updated_at: nil>
r:004 > some_firm.clients         # Still no clients
 => []
r:005 > some_firm.clients.build   # Create a new client with build
 => #<Client id: nil, firm_id: 1, created_at: nil, updated_at: nil>
r:006 > some_firm.clients         # New client is added to clients
 => [#<Client id: nil, firm_id: 1, created_at: nil, updated_at: nil>]
r:007 > some_firm.save
 => true
r:008 > some_firm.clients         # Saving firm also saves the attached client
 => [#<Client id: 1, firm_id: 1, created_at: "2011-02-11 00:18:47",
updated_at: "2011-02-11 00:18:47">]
~~~~~~~~


If you're creating an object through an association, build should be preferred over new as build keeps your in-memory object, some_firm (in this case) in a consistent state even before any objects have been saved to the database.

Since RAILS 3.2 > "build" is just an alias for "new":
  alias build new
  * Check its code here: https://github.com/rails/rails/blob/master/activerecord/lib/active_record/relation.rb)


RAILS 2.0 exapmle:

http://stackoverflow.com/questions/783584/ruby-on-rails-how-do-i-use-the-active-record-build-method-in-a-belongs-to-rel
I have been unable to find any documentation on the .build method in Rails (i am currently using 2.0.2).
Through experimentation it seems you can use the build method to add a record into a has_many relationship before either record has been saved.
For example:

{title="model", lang=ruby, line-numbers=off}
~~~~~~~~
class Dog < ActiveRecord::Base
  has_many :tags
  belongs_to :person
end

class Person < ActiveRecord::Base
  has_many :dogs
end
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
rails c
d = Dog.new
d.tags.build(:number => "123456")
d.save # => true
~~~~~~~~

This will save both the dog and tag with the foreign keys properly. This does not seem to work in a belongs_to relationship.

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
d = Dog.new
d.person.build # => nil object on nil.build
~~~~~~~~

I have also tried

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
d = Dog.new
d.person = Person.new
d.save # => true
~~~~~~~~

The foreign key in Dog is not set in this case due to the fact that at the time it is saved, the new person does not have an id because it has not been saved yet.

My questions are:
    How does build work so that Rails is smart enough to figure out how to save the records in the right order?
    How can I do the same thing in a belongs_to relationship?
    Where can I find any documentation on this method?


Where it is documented:
From the API documentation under the has_many association in "Module ActiveRecord::Associations::ClassMethods"
http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
collection.build(attributes = {}, …) Returns one or more new objects of the collection type that have been instantiated with attributes and linked to this object through a foreign key, but have not yet been saved. Note: This only works if an associated object already exists, not if it‘s nil!

The answer to building in the opposite direction is a slightly altered syntax. In your example with the dogs,

{title="model", lang=ruby, line-numbers=off}
~~~~~~~~
Class Dog
   has_many :tags
   belongs_to :person
end

Class Person
  has_many :dogs
end
~~~~~~~~

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
d = Dog.new
d.build_person(:attributes => "go", :here => "like normal")
~~~~~~~~

or even

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
d = Tag.new
d.build_dog(:name => "Rover", :breed => "Maltese")
~~~~~~~~

You can also use create_dog to have it saved instantly (much like the corresponding "create" method you can call on the collection)
