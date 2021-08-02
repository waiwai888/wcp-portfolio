class Post < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  #タグ機能
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
end
