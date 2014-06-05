class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |v|
      v.string :make
      v.string :model
      v.integer :year
      v.integer :sellprice
      v.integer :buyprice
      v.integer :kilometers
      v.string :engine
      v.string :colour
      
      v.text :description
      v.timestamps
    end
  end
end
