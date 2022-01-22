class Campsite < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code
  mount_uploader :image, CampsiteImageUploader

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :address, uniqueness: true, presence: true
  validates :prefecture_code, presence: true

  # 評価の平均を算出
  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  # 評価の平均の百分率(CSSに適用する)
  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f * 100 / 5
    else
      0.0
    end
  end
end
