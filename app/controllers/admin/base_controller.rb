class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, warning: '権限がありません' unless current_user.admin?
  end
end
