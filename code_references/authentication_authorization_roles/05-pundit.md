# Pundit - Autorizzazione

Installazione ed uso di Pundit



## Risorse interne

- 01-base/16-authorization/02-authorization-pundit
- 01-base/16-authorization/03-authorization-users
- 01-base/16-authorization/04-authorization-eg_posts



## Risorse esterne

- [gems pundit](https://rubygems.org/gems/pundit)
- [varvet pundit](https://github.com/varvet/pundit)
- [rails authorization](http://railsapps.github.io/rails-authorization.html)
- [rails authorization freecodecamp](https://medium.freecodecamp.org/rails-authorization-with-pundit-a3d1afcb8fd2)
- [authorization with pundit tutplus](https://code.tutsplus.com/tutorials/authorization-with-pundit--cms-28202)
- [authorization with pundit medium](https://medium.com/@stacietaylorcima/implement-user-authorization-with-pundit-rails-80d921cdbf28)
- [Episode #047 - Authorization with Pundit](https://www.youtube.com/watch?v=PWizyTjCAdg)
- [Rails Authorization With Pundit - parte da zero ed installa anche devise ed usa anche spec tests](https://www.youtube.com/watch?v=qruGD_8ry7k)

- [Devise authentication 48:50](https://www.youtube.com/watch?v=qruGD_8ry7k
- [current_user present? and signed_in](https://stackoverflow.com/questions/45398702/what-is-the-difference-between-current-user-present-and-if-user-signed-in)
- [Differenza fra public e private](https://www.codementor.io/anuraag.jpr/the-difference-between-public-private-and-protected-methods-in-ruby-6zsvkeeqr)
- [Rails Authorization With Pundit - parte da zero ed installa anche devise ed usa anche spec tests](https://www.youtube.com/watch?v=qruGD_8ry7k)

- [Pundit versus CanCan](https://vector-logic.com/blog/posts/authorizing-controller-endpoints-in-rails-punit-versus-cancan)



## Identifichiamo il problema di autorizzazione

Impostiamo che autorizzazioni ha l'utente, una volta autenticato attraverso il login.
Attiviamo pundit per autorizzare le modifiche degli utenti solo se la persona è loggata (autenticata) ed ha il ruolo di amministratore (autorizzata).
In altre parole solo l'amministratore può modificare gli utenti.




### altri esempi di richieste di autorizzazione

Ma prima di approfondire Pundit identifichiamo il nostro problema che richiede autenticazione:

Nel sistema di gestione delle aziende abbiamo 2 ruoli, quello del manager e quello del dipendente. 
Il Manager può visualizzare tutte le schermate del sistema. 
Il dipendente non può creare, modificare o cancellare alcuna azienda.


## Teoria

Most application developers will encounter the fundamental concepts of authentication and authorization pretty early in their career. These are essential components in securing a web application, or general software system, or indeed any system.

Authentication and Authorization
**Authentication** describes how we verify the identity of the users of our system, i.e. who the user is. Some applications will expose functionality or content to anonymous users, in this case these users do not need to complete authentication. But many applications need to know who the user is. Authentication is often achieved using credentials like username and password, or a secret token.

**Authorization** describes what the user is allowed to do. The question of what the user can do will usually come after we know who the user is. So for most applications effective authorization will be dependent on authentication.

> authentication (i.e. knowing who the user is) is often a precursor to authorization checks (i.e. checking what the user is allowed to do).



## Pundit

Pundit provides a simple framework of helper methods, along with some conventions, which encourage the use of plain Ruby objects to define your authorization rules in an object-oriented fashion.

It requires that you create a policy file for each domain class that you wish to authorize actions against. This is a plain Ruby object that is instantiated with a user object and an instance of the class to which the policy relates. In our case we will construct a `PostPolicy`. Within the `PostPolicy` you will define separate instance methods that should return truthy or falsey values to indicate if the user has permission to execute the action on the defined `Post` instance.

In addition to this you can define a `Scope` class. The intention of this class is to encapsulate the logic that defines which instances the user should be allowed to list. This is typically defined as an inner class of the policy class. The `Scope` class should be initialized with the user instance and an initial scope which you will chain to, based on the particular user passed. The `Scope` class should then define a `resolve` method that will define the list of model instances that the defined user has access to.

Implementation

```ruby
class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def show?
    post.published ||
      user.is_admin ||
      (user.name == post.author)
  end

  def destroy?
    user.name == post.author
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.is_admin
        scope.all
      else
        scope.where(published: true).or(scope.where(author: user.name))
      end
    end
  end
end
```

The instance methods defined in the policy will use the `User` and `Post` instances to make the decision on whether the user should be allowed to execute the action on that model. The logic in these methods will reflect your business logic for the user and domain model involved. For example, in our case we have said that the user should be able to `#show?` the `Post` instance if the post is public *or* if the user is an admin *or* if the user is the author of the post.

```ruby
  def show?
    post.published ||
      user.is_admin ||
      (user.name == post.author)
  end
```

By contrast the `Scope` does not concern itself with instances of the `Post` class, instead it uses the `ActiveRecord` query API to define which set of posts an individual user should be able to list. In our case the admin can list *all* posts, while other users should only see posts which are published, or which they have authored themselves.


```ruby
    def resolve
      if user.is_admin
        scope.all
      else
        scope.where(published: true).or(scope.where(author: user.name))
      end
    end
```

We make use of this policy within the `Pundit::PostsController`. It exposes the same controller end-points as the original, unauthorized controller but this time we make use of the `authorize` helper-method included via Pundit. This method will instantiate an instance of our `PostPolicy` and will use that to decide if the `current_user` has access to the defined action on the defined model instance. When the user should not have access to the action then a `Pundit::NotAuthorizedError` is raised to abort the action.

In addition to the `authorize` method we can see the `policy_scope` helper method is being used in the index. This will be used to retrieve only the `Post` instances to which the `current_user` has access.


```ruby
class Pundit::PostsController < ApplicationController
  include Pundit::Authorization

  def index
    @posts = policy_scope(Post)
  end

  def show
    @post = Post.find(params[:id].to_i)
    authorize @post
  end

  def destroy
    @post = Post.find(params[:id].to_i)
    authorize @post
    @post.destroy
    redirect_to pundit_posts_path, flash: { warning: "Post has been successfully deleted" }
  end
end
```

It can be instructive to imagine how the `authorize` helper-method might be implemented by Pundit. Something like this should provide the correct behaviour:

```ruby
      def authorize(model, action)
        unless PostPolicy.new(current_user, model).public_send(action)
          raise Pundit::NotAuthorizedError
        end
      end
```

Obviously things are a little more complicated that this, as Pundit will need to infer the policy class from the model instance passed, also the action can be inferred from the controller action being executed. But these details aside, this is the essence of how Pundit enforces authorization using our simple policy classes.

Comments
This simple example shows some of the basics of how Pundit can be used to enforce authorization of your controller end-points. Some essential comments about this usage:

- You will need to define a policy class for each domain class that you wish to authorize actions against. This can lead to a lot of new policy classes being required, but it encourages simple well-defined policies, which are easily tested.
- Within your controller you will use `authorize` and `policy_scope` helper methods to authorize your actions and scope your queries, respectively.
- Pundit also adds a method to your controllers called `verify_authorized`. This method will raise an exception if `authorize` has not yet been called, which might be a useful safety check in some cases.
- We have looked at the methods used to secure your controller actions, but Pundit also offers a `policy` helper method which you can access in your views to conditionally display elements which the user should have access to. For example:

```html+erb
<%- if policy(@post).edit? &>
  <%= link_to t('general.edit'), edit_blog_post_path(@post) %>
<%- end %>
```
