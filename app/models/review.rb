class Review < ApplicationRecord
  belongs_to :user
  belongs_to :campsite

  validates :score, presence: true
  validates :content, presence: true, length: { maximum: 256 }
end
