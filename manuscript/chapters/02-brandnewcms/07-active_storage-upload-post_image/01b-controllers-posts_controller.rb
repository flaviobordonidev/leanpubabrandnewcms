module Authors
  class PostsController < ApplicationController

    before_action :set_post, only: [:edit, :update, :destroy]
    layout 'dashboard'
  
    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.all
      authorize @posts
      #authorize Post
    end

    # GET /posts/new
    def new
      @post = Post.new
      authorize @post
    end
  
  
    # GET /posts/1/edit
    def edit
      authorize @post
    end
  
    # POST /posts
    # POST /posts.json
    def create
      @post = Post.new(post_params)
      #@post.user = current_user
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
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :incipit, :content, :type, :video_youtube, :video_vimeo, :seocontent, :date_chosen, :user_id, :header_image, :main_image)
      end
  end
end