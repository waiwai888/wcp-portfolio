class Review < ApplicationRecord
  belongs_to :user
  belongs_to :camp_site
  
  validates :title, presence: true
  validates :body, presence: true
  validates :score, presence: true
  
end
