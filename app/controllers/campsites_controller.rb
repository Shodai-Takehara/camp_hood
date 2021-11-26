class CampsitesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_campsite, only: %i[show]

  def index
    @campsites = Campsite.all.page(params[:page])
  end

  def show ; end

  def mypage
    @bookmark_campsites = current_user.bookmark_campsites.order(created_at: :asc).page(params[:page]).per(9)
  end

  private

  def set_campsite
    @campsite = Campsite.find(params[:id])
  end
end
