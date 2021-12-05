class BookmarksController < ApplicationController
  skip_before_action :require_login
  def create
    @campsite = Campsite.find(params[:campsite_id])
    current_user.bookmark(@campsite)
  end

  def destroy
    @campsite = current_user.bookmarks.find(params[:id]).campsite
    current_user.unbookmark(@campsite)
  end
end
