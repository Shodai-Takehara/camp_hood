class CampsitesController < ApplicationController
  require "open-uri"
  require "json"

  skip_before_action :require_login, only: %i[index show guidance]
  before_action :set_campsite, :set_lat_long_name, only: %i[show guidance]
  before_action :set_key_openweather_map, :get_rakuten_tent, only: %i[guidance]

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

  def get_rakuten_tent
    api_key = Rails.application.credentials.rakuten[:key]
    rakuten_tent_url = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?format=json&genreId=302373&applicationId=#{ api_key }"
    rakuten_hotel_url = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=#{ @campsite.latitude }&longitude=#{ @campsite.longitude }&applicationId=#{ api_key }"
    response_tent = URI.open(rakuten_tent_url)
    rakuten_tent = JSON.parse(response_tent.read)
    get_tent = []
    rakuten_tent["Items"].first(20).each do |tent|
      get_tent << { name: tent["Item"]["itemName"], url: tent["Item"]["itemUrl"], image_url: tent["Item"]["smallImageUrls"][0]["imageUrl"], price: tent["Item"]["itemPrice"], score: tent["Item"]["reviewAverage"] }
    end
    @tents = get_tent.sample(4)
  end
end
