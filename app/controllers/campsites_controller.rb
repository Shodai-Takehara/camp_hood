class CampsitesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_campsite, only: %i[show]

  def index
    @search = Campsite.ransack(params[:q])
    @campsites = @search.result(distinc: true).page(params[:page])
  end

  def show ; end

  def mypage
    @search = current_user.bookmark_campsites.ransack(params[:q])
    @bookmark_campsites = @search.result(distinc: true).order(created_at: :asc).page(params[:page]).per(9)
  end

  private

  def set_campsite
    @campsite = Campsite.find(params[:id])
  end
end
