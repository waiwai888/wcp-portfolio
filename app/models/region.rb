class Region < ApplicationRecord
  has_ancestry
  has_many :camp_sites, dependent: :destroy
end
