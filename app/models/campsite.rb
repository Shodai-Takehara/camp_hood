class Campsite < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code
  mount_uploader :image, CampsiteImageUploader

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many :bookmarks, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :address, uniqueness: true, presence: true
  validates :prefecture_code, presence: true
end
