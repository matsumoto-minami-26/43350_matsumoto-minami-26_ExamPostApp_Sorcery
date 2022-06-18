class BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update destroy]

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end
  
  def show
    @board = Board.find(params[:id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @board = Board.new
  end
  
  def edit
    current_user.boards.find(params[:id])
  end
  
  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end
  
  def update
    @board = current_user.boards.new(board_params)
    if @board.update(board_params)
      redirect_to @board, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @board = current_user.boards.new(board_params)
    @board.destroy
    redirect_to boards_url, notice: 'Post was successfully destroyed.'
  end
  
  private
  
  def set_board
    @board = Board.find(params[:id])
  end
  
  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
