class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_post_comment, except: [:create]
  before_action :authenticate_user!

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  private

    def comment_params
      params[:comment].permit(:comment)
    end

    def find_post
      @post = Post.find(params[:post_id])
    end

    def find_post_comment
      @comment = @post.comments.find(params[:id])
    end

end
