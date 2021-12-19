class TopPageController < ApplicationController
  skip_before_action :require_login, only: %i[top terms_of_service privacy_policy]

  def top
    @search = Campsite.ransack(params[:q])
    @campsites = @search.result(distinc: true).page(params[:page])
  end


  def terms_of_service; end

  def privacy_policy; end

end
