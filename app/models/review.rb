class Review < ApplicationRecord
  belongs_to :user
  belongs_to :camp_site
end
