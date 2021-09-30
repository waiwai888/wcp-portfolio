class CampSite < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :region
  
  validates :site_name, presence: true
end
