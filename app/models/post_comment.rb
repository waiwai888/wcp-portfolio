class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  has_many :post_tags
  belongs_to :user

end
