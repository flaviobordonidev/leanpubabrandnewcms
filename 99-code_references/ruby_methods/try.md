# try

try can make your code shorter when you are dealing with potential nil objects.



## Risorse esterne

- https://coderwall.com/p/nnmjjq/try-method-do-you-need-it
- 



## il post del blog

What is "try"?
Have you ever end up with this code?

@person && @person.name
We are doing that since we don't know here if @person is nil value. However we can refactor this line with try:

@person.try(:name)
Which is equivalent to

@person.nil? ? nil : @person.name
So no exception is raised and name method is called if @person is nil. We are happy:)

Picture

Arguments
The first argument is the method name, and other arguments are passed as arguments to the called method.

@people.take(5)
can be written as:

@people.try(:take, 5)
Method Chaining
try method returns always nil if called on nil object:

nil.try(:foo) # => nil
Thanks to that we can refactor this:

@person && @person.name && @person.name.downcase == "Kavinsky"
into that:

@person.try(:name).try(:downcase) == "Kavinsky"
Picture

You can take it even further to avoid repeating try:

"Don'tRepeatYourselfs ".try_chain(:underscore, :capitalize, :chop!, :chop!)
Where does try come from?
try method is defined on Object class and NilClass class in Rails and it's not part of Ruby itself. However if you want use it without Rails, you can install activesupport gem only and then call:

require 'active_support/core_ext/object/try'
Do you really need to use try?
I'm wondering if you ever need to use try. I had a big problem coming up with real example so I just grabbed it from Rails source code. Let's take a look at some examples from another blog post describing try to see if we can avoid try

@manufacturer.products.first.try(:enough_in_stock?, 32) # => "Yes"
Why the heck would you ask this query?

@manufacturer.products.try(:collect) { |p| p.name } # => ["3DS", "Wii"]
Here you can use @manufacturer.products.collect since products will return an array which responds to collect (if you use has_many association in the model).

What about this one? Is try really necessary here?

if current_user.try(:is_admin?)
We don't have to use try if we represent special case as another object (like in Confident Ruby book section 2.2). The problem try wants to solve is that we don't want to get NoMethodError calling is_admin? on nil object. So what we can do is to make the object respond to the desired method is_admin? by defining the method. The current_user method can actually return an instance of the following class if the user is not signed in:

class GuestUser
   def is_admin?
    false
   end
end
Now you can use:

if current_user.is_admin?
Conclusion
try can make your code shorter when you are dealing with potential nil objects. However I would always think about the code redesign first before injecting try into your code.

Note:

Just for the sake of completeness try method accepts a block.
More on that here http://api.rubyonrails.org/classes/Object.html#method-i-try

2.0.0p195, Rails 3.2


## Varie


```ruby
if current_user.try(:role_admin?)
  # do something
end
```

Se *current_user* è *nil* non viene generato un errore (raising an undefined method admin? for nil:NilClass exception).

> DA VERIFICARE!!

