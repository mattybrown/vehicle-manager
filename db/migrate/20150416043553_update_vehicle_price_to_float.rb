class UpdateVehiclePriceToFloat < ActiveRecord::Migration
  def change
    change_table :vehicles do |c|
      c.change :sellprice, :float
      c.change :buyprice, :float
    end
  end
end
