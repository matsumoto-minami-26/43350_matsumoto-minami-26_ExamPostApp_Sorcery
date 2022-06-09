class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to posts_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('.success')
  end

  private

  def session_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end
end
