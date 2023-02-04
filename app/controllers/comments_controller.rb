class CommentsController < ApplicationController
  def create
    @comment = Comment.new(post: Post.find(params[:post_id]), author: User.find(params[:user_id]),
                           text: params[:text])
    puts @comment.inspect
    respond_to do |_format|
      if @comment.save
        flash[:success] = 'Comment Added successfully'
        redirect_to user_post_path(current_user, @comment.post_id)
      else
        flash[:error] = 'An error has occurred. Comment could not be created, Please try again later.'
      end
    end
  end
end