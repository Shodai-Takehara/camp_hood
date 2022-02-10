class Admin::CampsitesController < Admin::BaseController
  before_action :set_campsite, only: %i[show edit update destroy]

  def index
    @search = Campsite.ransack(params[:q])
    @campsites = @search.result(distinc: true).page(params[:page])
  end

  def new
    @campsite = Campsite.new
  end

  def create
    @campsite = Campsite.new(campsaite_params)
    if @campsite.save
      redirect_to admin_campsites_path(@campsite), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @campsite.update(campsaite_params)
      redirect_to admin_campsite_path(@campsite),
                  success: t('defaults.message.updated', item: Campsite.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Campsite.model_name.human)
      render :edit
    end
  end

  def destroy
    if @campsite.destroy!
      redirect_to admin_campsites_path(@campsites),
                  success: t('defaults.message.deleted', item: Campsite.model_name.human)
    end
  end

  private

  def campsaite_params
    params.require(:campsite).permit(:name, :address, :prefecture_code, :access,
                                     :description, :period, :checkin, :checkout, :phone,
                                     :contact_link, :latitude, :longitude, :image, :image_cache)
  end

  def set_campsite
    @campsite = Campsite.find(params[:id])
  end
end
