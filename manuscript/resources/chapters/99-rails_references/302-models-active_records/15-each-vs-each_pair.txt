# Differenza fra each ed each_pair

Non c'è nessuna differenza. Condividono lo stesso codice. Sono alias uno dell'altro.


* https://stackoverflow.com/questions/46435551/in-ruby-whats-the-advantage-of-each-pair-over-each-when-iterating-through-a


Let's say I want to access the values of a hash like this:

```
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
```

I could use #each with two parameters:

```
munsters.each do |key, value| 
    puts "#{name} is a #{values["age"]}-year-old #{values["gender"]}."
end
```

Or I could use #each_pair with two parameters:

```
munsters.each_pair do |key, value| 
    puts "#{name} is a #{values["age"]}-year-old #{values["gender"]}."
end
```

Perhaps the difference between the two is not borne out in this simple example, but can someone help me to understand the advantage of using #each_pair over #each ?


Answer

Because Hash is an Enumerable, it has to have an each method. each_pair may be a clearer name, since it strongly suggests that two-element arrays containing key-value pairs are passed to the block.

They are aliases for each other: they share the same source code.

