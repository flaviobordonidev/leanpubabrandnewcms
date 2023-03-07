# Switch "case"

Risorse web:

* [](https://stackoverflow.com/questions/6603362/ruby-on-rails-switch)
* [](https://stackoverflow.com/questions/948135/how-to-write-a-switch-statement-in-ruby)




## Case .. when

I assume you refer to case/when.

```ruby
case a_variable # a_variable is the variable we want to compare
when 1    #compare to 1
  puts "it was 1" 
when 2    #compare to 2
  puts "it was 2"
else
  puts "it was something else"
end
```

or

```ruby
puts case a_variable
when 1
  "it was 1"
when 2
  "it was 2"
else
  "it was something else"
end
```

EDIT

Something that maybe not everyone knows about but what can be very useful is that you can use regexps in a case statement.

```ruby
foo = "1Aheppsdf"

what = case foo
when /^[0-9]/
  "Begins with a number"
when /^[a-zA-Z]/
  "Begins with a letter"
else
  "Begins with something else"
end
puts "String: #{what}"
```

Thanks a lot. Can I replace a_variable with params[:id] right? – glarkou Jul 6 '11 at 22:11 
Absolutely, just make sure you are comparing variables of the same type, e.g "1" is not equal to 1. However "1".to_i is equal to 1 (to_i converts a string to an integer). If you want to compare params[:id] with an integer you need to do "case params[:id].to_i". It looks a bit strange to me to test params[:id] with "case", are you sure about what you are doing?

There are some differences from a traditional switch..case. The most notable being there is no cascading onto the next item. Another being that you can list multiple (comma separated) items in each when. Lastly, they don't just match on equality, they match on the === operator, so: String === "thing" is true, therefore when String then whatever would be matched.
Important: Unlike switch statements in many other languages, Ruby’s case does NOT have fall-through, so there is no need to end each when with a break.



## How do I write a switch statement in Ruby?

Ruby uses the case expression instead.

```ruby
case x
when 1..5
  "It's between 1 and 5"
when 6
  "It's 6"
when "foo", "bar"
  "It's either foo or bar"
when String
  "You passed a string"
else
  "You gave me #{x} -- I have no idea what to do with that."
end
```

Ruby compares the object in the when clause with the object in the case clause using the === operator. For example, 1..5 === x, and not x === 1..5.

This allows for sophisticated when clauses as seen above. Ranges, classes and all sorts of things can be tested for rather than just equality.

Unlike switch statements in many other languages, Ruby’s case does not have fall-through, so there is no need to end each when with a break. You can also specify multiple matches in a single when clause like when "foo", "bar".



## when ... then

Also worth noting, you can shorten your code by putting the when and return statement on the same line: when "foo" then "bar"




## Usando LAMBDAS

In Ruby 2.0, you can also use lambdas in case statements, as follows:

is_even = ->(x) { x % 2 == 0 }

case number
when 0 then puts 'zero'
when is_even then puts 'even'
else puts 'odd'
end
You can also create your own comparators easily using a Struct with a custom ===

Moddable = Struct.new(:n) do
  def ===(numeric)
    numeric % n == 0
  end
end

mod4 = Moddable.new(4)
mod3 = Moddable.new(3)

case number
when mod4 then puts 'multiple of 4'
when mod3 then puts 'multiple of 3'
end
(Example taken from "Can procs be used with case statements in Ruby 2.0?".)

Or, with a complete class:

class Vehicle
  def ===(another_vehicle)
    self.number_of_wheels == another_vehicle.number_of_wheels
  end
end

four_wheeler = Vehicle.new 4
two_wheeler = Vehicle.new 2

case vehicle
when two_wheeler
  puts 'two wheeler'
when four_wheeler
  puts 'four wheeler'
end
(Example taken from "How A Ruby Case Statement Works And What You Can Do With It".)





## Precisazione sulle CLASSI

This means that if you want to do a case ... when over an object's class, this will not work:

---
obj = 'hello'
case obj.class
when String
  print('It is a string')
when Fixnum
  print('It is a number')
else
  print('It is not a string or number')
end
Will print "It is not a string or number".
---

Fortunately, this is easily solved. The === operator has been defined so that it returns true if you use it with a class and supply an instance of that class as the second operand:

---
Fixnum === 1 # => true
---
In short, the code above can be fixed by removing the .class:

---
obj = 'hello'
case obj  # was case obj.class
when String
  print('It is a string')
when Fixnum
  print('It is a number')
else
  print('It is not a string or number')
end
---

I hit this problem today while looking for an answer, and this was the first appearing page, so I figured it would be useful to others in my same situation.

Having the .class part in is interesting to note, thanks. 
Of course, this is entirely appropriate behavior (though I could see how it might be a common mistake to think that would print It is a string)... 
you're testing the class of some arbitrary object, not the object itself. 
So, for example: 

---
case 'hello'.class 
when String then "String!" 
when Class then "Class!" 
else "Something else" 
end 
---
results in: "Class!" This works the same for 1.class, {}.class, etc. Dropping .class, we get "String!" or "Something else" for these various values. – lindes A

thanks for this! this is more elegant than my solution which was to use "case obj.class.to_s"



## Gestione del fallthrough

Many programming languages, especially those derived from C, have support for the so-called Switch Fallthrough. I was searching for the best way to do the same in Ruby and thought it might be useful to others:

In C-like languages fallthrough typically looks like this:

switch (expression) {
    case 'a':
    case 'b':
    case 'c':
        // Do something for a, b or c
        break;
    case 'd':
    case 'e':
        // Do something else for d or e
        break;
}
In Ruby, the same can be achieved in the following way:

case expression
when 'a', 'b', 'c'
  # Do something for a, b or c
when 'd', 'e'
  # Do something else for d or e
end
This is not strictly equivalent, because it's not possible to let 'a' execute a block of code before falling through to 'b' or 'c', but for the most part I find it similar enough to be useful in the same way.





## Esempio sui numeri

---
case n
when 0
  puts 'You typed zero'
when 1, 9
  puts 'n is a perfect square'
when 2
  puts 'n is a prime number'
  puts 'n is an even number'
when 3, 5, 7
  puts 'n is a prime number'
when 4, 6, 8
  puts 'n is an even number'
else
  puts 'Only single-digit numbers are allowed'
end
---

Another example:

---
score = 70

result = case score
   when 0..40 then "Fail"
   when 41..60 then "Pass"
   when 61..70 then "Pass with Merit"
   when 71..100 then "Pass with Distinction"
   else "Invalid Score"
end

puts result
---




## Altri esempi

With parameter:

---
case a
when 1
  puts "Single value"
when 2, 3
  puts "One of comma-separated values"
when 4..6
  puts "One of 4, 5, 6"
when 7...9
  puts "One of 7, 8, but not 9"
else
  puts "Any other thing"
end
---

Without parameter:

---
case
when b < 3
  puts "Little than 3"
when b == 3
  puts "Equal to 3"
when (1..10) === b
  puts "Something in closed range of [1..10]"
end
---



## Esempio su views/posts/show



{title=".../app/views/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
<% case @post.type_of_content %>
<% when "image" %>
  <% raise "image" %>
<% when "video_youtube" %>
  <% raise "video_youtube" %>
<% when "video_vimeo" %>
  <% raise "video_vimeo" %>
<% when "audio" %>
  <% raise "audio" %>
<% else %>
  <% raise "menu a cascata type_of_content null o con valore non consentito" %>
<% end %>
~~~~~~~~




## Esempio sul menu di navigazione navbar

```
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <% case params[:locale] %>
          <% when "en" %>
            Inglese
          <% when "it" %>
            Italiano
          <% else %>
            Italiano <!-- default -->
          <% end %>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <%= link_to params.permit(:locale).merge(locale: 'en'), class: "dropdown-item #{'active' if params[:locale] == 'en'}" do %>
            <span class="glyphiconmy ico_language_us right-pad"></span> Inglese
          <% end %>
          <%= link_to params.permit(:locale).merge(locale: "it"), class: "dropdown-item #{'active' if params[:locale] == 'it'}" do %>
            <span class="glyphiconmy ico_language_it right-pad"></span> Italiano
          <% end %>
        </div>
      </li>
```
