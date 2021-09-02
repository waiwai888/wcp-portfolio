class CreateCampSites < ActiveRecord::Migration[5.2]
  def change
    create_table :camp_sites do |t|
      t.string :site_name, null: false

      t.timestamps
    end
  end
end
