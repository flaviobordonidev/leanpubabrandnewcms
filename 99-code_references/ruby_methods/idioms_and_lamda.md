
## Ruby Idioms

a || b
The expression a || b evaluates a. If it isn’t false or nil, then evaluation stops, and the expression returns a. Otherwise, the statement returns b. This is a common way of returning a default value if the first value hasn’t been set.

a ||= b
The assignment statement supports a set of shortcuts: a op= b is the same as a = a op b. This works for most operators.

 	count += 1 # same as count = count + 1
 	price *= discount # price = price * discount
 	count ||= 0 # count = count || 0
So, count ||= 0 gives count the value 0 if count doesn’t already have a value.

lambda
The lambda operator converts a block into an object of type Proc. We will see this used ​here​.{577.4 / 896}

