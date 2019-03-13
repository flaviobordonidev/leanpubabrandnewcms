# Each vs Map

Risorse web:

* https://mixandgo.com/learn/how-to-use-ruby-each
* https://mixandgo.com/learn/how-to-use-the-ruby-map-method


## Each

You should use each when you want iteration but don’t care about what it returns.




### Looping through an array with each

~~~~~~~~
[1, 2, 3].each { |n| puts "Current number is: #{n}" }
Current number is: 1
Current number is: 2
Current number is: 3
~~~~~~~~

For every element in the array, each runs the block, passing it the element as an argument (n in the example above).

You don’t have to pass the block inline. A multiline block is recommended when you’ve got multiple lines in the block, or when the line is too long. It improves readability.

~~~~~~~~
[1, 2, 3].each do |n|
  text = "Current number is: #{n}"
  puts text
end
Current number is: 1
Current number is: 2
Current number is: 3
~~~~~~~~




### Looping through a hash with each

A hash is a list of key value pairs. We can use the method "each" in the hash just like we did with an array object. The difference is that, the block receives two arguments. The first argument is a key, and the second one is the value.

~~~~~~~~
my_hash = {min: 2, max: 5}
my_hash.each { |key, value| puts "k: #{key}, v: #{value}" }
k: min, v: 2
k: max, v: 5
~~~~~~~~




## Map

Applying "map" on an array returns a new array where each element is the result of evaluating the block with the element as an argument.

~~~~~~~~
[1, 2, 3].map { |n| n * 2 } # => [2, 4, 6]
~~~~~~~~

In this example, the block (i.e. { |n| n * 2 }) is applied to each element of the initial array (i.e. [1, 2, 3]) in turn, resulting in a new array.




### The "&:" shorthand

It’s a shorthand notation, and it’s useful when all you need to do inside the block is call a method.

~~~~~~~~
[1, 2, 3].map { |n| n.even? }
~~~~~~~~

could be written as

~~~~~~~~
[1, 2, 3].map(&:even?)
~~~~~~~~




## Map Vs Each

You use map to collect the result of running the block over the elements of the array. 
And you use each to run the block over the elements without collecting the values. 




## Map vs. collect

They are aliases for each other, so there is no difference. But map is a more popular name for what it’s doing than collect is.




## Map vs. select

select is different than the ruby map method. What select does is it returns all the objects for which the block returns a truthy value (i.e. not nil or false).
