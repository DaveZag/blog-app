class CommentsController < ApplicationController
  def create
    @comment = Comment.new(post: Post.find(params[:post_id]), author: User.find(params[:user_id]),
                           text: params[:text])

    respond_to do |_format|
      if @comment.save
        flash[:notice] = 'Comment Added successfully'
        redirect_to user_post_path(current_user, @comment.post_id)
      else
        flash[:error] = 'An error has occurred. Comment could not be created, Please try again later.'
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:success] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to user_post_path
  end
end
