class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    # if 
    @comment.save
      # redirect_to board_path(comment.board), success: t('defaults.message.created', item: Comment.model_name.human)
    # else
      # redirect_to board_path(comment.board), danger: t('defaults.message.not_created', item: Comment.model_name.human)
    # end
  end

  def update
    @comment = @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      render json: { comment: @comment }, status: :ok
    else
      render json: { comment: @comment, errors: { messages: @comment.errors.full_messages } }, status: :bad_request
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private
  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
