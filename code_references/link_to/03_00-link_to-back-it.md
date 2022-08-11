# <a name="top"></a> Cap link_to.1 - Torniamo alla pagina precedente

Creiamo un pulsante che torna alla pagina che lo ha chiamato.



## Risorse esterne

- [Ruby on Rails - back button that will take you back to the previous page](https://stackoverflow.com/questions/70960161/ruby-on-rails-back-button-that-will-take-you-back-to-the-previous-page)
- [Rails going backwards](https://dev.to/notapatch/rails-going-backwards-56h5#:~:text=link_to%20%3Aback%20rails%20code%20It,a%20referer%20if%20none%20exists).)
- [Ensure location is safe before redirecting in Rails 7.0](https://www.mintbit.com/blog/ensure-location-safe-before-redirect-rails7)


- [Redirect to back is deprecated in Rails5. What to use instead?](https://medium.com/@hsdeekshith/redirect-to-back-is-deprecated-in-rails-5-what-to-use-instead-7ac8e970cd39)

```
redirect_back(fallback_location:"/")
redirect_back(fallback_location: { action: "show", id: 5})
redirect_back(fallback_location: users_path)
```

- [How to redirect browser window back using JavaScript ?](https://www.geeksforgeeks.org/how-to-redirect-browser-window-back-using-javascript/)



## Link_to back

```html+erb
<%= link_to "Back", :back %>
```

Quando lo uso in forma pulita funziona. Quando invece arrivo con un link che disattiva turbo siccome ho un refresh della pagina il `link_to "Back", :back` non funziona. Mi resta sulla stessa pagina con il video nascosto.

Solution: Back with JavaScript
Another popular class of answers are JavaScript. JavaScript is also used in Rails :back if the referer can't be found. Example of Back with Javascript is in listing 2.

```html+erb
 <%= link_to 'Back', 'javascript:history.back()' %>
```



##  Javascript - Approach 1: Using history.back()

This example uses history.back() method to redirect the browser into previous page.

```javascript
<html>

<head>
	<script>
		function Previous() {
			window.history.back()
		}
	</script>
</head>

<body>

	<input type="button"
		value="GoBack"
		onclick="Previous()">

</body>

</html>
```



##  Javascript - Approach 2: Using history.go() 

The history.go() method of the window.history object is used to load a page from the session history. It can be used to move forward or backward using the value of the delta parameter. A positive delta parameter means that the page would go forward in history. Similarly, a negative delta value would make the page go back to the previous page. This method can be used with ‘-1’ as the delta value to go back one page in history. The onclick event can be specified with the method to go back one page in history. 

Syntax:

```javascript
  history.go(number\URL)
```

Example 2: This example uses window.history.go() method to redirect the browser into previous page. 

```html
<!DOCTYPE html>
<html>

<body>
	<button onclick="Previous()">Go Back 1 Page</button>
	<script>
		function Previous() {
			window.history.go(-1);
		}
	</script>
</body>

</html>
```

Note: This method will not work if the previous page does not exist in the history list. 

--
Listing 2

```javascript
 <%= link_to 'Back', 'javascript:history.back()' %>
```

JavaScript back uses the browser's page stack. Each time it visits a page, it is added to a stack of URLs. Going back meant popping each page reference off the stack. Here's a Stackoverflow on how a Browser back button works. The downside for this, if the user had gone to the edit and then saved and returned to the show page and then started to use back you would have to go "back" via the edit which might not be what the user expected.



## Solution 4: Back with session
The final class of solutions were saving the routes in the session. To get this to work, I added methods to the ApplicationController to set and retrieve the values, as well as code to update the session in the controller and use the session variable in the view's link_to - Listing 3 contains the code.

This is not nearly as nice as the other two solutions, much less cohesion, as there's already 3 files required compared to 1 liners for the other solutions.

I'm not saying this is good code, I'm just saying this is what I had to do to get it to work!

Listing 3 Example of using session to go backwards
# app/controllers/application_controller.rb

class ApplicationController
  ...
  helper_method :retrieve_last_index_page_or_default
  ...
  def store_last_index_page
    session[:last_index_page] = request.fullpath
  end

  def retrieve_last_index_page_or_default(default_path: root_path)
    session[:last_index_page] || default_path
  end
  ...
end
Updating session in controller code
# app/controllers/my_controller.rb
class MyController < ApplicationController
  ...
  def index
    ...
    # this could have been in a before_action
    store_last_index_page
    ...
  end
end
View code
# app/views/my/index.html.erb

# this could have been a variable set in controller
<%= link_to retrieve_last_index_page_or_default do %>
  ...
<% end %>



## Caso interessante fatto a livello di controller

In Rails 7.0 the problem is solved by setting a `url_from` method in private:

```ruby
class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to return_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def return_url
      url_from(params[:return_to]) || @post
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
```

The `url_from` method is new in Rails 7 and should **not be confused** with `url_for` which generates an internal URL from within the app.



## Ruby on Rails - back button that will take you back to the previous page

Usually you can use link_to with the symbol :back instead of an URL like this

```
<%= link_to "Back", :back %>
```

to return to the previous page.

But this, unfortunately, doesn't work in cases in which you want to skip certain pages (like a page with a form), because :back would simply return you to the previous URL from your history.

If you only want to return to certain pages but not to others then you have to build that functionality on your own. I would start with pushing those pages into the session that you think are worth being on that list. For example like this:

```ruby
# in the `application_controller.rb`
private

def remember_page
  session[:previous_pages] ||= []
  session[:previous_pages] << url_for(params.to_unsafe_h) if request.get?
  session[:previous_pages] = session[:previous_pages].unique.first(2)
end

# in each controller that is worthy
before_action :remember_page, only: [:index, :show]
Now you will find the previous and the current page in the session if there was already a previous page. And will can return to that previous page with a helper like this

# in a helper
def link_to_previous_page(link_title)
  link_to_if(
    session[:previous_pages].present? && session[:previous_pages].size > 1,
    link_title, 
    session[:previous_pages].first
  )
end
```

Which can be used in a view like this

```
<%= link_to_previous_page("return to previous page") %>
```

spickermann

Thank you! I had someone else recomment this gem: github.com/Greyoxide/backpedal (https://github.com/Greyoxide/backpedal/tree/master/lib/backpedal) but I think I'm going to try using this instead. – 
Stephanie Couto
 Feb 2 at 19:46

What do you mean by controller page that is worthy? A any page that I would like my user to go back to? So no forms obviously... Is "before_action :remember_page, only: [:index, :show]" how rails keeps track of the previous URL? – 
Stephanie Couto
 Feb 2 at 20:00 

Rails doesn't know how the previous page looked like. If there was a form on it or not. Therefore you need to tell Rails what pages to remember and which not. You can do that by calling remember_page before all actions that you want to remember. Or you can remember all pages and only skip the before_action for those that you do not want to remember. But Rails cannot make the decision for you. – 
spickermann
 Feb 2 at 20:14

Can you help explain `session[:previous_pages] << url_for(params) if request.get?` to me? I keep getting a unable to convert unpermitted parameters to hash error and I'm trying to trouble shoot the issue myself. i just can't find url_for in rails very frequently so it has been difficult – 
Stephanie Couto
 Feb 8 at 19:56 

`url_for` allows creating an URL from a hash. The params in the controller represent the current request. That means when the request was a get request (we do not want to return to post, put or delete requests) then add the current URL to the list of URLs to remember. Regarding the error: I updated my answer to address that issue. – 
spickermann
 Feb 8 at 20:03