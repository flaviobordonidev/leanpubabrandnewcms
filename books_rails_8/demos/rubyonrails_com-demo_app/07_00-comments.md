# <a name="top"></a> Aggiungiamo commenti al nostro Blog

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.


## Let's add comments

Now let's add some comments to our blogging system!
And I'm gonna use a different generator here, I'm gonna use a `resource` generator, that is a little lighter than the one we're using for scaffold, that doesn't generate a bunch of views, and doesn't generate all sorts of actions in the controller by default, but it does generate the new model that we need, the comment model, it generate a migration for that, create comments, and it generates just some empty placeholders for the comments controller and for the view action. So, let's run the migration for that...

```shell
❯ rails g resource comment post:references content:text
❯ rails db:migrate
```

...that set up the `comments` table.
You can see below the schema that we've now built up.

***Codice 01 - .../db/schema.rb - linea:52***

```ruby
  create_table "comments", force: :cascade do |t|
    t.integer "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
  end
```

***Codice 01 - .../db/schema.rb - linea:69***

```ruby
  add_foreign_key "comments", "posts"
```



## Vediamo il controller

If we hop into that `comments_controller`, it is empty 

***Codice 02 - .../app/controllers/comments_controller.rb - linea:1***

```ruby
class CommentsController < ApplicationController
end
```

and we insert the following code...

***Codice 03 - .../app/controllers/comments_controller.rb - linea:1***

```ruby
class CommentsController < ApplicationController
  before_action :set_post

  def create
    @post.comments.create! params.expect(comment: [ :content ])
    redirect_to @post
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
```

You'll see one principle of the controller setup we have is that we have these callbacks: `before_action`, we're gonna set posts.
So before all the actions, we're going to reflect the fact that this is a nested resource. The comments it's something that belongs to a post, and we will pull out the post ID from the params, that's what is being parsed in as part of the URL.
And we will fetch that post, and now we will create the comments associated with that post, based on the parameters that are expected as comment content.
And then after it's created, we will redirect back to the post.



## Vediamo il model

So let's actually also create the other direction of this association.
You saw a comment belong to a post, but then we're also gonna make the post has many comments. 

***Codice 04 - .../app/models/post.rb - linea:1***

```ruby
class Post < ApplicationRecord
  has_rich_text :body
  has_many :comments
end
```

Now we hava a biderectional association.



## Creiamo le views/partials per comments

Now we're adding a bunch of partials in the views comments folder.

- ***.../app/views/comments/_comments.html.erb***
- ***.../app/views/comments/_comment.html.erb***
- ***.../app/views/comments/_new.html.erb***

This is the templating system, basically, a sub-routine that you can refer to. There's gonna be three of them:
- ***comments*** that include the entire comment section. We're gonna reference that in our post show in just a second. Whithin of that we're going to refer to another partial for an individual ***comment***, and another partial again for the ***new*** setup.

So let's past some of that in here.


***Codice 05 - .../app/views/comments/_comments.html.erb - linea:1***

```html
<h2>Comments</h2>

<div id="comments">
  <%= render post.comments %>
</div>

<%= render "comments/new", post: post %>
```

You can see this is for the entire collection.
We render the post.comments, this again uses Rails convention over configuration approach.
It'll automatically know that the comment model should map to view/comments/_comment, so it can look up the right partial file to use.
Below that we have the form that we're referencing with the comments new.

So let's code the individual comment.

***Codice 06 - .../app/views/comments/_comment.html.erb - linea:1***

```html
<div id="<%= dom_id(comment) %>">
  <%= comment.content %> - 
  <%= time_tag comment.updated_at, "data-local": "time-ago" %>
</div>
```

As you can see here, we just give it a div, that has a dom ID so that we can reference it.
We are pacing in the comment, and we're using that same time tag as we were using with the post, but this time, we are going to use time_ago, so we get the nice "two minutes ago" on when something went posted, rather than a local time spelled out with AM/PM set up.

and then finally, let's past in the form.

***Codice 07 - .../app/views/comments/_new.html.erb - linea:1***

```html
<%= form_with model: [ post, Comment.new ] do |form| %>
  Your comment:<br>
  <%= form.text_area :content, size: "20x5" %><br>
  <%= form.submit %>
<% end %>
```

This form is going off a model, the new comment, but it's nested underneath the post, is that we automatically can deduce which URL that we should post this new form to.
And yuor comment is just gonna be a text area for content.


## Andiamo nella view del post

Adesso mostriamo i partial dei commenti nella view show di post.

***Codice 08 - .../app/views/posts/show.html.erb - linea:12***

```html
<%= render "comments/comments", post: @post %>
```

That's gonna reference that common slot comments, that includes both the comments and the new form!



## Allineamo la risorse negli instradamenti (routes)

When we generated the resource, it added a route for the new comments, but that route was not nested by default.
We actually need to go into our routes.rb 

***Codice 09 - .../config/routes.rb - linea:2***

```ruby
  resources :comments
  resources :posts
```

...and nest it.

***Codice 10 - .../config/routes.rb - linea:2***

```ruby
  resources :posts do
    resources :comments
  end
```

When it is nested, we get the fact that it's gonna be `/post/comments` and we have the association is set up nicely.



## Vediamo nel browser

```shell
❯ bin/dev
```




## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
