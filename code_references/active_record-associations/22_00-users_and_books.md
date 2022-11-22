# <a name="top"></a> Cap active_record-associations.22 - Users and Books

How to set the current user when building or creating an association
Nathan Watson edited this page on May 20, 2018 · 20 revisions


## Risorse interne

- [ubuntudream/15-lessons_steps/04_00-steps_sequences-it.md]()



## Risorse esterne

- [Adding the user to the new book association](https://github.com/StanfordBioinformatics/pulsar_lims/wiki/How-to-set-the-current-user-when-building-or-creating-an-association)
- [Adding the user to the new book association](https://github-wiki-see.page/m/StanfordBioinformatics/pulsar_lims/wiki/How-to-set-the-current-user-when-building-or-creating-an-association)


## How to set the current user when building or creating an association

The `current_user` method from *Devise* is used in a controller to get the current user, which can then be set on any new model instance that has a ***`belongs_to` relationship with the `user` model***.

In this example, we have an Author model and a Book model:

```ruby
class Author < ActiveRecord::Base  
  has_many :books, dependent: :destroy
  belongs_to :user
  ...  
end  
```

```ruby
class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :user 
  ...
end
```

Now, turning to the `create` action in the Author controller, we can set the current user before a new author record is saved to the database:

```ruby
def create  
  @author = Author.new(author_params)
  @author.user = current_user
  ...
end
```

Within the show view of a given author page, we may have a button Add Book, and clicking on this button will dynamically insert a form to create a new book record and associate it to the author. Adding the user to the new book association can be tricky, depending on what action the form posts to. If the form posts to the create action of the Book controller, then setting the user is simple as we can imitate what was done above in the create action of the Author. But that would cause a redirect to the show view of the Book after the user clicks on the button (assuming that the Book's create action renders the show view). If instead we want the redirect to happen back to the show view of the Author, where we'll have a link back to the newly added book, then things get more complicated for the following reasons:

1. The Book form that is embedded within the show view of an Author needs to post to a different controller action - one where we can set the redirect back to the Author's show view.
2. This controller action needs to explicitly set the user on the associated book.

Let's consider each part in turn. Since we don't want to be redirected to Book views after submitting the form, we can set the form to post to the update action of the Author controller (we are updating the Author afterall). To do this, we'll need to generate a wrapper form for the Author, and then use fields_for (or simple_fields_for if using the Simple Form gem to specify the form fields for the Book. We also don't want to duplicate the Book's form view in our Author's show view; we can instead render the partial. To make the Book's form portable in other views like this, we'll need to make some adjustments to the form.



## Adjusting the Book form

Our book model only has two fields: title and edition. By default, the rails scaffold generator creates the following Book form:

```html+erb
<%= simple_form_for(@book) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :edition %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>
```

You must first remove the <form> from this, but keep the form fields:

```html+erb
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :edition %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
```

We just removed the first and last lines. We also need to remove the <div> element that contains the submit button, since that button is configured to submit to the Book controller (the create action in this case). It should now look like:

```html+erb
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :edition %>
  </div>
```

Let's create a new partial for the submit button that we just removed. The new and edit Book partials that render the form partial still need a submit button. Create a file in app/views/books/ called _submit.html.erb and add the <div> content (that we just removed) to this file:

```html+erb
<div class="actions">
  <%= f.button :submit, class: "btn-primary" %>
</div></br>
```

Now, update the edit and new Book partials to add back the <form> element and the submit button. Change the default new view from

```html+erb
<h1>New Book</h1>

<%= render 'form' %>

<%= link_to 'Back', books_path %>
```

to

```html+erb
<h1>New Book</h1>
<%= simple_form_for(@book) do |f| %>
  <%= render partial: 'form', locals: {f: f} %>
  <%= render partial: 'submit', locals: {f: f} %>
<% end %>
<%= link_to 'Back', books_path %>
```

We are simply adding back the wrapper lines that we removed from the form to the Book partials that render the form. Next, perform the same modification to the edit partial.

At this point, we have a Book form that we can embed in other model views, and we can set our own custom submit button on it. Next, we'll do an example of just that - embedding the Book form partial into the show view of an Author.



## Embedding the Book form partial in the show view of an Author

We want an Add Book button that, when clicked, will result in a Book form that appears on the Author's show view (i.e. via jQuery). You can add such a button in the Author's show view like so:

```html+erb
<%= link_to "Clone", [:clone, @biosample], class: "clone" %>
```

You can use some CSS to style it to make it look like a button instead of a link. You can then use jQuery to set up an on-click event listener that sends a GET request to a dedicated action (call it add_book) of the Author controller. The code for this new controller action should look like so:

```ruby
def add_book
  @book = @author.books.build
  render partial: "add_book", layout: false
end 
```

The HTML that you'll want to insert into the rendered partial at *app/views/authors/_add_book.html.erb* is:

```ruby
<%= simple_form_for @author do |f| %> 
  <%= f.simple_fields_for :books, @book do |ff| %> 
  <%= render partial: "books/form", locals: {f: ff} %> 
<% end %>

<%= f.button :submit, "Create Book", class: "btn-primary" %>
<% end %>
```

Note that I've made this a partial instead of a normal view since I'll also need to be able to render it explicitly from the Author's *show* view as shown later.
As you can see, we followed the same principle to render the Book form partial as we did in the Book's new and edit views by wrapping the Book's form partial with a <form> element and adding a submit button at the end. The difference here is that the <form> element is for an Author instance, not a Book instance. Additionally, the submit button is tied to the Author instance as well. Thus, this HTML form will post to the update action of the Author controller since we are updating an Author instance with a new Book association.

We're not yet done. We still need to update the Author controller's update action such that it looks for a new Book association and, when it finds one, associates the new Book with the current user. Currently, there is nothing in place that is setting the current user of an association that doesn't get created through its own controller's create action.



## Setting the current user of a new Book record in the Author controller

First, update the Author model to indicate that we want to be able to create and edit nested Book associations when creating or editing an Author. Add the following line to author.rb before the first method definition:

```ruby
accepts_nested_attributes_for :books, allow_destroy: true
```

Let's say that the Author model only has two fields, which are required: first_name and last_name. In the Author controller, in the method named author_params, change

```ruby
def author_params
  params.require(:author).permit(:first_name, :last_name)
end
```

to

```ruby
def author_params
  params.require(:author).permit(:first_name, :last_name, books_attributes: [:title, :edition])
end
```

Next, what you want to do in the update action is look in the params object for the key :books_attributes. If present, it will be a hash of hash objects, each being either a new Book or an associated Book you are editing. In our case, they should only be new Book associations we are making, but that doesn't mean in the future that some other form is also posting to this update action and allowing you to edit existing Book associations on the given Author. So here, you'll need to loop through this hash of hash objects, and associate the current user only to those that aren't persisted to the database yet (have an unset value for the :id attribute). But it's not a good idea to directly tamper with the params hash that Rails provides us, as doing so can result in unpredictable behavior. So we'll first make a copy of the params hash:

```ruby
def update
  ...
  author_params_copy = author_params
  if author_params_copy[:books_attributes].present?
    author_params_copy[:books_attributes].each do |pos,book_params| #keys are integers, like indices in a list.
      next if book_params.include?(:id) #Because the user is updating a book
      author_params_copy[:books_attributes][pos][:user_id] = current_user.id
    end 
  end
  ...
end 
```

Lets add to this code chunk the respond_to block:

```ruby
def update
  ...
  author_params_copy = author_params
  if author_params_copy[:books_attributes].present?
    author_params_copy[:books_attributes].each do |pos,book_params| #keys are integers, like indices in a list.
      next if book_params.include?(:id) #Because the user is updating a book
      author_params_copy[:books_attributes][pos][:user_id] = current_user.id
      flash[:action] = :show
    end 
  end

  respond_to do |format|
    if @author.update(author_params_copy)
      format.html { redirect_to @author, notice: 'Author was successfully updated.' }
      format.json { head :no_content }
    else
      action = flash[:action]
      if action.present?
        flash[:action] = action
      end 
      format.html { render flash[:action] || 'edit' }
      format.json { render json: @author.errors, status: :unprocessable_entity }
    end 
  end
end 
```

Now, when the new Book is successfully saved to the database, it will store the current user in it's user foreign key, in addition to the Book being associated with the Author. After a successful save, the user will be redirected back to the Author's show view. But what if something goes wrong and the save isn't successful? This could be the case if the users omit a required field in the new Book form. Since both first_name and last_name are required fields in the Book model, if the user fails to omit either of these then that will result in validation errors. It would be helpful to be able to see such validation errors. By default, when an object fails validation, Rails configures the update or create actions to render the edit view for the current controller. We don't want that because in our case, the Author's edit view doesn't contain the embedded Book form partial. We need to a way to tell the update action to render the show view instead on validation error. We accomplish this by making use of the flash, which is what has been done in the preceding code. The flash is used to store session attributes that have a short-term life-span; they only survive one more HTTP request. We can insert a custom key called :action into the flash and set the value to a controller action name. Then, in the update action in the error-checking block we can check for the presence of the :action key in the flash, and if present, render the specified controller action. Of course we could instead just use a regular variable to indicate the action instead of storing this knowledge in the flash, and that would work in this example. But, other controller actions could also benefit from setting the :action key in the flash, so its best to let the :update action check for this logic in a simple and centralized manner.

Finally, we need to be able to render the Book form partial whenever the Author's show view is rendered and we have an unsaved and associated @book instance. This is the case when there is a validation error as explained above. When the browser renders the Author's show view again, we display the embedded Book form partial and populate it with the values currently set in the @book instance so that the user can see where the errors are and have a chance to fix them. They way we can check in the show view for an unsaved @book association is with this line of code:

```html+erb
<% if @author.books.any? and not @author.books.last.id.present? %> 
```

As an exercise, you can use that logic to conditionally render the _add_book.html.erb partial or the Add Book button.
