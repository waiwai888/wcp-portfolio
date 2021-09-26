class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_many :post_tags

  validates :comment, presence: true

end
