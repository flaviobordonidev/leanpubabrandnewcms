class EgPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_eg_post, only: [:show, :edit, :update, :destroy]

  # GET /eg_posts
  # GET /eg_posts.json
  def index
    #@eg_posts = EgPost.all
    @pagy, @eg_posts = pagy(EgPost.all, items: 2)

    authorize @eg_posts
  end

  # GET /eg_posts/1
  # GET /eg_posts/1.json
  def show
  end

  # GET /eg_posts/new
  def new
    @eg_post = EgPost.new
    authorize @eg_post
  end

  # GET /eg_posts/1/edit
  def edit
  end

  # POST /eg_posts
  # POST /eg_posts.json
  def create
    @eg_post = EgPost.new(eg_post_params)
    authorize @eg_post

    respond_to do |format|
      if @eg_post.save
        format.html { redirect_to @eg_post, notice: 'Eg post was successfully created.' }
        format.json { render :show, status: :created, location: @eg_post }
      else
        format.html { render :new }
        format.json { render json: @eg_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eg_posts/1
  # PATCH/PUT /eg_posts/1.json
  def update
    respond_to do |format|
      if @eg_post.update(eg_post_params)
        format.html { redirect_to @eg_post, notice: 'Eg post was successfully updated.' }
        format.json { render :show, status: :ok, location: @eg_post }
      else
        format.html { render :edit }
        format.json { render json: @eg_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eg_posts/1
  # DELETE /eg_posts/1.json
  def destroy
    @eg_post.destroy
    respond_to do |format|
      format.html { redirect_to eg_posts_url, notice: 'Eg post was successfully destroyed.' }
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
    def set_eg_post
      @eg_post = EgPost.find(params[:id])
      authorize @eg_post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :user_id, :price, :header_image)
    end
end
