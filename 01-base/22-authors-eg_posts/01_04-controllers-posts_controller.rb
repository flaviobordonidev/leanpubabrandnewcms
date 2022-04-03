class EgPostsController < ApplicationController
  layout 'dashboard'

  # GET /eg_posts
  # GET /eg_posts.json
  def index
    #@pagy, @eg_posts = pagy(EgPost.all, items: 2)
    @pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
    authorize @eg_posts
  end

  # GET /eg_posts/1
  # GET /eg_posts/1.json
  def show
      @eg_post = EgPost.find(params[:id])
      authorize @eg_post
  end

end
