# <a name="top"></a> Cap 99.action_view.01 - dom_id

Rails 7 lo ha introdotto come codice compilato in automatico facendo il `generate scaffold`.



## Risorse esterne

- [stackoverflow - how dom_id/class works](https://stackoverflow.com/questions/24518804/how-does-dom-id-and-dom-class-work-in-rails)
- [use dom_id](https://williamkennedy.ninja/rails/2021/02/23/use-dom-id-to-clean-up-views/)


## stackoverflow

Can anyone give a brief explaination on how *dom_id* and *dom_class* work in rails ?

*dom_id* and *dom_class* are helper methods you can use in your HTML to get consistent html id attributes and class attributes for objects.

- [vedi](http://api.rubyonrails.org/classes/ActionView/RecordIdentifier.html#method-i-dom_id)

As an example, you might want to do the following in an index page:

```html+erb
<ul>
  <%= @accounts.each do |account| %>
    <li id="<%= dom_id(account) %>">
      <%= account.title %>
      <%= link_to "Edit", edit_account_path(account), class: dom_class(account, :edit) %>
    </li>
  <% end %>
</ul>
```

This will give you a list where each *li tag* has an id in the format of *account_X* where *X* is the ActiveRecord ID. 
You can use this ID then for javascript, etc to target the right elements.

In addition, the code above would give each *edit link* a class of *edit_account* if you want styling or selection of those common elements.



## altro esempio

dom_id(record, prefix = nil) public
The DOM id convention is to use the singular form of an object or class with the id following an underscore. If no id is found, prefix with “new_” instead.

```ruby
dom_id(Post.find(45))       # => "post_45"
dom_id(Post.new)            # => "new_post"
```

If you need to address multiple instances of the same class in the same view, you can prefix the dom_id:

```ruby
dom_id(Post.find(45), :edit) # => "edit_post_45"
dom_id(Post.new, :custom)    # => "custom_new_post"
```



## altro esempio

If you’ve written code like below, *dom_id* may help you in the future.

```html+erb
<% @posts.each do |post| %>
  <p id="index_post_<%= post.id %>"></p>
<% end %>
```

There is nothing wrong here, the issue arises when you have to interact with the dom via Javascript or a background job. Your code ends being a little less dry because you have to remember that you prepended *index_post_<%= post.id %>* every time.

I have come across code like this in a js.erb template.

```html+erb
var post = document.querySelector("#index_post_<%= @post.id %>")  
```

And in the background job or service worker, you will also have to remember this format if you plan on using something like cable ready to update the dom.

Luckily, *dom_id* provided a simple way to clean up all that code and make everything DRYer.

### How do you use dom_id in a view

Let’s imagine we have a Post model.

The dom_id methods take one argument and one optional argument for a prefix.

```ruby
# without prefix
dom_id(Post.find(2))       # => "post_2”
dom_id(Post.new)            # => "new_post”

# with prefix
dom_id(post.find(2)) #=> “post_2”
dom_id(post.find(2), :custom) #=> “custom_post_2”
```

### How do you use dom_id from a background job or model

Since dom_id is baked right into Rails, you can call it from anywhere using ActionView.

*** app/models/post.rb***

```ruby
def dom_id
  ActionView::RecordIdentifier.dom_id(self)
end
```
