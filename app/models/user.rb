class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_campsites, through: :bookmarks, source: :campsite

  accepts_nested_attributes_for :authentications
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true, presence: true

  def bookmark(campsite)
    bookmark_campsites << campsite
  end

  def unbookmark(campsite)
    bookmark_campsites.destroy(campsite)
  end

  def bookmark?(campsite)
    bookmark_campsites.include?(campsite)
  end

end

