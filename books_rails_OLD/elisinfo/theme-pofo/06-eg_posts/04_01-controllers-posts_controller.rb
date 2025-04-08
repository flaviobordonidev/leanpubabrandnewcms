class PostsController < ApplicationController
  layout 'pofo'

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag].present?
      @pagy, @posts = pagy(Post.published.tagged_with(params[:tag]).order(created_at: 'DESC'), items: 2)
      #@posts = Post.published.tagged_with(params[:tag]).order(created_at: "DESC")
    else
      @pagy, @posts = pagy(Post.published.order(created_at: 'DESC'), items: 2)
      #@posts = Post.published.order(created_at: "DESC")
    end
    authorize @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.friendly.find(params[:id])
    authorize @post
  end
end
