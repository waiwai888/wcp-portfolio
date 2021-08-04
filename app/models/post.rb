class Post < ApplicationRecord

  attachment :image

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user

  #タグ機能
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

	validates :body, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  

end
