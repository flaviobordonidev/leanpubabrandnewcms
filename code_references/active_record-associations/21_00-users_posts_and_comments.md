# <a name="top"></a> Cap active_record-associations.21 - User Posts and Comments

Keeping track of which posts or comments were posted by which user. 
To do so, we'll need to make an association between users and their posts and comments.



## Risorse interne

- [ubuntudream/15-lessons_steps/04_00-steps_sequences-it.md]()



## Risorse esterne

- [Associating Users with Posts and Comments](https://thinkster.io/tutorials/angular-rails/associating-users-with-posts-and-comments)



## Steps

Generate the migration to associate posts with users in the database: 

```bash
$ rails g migration AddUserRefToPosts user:references
```

Generate the migration to associate comments with users in the database: 
```bash
rails g migration AddUserRefToComments user:references
```
 
```bash
$ rails db:migrate
```

Add a `belongs_to :user` association to the `Post` model
Add a `belongs_to :user` association to the `Comment` model

Our Post and Comment models are now associated with User. Now we need to update our controllers so that newly created comments are automatically associated with users.

Update the create action in `PostsController`:

```ruby
  def create
    respond_with Post.create(post_params.merge(user_id: current_user.id))
  end
```

Update the create action in `CommentsController`:

```ruby
  def create
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with post, comment
  end
```

Finally, we'll need to update our as_json methods on our models to include user in our JSON responses.

Override the as_json method in Comment to include the user:

```ruby
  def as_json(options = {})
    super(options.merge(include: :user))
  end
```

Update the as_json method in Post to include the post and comments' users:

```ruby
  def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
  end
```



## update the views

Let's update the views to display the username of the user associated with each post and comment.

Update _home.html to show the poster's username:

```ruby
    posted by <a ng-href="#/users/{{post.user.username}}">{{post.user.username}}</a>
```

Update _posts.html to show the commenter's username:

```ruby
  {{comment.upvotes}} - by {{comment.user.username}}
```

Now when we create new posts and comments, we should be able to see who created the post or comment!
