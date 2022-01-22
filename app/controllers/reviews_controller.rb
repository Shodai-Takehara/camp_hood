class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_campsite, only: %i[index create destroy]

  def index
    @review = Review.new
    @reviews = @campsite.reviews.order(created_at: :desc)
    render template: "campsites/show"
  end

  def create
    begin
      @review = current_user.reviews.build(review_params)
      if @review.save
        redirect_to campsite_path(@review.campsite), success: t('.success')
      else
        render template: "campsites/show", danger: t('.fail')
      end
    rescue
      redirect_to campsite_path(@campsite), danger: t('.fail')
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy!
    redirect_to campsite_path(@campsite), success: t('.success')
  end

  private

  def set_campsite
    @campsite = Campsite.find(params[:campsite_id])
  end

  def review_params
    params.require(:review).permit(:campsite_id, :content, :score)
  end
end
