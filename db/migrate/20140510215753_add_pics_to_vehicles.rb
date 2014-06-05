class AddPicsToVehicles < ActiveRecord::Migration
  def change

    change_table :vehicles do |v|
      v.string :main_picture
    end

  end
end
