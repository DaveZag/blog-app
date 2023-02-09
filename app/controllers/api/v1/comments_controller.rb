module Api
    module V1
        class CommentsController < ApiController
            def index
                @comments = Comment.where(post: params[:post_id])
                render json: @comments
            end
            def create
                @comment = Comment.new(comment_params)
                if @comment.save
                    render json: @comment, status: :created
                else
                    render json: 'Comment could not be created. Please try later.', status: :unprocessable_entity
                end
            end
            
            private
            def comment_params
                params.require(:comment).permit(:post_id, :author_id, :text)
            end
        end
    end
end