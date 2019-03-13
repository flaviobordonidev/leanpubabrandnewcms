class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    @posts = Post.published
    authorize @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.friendly.find(params[:id])
    authorize @post
    #@post = authorize Post.friendly.find(params[:id])
  end

end
