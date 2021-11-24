class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :campsite

  validates :user_id, uniqueness: { scope: :campsite_id }
end
