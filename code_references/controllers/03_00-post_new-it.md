# <a name="top"></a> Cap controllers.3 - Spiegazione su Post.new ripetuto


## Domanda

I have just confusion about these two methods in post_controller. And that makes me to add user_id in the post_param.permit.require

Why we must repeat that code twice @post = Post.new into the two methods.once with param and once without. I was trying to make it work with one instance of them only, so I added user_id in post_param method.

We have created the instance in the new method. So why we must create newer instance with post_param?

```ruby
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save 
      flash[:notice] = "You have already created your post"
      redirect_to posts_path
    else
      flash[:alert] = "Something wrong with your post"
      render new_post_path, status: :unprocessable_entity
    end
  end

 def post_params 
    params.require(:post).permit(:title, :body, user_id)
  end
```



## Risposta

The two lines in your example (namely line 2, and 6) have different responsibilities.

The `new` action initializes the form setting all the values to `nil`. That's so you can fill it in, otherwise, it would be populated with the values you set on the `@post` object.

Also, it doesn't have access to the parameters sent by the form, because the action that handles the form is the `create` action.

The `create` action on the other hand takes the data sent through the form and builds a new `Post` object. But this time the fields are not `nil` anymore, because they are being set (through mass-assignment) to the values in the params.

And to answer your question, it's because each request is totally separate from all other requests. All requests are stateless. So Rails has no knowledge about the previous requests.

So the `@post` object in the `new` method is gone after the response has been sent to the user's browser.

The second request (the form submission) starts from scratch.