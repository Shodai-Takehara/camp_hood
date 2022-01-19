class ReviewsController < ApplicationController

  def index
    @campsite = Campsite.find(params[:campsite_id])
    @review = Review.new(review_params)
    render template: "campsites/show"
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to campsite_path(@review.campsite), success: t('.success')
    else
      @campsite = Campsite.find(params[:campsite_id])
      render template: "campsites/show", danger: t('.fail')
    end
  end

  private

  def review_params
    params.require(:review).permit(:campsite_id, :content, :score)
  end
end
