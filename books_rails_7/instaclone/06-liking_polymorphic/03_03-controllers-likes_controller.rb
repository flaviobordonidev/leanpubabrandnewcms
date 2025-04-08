class LikesController < ApplicationController
  def create
    if params[:comment_id].present?
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:comment_id])
      current_user.like!(@comment.model_name.to_s, @comment.id)
    else
      @post = Post.find(params[:post_id])
      current_user.like!(@post.model_name.to_s, @post.id)
    end
  end

  def destroy
    if params[:comment_id].present?
      @post = current_user.posts.find_by(id: params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      current_user.likes.where(likeable_type: @comment.model_name.to_s, likeable_id: @comment.id).delete_all
    else
      @post = current_user.posts.find_by(id: params[:post_id])
      current_user.likes.where(likeable_type: @post.model_name.to_s, likeable_id: @post.id).delete_all
    end
  end
end
