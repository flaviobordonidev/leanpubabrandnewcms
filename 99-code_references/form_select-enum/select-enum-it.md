# Menu a cascata


## Risorse esterne

- [Create a Dynamic Select Tag for Your Model-Based Form in Ruby on Rails](https://dev.to/jleewebdev/create-a-dynamic-select-tag-for-your-model-based-form-in-ruby-on-rails-39l6)
- [Create a Dynamic Select Tag for Your Model-Based Form in Ruby on Rails](https://clickbear.medium.com/create-a-dynamic-select-tag-for-your-model-based-form-in-ruby-on-rails-11194ce5d75e)
- [css in select](https://www.examplefiles.net/cs/35189)
- [menu a cascata con giorni settimana](https://blog.saeloun.com/2021/09/22/rails-7-adds-weekday_options_for_select.html)
- [Select-Boxes](https://findnerd.com/list/view/Creating-Select-Boxes-using-form-helpers-in-rails/5590/)
- [first-option-as-disabled](https://stackoverflow.com/questions/35074907/rails-select-options-set-first-option-as-disabled-selected)

- [apidock FormBuilder/select](http://apidock.com/rails/ActionView/Helpers/FormBuilder/select)
- [apidock FormOptionsHelper/select](http://apidock.com/rails/ActionView/Helpers/FormOptionsHelper/select)



## Boolean Select

```html+erb
<%= form.select :remote, options_for_select([true, false]), class: 'form-control' %>
```


## Dynamic Select Tag

I was writing an app that had a post model. The post model belongs to a “type.” In order to create my form for my post model, I needed to create a dynamic select field with my options coming from my type model.
Here’s how I did that.
First, in my controller, I got my types and put them in an instance variable to expose it to my view.

```
def new
   @post = Post.new
   @types = Type.all 
end
```

Then, in my view, I had the form:

```
<%= form_with(model: @post, local: true) do |f| %>
  <div class="form-group">
    <%= f.label :title %><br/>
    <%= f.text_field :title, class: "form-control" %>
  </div>
  <div class="form-group">
    <%= f.select :type_id, @types.map { |t| [t.name, t.slug]}, {}, class: "form-control" %>
  </div>
  <div class="form-group">
    <%= f.submit class: "btn btn-primary" %>
  </div>
<% end %>
```

Here, my form also includes a title. Also, I’m using Bootstrap for my form.
The important part — the part this post is focused on — is right here:

```
<%= f.select :type_id, @types.map { |t| [t.name, t.slug]}, {}, class: "form-control" %>
```

Here, we’re setting up a select tag and telling it to map to the :type_id param. Then we are passing an array of arrays that contain the name in the option as well as the value of the option.
This generates similar code to the following:

```
<option value="the-slug">the name </option>
```

And that’s how you can generate a dynamic select tag for your model-based form in Ruby on Rails.



## Da post giapponese

```
<%= form_with model: @post, url: posts_path, do |form| %>
  <%= form.select :user_id, [['太郎', 1], ['二郎', 2]], { include_blank: true, selected: 1 }, { id: "user_id", class: "user_class" } %>
<% end %>
```

What each represents is as follows.

- Property name: Column name (Supplementary below)
- Tag information: Array or hash of data used for select box display
- Options: Select box options (include_blank, selected, etc.)
- HTML options: HTML options (id, class, etc.)

Let's look a little more concretely.

**Property name** 
This is the name "What name do you want the controller to receive the value for?" Is specified.

How to receive data in the controller: `params[:post][:user_id]`


**Tag information**
This is the data used to display the select box.
In other words, it is the data set in the option tag.

**Options, HTML options**
As the name implies, it is an option setting of the select box.

However, there are two places to set options.

`{ include_blank: true, selected: 1 }, { id: "user_id", class: "user_class" }`

The first is usually called an option.

The following are typical examples:
- include_blank: Make the beginning an empty choice
- selected: Set the value you want to select by default

The latter is called an HTML option.

This is used when you want to specify id and class in the select tag.
- id: id of select tag
- class: class of select tag

There are some caveats when using this HTML option.
Be sure to set the empty parentheses in the options part even if you do not set the normal options {},.
Without this empty parenthesis, the HTML option would be ignored, so setting id / class doesn't work!

Examples:

- ERRATO: `<%= form.select :user_id, [['太郎', 1], ['二郎', 2]], { id: "user_id", class: "user_class" } %>`
- CORRETTO: `<%= form.select :user_id, [['太郎', 1], ['二郎', 2]], {}, { id: "user_id", class: "user_class" } %>`


## Select Boxes

One of the most common html elements in a web page is select box. In Rails select and option tag helper method is used to display it .

select and option tag:

```
<%= select_tag(:city_id, options_for_select[[Bangalore, 1], [Dehradun, 2]]) %>
```

```
#<select id="city_id" name="city_id">
#<option value="1">Banglore</option>
#<option value="2">Dehradun</option>
#</select>
```

In the above example in the controller we can get the chosen city id as params[:city_id].

The select method looks like this:

```
select_tag(name, option_tags = nil, options = {})
```

For the above example name is :city_id , option_tags is options_for_select[[Bangalore, 1], [Dehradun, 2]]. options = {} are the optional arguments. They are :

:multiple - When set to true we can select more than one option.
:disabled - When set to true the select box will be disabled in the web page.
:include_blank - When set to true an empty option will be created.
:prompt - When a string is passed to this option it is displayed as option without any value in the web page.

Others ways of displaying select boxes are:

Select box for model specific form:

select method is used in model specific form for displaying select boxes. Example:

```
    <%= select(:location, :city_id, [[Bangalore, 1], [Dehradun, 2]]) %>
```

Please follow this tutorial Rails:Populating Select boxes with model data for details.

Option Tags from a Collection of Arbitrary Objects:

In the above example we have given static values of option tag , but what to do when we have dynamic collection for option tags then we will use options_from_collection_for_select

Example:

```
<%= select_tag(:city_id,  options_from_collection_for_select(@city, "id", "name")) %>
```


## First option as Disabled

There's no way of doing this (natively) that will ensure cross-browser functionality, but here's an answer:

```
# on store types 
def self.options
  options = self.all.collect { |type| [type.capitalize, type.id] } 
  options.unshift(["Select Store Type", "0"])
  options
end 
```

```
# in your form 
<%= f.select :store_type_id, options_for_select(StoreType.options, :disabled => "0") %> 
```

However, you're depending on the browser to select a disabled input, which will contradict itself. Chrome latest goes to the next non-disabled input.

Instead, you may want to do some form validation to ensure that the value of the select is not blank.

And to keep future Ruby developers happy (and to keep yourself in line with conventions and best practices), keep in mind that Ruby endorses snake_casing your variables :)

according to api.rubyonrails.org/classes/ActionView/Helpers/… you can pass the values into the arguments under the disabled key, like, f.select :store_type_id, options_for_select(StoreType.options, :disabled => %w{0 1 2 3 4 5}) 
