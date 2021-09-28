class CampSite < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :region
end
