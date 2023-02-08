class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author: @user)
  end

  def show
    @post = Post.includes(comments: [:author]).find(params[:id])
    @comments = Comment.where(post_id: @post)
  end

  def def(_new)
    @post = Post.new

    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text).merge(author: current_user))
    respond_to do |_format|
      if @post.save
        flash[:notice] = 'Post was successfully created'
      else
        flash.now[:error] = 'An error has occurred. Post could not be created, Please try again later.'
      end
      redirect_to user_posts_path(current_user)
    end
  end
end
