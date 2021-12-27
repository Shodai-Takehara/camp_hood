class CampsitesController < ApplicationController
  require "open-uri"
  require "json"

  skip_before_action :require_login, only: %i[index show guidance]
  before_action :set_campsite, :set_lat_long_name, only: %i[show guidance]
  before_action :set_key_openweather_map, :get_rakuten_tent, :get_rakuten_hotel, :get_rakuten_books, only: %i[guidance]

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
    response_tent = URI.open(rakuten_tent_url)
    rakuten_tent = JSON.parse(response_tent.read)
    get_tent = []
    rakuten_tent["Items"].first(20).each do |tent|
      get_tent << { name: tent["Item"]["itemName"], url: tent["Item"]["itemUrl"], image_url: tent["Item"]["smallImageUrls"][0]["imageUrl"], price: tent["Item"]["itemPrice"], score: tent["Item"]["reviewAverage"], count: tent["Item"]["reviewCount"]}
    end
    @tents = get_tent.sample(4)
  end

  def get_rakuten_hotel
    api_key = Rails.application.credentials.rakuten[:key]
    begin
      rakuten_hotel_url = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=#{ @campsite.latitude }&longitude=#{ @campsite.longitude }&applicationId=#{ api_key }&searchRadius=3"
      response_hotel = URI.open(rakuten_hotel_url)
      rakuten_hotel = JSON.parse(response_hotel.read)
      count = rakuten_hotel["hotels"].length > 4 ? 4 : rakuten_hotel["hotels"].length
      get_hotel = []
      rakuten_hotel["hotels"].first(count).each do |hotel|
        get_hotel << { name: hotel["hotel"][0]["hotelBasicInfo"]["hotelName"], url: hotel["hotel"][0]["hotelBasicInfo"]["hotelInformationUrl"], image_url: hotel["hotel"][0]["hotelBasicInfo"]["hotelImageUrl"],
        review: hotel["hotel"][0]["hotelBasicInfo"]["reviewAverage"], review_count: hotel["hotel"][0]["hotelBasicInfo"]["reviewCount"], address1: hotel["hotel"][0]["hotelBasicInfo"]["address1"], address2: hotel["hotel"][0]["hotelBasicInfo"]["address2"] }
      end
      @hotels = get_hotel
    rescue
      @hotels = []
    end
  end

  def get_rakuten_books
    api_key = Rails.application.credentials.rakuten[:key]
    rakuten_books_url = "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&keyword=%E3%82%AD%E3%83%A3%E3%83%B3%E3%83%97&booksGenreId=001&applicationId=#{ api_key }"
    response_books = URI.open(rakuten_books_url)
    rakuten_books = JSON.parse(response_books.read)
    get_book = []
    rakuten_books["Items"].first(20).each do |book|
      get_book << { name: book["Item"]["title"], url: book["Item"]["itemUrl"], image_url: book["Item"]["mediumImageUrl"], price: book["Item"]["itemPrice"], sales: book["Item"]["salesDate"], publisher: book["Item"]["publisherName"] }
    end
    @books = get_book.sample(4)
  end
end
