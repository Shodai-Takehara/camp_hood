class Campsite < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
end
