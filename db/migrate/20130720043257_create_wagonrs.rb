class CreateWagonrs < ActiveRecord::Migration
  def change
    create_table :wagonrs do |t|
      t.string :olx_id
      t.string :posted_date
      t.string :model
      t.string :Mileage
      t.string :price
      t.string :name
      t.string :base_link

      t.timestamps
    end
  end
end
