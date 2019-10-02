class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.published.order(created_at: "DESC")
    authorize @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.friendly.find(params[:id])
    authorize @post
  end
end
