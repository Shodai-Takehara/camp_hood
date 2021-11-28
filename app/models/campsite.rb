class Campsite < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :address, uniqueness: true, presence: true
  validates :prefecture_code, presence: true
end
