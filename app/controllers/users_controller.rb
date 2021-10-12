class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
