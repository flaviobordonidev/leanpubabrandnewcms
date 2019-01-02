## Spiegazione didattica su differenza fra each, map, collect

http://queirozf.com/entries/ruby-map-each-collect-inject-reject-select-quick-reference
https://stackoverflow.com/questions/9429034/what-is-the-difference-between-map-each-and-collect


### each
Executes an action using as parameter each element of the array. Returns the unmodified array.

[1,2,3,4,5,6,7,8,9,10].each{|e| print e.to_s+"!" }
# prints "1!2!3!4!5!6!7!8!9!10!"
# returns [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] 

each performs the enclosed block for each element in the (Enumerable) receiver:

[1,2,3,4].each {|n| puts n*2}
# Outputs:
# 2
# 4
# 6
# 8



### map
Performs an action on each array element. Returns the modified array. The original array is NOT modified.

[1,2,3,4,5,6,7,8,9,10].map{|e| e*3 }
# returns [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

map produce a new Array containing the results of the block applied to each element of the receiver:

[1,2,3,4].map {|n| n*2}
# => [2,4,6,8]




#### map! 
Performs an action on each array element. Returns the modified array. The original array IS modified.

a = [1,2,3,4]

a.map {|n| n*2} # => [2,4,6,8]
puts a.inspect  # prints: "[1,2,3,4]"

a.map! {|n| n+1}
puts a.inspect  # prints: "[2,3,4,5]"




### collect 
Alias for map
map and collect are the same. Technically map is an alias for collect, but map is used a lot more frequently.
map is the community-choosen version ( https://github.com/bbatsov/ruby-style-guide#map-fine-select-reduce-size )
