# <a name="top"></a> Cap ruby_methods.04 - Blocks



## Risorse esterne

- [Understanding Ruby blocks](https://www.codewithjason.com/understanding-ruby-blocks/)


```bash
$ rails console
```


## Cos'è un `block`

Virtually all languages have a way for functions to take arguments. You pass data into a function and then the function does something with that data.

A block takes that idea to a new level. **A block is a way of passing** ***behavior*** **rather than data to a method**. The examples that follow will illustrate exactly what is meant by this.

> Ruby methods that take blocks: `times`, `each`, `map` and `tap`.



## `times`

Description of this method: “However many times I specify, repeat ***behavior*** X.”

Example: three times, print the text “hello”. (***behavior*** X is printing “hello”.)

```ruby
$ rails c
> 3.times do
>   puts "hello"
> end

# hello
# hello
# hello
```



## `each`

Description of this method: “Take this array. For each element in the array, execute ***behavior*** X.”

Example: iterate over an array containing three elements and print each element. (***behavior*** X is printing the element.)

```ruby
$ rails c
> [1, 2, 3].each do |n|
>   puts n
> end

# 1
# 2
# 3
```



## `map`

Description of this method: “Take this array. For each element in the array, execute ***behavior*** X, append the return value of X to a **new array**, and then after all the iterations are complete, return the newly-created array.”

Example: iterate over an array and square each element. (***behavior*** X is squaring the element.)

```ruby
$ rails c
> squares = [1, 2, 3].map do |n|
>   n * n
> end

> puts squares.join(",")

# 1,4,9
```



## `tap`

“See this value? Perform ***behavior*** X and then return that value.”

Example: initialize a file, write some content to it, then return the original file. (***behavior*** X is writing to the file.)

```ruby
$ rails c

> require "tempfile"

> file = Tempfile.new.tap do |f|
>   f.write("hello world")
>   f.rewind
> end

> puts file.read

# hello world
```



## Custom methods that take blocks

Now let’s look at how we can write our own method that can take a block.

An HTML generator

Here’s a method which we can give an HTML tag as well as a piece of behavior. The method will execute our behavior. Before and after the behavior will be the opening and closing HTML tags.

```ruby
inside_tag("p") do
  puts "Hello"
  puts "How are you?"
end
```

The output of this code looks like this.

```html
<p>
Hello
How are you?
</p>
```

In this example, the “Behavior X” that we’re passing to our method is printing the text “Hello” and then “How are you?”.



## The method definition

Here’s what the definition of such a method might look like.

```ruby
def inside_tag(tag, &block)
  puts "<#{tag}>"  # output the opening tag
  block.call       # call the block that we were passed
  puts "</#{tag}>" # output the closing tag
end
```


## Adding an argument to the block

Blocks can get more interesting when add arguments.

In the below example, the inside_tag block now passes an instance of Tag back to the block, allowing the behavior in the block to call tag.content rather than just puts. This allows our content to be indented.

```ruby
class Tag
  def content(value)
    puts "  #{value}"
  end
end

def inside_tag(tag, &block)
  puts "<#{tag}>"
  block.call(Tag.new)
  puts "</#{tag}>"
end

inside_tag("p") do |tag|
  tag.content "Hello"
  tag.content "How are you?"
end
```

The above code gives the following output.

```html
<p>
  Hello
  How are you?
</p>
```

Passing an object back to a block is a common DSL technique used in libraries like RSpec, Factory Bot, and Rails itself.



## The technical details of blocks

There are a lot of technical details to learn about blocks. There are some interesting questions you could ask about blocks, including the following:

- [What are the different ways to call blocks and why would you use each?](https://www.codewithjason.com/two-common-ways-call-ruby-block/)
- [What’s the difference between a proc, a block, and a lambda?](https://www.codewithjason.com/ruby-procs/)
- [What’s a Proc object and how does it relate to a block?](https://www.codewithjason.com/ruby-procs/)
- [What’s a closure?](https://www.codewithjason.com/ruby-closures/)
- [What does the & at the beginning of &block mean?](https://www.codewithjason.com/ampersand-ruby-block/)
- [When I do e.g. [1, 2, 3].map(&:to_s), how does that work?](https://www.codewithjason.com/how-map-works/)

These are all good questions worth knowing the answer to, and you can click the links above to find out. But understanding these details is not necessary in order to understand the high-level gist of blocks.

