class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:error].present?
      redirect_to root_path, warning: t('.cancel')
      return
    end
    if (@user = login_from(provider))
      redirect_back_or_to root_path, success: t('.success')
    else
      @user = create_from(provider)
      reset_session
      auto_login(@user)
      redirect_to root_path, success: t('.success')
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error)
  end
end
