# <a name="top"></a> Cap best-practiesr.2 - Sulla sicurezza

Buone pratiche per mantenere sicuro il codice



## Risorse interne

- []()



## Risorse esterne

- [Security Best Practices for Your Rails Application](https://blog.appsignal.com/2022/10/05/security-best-practices-for-your-rails-application.html?utm_source=ruby-magic&utm_medium=email&utm_campaign=rss-email&utm_content=button)



## Intro

Alongside performance and usability, you should always focus on security when creating any web application. Keep in mind that hacking techniques are constantly evolving, just as fast as technology is. So you must know how to secure your users and their data.

This article will show you how to create a secure Rails application. The framework is known to be secure by default, but the default configuration is not enough to let you sleep well at night.

We will share some best coding practices and a few habits in the development process that can help you create secure code.

Let's dive in!

Security in Your App: Best Coding Practices
Modern web applications are often complex. They utilize multiple data sources and handle custom authorization rules as well as different methods of authentication. Knowing how to avoid SQL injections or ensuring that users can only read their data is not enough.

When you build a Rails application, you have to configure it properly, design the application securely, and write code that makes it bulletproof.

We'll look at:

- Application configuration - The default configuration is exemplary, but we can make things even better with a few extra steps.
- Business logic - Applications should be secure by design, not only by code. This principle is essential but is often ignored when an MVP has to be delivered quickly.
- Code in controllers - These classes are the entry point to our application, so an extra dose of attention is always needed to design a reliable application.
- Code in models - Many issues are related to a database, so it is essential to design and perform secure communication with the primary source of the data.
- Code in views - The point where we expose data to the browser is also a popular target for hackers, so we have to ensure that we don't render anything that risks our users' data or privacy.



## Application Configuration

It all starts here, in the configuration files. In most cases, unless you restart the application, the rules will remain the same. Rails' creators made an effort to create secure defaults, but we can still improve them with some extra steps.



### Force SSL

You can force your Rails application to always use a secure connection with the HTTPS protocol. To do this, open the `config/environments/production.rb` file and set the following line:

```
config.force_ssl = true
```

This setting does a few things to the application:

- Every time there is a request to the HTTP version of the application, Rails will redirect the request to the HTTPS protocol.
- It sets a secure flag on cookies. Thanks to this, browsers won't send cookies with HTTP requests.
- It tells the browser to remember your application as TLS-only (TLS is Transport Layer Security, an extension of the HTTPS protocol).



### CORS

Cross-Origin Resource Sharing (CORS) is a security mechanism that defines which website can interact with your application's API. Of course, if you build a monolith app, you don't need to care about this protection.

If you build an API application, you can configure CORS by installing an additional gem called `rack-cors`.

Once you have done that, create a file called `cors.rb` in the initializers directory `config/initializers`. Define what endpoints a website can access (including request methods):

```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
 allow do
   origins 'https://your-frontend.com'
   resource '/users',
     :headers => :any,
     :methods => [:post]
   resource '/articles',
     headers: :any,
     methods: [:get]
 end
end
```

In the above example, we allow the your-frontend.com website to call the `/users` endpoint (using only the POST method) and the `/articles` endpoint (using only the GET method).



## Secure Environment Variables

You should never hardcode your API keys, passwords, or other sensitive credentials in the source code. You might accidentally make them public or give someone who's not authorized access to some sensitive application resources.

The Rails framework itself provides a way to store credentials securely. However, the implementation varies depending on the framework version:

- Rails 4 - The feature is called 'secrets'. You store your sensitive information in a config/secrets.yml file that is not tracked in the git repository.
- Rails 5 - The feature is called 'credentials'. Your sensitive information is stored encrypted in config/credentials.yml.enc — you can edit it with the config/master.key file. So while the YAML configuration file can be stored in the repository because it’s encrypted, you don’t track the master.key file.
- Rails 6 - Also called 'credentials', you can store credentials per environment. Because of that, for every environment, you have the encrypted YAML file and key to decrypt it.
Alternatively, you can always set the values on the server level, so that they only load in the server environment. Locally, each developer sets them individually.



### Business Logic
You should think about security not only when you write code, but also when you design the processes in your application.

Business logic is a set of rules that apply in the real world, and your goal is to map them in your code. Unfortunately, mapping them can cause weak points in your application and lead to security issues.



### Strong Authentication and Authorization Rules
Let's first explain the difference between authentication and authorization, as these terms are sometimes misinterpreted:

- **Authentication** - You validate a user's login and password against an application's database.
- **Authorization** - You validate the role of a signed-in user and, based on that, render different information for different users. For example, a user with an admin role can access a list of users in an application, while in most cases, the typical user can't.
To improve the security level of your authentication, you can set high standards for your end-users:

- **Strong passwords** - Set a strict password policy that doesn't allow for passwords that are too simple or weak. Of course, you can't control if your users share their passwords, but you can make their passwords hard to guess.
- **Two-factor authentication** - Another layer of protection that will secure an account even if someone else knows the password.
- **Encrypted passwords** - Never store passwords in your database as plain text. Then, even if your database is exposed, a hacker won't be able to get your users' passwords.



## Authorization Best Practices
If your application is complex, you probably need different roles for users to manage their data. As business logic grows, it may be hard to control everything without making a mistake that leads to an information leak.

You can avoid issues by following some well-known good practices:

- **Keep authorization logic in one place** - It's hard to modify business logic correctly if you have to change multiple areas in the code. Storing the rules in one file makes it easy.
- **Set clear rules** - You won't be able to tell whether your application is secure if you can't validate the business logic against well-defined rules.
- **Set roles based on the group, not a single user** - It is easier to control the authorization process if you have groups of permissions instead of defining rules per user.

Of course, good code reviews and well-written tests are also a must here to avoid introducing bugs to existing business logic.



## Code in Controllers

Controllers are the first layer of MVC architecture and handle requests coming from users. Therefore, it is essential to filter incoming information correctly as it will be propagated on other application layers.

### Filter Incoming Parameters

You should never pass a raw `params` value to your application. Thanks to the strong parameters feature, it is easy to control the data that we'd like to pass along.

Imagine that we have a `User` model we want to update:

```
class UsersController < ApplicationController
  def update
    current_user.update(params[:user])
  end
end
```

Someone can manipulate the params, and it would be possible to update other `User` model attributes (for example, the `admin` flag if you have one). To avoid such a situation, filter params that you pass to your model:

```
class UsersController < ApplicationController
  def update
    current_user.update(user_params)
  end
 
  private
 
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
```



### Use Scopes to Avoid Data Leaking

Usually, we don't want to show the user data that does not belong to them. We may inadvertently expose some records for URL address manipulation due to the wrong code design. Let's consider the following case:

```
class MessagesController
  before_action :authenticate_user!
 
  def show
    @message = Message.find(params[:id])
  end
end
```

Everything seems fine; the controller is protected from guests, and we assign the message object. However, a user just needs to change the id in the URL address to get a message that does not belong to them. This is a very dangerous situation.

We can avoid it by using scopes within the given context. In the mentioned example, the current user is the scope:

```
class MessagesController
  before_action :authenticate_user!
 
  def show
    @message = current_user.messages.find(params[:id])
  end
end
```



## Avoid Insecure URL Redirects
Let's consider a straightforward example of a redirect based on the user input:

```
redirect_to params[:url]
```

We should never do that, as we expose our user to a redirect that can take them everywhere. The simplest solution to prevent this security issue is to avoid using redirects with user input. If you can't, you can always redirect to a path without the host:

```
path = URI.parse(params[:url]).path.presence || "/"
redirect_to path
```



## Code in Models

Once Rails parses code in a controller, you will probably call models to receive the information from the database. Since models are responsible for communicating with your database as well as performing important computations, they are also often targeted by hackers.



## Avoid SQL Injection

SQL injection is one of the most popular techniques used to access database information from the outside. The Rails framework tries to protect us from that threat, but we also need to write code that won't let this happen.

In general, we should avoid passing user input directly as a part of a query:

```
User.joins(params[:table]).order('id DESC')
```

If you need to, always validate the user input and assign a default value when the input is invalid:

```
valid_tables = %w[articles posts messages]
table = valid_tables.include?(params[:table]) ? params[:table] : "articles"
User.joins(table).order('id DESC')
```

[Check out this extensive set of examples of what not to do when it comes to SQL injection.](https://rails-sqli.org/)



## Prevent Command Injection

Avoid using methods that allow a program to execute any code. Such methods include `exec`, `system`, `` ` ``, and `eval`. You should never pass user input to those functions.

If your application allows users to execute code, you should run their code in separate Docker containers. In addition, you can remove dangerous methods before executing user input:

```ruby
module Kernel
 remove_method :exec
 remove_method :system
 remove_method :`
 remove_method :eval
 remove_method :open
end
 
Binding.send :remove_method, :eval
RubyVM::InstructionSequence.send :remove_method, :eval
```



## Avoid Unsafe Data Serialization
Insecure deserialization can lead to the execution of arbitrary code in your application. If you plan to serialize JSON:

```ruby
data = { "key" => "value" }.to_json
# => "{\"key\":\"value\"}"
```

Instead of using `load` or `restore` methods, use `parse`:

```ruby
# bad
JSON.load(data)
JSON.restore(data)
 
# good
JSON.parse(data)
```

If you plan to serialize YAML:

```ruby
data = { "key" => "value" }.to_yaml
# => "---\nkey: value\n"
```

Instead of using `load` or `restore` methods from the `Marshal` module, use the `safe_load` method from `Psych`:

```
# bad
Marshal.load(data)
Marshal.restore(data)
 
# good
Psych.safe_load(data)
```



## Code in Views
Whatever you render in views is visible to the end-user. When malicious code is rendered, it will affect your users directly by exposing them to untrusted websites and data sources.



## Avoid CSS Injection

It would appear that CSS code is always secure; it only modifies the styles of a website. However, if you allow for user-defined styles in your application, there is always a risk of CSS code injection.

One of the most popular cases of user-defined CSS is a custom page background:

```
<body style="background: <%= profile.background_color %>;"></body>
```

A user with bad intentions can input a URL that an application will automatically load, and do damage to the current user viewing the content. To prevent such situations, provide a predefined set of values instead of allowing users to type any value.



## Sanitize Rendered Output

In the modern versions of Rails, output is sanitized by default. Even if a user inputs HTML or JS code and the application renders it, the HTML or JS code will escape.

If you want to render HTML defined by users, always predefine which tags should render and which should escape:

```
<%= sanitize @comment.body, tags: %w(strong em a), attributes: %w(href) %>
```

In the above code, we allow users to render `strong`, `em`, and `a` HTML elements in their comments.



## Don't Include Sensitive Data in Comments

This is primarily a reminder for junior developers unfamiliar with how web applications work on the front end. Don't ever put sensitive information in comments (especially in views, as it will be exposed to end-users):

```
<!--- password for the service is 1234 –>
<%= @some_service.result_of_search %>
```



## Habits to Keep Your Rails Application Secure

To make your Rails app secure and reduce technical debt, establish some valuable development habits. Taking small preventative actions frequently is much less painful than refactoring more significant portions of your codebase.



## Upgrade Rails and Other Libraries Often

An upgrade is often painful and time-consuming, unless you upgrade to minor versions of a library. Develop a habit of upgrading a library each time a new, stable version is published. Your application will then be in good shape (not only regarding security, but also performance).

If you use GitHub for day-to-day development, an extension like Depfu is useful as it performs frequent updates for you.



## Perform Security Audits

I don't mean expensive audits by external companies. Often, it is enough to install a tool like [Brakeman](https://brakemanscanner.org/) and scan code with every commit or pull request.

Also, it is a good idea to scan your Gemfile and find gems that need updating due to security issues discovered by the community. You can use [bundler-audit](https://github.com/rubysec/bundler-audit) to automate this process.



## Have A Proper Logging Strategy

Logs, in many cases, are usually just thousands of lines of information you will never view. However, there might be a case where one of your users is attacked or experiences a suspicious action.

In such a situation, if you have detailed and easily searchable logs, you can collect information that will help you prevent similar problems in the future.



## Wrapping Up: Keep Your Rails App Secure

In this post, we ran through some security best practices for your Rails app that reduce the risk of a data breach.

Making sure that your Rails application is secure might be challenging. Sticking to the framework's defaults is not enough; you have to know how to avoid creating security issues. For example, various injections and remote code executions have been well-known issues for the past few years, but still, you can't be 100% sure that your application won't be affected.

Don't forget the importance of frequent upgrades, security audits, and a culture of good logging. When combined, all of these things will help to make your Rails application more secure.

Happy coding!
