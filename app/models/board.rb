class Board < ApplicationRecord
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user)
  end
end
