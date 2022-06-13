class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end
  
  def show; end

  def new
    @board = Board.new
  end
  
  def edit
    current_user.boards.find(params[:id])
  end
  
  def create
    @board = current_user.boards.new(board_params)
  
    if @post.save
      redirect_to @board, notice: 'Post was successfully created.'
    else
      render :new
    end
  end
  
  def update
    current_user.boards.find(params[:id])
    if @post.update(board_params)
      redirect_to @board, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    current_user.boards.find(params[:id])
    @board.destroy
    redirect_to boards_url, notice: 'Post was successfully destroyed.'
  end
  
  private
  
  def set_post
    @board = Board.find(params[:id])
  end
  
  def board_params
    params.require(:board).permit(:title, :content)
  end
end
