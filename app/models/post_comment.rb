class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_many :post_tags
  # has_many :notifications, dependent: :destroy

  validates :comment, presence: true

end
