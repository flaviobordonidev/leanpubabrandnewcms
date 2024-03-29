# <a name="top"></a> Cap *routes-instradamenti*.1 - Instradamenti

Introduciamo gli instradamenti.



## Risorse interne

- 01-base/03-mockups/01-mockups
- 01-base/07-authentication/03-devise-users-seeds
- 01-base/11-eg_pages/07-eg_posts-protected 



## Risorse esterne

- [Rails: routing](https://guides.rubyonrails.org/routing.html)
- [Routing For Beginners In Ruby On Rails 7](https://www.youtube.com/watch?v=F3aPSBTPiRM)
- [Understanding Rails Routes 1](https://medium.com/podiihq/understanding-rails-routes-and-restful-design-a192d64cbbb5)
- [Understanding Rails Routes 2](https://richonrails.com/articles/understanding-rails-routing)

- [Understanding the Rails Router 2023](https://www.akshaykhot.com/understanding-rails-router-why-what-how/)



## Understanding Rails Routes and RESTful Design

A router in Rails is a directing module that recognizes browser URLs and dispatches them to the controller actions requested. To make it simple, when you enter a url in your domain, the rails router will know which controller and action to handle your url.

> Routing is the process that determines what code needs to run based on the URL of the incoming request.

The router is the first point of contact for a request inside your Rails application.
After inspecting the URL, the router decides to either:

1. forward the request to a controller action
2. redirect the request to another URL inside or outside the application
3. filter and reject the request based on pre-defined constraints

If the router can't find a route that matches the incoming request, it throws an error.

descrizione               | codice
|:-                       |:-
Browser URL               | /pages/home
routes.rb                 | get "pages/home"
pages_controller.rb       | def home ... end
views/pages/home.html.erb | ...


```ruby
  get "pages/home", to: "pages#home”
```


## Instradamento di root

Quando non inseriamo nessun *path* nell'url: `http://192.168.64.3:3000/`

***code 01 - .../config/routes.rb - line:3***

```ruby
  # GET /
  root 'my_controller#my_action'
```

Esegue l'azione `my_action` del controller `my_controller_controller`.



## Instradamento GET

Quando inseriamo un *path* nell'url: `http://192.168.64.3:3000/pages/page_a`

***code 02 - .../config/routes.rb - line:3***

```ruby
  # GET /my_controller/my_action
  get 'my_controller#my_action'
```

Esegue l'azione `my_action` del controller `my_controller_controller`.

Se vogliamo eseguire stessa azione dello stesso controller ma con path: `/my_page`.

url: `http://192.168.64.3:3000/my_page`.

```ruby
  # GET /my_page
  get "/my_page", to: "my_controller#my_action"
```



## Verifichiamo instradamenti da console

Tutti gli instradamenti

```bash
$ rails routes
```

Filtriamo per i soli utenti

```bash
$ rails routes | egrep "user"
```




## Rails RESTful Design

routes.rb           : resources :users


resources :users, only: [:index, :new, :create]


---
resources :users, :books, :messages

è uguale a:

resources :users
resources :books
resources :messages
---




## Controller Namespace and Routing


namespace :admin do 
 resources :articles, :comments
end


/admin/articles




## Naming Routes

Instead of using raw urls generated by Rails app, Rails allows you to refer to routes by names. For example, the following will create a logout_path or logout_url a named helpers in your application.

get “sessions/destroy”, as: :logout 

To refer to this route anywhere in your application you can write:

logout_path

Beauty of this being that you can always change the controller and action without refactoring so much code in the views and other controllers.

* http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing




## Redirection

You can redirect any path to another path using the redirect helper in your router:

get ‘/stories’, to: redirect(‘/articles’)

Please note that default redirection is a 301 “Moved Permanently” redirect. Keep in mind that some web browsers or proxy servers will cache this type of redirect, making the old page inaccessible. 
You can use the :status option to change the response status:

get ‘/stories’, to: redirect(‘/articles’, status : 302)

This depicts a “Moved Temporarily” so the next time user requests for the resource the redirect will always occur. If we used the 301 then if a browser caches it as inaccessible then if a user tries to access the route for a second time the browser will not even make the request to our server assuming that the resources was permanently moved



## Approfondiamo Routing in Rails

To configure the router, you add specific rules (called **routes**) in the `config/routes.rb` file. These routes tell the router how to map incoming URLs to specific controller actions.

When a request arrives, the router finds the route which matches the URL pattern. It does this by going through the routes in the order they're defined in the `routes.rb` file. As soon as it finds a matching route, the search ends.

For example, the following route instructs Rails to direct any `POST` request with the URL `posts/publish` to the `publish` method on the `PostsController` class.  

```ruby
match "posts/publish/:id", controller: "posts", action: "publish", as: "publish", via: :post
```

> Note: If you were expecting to see a shorthand route like `get posts/publish => posts#publish`, I'm intentionally taking the difficult and longer route with the `match` method, as it will give you a deeper and better understanding of routing.

This single route contains multiple components that we'll examine in this post.

- the incoming URL `path` to match: `posts/publish`
- which controller and action this request should be routed to.
  es: the `publish` action on `Posts` controller.
- the name for this route: `publish`, it generates URL helpers named `publish_url` and `publish_path`.
- HTTP verb this route corresponds to `:post`.
- segment key `:id` which acts as a variable placeholder for the id of the post.

As you can see, the router offers a rich domain-specific language (DSL) to express a lot of information with a concise syntax. And this is still a long-form version that you'll rarely use!!

As you'll soon learn, Rails uses convention-over-configuration to even shorten the above route without affecting its expressiveness.

For example, the above route could be simplified to:

```ruby
post "posts/publish/:id" => "posts#publish", as: "publish"
```

And it keeps getting better.



## Digging Deeper: Router Internals

When you create a new Rails app, it automatically creates a `/routes.rb` file in the `config` directory. All it contains is a single call to the `draw` method on the object returned by the `Rails.application.routes` method. Additionally, it takes a block containing the routes for your application.  

```ruby
Rails.application.routes.draw do
  get "posts/publish": "posts#publish", as: "publish"
end
```

To understand how the above method works, we need to take a short detour and understand the `instance_exec` method, which is defined on the `BasicObject class`.



## Understanding how `instance_exec` works

The `instance_exec` method takes a block and runs that block in the context of the object on which it's called. Inside the block, it sets `self` to that object, so you can access its instance variables and methods.

```ruby
class Company
  def initialize(name, product)
    @name = name
    @product = product
  end

  def info
    "#{@name}: #{@product}"
  end
end

microsoft = Company.new 'Microsoft', 'Excel' 

microsoft.instance_exec do
  puts info    # access instance method
  puts @name   # access instance variable
end

# Output:

# Microsoft: Excel
# Microsoft
```

You might wonder what's the purpose of using `instance_exec` when you can just call the method directly on `microsoft`. You are right in this example, but, as we'll soon see, the `instance_exec` method allows you to pass a block and run it later in the context of an object, which is a really useful technique for creating special-purpose DSLs.

Not sure what I mean? let's revisit the `routes.rb` file.

```ruby
Rails.application.routes.draw do
end
```

The `Rails.application` is an instance of the `Application` class which inherits from the `Engine` class. The `Engine` class has a `routes` method which returns an instance of the `RouteSet` class.

```ruby
# railties/lib/rails/engine.rb

def routes(&block)
  @routes ||= ActionDispatch::Routing::RouteSet.new_with_config(config)

  # ...
  
  @routes
end
```

It means that the block passed to the `draw` method in the `routes.rb` file is ultimately received by the `draw` method on the `RouteSet` class. This method passes that block to the `eval_block` method, as seen below.

```ruby
# actionpack/lib/action_dispatch/routing/route_set.rb

def draw(&block)
  # ...
  eval_block(block)
  # ...
end

def eval_block(block)
  mapper = Mapper.new(self)
  if default_scope
    mapper.with_default_scope(default_scope, &block)
  else
    mapper.instance_exec(&block)
  end
end
```

As you can see, the `eval_block` method first creates an instance of the `ActionDispatch::Routing::Mapper` class and executes the block within the context of that instance.

What it means, is that **any code we write inside the block passed to the `Rails.application.routes.draw` method will be evaluated as if it was written inside the `Mapper` class.**

For example, the two pieces of code below are similar. However, the first version just reads better. It feels like **a programming language specifically designed for the routing domain.**

```ruby
Rails.application.routes.draw do
  root 'application#index'
  get 'posts/publish', to: 'posts#publish'
end

# is similar to 

routes = ActionDispatch::Routing::RouteSet.new
mapper = Mapper.new(routes)
mapper.root 'application#index'
mapper.get 'posts/publish', to: 'posts#publish'
```

This also means that whenever you see a method in your `routes` file, you know where to look for its definition. It's the `ActionDispatch::Routing::Mapper` class. For example, the commonly used `get` method is defined in the `Mapper::HttpHelpers` module.

This gives us a solid base to explore the Rails Routing API. We'll start our investigation with the `match` method.



## The match Method
To understand the Rails Router API, it's essential to learn the `match` method, which forms the core of the Router DSL. All helper methods like `get` and `post` use `match` under the hood. Additionally, most of the shorthand syntax such as `scopes` and `constraints` use the options provided by `match` behind the scenes.

**Once you really understand the `match` method and its options, the rest of the routing methods and shorthands become very easy to understand.**

Here's the basic API of the `match` method, which is defined inside the `Mapper` class.

```ruby
match(path, options)
```

The first parameter `path` tells the router what URL pattern you wish to match. It can be either a String or a Hash.

- The string version specifies the URL pattern, e.g. `/posts/publish/:id`
- The hash matches the URL pattern to a `controller#action` pair, like `'/posts/1' => 'posts#show'`.

The second parameter `options` is a hash containing additional data required by the router to decide where it should redirect this request. You can also pass any custom data, which gets passed to the `params` hash accessible in the controllers.

In its simplest and most explicit form, you supply a URL pattern along with the name of the controller and the action. If you don't want to pass them separately, a string in the form of `controller#action` is also allowed with the `:to` option.

```ruby
match 'photos/:id', controller: 'photos', action: 'show', via: :get

match 'photos/:id', to: 'photos#show', via: :get

match 'photos/:id' => 'photos#show', via: :get
```

As we'll learn later, you'll often use shortcuts like `get` and `post` instead of directly using the `match` method. However, `match` comes in handy when you want to match a route for multiple HTTP verbs.

```ruby
match 'photos/:id', to: 'photos#show', via: [:get, :post]
```

> note:</br> 
> The `:via` option is mandatory for security-related reasons. If you don't pass it, the router raises an `ArgumentError`.



## Options Available to Match

The `options` hash helps the router identify the action to which it should pass the incoming request. Here are some of the important options that you can provide to the `match` method.

> Any custom data that doesn't match the existing option gets passed as-is to the `params` hash, which you can access in the controllers.


### controller

The name of the controller you want to route this request to.


### action

The name of the action you want to route this request to. 
> The `controller` and `action` keys are used together.


### to

If you don't want to pass the controller and action as separate options, the `:to` option lets you pass the `controller#action` as a string.  

> Note: You're not restricted to using only controller actions for incoming requests. 
> The `:to` option also allows you to point to a Rack endpoint, i.e. any object that responds to a `call` method.

```ruby
match 'path', to: 'controller#action', via: :get
match 'path', to: -> (env) { [200, {}, ["Success!"]] }, via: :get
match 'path', to: RackApp, via: :get
```

If you're curious to learn more about Rack, check this out:
- [The definitive guide to rack](https://www.akshaykhot.com/definitive-guide-to-rack/)


### via

Lists the HTTP verb for this route. You have to pass at least one HTTP verb.

```ruby
match 'path', to: 'controller#action', via: :get
match 'path', to: 'controller#action', via: [:get, :post]
match 'path', to: 'controller#action', via: :all
```


### module

Use this if you want **namespaced controllers**. The following route directs the request with `/posts` URL to `Blog::PostsController#index` action.

```ruby
match '/posts', module: 'blog', controller: 'posts', action: 'index', via: :get
```


### as

This option provides the name for the generated URL helpers. The following route creates the helpers named `blog_path` and `blog_url`.

```ruby
match 'posts', to: 'posts#index', as: 'blog', via: :get
```

### constraints

If you want to put more restrictions on what URL patterns a route should match, provide this option with a hash of regular expressions. It can also take an object responding to `matches?`.

```ruby
match 'path/:id', constraints: { id: /[A-Z]\d{5}/ }, via: :get
```


### defaults

Sets the default value for a parameter. 
The following route will set the value of `params[:author]` to 'Akshay'.

```ruby
match '/courses/publish(/:author)', to: 'courses#publish', defaults: { author: 'Akshay' }, via: :get
```

Most of the routing methods you'll use are just shorthands using various combinations of the `match` method's options.

> Next, we'll learn about the shortcuts Rails provides you so you don't need to use the common options such as `:via` all the time.



## HTTP Method Shorthands

So far, we've been using the `match` method, passing the HTTP verbs like `:get` and `:post` with the `:via` option. Can we do better?

YES! Rails provides simplified shorthand methods like `get` and `post` which implicitly assume the HTTP verb. For example, the following three routes mean the same thing.

```ruby
match 'posts', to: 'posts#index', via: :get
# OR
get 'posts', to: 'posts#index'
# OR
get 'posts' => 'posts#index'
```

There is a method for each HTTP verb:

- `get`
- `post`
- `patch` and `put`
- `delete`
- `options`

All of them accept the exact same options that we saw for the `match` method. 

> For the remaining post, I'll use the above shorthands instead of the more explicit match method, unless needed.



##  Segment Keys

So far, we've seen route paths such as `posts\:id`. If you're new to routing, you might be wondering why there are symbols inside the URL.

These symbol-like terms are called **segment keys, which make your URLs dynamic**. It means that they allow the router to match both `photos/1`, `photos/2` and `photos/n`, where n can be anything.

> A segment key is just a variable prefixed with a colon, just like a symbol, inside a URL pattern. It lets you capture the value inside the URL.

Instead of hard-coding a URL which matches exactly one URL, segment keys allow you to match more than one URL. You can access the values of those keys in the `params` hash, e.g. `params[:id]`.

```ruby
get '/posts/:slug', to: 'posts#show'
```

> A Slug is the unique identifying part of a web address.

When you make a GET request to the URL matching the above route, e.g. `/posts/understanding-router`, Rails sets `params[:slug]` to `understanding-router`. You can access the slug value inside the controller.

```ruby
class PostsController < ApplicationController
  def show
    @post = Post.find_by(slug: params[:slug])
  end
end
```

> Note: If you use segment keys in a route, you have to provide their values when generating the URLs with the Rails helpers.

```ruby
<%= link_to 'Understanding Rails', controller: 'posts', action: 'show', slug: 'understanding-rails' %>
```



## But what if some of my URLs don't need a segment key?

You can mark a segment key as **optional by wrapping it in parentheses**. 
The following route matches both `/posts/understanding-rails` and `posts`.

```ruby
get '/posts(/:slug)', to: 'posts#show'
```



## That's nice, but how can I restrict the slugs to only be text and not numbers?

This is where the `constraints` option that we saw earlier, comes into the picture. You can add restrictions on the segment keys by providing a constraint.

The following route matches only those URLs where `slug` is a word consisting of letters between `a` to `z`.

```ruby
get '/posts/:slug', to: 'posts#show', constraints: { slug: /[a-z]+/ }
# or you can also use a shorthand
get '/posts/:slug', to: 'posts#show', slug: /[a-z]+/
```



## But I also want to access the request object...

For more powerful constraints, you can pass a lambda to `:constraints` which receives the `request` object.

```ruby
get '/posts/:slug', to: 'posts#show', constraints: ->(req) { req.params[:slug].length < 10 }
```



## But, my constraint logic is too complicated, and I hate putting it right there inside the route...

Rails allows you to extract the complex logic to a class that has a `matches(request)` method on it. 
Put that class inside the `app/constraints` directory, and Rails will pick it up without a hitch.

```ruby
get '/posts/:slug', to: 'posts#show', constraints: SlugLength.new

# app/constraints/slug_length.rb
class SlugLength
  def matches?(request)
    request.params[:slug].length < 5
  end
end
```

Don't forget to return a boolean result from the method, depending on whether the URL matches the pattern.

Alright, that's enough about the segment keys.



## Named routes

Named routes give you sweet helper methods to generate the URLs on the fly.
Consider the following route.

```ruby
get 'post/:id', to: 'posts#show'
```

When you make a request to `post/10`, the router invokes the `show` action on the `PostsController` class.

What if you want to link to a post? **How would you go about creating the URL?**

Well, the simplest solution is to interpolate it, passing the post id.

```ruby
link_to post.title, "/post/#{post.id}"
```

But hard-coding URLs into your application is not always a good idea. When your URL changes, you'll have to search the whole codebase to find and replace the old URLs. If you miss one, your code won't complain until the users click the link, only to be shown an error page.

To fix this, you could provide the controller and action name along with the post id, so Rails could infer the URL.

```ruby
link_to post.title, controller: 'posts', action: 'show', id: post.id
```

However, there's an even better way with the **named routes**, where you can name a route by providing the `:as` option.

When you name a route, Rails will automatically generate helper methods to generate URLs for that route. These methods are called `name_url` or `name_path`, where `name` is the value you gave to the `:as` option.

Let's rewrite the above route and give it a name.

```ruby
match '/post/:id', to: 'posts#show', as: 'article'
```

The router creates two methods named: `article_path` and `article_url`. The difference between the two methods is that `article_path` returns only the path portion of the URL, whereas `article_url` returns the complete URL, which includes the protocol and domain.

```ruby
article_path -> `/posts/4`
article_url  -> `https://blog.com/posts/4` or `https://localhost:3000/posts/4`
```

Once you have named a route, you can use it as follows:

```ruby
link_to post.title, article_path(id: post.id)
```

It's less code to write, and it also avoids the problem of hard-coding the URL.
In fact, we can skip the `id` key, and just pass its value.

```ruby
link_to post.title, article_path(post.id)
```

We can go even further. Rails allows you to pass any object to the named helper methods as long as those objects have a `to_param` method on it.

```ruby
class Question
  def to_param
    '100'
  end
end

article_path(Question.new) # '/post/100'
```

What's more, all the active record objects have a `to_param` method out of box, which returns the object's `id` (you can customize this).

```ruby
link_to post.title, article_path(post)
```

This version is more readable, concise, and also avoids the problem of hard-coded URLs. Pretty cool, right?



## Resourceful Routes

Now we're going to tackle one of the most practical concepts in routing that you'll use every day on your Rails apps: resources.

The concept of resources is very powerful in Rails. With a single call to a method named `resources`, Rails will generate seven different routes for you, saving you a lot of typing. But saving a few keystrokes is just the cherry on top. The biggest benefit of using resourceful routing is that it provides a nice organizational structure for your application. Let's learn how.

What's a Resource?

A resource, like an object, is one of those concepts that's difficult to put into words. You intuitively understand them, but you can't express them.

> A resource is the key abstraction of information. Any information that can be named can be a resource.

Any concept in your application domain can be a resource: an article, a course, or an image. It doesn't have to be a physical entity, but can be an abstract concept such as a weather forecast or an SSH connection to connect to a remote server.

The main point is: **you have total freedom** in choosing whatever idea you are using in your application as a resource.


### But Why do I need a Resource?

Good question. You might be wondering what this discussion of resources has to do with routing. Well, resources are fundamental to routing. They allow you to reduce seven different routes into a single method call.

If you've used any software application, you must have noticed that most apps have a few common patterns. Most of the time, you're:

1. Creating some data (publishing a post, uploading an image)
2. Reading that data (viewing the tweets, listening to podcasts)
3. Updating the data (changing source code on GitHub, editing the post)
4. Deleting the data (removing a folder from Dropbox, deleting your profile picture)

No matter how fancy your application is, I guarantee it will have some form of these four actions that your users can take. Collectively, they're called **CRUD** which stands for Create, Read, Update, and Delete.

> A resource is an object that you want users to be able to access via URI and perform CRUD operations.

For each of these actions, your application should have a route. Assuming you're building a course platform, your routes file might have the following routes.

```ruby
post   'courses'      => 'courses#create'
get    'course'       => 'course#show'
patch  'courses/:id'  => 'courses#update'
delete 'courses/:id'  => 'courses#destroy'
```

In addition to these four routes, you'll typically have three more:
- one to see all the courses
- two to fetch the pages that let the users create and modify the courses.

```ruby
get 'courses'          => 'courses#index'

get 'courses/new'      => 'courses#new'
get 'courses/:id/edit' => 'courses#edit'
```

So we have a total of seven routes that are common to most resources in most web applications. If you are building a blog, you'll have these seven routes for `posts`. If you're building Instagram, you'll have the same routes for `images`.

> No matter the topic, you'll most likely have some subset of these seven routes for each resource.

Since this pattern is so common, Rails introduced the concept of resourceful routing, whereby calling one method named `resources` and passing the name of the resource, i.e. `:post`, `:course`, `:image`, etc. you get these seven routes for free. Rails will automatically generate them for you.

```ruby
resources :courses
```

In addition, resourceful routing also generates sensible names for these routes. For example, you'll have names like `course_path`, `edit_course_path` at your disposal without providing the `:as` option.

The following table summarizes what you get with a single call to `resources`. 
The values under the **Prefix** column represent the prefix of the route's name, e.g. `new_course` gives you `new_course_path` and `new_course_url` helpers, and so on.  

```ruby
$ bin/rails routes -g course

     Prefix Verb   URI Pattern                 Controller#Action
    courses GET    /courses(.:format)          courses#index
            POST   /courses(.:format)          courses#create
 new_course GET    /courses/new(.:format)      courses#new
edit_course GET    /courses/:id/edit(.:format) courses#edit
     course GET    /courses/:id(.:format)      courses#show
            PATCH  /courses/:id(.:format)      courses#update
            PUT    /courses/:id(.:format)      courses#update
            DELETE /courses/:id(.:format)      courses#destroy
```

> Resourceful routing allows you to quickly declare all of the common routes for a given resource. 
> A single call to `resources` declares seven routes for `index`, `show`, `new`, `create`, `edit`, `update`, and `destroy` actions.

In addition to having multiple resources, there's also a singular form of resourceful routes. It represents a resource that only has one, single form. For example, a logged-in user's profile. You can use the `resource` method for this.

```ruby
resource :profile
```

It creates the following routes:

```ruby
new_profile GET    /profile/new(.:format)  profiles#new
edit_profile GET    /profile/edit(.:format) profiles#edit
     profile GET    /profile(.:format)      profiles#show
             PATCH  /profile(.:format)      profiles#update
             PUT    /profile(.:format)      profiles#update
             DELETE /profile(.:format)      profiles#destroy
             POST   /profile(.:format)      profiles#create
```

Note two important differences from the plural version:

1. The route to show all profiles is missing. Since we only have a single profile, there's no point in displaying all.
2. None of the routes contain an id segment key. We don't need it to identify a profile as there's only one profile.



### What if I don't have all seven routes?

Sometimes, you don't want all seven routes that `resources` method creates for you. In such cases, you can pass the `only` or `except` options to filter the ones you need or don't need.

```ruby
resources :courses, only: [:index, :show]

resources :courses, except: [:delete]
```

You can even nest multiple resources.


## Non-Resourceful Custom Routes

A single call to `resources` in the `routes.rb` file declares the seven standard routes for your resource. What if you need additional routes?

Don't worry, Rails will let you create custom routes that don't fit one of the above seven routes with the `member` and `collection` routes. 

- The `member` route only applies to a single resource, 
- whereas `collection` will apply to a group of resources.


### Member Routes

Let's assume that your users need to see a preview of the course before purchasing it, and you need to expose that route on the `courses/:id/preview` URL. How should you go about it?

Here's how you define the `preview` route on the `CoursesController` using the `member` block.

```ruby
resources :courses do
  member do
    get 'preview'
  end
end
```

The router adds a new route that directs the request to the `preview` action on the `CoursesController` class. The remaining routes remain unchanged.

It also passes the course id in `params[:id]` and creates the `preview_course_path` and `preview_course_url` helpers.

```ruby
preview_course GET    /courses/:id/preview(.:format) courses#preview
```

If you have a single `member` route, use the short-hand version by passing the `:on` option to the route, eliminating the block.

```ruby
resources :courses do
  get 'preview', on: :member
end
```


### Collection Routes

Let's say you want to search all courses and you want to expose it on the `courses/search` endpoint. You can add a new route for the collection of courses with the `collection` block.

```ruby
resources :courses do
  collection do
    get 'search'
  end
end
```

This adds the following new route. It will also add a `search_courses_path` and `search_courses_url` helpers.

```ruby
search_courses GET    /courses/search(.:format)   courses#search
```

If you don't need multiple `collection` routes, just pass `:on` option to the route.

```ruby
resources :courses do
  get 'search', on: :collection
end
```

This will add the same route as above.

To learn more about custom routes, check out this article: https://www.akshaykhot.com/define-new-routes-using-member-and-collection-blocks-in-rails/

As we saw, the Rails router is very powerful and highly flexible. Routing is also a two-way street: match URLs to controller actions, and generate URLs dynamically. Additionally, the router uses powerful conventions such as resourceful routing to automatically generate sensible routes for you.

Alright, I will stop here. There are a few other shortcuts and helper methods that we didn't cover in this article, but I've already written more than 5000 words non-stop, and this article is way, wayy, wayyy bigger than what I first thought it would be. If you're still reading, I sincerely hope that you learned at least one new thing about the Rails router that you didn't know before.

Expect a few posts in the upcoming weeks that will explain the remaining topics. But what we've covered so far should be more than enough for you to get started and be productive with using various routing features, both basic and advanced, in your applications.

Here're some additional resources, if you want to learn more about routing.

Further Resources

- [Rails Routing from the Outside In](https://guides.rubyonrails.org/routing.html?ref=akshaykhot.com)
- [Rails API: The Mapper Class](https://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper.html?ref=akshaykhot.com)
- [Routing in Laravel (to learn routing from a different framework's perspective)](https://laravel.com/docs/10.x/routing?ref=akshaykhot.com)
- [Roy Fielding's Dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm?ref=akshaykhot.com)



## Define New Routes Using the Member and Collection Blocks


```ruby
# preview_article: /articles/:id/preview

resources :articles do
  member do
    get 'preview'
  end
end
```


```ruby
# search_articles: /articles/search

resources :articles do
  collection do
    get 'search'
  end
end
```

A single call to `resources` in the `routes.rb` file declares the seven standard routes for your resource. What if you need additional routes? Don't worry. Rails provides the `member` and `collection` blocks so you can define custom routes for both the resource collection and the individual resource.

Here's how you'd typically define routes for the `article` resource.

```ruby
resources :articles
```

This creates the following routes.

```ruby
$ bin/rails routes -g article

      Prefix Verb   URI Pattern                  Controller#Action
    articles GET    /articles(.:format)          articles#index
             POST   /articles(.:format)          articles#create
 new_article GET    /articles/new(.:format)      articles#new
edit_article GET    /articles/:id/edit(.:format) articles#edit
     article GET    /articles/:id(.:format)      articles#show
             PATCH  /articles/:id(.:format)      articles#update
             PUT    /articles/:id(.:format)      articles#update
             DELETE /articles/:id(.:format)      articles#destroy
```

But let's say you are writing your articles in markdown, and need to see a preview of the article as you write it.

You could create a `PreviewController` and display the article's preview using its `show` action, but it's convenient to add a `preview` action on the `ArticlesController` itself.


### Custom Member Routes

Here's how you define the `preview` route on the `ArticlesController` using the member block.

```ruby
resources :articles do
  member do
    get 'preview'
  end
end
```

The Rails router adds a new route that directs the request to `ArticlesController#preview` action. 
The remaining routes remain unchanged. It also passes the article id in `params[:id]` and creates the `preview_article_path` and `preview_article_url` helpers.

```ruby
$ bin/rails routes -g article

         Prefix Verb   URI Pattern                     Controller#Action
preview_article GET    /articles/:id/preview(.:format) articles#preview

...remaining routes
```

If you have a single `member` route, use the short-hand version by passing the `:on` option to the route, eliminating the block.

```ruby
resources :articles do
  get 'preview', on: :member
end
```

You can go one step further and leave out the `:on` option.

```ruby
resources :articles do
  get 'preview'
end
```

It generates the following route.

```ruby
$  bin/rails routes -g preview

         Prefix Verb URI Pattern                         Controller#Action         
article_preview GET  /articles/:article_id/preview(.:format) articles#preview
```

There are two important differences here:

1. The article's id is available as `params[:article_id]` instead of `params[:id]`.
2. The route helpers changes from `preview_article_path` to `article_preview_path` and `preview_article_url` to `article_preview_url`.



## Custom Collection Routes

To add a new route for the collection of a resource, use the `collection` block.

```ruby
resources :articles do
  collection do
    get 'search'
  end
end
```

This adds the following new route. It will also add a `search_articles_path` and `search_articles_url` helper.

```ruby
search_articles GET    /articles/search(.:format)   articles#search
```

If you don't need multiple `collection` routes, just pass `:on` option to the route.

```ruby
resources :articles do
  get 'search', on: :collection
end
```

This will add the same route as above.



## Conclusion

Rails allows you to break out of its convention of using seven resourceful routes using the `member` and `collection` blocks. Both allow you to define additional routes for your resources than the standard seven routes.

- A `member` block acts on a single member of the resource, 
- whereas a `collection` operates on a collection of that resource.
