class Authors::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  layout 'dashboard'

  # GET /authors/posts
  # GET /authors/posts.json
  def index
    #@posts = current_user.posts unless current_user.admin?
    #@posts = Post.all if current_user.admin?
    @pagy, @posts = pagy(current_user.posts) unless current_user.admin?
    @pagy, @posts = pagy(Post.all) if current_user.admin?
    authorize @posts
  end

  # GET /authors/posts/new
  def new
    #@post = Post.new
    @post = current_user.posts.new
    authorize @post
  end

  # GET /authors/posts/1/edit
  def edit
  end

  # POST /authors/posts
  # POST /authors/posts.json
  def create
    @post = Post.new(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/posts/1
  # PATCH/PUT /authors/posts/1.json
  def update
    #raise "published è #{params[:post][:published] == "1"} - published_at è #{params[:post][:published_at].blank?} - La data di oggi è #{DateTime.current}"
    # params restituisce una stringa ed il check-box restituisce "1" se flaggato.
    params[:post][:published_at] = "#{DateTime.current}" if params[:post][:published] == "1" and params[:post][:published_at].blank?
    params[:post][:published_at] = "" if params[:post][:published] == "0"
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/posts/1
  # DELETE /authors/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to authors_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
      authorize @post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :incipit, :content, :type_of_content, :video_youtube, :video_vimeo, :seocontent, :date_chosen, :user_id, :main_image, :published, :published_at)
    end
end