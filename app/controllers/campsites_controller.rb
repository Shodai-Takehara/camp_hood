class CampsitesController < ApplicationController
  skip_before_action :require_login, only: %i[index show guidance]
  before_action :set_campsite, :set_lat_long_name, only: %i[show guidance]
  before_action :set_key_openweather_map, only: %i[guidance]

  def index
    @search = Campsite.ransack(params[:q])
    @campsites = @search.result(distinc: true).page(params[:page])
  end

  def show; end

  def mypage
    @search = current_user.bookmark_campsites.ransack(params[:q])
    @bookmark_campsites = @search.result(distinc: true).order(created_at: :asc).page(params[:page]).per(9)
  end

  def guidance; end

  private

  def set_campsite
    @campsite = Campsite.find(params[:id])
  end

  def set_key_openweather_map
    gon.openweather_map_key = Rails.application.credentials.dig(:open_weather, :appid)
  end

  def set_lat_long_name
    gon.campsite_name = @campsite.name
    gon.latitude = @campsite.latitude
    gon.longitude = @campsite.longitude
    gon.address = @campsite.address
  end
end
