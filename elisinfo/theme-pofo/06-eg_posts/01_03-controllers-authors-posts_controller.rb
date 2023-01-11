class Authors::PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  layout 'dashboard'

  # GET /posts
  # GET /posts.json
  def index
    @posts = current_user.posts.order(created_at: "DESC") unless current_user.admin?
    @posts = Post.all.order(created_at: "DESC") if current_user.admin?
    authorize @posts
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    # params restituisce una stringa ed il check-box restituisce "1" se flaggato.
    params[:post][:published_at] = "#{DateTime.current}" if params[:post][:published] == "1" and params[:post][:published_at].blank?
    params[:post][:published_at] = "" if params[:post][:published] == "0"
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to authors_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
      authorize @post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :incipit, :content, :content_type, :video_youtube, :video_vimeo, :seocontent, :user_id, :main_image, :published, :published_at, :tag_list, :paraghraph_title1, :paragraph_content1, :paragraph_image1, :paragraph_title2, :paragraph_content2, :paragraph_title3, :paragraph_content3, :paragraph_title4, :paragraph_content4, :paragraph_image4, :paragraph_title5, :paragraph_content5, :paragraph_image5, :paragraph_image_label5, :paragraph_title6, :paragraph_content6, :paragraph_image6, :paragraph_image_label6)
    end
end
