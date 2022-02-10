class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml

  def reset_password_email(user)
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: t('defaults.password_reset'))
  end

  def welcome
    @name = params[:name]
    mail(to: params[:to], subject: t('defaults.users_new'))
  end
end
