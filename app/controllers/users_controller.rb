class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
      UserMailer.welcome(@user).deliver_now
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy!
    redirect_to root_path, danger: t('defaults.message.quited')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
