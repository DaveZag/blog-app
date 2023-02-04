class LikesController < ApplicationController
  def create
    @like = Like.new(author: User.find(params[:user_id]), post: Post.find(params[:post_id]))

    respond_to do |_format|
      redirect_to user_post_path(current_user, @like.post_id) unless @like.save
      flash[:error] = 'Not saved!'
    end
  end
end
