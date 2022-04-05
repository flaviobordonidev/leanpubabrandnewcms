class EgPostsController < ApplicationController
  # GET /eg_posts or /eg_posts.json
  def index
    #@eg_posts = EgPost.all
    #@eg_posts = EgPost.published.order(created_at: "DESC")
    @pagy, @eg_posts = pagy(EgPost.all, items: 2)
    #@pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
    authorize @eg_posts
  end

  # GET /eg_posts/1 or /eg_posts/1.json
  def show
    @eg_post = EgPost.find(params[:id])
    authorize @eg_post
  end
end