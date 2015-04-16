class AddBuyAndSellDatesToVehicles < ActiveRecord::Migration
  def change
    change_table :vehicles do |v|
      v.string :purchase_date
      v.string :sale_date
    end
  end
end
