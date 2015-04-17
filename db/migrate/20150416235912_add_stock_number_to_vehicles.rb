class AddStockNumberToVehicles < ActiveRecord::Migration
  def change
    change_table Vehicle do |v|
      v.integer :stock_number
    end
  end
end
