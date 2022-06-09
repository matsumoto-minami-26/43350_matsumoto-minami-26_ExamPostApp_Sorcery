class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    super
  end

  def create
    super
    @user = login(params[:email], params[:password])

    if @user
      redirect_to posts_path, notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out!'
  end

  private

  def session_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end
end
