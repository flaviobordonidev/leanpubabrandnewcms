# Ranges

## Risorse esterne

- https://www.tutorialspoint.com/ruby/ruby_ranges.htm


## Ranges as Sequences
The first and perhaps the most natural use of ranges is to express a sequence. Sequences have a start point, an end point, and a way to produce successive values in the sequence.

Ruby creates these sequences using the ''..'' and ''...'' range operators. The two-dot form creates an inclusive range, while the three-dot form creates a range that excludes the specified high value.

```ruby
(1..5) #==> 1, 2, 3, 4, 5
(1...5) #==> 1, 2, 3, 4
('a'..'d') #==> 'a', 'b', 'c', 'd'
```

If you need to, you can convert a range to a list using the `to_a` method. Try the following example:

```ruby
$ rails c
> range1 = (1..10).to_a
> range2 = ('bar'..'bat').to_a
> puts "#{range1}"
> puts "#{range2}"
```

his will produce the following result:

```
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
["bar", "bas", "bat"]
```



## Ranges can be used in case statements


```ruby
score = 70

result = case score
   when 0..40 then "Fail"
   when 41..60 then "Pass"
   when 61..70 then "Pass with Merit"
   when 71..100 then "Pass with Distinction"
   else "Invalid Score"
end

puts result
```

This will produce the following result −

```
Pass with Merit
```

## Ranges as Intervals

A final use of the versatile range is as an interval test: seeing if some value falls within the interval represented by the range. This is done using ===, the case equality operator.

```ruby
if ((1..10) === 5)
   puts "5 lies in (1..10)"
end

if (('a'..'j') === 'c')
   puts "c lies in ('a'..'j')"
end

if (('a'..'j') === 'z')
   puts "z lies in ('a'..'j')"
end
```

This will produce the following result −

```
5 lies in (1..10)
c lies in ('a'..'j')
```



## Esempi con `each()`

The each() is an inbuilt method in Ruby iterates over every element in the range.

- Syntax: range1.each(|el| block)
- Parameters: The function accepts a block which specifies the way in which the elements are iterated.
- Return Value: It returns every elements in the range.


### Example 1

Ruby program for each method in Range 
  
***Initialize range***

```
range1 = (0..10)
```
  
***Prints elements***

```
puts range1.each {|el| print el, ',' } 
```

Output:

```
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0..10
```


## Example 2

Ruby program for each method in Range 
  
***Initialize range***

```
range1 = (6..12)
```
  
***Prints elements***

```
puts range1.each{|el| print el, ',' }
```

Output:

```
6, 7, 8, 9, 10, 11, 12, 6..12
```
