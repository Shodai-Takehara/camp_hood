class BookmarksController < ApplicationController
  def create
    @campsite = Campsite.find(params[:campsite_id])
    current_user.bookmark(@campsite)
  end

  def destroy
    @campsite = current_user.bookmarks.find_by(params[:id]).campsite
    current_user.unbookmark(@campsite)
  end
end
