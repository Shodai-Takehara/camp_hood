class TopPageController < ApplicationController
  skip_before_action :require_login, only: %i[top]

  def top
    @search = Campsite.ransack(params[:q])
    @campsites = @search.result(distinc: true).page(params[:page])
  end

end
