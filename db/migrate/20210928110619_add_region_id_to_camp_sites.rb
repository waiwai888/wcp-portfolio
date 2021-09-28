class AddRegionIdToCampSites < ActiveRecord::Migration[5.2]
  def change
    add_column :camp_sites, :region_id, :integer
  end
end
