class CampsitesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_campsite, only: %i[show]

  def index
    @campsites = Campsite.all.page(params[:page])
  end

  def show
  end

  private

  def set_campsite
    @campsite = Campsite.find(params[:id])
  end
end
