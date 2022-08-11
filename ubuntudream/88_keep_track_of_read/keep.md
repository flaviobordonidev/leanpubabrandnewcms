

- https://gorails.com/forum/how-to-mark-a-post-as-read-so-that-it-won-t-show-up-again-for-a-user

Creare una relazione molti-a-molti

lesson_user_maps --> journals

def show
    @post = Post.find(params[:id])
    @read = Journal.where(post_id: @post.id, user_id: current_user.id).last
end


# user model
  has_many :journals # kinda clunky but it means journal entries
  has_many :posts, :through => :journals
# posts model
  has_many :journals
  has_many :users, :through => :journals
# journal model
  belonds_to: user
  belongs_to :post


<% if @read == nil %>
    <% form_for @journal do |f| %>
        <% f.hidden_field :post_id, value: post.id %>
        <% f.hidden_field :user_id, value: current_user.id %>
        <% f.submit 'Mark as Read' %>
    <% end %>
<% else %>
    You read this entry <%= time_ago_in_words(@read.created_at) %> ago
<% end %>


Now, you can create a page where you list all the posts read by a user by doing a query like this:
@posts_read_by_user = current_user.posts

Or, you can list all the readers of a post:
@readers_of_post = @post.users

