class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  before_action :set_q, only: [:index, :search]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end
  
  def show
    @board = Board.find(params[:id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @board = Board.new
  end
  
  def edit;
    @board = current_user.boards.find(params[:id])
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
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end
  
  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to boards_path, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  def bookmarks
    # binding.pry
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def search
    @results = @q.result
  end
  
  private
  
  def set_q
    @q = Board.ransack(params[:q])
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end
  
  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
